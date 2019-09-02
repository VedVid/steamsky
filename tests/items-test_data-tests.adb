--  This package has been generated automatically by GNATtest.
--  You are allowed to add your code to the bodies of test routines.
--  Such changes will be kept during further regeneration of this file.
--  All code placed outside of test routine bodies will be lost. The
--  code intended to set up and tear down the test environment should be
--  placed into Items.Test_Data.

with AUnit.Assertions; use AUnit.Assertions;
with System.Assertions;

--  begin read only
--  id:2.2/00/
--
--  This section can be used to add with clauses if necessary.
--
--  end read only

with Ships; use Ships;

--  begin read only
--  end read only
package body Items.Test_Data.Tests is

--  begin read only
--  id:2.2/01/
--
--  This section can be used to add global variables and other elements.
--
--  end read only

--  begin read only
--  end read only
--  begin read only
   function Wrap_Test_FindProtoItem_f36791_112bba (ItemType: Unbounded_String)  return Unbounded_String
   is
   begin
      begin
         pragma Assert
           ((ItemType /= Null_Unbounded_String));
         null;
      exception
            when System.Assertions.Assert_Failure =>
               AUnit.Assertions.Assert
                 (False,
                  "req_sloc(items.ads:0):Test_FindProtoItem test requirement violated");
      end;
      declare
         Test_FindProtoItem_f36791_112bba_Result : constant Unbounded_String := GNATtest_Generated.GNATtest_Standard.Items.FindProtoItem (ItemType);
      begin
         begin
            pragma Assert
              (True);
            null;
         exception
            when System.Assertions.Assert_Failure =>
               AUnit.Assertions.Assert
                 (False,
                  "ens_sloc(items.ads:0:):Test_FindProtoItem test commitment violated");
         end;
         return Test_FindProtoItem_f36791_112bba_Result;
      end;
   end Wrap_Test_FindProtoItem_f36791_112bba;
--  end read only

--  begin read only
   procedure Test_FindProtoItem_test_findprotoitem (Gnattest_T : in out Test);
   procedure Test_FindProtoItem_f36791_112bba (Gnattest_T : in out Test) renames Test_FindProtoItem_test_findprotoitem;
--  id:2.2/f36791a587ee5451/FindProtoItem/1/0/test_findprotoitem/
   procedure Test_FindProtoItem_test_findprotoitem (Gnattest_T : in out Test) is
      function FindProtoItem (ItemType: Unbounded_String) return Unbounded_String renames Wrap_Test_FindProtoItem_f36791_112bba;
--  end read only

      pragma Unreferenced (Gnattest_T);

   begin

      Assert(FindProtoItem(To_Unbounded_String("Iron")) /= Null_Unbounded_String, "Can't find existing item.");
      Assert(FindProtoItem(To_Unbounded_String("sdfsfsdfdsfsd")) = Null_Unbounded_String, "Non existing item should return null string.");

--  begin read only
   end Test_FindProtoItem_test_findprotoitem;
--  end read only

--  begin read only
   function Wrap_Test_GetItemDamage_dedcfa_d584da (ItemDurability: Natural; ToLower: Boolean := False)  return String
   is
   begin
      declare
         Test_GetItemDamage_dedcfa_d584da_Result : constant String := GNATtest_Generated.GNATtest_Standard.Items.GetItemDamage (ItemDurability, ToLower);
      begin
         return Test_GetItemDamage_dedcfa_d584da_Result;
      end;
   end Wrap_Test_GetItemDamage_dedcfa_d584da;
--  end read only

--  begin read only
   procedure Test_GetItemDamage_test_getitemdamage (Gnattest_T : in out Test);
   procedure Test_GetItemDamage_dedcfa_d584da (Gnattest_T : in out Test) renames Test_GetItemDamage_test_getitemdamage;
--  id:2.2/dedcfaf3e24b7100/GetItemDamage/1/0/test_getitemdamage/
   procedure Test_GetItemDamage_test_getitemdamage (Gnattest_T : in out Test) is
      function GetItemDamage (ItemDurability: Natural; ToLower: Boolean := False) return String renames Wrap_Test_GetItemDamage_dedcfa_d584da;
