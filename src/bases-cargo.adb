--    Copyright 2017-2019 Bartek thindil Jasicki
--
--    This file is part of Steam Sky.
--
--    Steam Sky is free software: you can redistribute it and/or modify
--    it under the terms of the GNU General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
--
--    Steam Sky is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU General Public License
--    along with Steam Sky.  If not, see <http://www.gnu.org/licenses/>.

with Maps; use Maps;
with Utils; use Utils;
with Trades; use Trades;
with Items; use Items;
with BasesTypes; use BasesTypes;

package body Bases.Cargo is

   procedure GenerateCargo is
      BaseIndex: constant Positive :=
        SkyMap(PlayerShip.SkyX, PlayerShip.SkyY).BaseIndex;
      Chance: Positive;
      Population: Natural := SkyBases(BaseIndex).Population;
   begin
      if Population = 0 then
         Population := 1;
      end if;
      if SkyBases(BaseIndex).Population < 150 then
         Chance := 5;
      elsif SkyBases(BaseIndex).Population < 300 then
         Chance := 10;
      else
         Chance := 15;
      end if;
      Chance := Chance + DaysDifference(SkyBases(BaseIndex).Visited);
      if SkyBases(BaseIndex).Cargo.Length = 0 then
         Chance := 101;
      end if;
      if GetRandom(1, 100) > Chance then
         return;
      end if;
      if SkyBases(BaseIndex).Cargo.Length = 0 then
         SkyBases(BaseIndex).Cargo.Append
           (New_Item =>
              (ProtoIndex => MoneyIndex,
               Amount => (GetRandom(50, 200) * Population), Durability => 100,
               Price => 0));
         for I in Items_List.Iterate loop
            if Is_Buyable
                (SkyBases(BaseIndex).BaseType, Objects_Container.Key(I),
                 False) then
               SkyBases(BaseIndex).Cargo.Append
                 (New_Item =>
                    (ProtoIndex => Objects_Container.Key(I),
                     Amount => (GetRandom(0, 100) * Population),
                     Durability => 100,
                     Price =>
                       Get_Price
                         (SkyBases(BaseIndex).BaseType,
                          Objects_Container.Key(I))));
            end if;
         end loop;
         if BasesTypes_List(SkyBases(BaseIndex).BaseType).Flags.Contains
             (To_Unbounded_String("blackmarket")) then
            declare
               Amount: Positive;
               ItemIndex: Natural;
            begin
               if SkyBases(BaseIndex).Population < 150 then
                  Amount := GetRandom(1, 10);
               elsif SkyBases(BaseIndex).Population < 300 then
                  Amount := GetRandom(1, 20);
               else
                  Amount := GetRandom(1, 30);
               end if;
               for I in 1 .. Amount loop
                  ItemIndex := GetRandom(1, Positive(Items_List.Length));
                  for J in Items_List.Iterate loop
                     ItemIndex := ItemIndex - 1;
                     if ItemIndex = 0 then
                        if Get_Price
                            (SkyBases(BaseIndex).BaseType,
                             Objects_Container.Key(J)) =
                          0 then
                           ItemIndex := ItemIndex + 1;
                        else
                           SkyBases(BaseIndex).Cargo.Append
                             (New_Item =>
                                (ProtoIndex => Objects_Container.Key(J),
                                 Amount => (GetRandom(0, 100) * Population),
                                 Durability => 100,
                                 Price =>
                                   Get_Price
                                     (SkyBases(BaseIndex).BaseType,
                                      Objects_Container.Key(J))));
                           exit;
                        end if;
                     end if;
                  end loop;
               end loop;
            end;
         end if;
      else
         declare
            Roll: Positive;
            MaxAmount: Natural;
         begin
            for Item of SkyBases(BaseIndex).Cargo loop
               Roll := GetRandom(1, 100);
               if Roll < 30 and Item.Amount > 0 then
                  MaxAmount := Item.Amount / 2;
                  if MaxAmount < 1 then
                     MaxAmount := 1;
                  end if;
                  Item.Amount := Item.Amount - GetRandom(1, MaxAmount);
               elsif Roll < 60 and SkyBases(BaseIndex).Population > 0 then
                  if Item.Amount = 0 then
                     Item.Amount := GetRandom(1, 10) * Population;
                  else
                     MaxAmount := Item.Amount / 2;
                     if MaxAmount < 1 then
                        MaxAmount := 1;
                     end if;
                     Item.Amount := Item.Amount + GetRandom(1, MaxAmount);
                  end if;
               end if;
            end loop;
         end;
      end if;
   end GenerateCargo;

   procedure UpdateBaseCargo
     (ProtoIndex: Unbounded_String := Null_Unbounded_String; Amount: Integer;
      Durability: Natural := 100; CargoIndex: Natural := 0) is
      BaseIndex: constant Positive :=
        SkyMap(PlayerShip.SkyX, PlayerShip.SkyY).BaseIndex;
      ItemIndex: Natural;
   begin
      if ProtoIndex /= Null_Unbounded_String then
         ItemIndex := FindBaseCargo(ProtoIndex, Durability);
      else
         ItemIndex := CargoIndex;
      end if;
      if Amount > 0 then
         if ItemIndex = 0 then
            SkyBases(BaseIndex).Cargo.Append
              (New_Item =>
                 (ProtoIndex => ProtoIndex, Amount => Amount,
                  Durability => Durability,
                  Price =>
                    Get_Price(SkyBases(BaseIndex).BaseType, ProtoIndex)));
         else
            SkyBases(BaseIndex).Cargo(ItemIndex).Amount :=
              SkyBases(BaseIndex).Cargo(ItemIndex).Amount + Amount;
         end if;
      else
         SkyBases(BaseIndex).Cargo(ItemIndex).Amount :=
           SkyBases(BaseIndex).Cargo(ItemIndex).Amount + Amount;
         if SkyBases(BaseIndex).Cargo(ItemIndex).Amount = 0 and
           not Is_Buyable
             (SkyBases(BaseIndex).BaseType,
              SkyBases(BaseIndex).Cargo(ItemIndex).ProtoIndex) and
           ItemIndex > 1 then
            SkyBases(BaseIndex).Cargo.Delete(Index => ItemIndex);
         end if;
      end if;
   end UpdateBaseCargo;

   function FindBaseCargo
     (ProtoIndex: Unbounded_String; Durability: Natural := 101)
      return Natural is
      BaseIndex: constant Natural :=
        SkyMap(PlayerShip.SkyX, PlayerShip.SkyY).BaseIndex;
      function FindCargo(Cargo: BaseCargo_Container.Vector) return Natural is
      begin
         for I in Cargo.Iterate loop
            if Durability < 101 then
               if Cargo(I).ProtoIndex = ProtoIndex and
                 Cargo(I).Durability = Durability then
                  return BaseCargo_Container.To_Index(I);
               end if;
            else
               if Cargo(I).ProtoIndex = ProtoIndex then
                  return BaseCargo_Container.To_Index(I);
               end if;
            end if;
         end loop;
         return 0;
      end FindCargo;
   begin
      if BaseIndex > 0 then
         return FindCargo(SkyBases(BaseIndex).Cargo);
      end if;
      return FindCargo(TraderCargo);
   end FindBaseCargo;

end Bases.Cargo;
