--    Copyright 2016-2017 Bartek thindil Jasicki
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

with Terminal_Interface.Curses.Forms; use Terminal_Interface.Curses.Forms;
with Terminal_Interface.Curses.Forms.Field_Types.IntField;
with Maps; use Maps;
with Items; use Items;
with UserInterface; use UserInterface;
with Ships; use Ships;
with Ships.Cargo; use Ships.Cargo;
with Ships.UI.Cargo; use Ships.UI.Cargo;
with Help.UI; use Help.UI;
with Events; use Events;
with Bases.Trade; use Bases.Trade;

package body Bases.UI.Trade is

   Buy: Boolean;
   TradeForm: Form;
   FormWindow: Window;

   procedure ShowItemInfo is
      ItemIndex, Price: Positive;
      InfoWindow, ClearWindow, BoxWindow: Window;
      BaseIndex: constant Positive :=
        SkyMap(PlayerShip.SkyX, PlayerShip.SkyY).BaseIndex;
      BaseType: constant Positive :=
        Bases_Types'Pos(SkyBases(BaseIndex).BaseType) + 1;
      CurrentLine: Line_Position := 4;
      CargoIndex: constant Natural :=
        Integer'Value(Description(Current(TradeMenu)));
      StartColumn: Column_Position;
      EventIndex: constant Natural :=
        SkyMap(PlayerShip.SkyX, PlayerShip.SkyY).EventIndex;
      WindowHeight: Line_Position := 8;
      MoneyIndex2: Natural := 0;
      FreeSpace: Integer;
   begin
      ClearWindow := Create(Lines - 3, (Columns / 2), 3, (Columns / 2));
      Refresh_Without_Update(ClearWindow);
      Delete(ClearWindow);
      for I in Items_List.Iterate loop
         if To_String(Items_List(I).Name) = Name(Current(TradeMenu)) then
            ItemIndex := Objects_Container.To_Index(I);
            exit;
         end if;
      end loop;
      if CargoIndex > 0 then
         WindowHeight := WindowHeight + 1;
         if PlayerShip.Cargo(CargoIndex).Durability < 100 then
            WindowHeight := WindowHeight + 1;
         end if;
      end if;
      WindowHeight :=
        WindowHeight +
        Line_Position
          ((Length(Items_List(ItemIndex).Description) / Natural(Columns / 2)));
      BoxWindow := Create(WindowHeight, (Columns / 2), 3, (Columns / 2));
      Box(BoxWindow);
      Move_Cursor(Win => BoxWindow, Line => 0, Column => 2);
      Add(Win => BoxWindow, Str => "[Item info]");
      InfoWindow :=
        Create(WindowHeight - 2, (Columns / 2) - 4, 4, (Columns / 2) + 2);
      Add(Win => InfoWindow, Str => "Type: ");
      if Items_List(ItemIndex).ShowType = Null_Unbounded_String then
         Add(Win => InfoWindow, Str => To_String(Items_List(ItemIndex).IType));
      else
         Add
           (Win => InfoWindow,
            Str => To_String(Items_List(ItemIndex).ShowType));
      end if;
      Move_Cursor(Win => InfoWindow, Line => 1, Column => 0);
      if Items_List(ItemIndex).Buyable(BaseType) then
         Add(Win => InfoWindow, Str => "Base buy/sell price:");
      else
         Add(Win => InfoWindow, Str => "Base sell price:");
      end if;
      Price := Items_List(ItemIndex).Prices(BaseType);
      if EventIndex > 0 then
         if Events_List(EventIndex).EType = DoublePrice and
           Events_List(EventIndex).Data = ItemIndex then
            Price := Price * 2;
         end if;
      end if;
      Add
        (Win => InfoWindow,
         Str => Integer'Image(Price) & " " & To_String(MoneyName));
      Move_Cursor(Win => InfoWindow, Line => 2, Column => 0);
      Add
        (Win => InfoWindow,
         Str =>
           "Weight:" & Integer'Image(Items_List(ItemIndex).Weight) & " kg");
      if CargoIndex > 0 then
         Move_Cursor(Win => InfoWindow, Line => 3, Column => 0);
         Add
           (Win => InfoWindow,
            Str =>
              "Owned:" & Integer'Image(PlayerShip.Cargo(CargoIndex).Amount));
         if PlayerShip.Cargo(CargoIndex).Durability < 100 then
            Move_Cursor(Win => InfoWindow, Line => 4, Column => 0);
            Add(Win => InfoWindow, Str => "Status: ");
            ShowCargoStatus(CargoIndex, InfoWindow, 4);
            CurrentLine := 5;
         end if;
         CurrentLine := CurrentLine + 1;
      end if;
      if Items_List(ItemIndex).Description /= Null_Unbounded_String then
         Move_Cursor(Win => InfoWindow, Line => CurrentLine, Column => 0);
         Add
           (Win => InfoWindow,
            Str => To_String(Items_List(ItemIndex).Description));
         Get_Cursor_Position
           (Win => InfoWindow,
            Line => CurrentLine,
            Column => StartColumn);
      end if;
      CurrentLine := WindowHeight + 3;
      Move_Cursor(Line => CurrentLine, Column => (Columns / 2));
      if Items_List(ItemIndex).Buyable(BaseType) and CargoIndex > 0 then
         Add(Str => "Press ENTER to buy, SPACE for sell.");
         Change_Attributes
           (Line => CurrentLine,
            Column => (Columns / 2) + 6,
            Count => 5,
            Color => 1);
         Change_Attributes
           (Line => CurrentLine,
            Column => (Columns / 2) + 20,
            Count => 5,
            Color => 1);
      elsif Items_List(ItemIndex).Buyable(BaseType) and CargoIndex = 0 then
         Add(Str => "Press ENTER to buy.");
         Change_Attributes
           (Line => CurrentLine,
            Column => (Columns / 2) + 6,
            Count => 5,
            Color => 1);
      elsif not Items_List(ItemIndex).Buyable(BaseType) and CargoIndex > 0 then
         Add(Str => "Press SPACE for sell.");
         Change_Attributes
           (Line => CurrentLine,
            Column => (Columns / 2) + 6,
            Count => 5,
            Color => 1);
      end if;
      CurrentLine := CurrentLine + 1;
      MoneyIndex2 := FindCargo(FindProtoItem(MoneyIndex));
      Move_Cursor(Line => CurrentLine, Column => (Columns / 2));
      if MoneyIndex2 > 0 then
         Add
           (Str =>
              "You have" &
              Natural'Image(PlayerShip.Cargo(MoneyIndex2).Amount) &
              " " &
              To_String(MoneyName) &
              ".");
      else
         Add
           (Str =>
              "You don't have any " &
              To_String(MoneyName) &
              " to buy anything.");
      end if;
      CurrentLine := CurrentLine + 1;
      Move_Cursor(Line => CurrentLine, Column => (Columns / 2));
      FreeSpace := FreeCargo(0);
      if FreeSpace < 0 then
         FreeSpace := 0;
      end if;
      Add(Str => "Free cargo space:" & Integer'Image(FreeSpace) & " kg");
      CurrentLine := CurrentLine + 1;
      Move_Cursor(Line => CurrentLine, Column => (Columns / 2));
      if SkyBases(BaseIndex).Cargo(1).Amount = 0 then
         Add
           (Str =>
              "Base don't have any " &
              To_String(MoneyName) &
              "to buy anything.");
      else
         Add
           (Str =>
              "Base have" &
              Positive'Image(SkyBases(BaseIndex).Cargo(1).Amount) &
              " " &
              To_String(MoneyName) &
              ".");
      end if;
      Refresh_Without_Update;
      Refresh_Without_Update(BoxWindow);
      Delete(BoxWindow);
      Refresh_Without_Update(InfoWindow);
      Delete(InfoWindow);
      Refresh_Without_Update(MenuWindow);
      Update_Screen;
   end ShowItemInfo;

   procedure ShowTrade is
      Trade_Items: Item_Array_Access;
      BaseType: constant Positive :=
        Bases_Types'Pos
          (SkyBases(SkyMap(PlayerShip.SkyX, PlayerShip.SkyY).BaseIndex)
             .BaseType) +
        1;
      MenuHeight: Line_Position;
      MenuLength: Column_Position;
      MenuIndex: Integer := 1;
      ItemsAmount: Positive := 1;
      Added: Boolean;
   begin
      for Item of PlayerShip.Cargo loop
         if Items_List(Item.ProtoIndex).Prices(BaseType) > 0 then
            ItemsAmount := ItemsAmount + 1;
         end if;
      end loop;
      for I in Items_List.Iterate loop
         if Items_List(I).Buyable(BaseType) then
            Added := False;
            for Item of PlayerShip.Cargo loop
               if Item.ProtoIndex = Objects_Container.To_Index(I) and
                 Items_List(I).Prices(BaseType) > 0 then
                  Added := True;
                  exit;
               end if;
            end loop;
            if not Added then
               ItemsAmount := ItemsAmount + 1;
            end if;
         end if;
      end loop;
      Trade_Items := new Item_Array(1 .. ItemsAmount);
      for I in PlayerShip.Cargo.Iterate loop
         if Items_List(PlayerShip.Cargo(I).ProtoIndex).Prices(BaseType) >
           0 then
            Trade_Items.all(MenuIndex) :=
              New_Item
                (To_String(Items_List(PlayerShip.Cargo(I).ProtoIndex).Name),
                 Positive'Image(Cargo_Container.To_Index(I)));
            MenuIndex := MenuIndex + 1;
         end if;
      end loop;
      for I in Items_List.Iterate loop
         if Items_List(I).Buyable(BaseType) then
            Added := False;
            for Item of PlayerShip.Cargo loop
               if Item.ProtoIndex = Objects_Container.To_Index(I) and
                 Items_List(I).Prices(BaseType) > 0 then
                  Added := True;
                  exit;
               end if;
            end loop;
            if not Added then
               Trade_Items.all(MenuIndex) :=
                 New_Item(To_String(Items_List(I).Name), "0");
               MenuIndex := MenuIndex + 1;
            end if;
         end if;
      end loop;
      Trade_Items.all(MenuIndex) := Null_Item;
      TradeMenu := New_Menu(Trade_Items);
      Set_Options(TradeMenu, (Show_Descriptions => False, others => True));
      Set_Format(TradeMenu, Lines - 3, 1);
      Set_Mark(TradeMenu, "");
      Scale(TradeMenu, MenuHeight, MenuLength);
      MenuWindow := Create(MenuHeight, MenuLength, 3, 2);
      Set_Window(TradeMenu, MenuWindow);
      Set_Sub_Window
        (TradeMenu,
         Derived_Window(MenuWindow, MenuHeight, MenuLength, 0, 0));
      Post(TradeMenu);
      if Trade_Items.all(CurrentMenuIndex) = Null_Item then
         CurrentMenuIndex := 1;
      end if;
      Set_Current(TradeMenu, Trade_Items.all(CurrentMenuIndex));
      ShowItemInfo;
   end ShowTrade;

   function ShowTradeForm return GameStates is
      Trade_Fields: constant Field_Array_Access := new Field_Array(1 .. 6);
      BaseType: constant Positive :=
        Bases_Types'Pos
          (SkyBases(SkyMap(PlayerShip.SkyX, PlayerShip.SkyY).BaseIndex)
             .BaseType) +
        1;
      FieldOptions: Field_Option_Set;
      FormHeight: Line_Position;
      FormLength: Column_Position;
      Visibility: Cursor_Visibility := Normal;
      ItemIndex, Price: Positive;
      MaxAmount: Natural := 0;
      FieldText: Unbounded_String := To_Unbounded_String("Enter amount of ");
      EventIndex: constant Natural :=
        SkyMap(PlayerShip.SkyX, PlayerShip.SkyY).EventIndex;
   begin
      for I in Items_List.Iterate loop
         if To_String(Items_List(I).Name) = Name(Current(TradeMenu)) then
            ItemIndex := Objects_Container.To_Index(I);
            exit;
         end if;
      end loop;
      Append(FieldText, Items_List(ItemIndex).Name);
      Price := Items_List(ItemIndex).Prices(BaseType);
      if EventIndex > 0 then
         if Events_List(EventIndex).EType = DoublePrice and
           Events_List(EventIndex).Data = ItemIndex then
            Price := Price * 2;
         end if;
      end if;
      if Buy then
         if not Items_List(ItemIndex).Buyable(BaseType) then
            ShowDialog
              ("You can't buy " &
               To_String(Items_List(ItemIndex).Name) &
               " in this base.");
            DrawGame(Trade_View);
            return Trade_View;
         end if;
         for Item of PlayerShip.Cargo loop
            if Item.ProtoIndex = 1 then
               MaxAmount := Item.Amount / Price;
               exit;
            end if;
         end loop;
         Append(FieldText, " to buy");
      else
         if Description(Current(TradeMenu)) = "0" then
            ShowDialog
              ("You don't have any " &
               To_String(Items_List(ItemIndex).Name) &
               " for sale.");
            DrawGame(Trade_View);
            return Trade_View;
         end if;
         MaxAmount :=
           PlayerShip.Cargo(Integer'Value(Description(Current(TradeMenu))))
             .Amount;
         Append(FieldText, " to sell");
      end if;
      Append(FieldText, " (max" & Natural'Image(MaxAmount) & "): ");
      if TradeForm = Null_Form then
         Set_Cursor_Visibility(Visibility);
         Trade_Fields.all(1) :=
           New_Field(1, Column_Position(Length(FieldText)), 0, 0, 0, 0);
         FieldOptions := Get_Options(Trade_Fields.all(1));
         Set_Buffer(Trade_Fields.all(1), 0, To_String(FieldText));
         FieldOptions.Active := False;
         Set_Options(Trade_Fields.all(1), FieldOptions);
         Trade_Fields.all(2) :=
           New_Field(1, 20, 0, Column_Position(Length(FieldText)), 0, 0);
         FieldOptions := Get_Options(Trade_Fields.all(2));
         FieldOptions.Auto_Skip := False;
         Set_Options(Trade_Fields.all(2), FieldOptions);
         Set_Background
           (Trade_Fields.all(2),
            (Reverse_Video => True, others => False));
         Terminal_Interface.Curses.Forms.Field_Types.IntField.Set_Field_Type
           (Trade_Fields.all(2),
            (0, 0, MaxAmount));
         Trade_Fields.all(3) :=
           New_Field(1, 8, 2, (Column_Position(Length(FieldText)) / 2), 0, 0);
         Set_Buffer(Trade_Fields.all(3), 0, "[Cancel]");
         FieldOptions := Get_Options(Trade_Fields.all(3));
         FieldOptions.Edit := False;
         Set_Options(Trade_Fields.all(3), FieldOptions);
         Trade_Fields.all(4) :=
           New_Field
             (1,
              4,
              2,
              (Column_Position(Length(FieldText)) / 2) + 10,
              0,
              0);
         FieldOptions := Get_Options(Trade_Fields.all(4));
         FieldOptions.Edit := False;
         Set_Options(Trade_Fields.all(4), FieldOptions);
         Set_Buffer(Trade_Fields.all(4), 0, "[Ok]");
         if Buy then
            Trade_Fields.all(5) := Null_Field;
         else
            Trade_Fields.all(5) :=
              New_Field
                (1,
                 11,
                 2,
                 (Column_Position(Length(FieldText)) / 2) + 16,
                 0,
                 0);
            FieldOptions := Get_Options(Trade_Fields.all(5));
            FieldOptions.Edit := False;
            Set_Options(Trade_Fields.all(5), FieldOptions);
            Set_Buffer(Trade_Fields.all(5), 0, "[Sell all]");
         end if;
         Trade_Fields.all(6) := Null_Field;
         TradeForm := New_Form(Trade_Fields);
         Scale(TradeForm, FormHeight, FormLength);
         FormWindow :=
           Create
             (FormHeight + 2,
              FormLength + 2,
              ((Lines / 3) - (FormHeight / 2)),
              ((Columns / 2) - (FormLength / 2)));
         Box(FormWindow);
         Set_Window(TradeForm, FormWindow);
         Set_Sub_Window
           (TradeForm,
            Derived_Window(FormWindow, FormHeight, FormLength, 1, 1));
         Post(TradeForm);
      end if;
      Refresh_Without_Update;
      Refresh_Without_Update(FormWindow);
      Update_Screen;
      return Trade_Form;
   end ShowTradeForm;

   function TradeResult return GameStates is
      ItemIndex: Positive;
      CargoIndex: constant Natural :=
        Integer'Value(Description(Current(TradeMenu)));
      Visibility: Cursor_Visibility := Invisible;
      FieldIndex: constant Positive := Get_Index(Current(TradeForm));
   begin
      if FieldIndex < 3 then
         return Trade_Form;
      elsif FieldIndex > 3 then
         for I in Items_List.Iterate loop
            if To_String(Items_List(I).Name) = Name(Current(TradeMenu)) then
               ItemIndex := Objects_Container.To_Index(I);
               exit;
            end if;
         end loop;
         if not Buy then
            if FieldIndex = 4 then
               SellItems(CargoIndex, Get_Buffer(Fields(TradeForm, 2)));
            else
               SellItems
                 (CargoIndex,
                  Positive'Image(PlayerShip.Cargo.Element(CargoIndex).Amount));
            end if;
         else
            BuyItems(ItemIndex, Get_Buffer(Fields(TradeForm, 2)));
         end if;
      end if;
      Set_Cursor_Visibility(Visibility);
      Post(TradeForm, False);
      Delete(TradeForm);
      DrawGame(Trade_View);
      return Trade_View;
   end TradeResult;

   function TradeKeys(Key: Key_Code) return GameStates is
      Result: Menus.Driver_Result;
   begin
      case Key is
         when Character'Pos('q') | Character'Pos('Q') => -- Back to sky map
            CurrentMenuIndex := 1;
            DrawGame(Sky_Map_View);
            return Sky_Map_View;
         when 56 | KEY_UP => -- Select previous item to trade
            Result := Driver(TradeMenu, M_Up_Item);
            if Result = Request_Denied then
               Result := Driver(TradeMenu, M_Last_Item);
            end if;
         when 50 | KEY_DOWN => -- Select next item to trade
            Result := Driver(TradeMenu, M_Down_Item);
            if Result = Request_Denied then
               Result := Driver(TradeMenu, M_First_Item);
            end if;
         when 32 => -- Sell item
            Buy := False;
            return ShowTradeForm;
         when 10 => -- Buy item
            Buy := True;
            return ShowTradeForm;
         when Key_F1 => -- Show help
            Erase;
            ShowGameHeader(Help_Topic);
            ShowHelp(Trade_View, 3);
            return Help_Topic;
         when others =>
            Result := Driver(TradeMenu, Key);
            if Result /= Menu_Ok then
               Result := Driver(TradeMenu, M_Clear_Pattern);
               Result := Driver(TradeMenu, Key);
            end if;
      end case;
      if Result = Menu_Ok then
         ShowItemInfo;
      end if;
      CurrentMenuIndex := Menus.Get_Index(Current(TradeMenu));
      return Trade_View;
   end TradeKeys;

   function TradeFormKeys(Key: Key_Code) return GameStates is
      Result: Forms.Driver_Result;
      FieldIndex: Positive := Get_Index(Current(TradeForm));
   begin
      case Key is
         when KEY_UP => -- Select previous field
            Result := Driver(TradeForm, F_Previous_Field);
            FieldIndex := Get_Index(Current(TradeForm));
            if FieldIndex = 2 then
               Result := Driver(TradeForm, F_End_Line);
            end if;
         when KEY_DOWN => -- Select next field
            Result := Driver(TradeForm, F_Next_Field);
            FieldIndex := Get_Index(Current(TradeForm));
            if FieldIndex = 2 then
               Result := Driver(TradeForm, F_End_Line);
            end if;
         when 10 => -- quit/buy/sell
            return TradeResult;
         when Key_Backspace => -- delete last character
            if FieldIndex = 2 then
               Result := Driver(TradeForm, F_Delete_Previous);
               if Result = Form_Ok then
                  FieldIndex := Get_Index(Current(TradeForm));
                  if FieldIndex /= 2 then
                     Set_Current(TradeForm, Fields(TradeForm, 2));
                  end if;
               end if;
            end if;
         when KEY_DC => -- delete character at cursor
            if FieldIndex = 2 then
               Result := Driver(TradeForm, F_Delete_Char);
            end if;
         when KEY_RIGHT => -- Move cursor right
            if FieldIndex = 2 then
               Result := Driver(TradeForm, F_Right_Char);
            end if;
         when KEY_LEFT => -- Move cursor left
            if FieldIndex = 2 then
               Result := Driver(TradeForm, F_Left_Char);
            end if;
         when others =>
            Result := Driver(TradeForm, Key);
      end case;
      if Result = Form_Ok then
         if FieldIndex = 2 then
            Set_Background
              (Current(TradeForm),
               (Reverse_Video => True, others => False));
         else
            Set_Background(Fields(TradeForm, 2), (others => False));
         end if;
         Refresh(FormWindow);
      end if;
      return Trade_Form;
   end TradeFormKeys;

end Bases.UI.Trade;