--  end read only

      pragma Unreferenced (Gnattest_T);

   begin

      Assert(GetItemDamage(60) = "Damaged", "Returned wrong description for item durability.");
      Assert(GetItemDamage(60, True) = "damaged", "Not lowered description for item durability.");

--  begin read only
   end Test_GetItemDamage_test_getitemdamage;
--  end read only

--  begin read only
   function Wrap_Test_GetItemName_2db285_6191e0 (Item: InventoryData; DamageInfo, ToLower: Boolean := True)  return String
   is
   begin
      declare
         Test_GetItemName_2db285_6191e0_Result : constant String := GNATtest_Generated.GNATtest_Standard.Items.GetItemName (Item, DamageInfo, ToLower);
      begin
         return Test_GetItemName_2db285_6191e0_Result;
      end;
   end Wrap_Test_GetItemName_2db285_6191e0;
--  end read only

--  begin read only
   procedure Test_GetItemName_test_getitemname (Gnattest_T : in out Test);
   procedure Test_GetItemName_2db285_6191e0 (Gnattest_T : in out Test) renames Test_GetItemName_test_getitemname;
--  id:2.2/2db285163d74c283/GetItemName/1/0/test_getitemname/
   procedure Test_GetItemName_test_getitemname (Gnattest_T : in out Test) is
      function GetItemName (Item: InventoryData; DamageInfo, ToLower: Boolean := True) return String renames Wrap_Test_GetItemName_2db285_6191e0;
--  end read only

      pragma Unreferenced (Gnattest_T);
      Item: InventoryData := (ProtoIndex => To_Unbounded_String("2"), Amount => 1, Name => Null_Unbounded_String, Durability => 80, Price => 0);

   begin

      Assert(GetItemName(Item) = "Basic Rations (slightly used)", "Invalid item name with lowered damage info.");
      Assert(GetItemName(Item, False) = "Basic Rations", "Invalid item name.");
      Assert(GetItemName(Item, True, False) = "Basic Rations (Slightly used)", "Invalid item name with damage info.");
      Item.Name := To_Unbounded_String("New name");
      Assert(GetItemName(Item, False) = "New name", "Invalid item name with local name.");

--  begin read only
   end Test_GetItemName_test_getitemname;
--  end read only

--  begin read only
   procedure Wrap_Test_DamageItem_f848d1_f75741 (Inventory: in out Inventory_Container.Vector; ItemIndex: Positive; SkillLevel, MemberIndex: Natural := 0) 
   is
   begin
      begin
         pragma Assert
           ((ItemIndex <= Inventory.Last_Index));
         null;
      exception
         when System.Assertions.Assert_Failure =>
            AUnit.Assertions.Assert
              (False,
               "req_sloc(items.ads:0):Test_DamageItem test requirement violated");
      end;
      GNATtest_Generated.GNATtest_Standard.Items.DamageItem (Inventory, ItemIndex, SkillLevel, MemberIndex);
      begin
         pragma Assert
           (True);
         null;
      exception
         when System.Assertions.Assert_Failure =>
            AUnit.Assertions.Assert
              (False,
               "ens_sloc(items.ads:0:):Test_DamageItem test commitment violated");
      end;
   end Wrap_Test_DamageItem_f848d1_f75741;
--  end read only

--  begin read only
   procedure Test_DamageItem_test_damageitem (Gnattest_T : in out Test);
   procedure Test_DamageItem_f848d1_f75741 (Gnattest_T : in out Test) renames Test_DamageItem_test_damageitem;
--  id:2.2/f848d19e08f0418b/DamageItem/1/0/test_damageitem/
   procedure Test_DamageItem_test_damageitem (Gnattest_T : in out Test) is
   procedure DamageItem (Inventory: in out Inventory_Container.Vector; ItemIndex: Positive; SkillLevel, MemberIndex: Natural := 0) renames Wrap_Test_DamageItem_f848d1_f75741;
--  end read only

      pragma Unreferenced (Gnattest_T);

   begin

      for I in 1 .. 100 loop
         DamageItem(PlayerShip.Crew(1).Inventory, 1);
      end loop;
      Assert(True, "This test can only crash.");

