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
with Messages; use Messages;
with Items; use Items;
with Ships.Cargo; use Ships.Cargo;
with Ships.Crew; use Ships.Crew;
with Crafts; use Crafts;
with Trades; use Trades;
with Utils; use Utils;
with Bases.Cargo; use Bases.Cargo;
with Config; use Config;
with BasesTypes; use BasesTypes;

package body Bases.Trade is

   -- ****if* Bases.Trade/CheckMoney
   -- FUNCTION
   -- Check if player have enough money
   -- PARAMETERS
   -- Price   - Miniumum amount of money which player must have
   -- Message - Additional message to return when player don't have enough
   --           money
   -- RESULT
   -- Cargo index of money from the player ship
   -- SOURCE
   function CheckMoney
     (Price: Positive; Message: String := "") return Positive is
      -- ****
      MoneyIndex2: constant Natural := FindItem(PlayerShip.Cargo, MoneyIndex);
   begin
      if MoneyIndex2 = 0 then
         if Message /= "" then
            raise Trade_No_Money with Message;
         else
            raise Trade_No_Money;
         end if;
      end if;
      if PlayerShip.Cargo(MoneyIndex2).Amount < Price then
         if Message /= "" then
            raise Trade_Not_Enough_Money with Message;
         else
            raise Trade_Not_Enough_Money;
         end if;
      end if;
      return MoneyIndex2;
   end CheckMoney;

   procedure HireRecruit
     (RecruitIndex, Cost: Positive; DailyPayment, TradePayment: Natural;
      ContractLenght: Integer) is
      BaseIndex: constant Positive :=
        SkyMap(PlayerShip.SkyX, PlayerShip.SkyY).BaseIndex;
      MoneyIndex2, Price, TraderIndex: Natural;
      Recruit: constant Recruit_Data :=
        SkyBases(BaseIndex).Recruits(RecruitIndex);
      Morale: Positive;
      Inventory: Inventory_Container.Vector;
   begin
      TraderIndex := FindMember(Talk);
      if TraderIndex = 0 then
         raise Trade_No_Trader;
      end if;
      Price := Cost;
      CountPrice(Price, TraderIndex);
      MoneyIndex2 := CheckMoney(Price, To_String(Recruit.Name));
      for Item of Recruit.Inventory loop
         Inventory.Append
           (New_Item =>
              (ProtoIndex => Item, Amount => 1, Name => Null_Unbounded_String,
               Durability => 100, Price => 0));
      end loop;
      if Factions_List(SkyBases(BaseIndex).Owner).Flags.Contains
          (To_Unbounded_String("nomorale")) then
         Morale := 50;
      else
         Morale := 50 + SkyBases(BaseIndex).Reputation(1);
         if Morale > 100 then
            Morale := 100;
         end if;
      end if;
      PlayerShip.Crew.Append
        (New_Item =>
           (Name => Recruit.Name, Gender => Recruit.Gender, Health => 100,
            Tired => 0, Skills => Recruit.Skills, Hunger => 0, Thirst => 0,
            Order => Rest, PreviousOrder => Rest, OrderTime => 15,
            Orders => (others => 0), Attributes => Recruit.Attributes,
            Inventory => Inventory, Equipment => Recruit.Equipment,
            Payment => (DailyPayment, TradePayment),
            ContractLength => ContractLenght, Morale => (Morale, 0),
            Loyalty => Morale, HomeBase => Recruit.HomeBase,
            Faction => Recruit.Faction));
      UpdateCargo
        (Ship => PlayerShip, CargoIndex => MoneyIndex2, Amount => (0 - Price));
      GainExp(1, TalkingSkill, TraderIndex);
      GainRep(BaseIndex, 1);
      AddMessage
        ("You hired " & To_String(Recruit.Name) & " for" &
         Positive'Image(Price) & " " & To_String(MoneyName) & ".",
         TradeMessage);
      SkyBases(BaseIndex).Recruits.Delete(Index => RecruitIndex);
      SkyBases(BaseIndex).Population := SkyBases(BaseIndex).Population - 1;
      UpdateGame(5);
   end HireRecruit;

   procedure BuyRecipe(RecipeIndex: Unbounded_String) is
      BaseIndex: constant Positive :=
        SkyMap(PlayerShip.SkyX, PlayerShip.SkyY).BaseIndex;
      Cost, MoneyIndex2: Natural;
      RecipeName: constant String :=
        To_String(Items_List(Recipes_List(RecipeIndex).ResultIndex).Name);
      BaseType: constant Unbounded_String := SkyBases(BaseIndex).BaseType;
      TraderIndex: Natural;
   begin
      if not BasesTypes_List(BaseType).Recipes.Contains(RecipeIndex) then
         raise Trade_Cant_Buy;
      end if;
      if Known_Recipes.Find_Index(Item => RecipeIndex) /=
        Positive_Container.No_Index then
         raise Trade_Already_Known;
      end if;
      TraderIndex := FindMember(Talk);
      if TraderIndex = 0 then
         raise Trade_No_Trader;
      end if;
      if Get_Price
          (SkyBases(BaseIndex).BaseType,
           Recipes_List(RecipeIndex).ResultIndex) >
        0 then
         Cost :=
           Get_Price
             (SkyBases(BaseIndex).BaseType,
              Recipes_List(RecipeIndex).ResultIndex) *
           Recipes_List(RecipeIndex).Difficulty * 10;
      else
         Cost := Recipes_List(RecipeIndex).Difficulty * 10;
      end if;
      Cost := Natural(Float(Cost) * NewGameSettings.PricesBonus);
      if Cost = 0 then
         Cost := 1;
      end if;
      CountPrice(Cost, TraderIndex);
      MoneyIndex2 := CheckMoney(Cost, RecipeName);
      UpdateCargo
        (Ship => PlayerShip, CargoIndex => MoneyIndex2, Amount => (0 - Cost));
      UpdateBaseCargo(MoneyIndex, Cost);
      Known_Recipes.Append(New_Item => RecipeIndex);
      AddMessage
        ("You bought the recipe for " & RecipeName & " for" &
         Positive'Image(Cost) & " of " & To_String(MoneyName) & ".",
         TradeMessage);
      GainExp(1, TalkingSkill, TraderIndex);
      GainRep(BaseIndex, 1);
      UpdateGame(5);
   end BuyRecipe;

   procedure HealWounded(MemberIndex: Crew_Container.Extended_Index) is
      BaseIndex: constant Positive :=
        SkyMap(PlayerShip.SkyX, PlayerShip.SkyY).BaseIndex;
      Cost, Time, MoneyIndex2: Natural := 0;
      TraderIndex: Natural;
   begin
      HealCost(Cost, Time, MemberIndex);
      if Cost = 0 then
         raise Trade_Cant_Heal;
      end if;
      TraderIndex := FindMember(Talk);
      if TraderIndex = 0 then
         raise Trade_No_Trader;
      end if;
      MoneyIndex2 := CheckMoney(Cost);
      if MemberIndex > 0 then
         PlayerShip.Crew(MemberIndex).Health := 100;
         AddMessage
           ("You paid for healing " &
            To_String(PlayerShip.Crew(MemberIndex).Name) & " for" &
            Positive'Image(Cost) & " " & To_String(MoneyName) & ".",
            TradeMessage);
         GiveOrders(PlayerShip, MemberIndex, Rest, 0, False);
      else
         for I in PlayerShip.Crew.Iterate loop
            if PlayerShip.Crew(I).Health < 100 then
               PlayerShip.Crew(I).Health := 100;
               GiveOrders
                 (PlayerShip, Crew_Container.To_Index(I), Rest, 0, False);
            end if;
         end loop;
         AddMessage
           ("You paid for healing for all wounded crew members for" &
            Positive'Image(Cost) & " " & To_String(MoneyName) & ".",
            TradeMessage);
      end if;
      UpdateCargo
        (Ship => PlayerShip, CargoIndex => MoneyIndex2, Amount => (0 - Cost));
      UpdateBaseCargo(MoneyIndex, Cost);
      GainExp(1, TalkingSkill, TraderIndex);
      GainRep(BaseIndex, 1);
      UpdateGame(Time);
   end HealWounded;

   procedure HealCost
     (Cost, Time: in out Natural;
      MemberIndex: Crew_Container.Extended_Index) is
      BaseIndex: constant Positive :=
        SkyMap(PlayerShip.SkyX, PlayerShip.SkyY).BaseIndex;
   begin
      if MemberIndex > 0 then
         Time := 5 * (100 - PlayerShip.Crew(MemberIndex).Health);
         Cost :=
           (5 * (100 - PlayerShip.Crew(MemberIndex).Health)) *
           Get_Price
             (To_Unbounded_String("0"),
              FindProtoItem
                (ItemType =>
                   Factions_List(PlayerShip.Crew(MemberIndex).Faction)
                     .HealingTools));
      else
         for Member of PlayerShip.Crew loop
            if Member.Health < 100 then
               Time := Time + (5 * (100 - Member.Health));
               Cost :=
                 Cost +
                 ((5 * (100 - Member.Health)) *
                  Items_List
                    (FindProtoItem
                       (ItemType =>
                          Factions_List(Member.Faction).HealingTools))
                    .Price);
            end if;
         end loop;
      end if;
      Cost := Natural(Float(Cost) * NewGameSettings.PricesBonus);
      if Cost = 0 then
         Cost := 1;
      end if;
      CountPrice(Cost, FindMember(Talk));
      if Time = 0 then
         Time := 1;
      end if;
      if BasesTypes_List(SkyBases(BaseIndex).BaseType).Flags.Contains
          (To_Unbounded_String("temple")) then
         Cost := Cost / 2;
         if Cost = 0 then
            Cost := 1;
         end if;
      end if;
   end HealCost;

   function TrainCost(MemberIndex, SkillIndex: Positive) return Natural is
      Cost: Natural := Natural(100.0 * NewGameSettings.PricesBonus);
   begin
      for Skill of PlayerShip.Crew(MemberIndex).Skills loop
         if Skill(1) = SkillIndex then
            if Skill(2) < 100 then
               Cost :=
                 Natural
                   (Float((Skill(2) + 1) * 100) * NewGameSettings.PricesBonus);
               if Cost = 0 then
                  Cost := 1;
               end if;
               exit;
            end if;
            return 0;
         end if;
      end loop;
      CountPrice(Cost, FindMember(Talk));
      return Cost;
   end TrainCost;

   procedure TrainSkill(MemberIndex, SkillIndex: Positive) is
      Cost: constant Natural := TrainCost(MemberIndex, SkillIndex);
      MoneyIndex2, TraderIndex: Natural;
      GainedExp: Positive;
      BaseIndex: constant Positive :=
        SkyMap(PlayerShip.SkyX, PlayerShip.SkyY).BaseIndex;
   begin
      if Cost = 0 then
         raise Trade_Cant_Train;
      end if;
      MoneyIndex2 := CheckMoney(Cost);
      AddMessage
        ("You purchased a training session in " &
         To_String(Skills_List(SkillIndex).Name) & " for " &
         To_String(PlayerShip.Crew(MemberIndex).Name) & " for" &
         Positive'Image(Cost) & " " & To_String(MoneyName) & ".",
         TradeMessage);
      GiveOrders(PlayerShip, MemberIndex, Rest, 0, False);
      GainedExp :=
        GetRandom(10, 60) +
        PlayerShip.Crew(MemberIndex).Attributes
          (Skills_List(SkillIndex).Attribute)
          (1);
      if GainedExp > 100 then
         GainedExp := 100;
      end if;
      GainExp(GainedExp, SkillIndex, MemberIndex);
      UpdateCargo
        (Ship => PlayerShip, CargoIndex => MoneyIndex2, Amount => (0 - Cost));
      UpdateBaseCargo(MoneyIndex, Cost);
      TraderIndex := FindMember(Talk);
      if TraderIndex > 0 then
         GainExp(5, TalkingSkill, TraderIndex);
      end if;
      GainRep(BaseIndex, 5);
      UpdateGame(60);
   end TrainSkill;

end Bases.Trade;