--  begin read only
   end Test_DamageItem_test_damageitem;
--  end read only

--  begin read only
   function Wrap_Test_FindItem_40535b_d3c7d4 (Inventory: Inventory_Container.Vector; ProtoIndex, ItemType: Unbounded_String := Null_Unbounded_String; Durability: Natural := 101)  return Natural
   is
   begin
      declare
         Test_FindItem_40535b_d3c7d4_Result : constant Natural := GNATtest_Generated.GNATtest_Standard.Items.FindItem (Inventory, ProtoIndex, ItemType, Durability);
      begin
         return Test_FindItem_40535b_d3c7d4_Result;
      end;
   end Wrap_Test_FindItem_40535b_d3c7d4;
--  end read only

--  begin read only
   procedure Test_FindItem_test_finditem (Gnattest_T : in out Test);
   procedure Test_FindItem_40535b_d3c7d4 (Gnattest_T : in out Test) renames Test_FindItem_test_finditem;
--  id:2.2/40535b42aced5966/FindItem/1/0/test_finditem/
   procedure Test_FindItem_test_finditem (Gnattest_T : in out Test) is
      function FindItem (Inventory: Inventory_Container.Vector; ProtoIndex, ItemType: Unbounded_String := Null_Unbounded_String; Durability: Natural := 101) return Natural renames Wrap_Test_FindItem_40535b_d3c7d4;
--  end read only

      pragma Unreferenced (Gnattest_T);

   begin

      Assert(FindItem(PlayerShip.Crew(1).Inventory, To_Unbounded_String("66")) = 1, "Can't find item with ProtoIndex.");
      Assert(FindItem(Inventory => PlayerShip.Crew(1).Inventory, ItemType => To_Unbounded_String("Weapon")) = 1, "Can't find item wiht ItemType.");
      Assert(FindItem(PlayerShip.Crew(1).Inventory, To_Unbounded_String("tsdfsdf")) = 0, "Item with not existing ProtoIndex found.");
      Assert(FindItem(Inventory => PlayerShip.Crew(1).Inventory, ItemType => To_Unbounded_String("sdfsdfds")) = 0, "Item with non existing ItemType found.");

--  begin read only
   end Test_FindItem_test_finditem;
--  end read only

--  begin read only
   function Wrap_Test_GetItemChanceToDamage_71801d_da4763 (ItemData: Natural)  return String
   is
   begin
      declare
         Test_GetItemChanceToDamage_71801d_da4763_Result : constant String := GNATtest_Generated.GNATtest_Standard.Items.GetItemChanceToDamage (ItemData);
      begin
         return Test_GetItemChanceToDamage_71801d_da4763_Result;
      end;
   end Wrap_Test_GetItemChanceToDamage_71801d_da4763;
--  end read only

--  begin read only
   procedure Test_GetItemChanceToDamage_test_getitemchancetodamage (Gnattest_T : in out Test);
   procedure Test_GetItemChanceToDamage_71801d_da4763 (Gnattest_T : in out Test) renames Test_GetItemChanceToDamage_test_getitemchancetodamage;
--  id:2.2/71801da93fac4ec5/GetItemChanceToDamage/1/0/test_getitemchancetodamage/
   procedure Test_GetItemChanceToDamage_test_getitemchancetodamage (Gnattest_T : in out Test) is
      function GetItemChanceToDamage (ItemData: Natural) return String renames Wrap_Test_GetItemChanceToDamage_71801d_da4763;
--  end read only

      pragma Unreferenced (Gnattest_T);

   begin

      Assert(GetItemChanceToDamage(3) = "Small", "Wrong value returned for 3.");
      Assert(GetItemChanceToDamage(30) = "Very high", "Wrong value returned for 30.");

--  begin read only
   end Test_GetItemChanceToDamage_test_getitemchancetodamage;
--  end read only

--  begin read only
--  id:2.2/02/
--
--  This section can be used to add elaboration code for the global state.
--
begin
--  end read only
   null;
--  begin read only
--  end read only
end Items.Test_Data.Tests;