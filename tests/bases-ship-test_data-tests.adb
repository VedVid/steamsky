--  This package has been generated automatically by GNATtest.
--  You are allowed to add your code to the bodies of test routines.
--  Such changes will be kept during further regeneration of this file.
--  All code placed outside of test routine bodies will be lost. The
--  code intended to set up and tear down the test environment should be
--  placed into Bases.Ship.Test_Data.

with AUnit.Assertions; use AUnit.Assertions;
with System.Assertions;

--  begin read only
--  id:2.2/00/
--
--  This section can be used to add with clauses if necessary.
--
--  end read only

--  begin read only
--  end read only
package body Bases.Ship.Test_Data.Tests is

--  begin read only
--  id:2.2/01/
--
--  This section can be used to add global variables and other elements.
--
--  end read only

--  begin read only
--  end read only
--  begin read only
   procedure Wrap_Test_RepairShip_41c4af_d40bee (ModuleIndex: Integer) 
   is
   begin
      begin
         pragma Assert
           ((ModuleIndex <= PlayerShip.Modules.Last_Index));
         null;
      exception
         when System.Assertions.Assert_Failure =>
            AUnit.Assertions.Assert
              (False,
               "req_sloc(bases-ship.ads:0):Test_RepairShip test requirement violated");
      end;
      GNATtest_Generated.GNATtest_Standard.Bases.Ship.RepairShip (ModuleIndex);
      begin
         pragma Assert
           (True);
         null;
      exception
         when System.Assertions.Assert_Failure =>
            AUnit.Assertions.Assert
              (False,
               "ens_sloc(bases-ship.ads:0:):Test_RepairShip test commitment violated");
      end;
   end Wrap_Test_RepairShip_41c4af_d40bee;
--  end read only

--  begin read only
   procedure Test_RepairShip_test_repairship (Gnattest_T : in out Test);
   procedure Test_RepairShip_41c4af_d40bee (Gnattest_T : in out Test) renames Test_RepairShip_test_repairship;
--  id:2.2/41c4af333c446830/RepairShip/1/0/test_repairship/
   procedure Test_RepairShip_test_repairship (Gnattest_T : in out Test) is
   procedure RepairShip (ModuleIndex: Integer) renames Wrap_Test_RepairShip_41c4af_d40bee;
--  end read only

      pragma Unreferenced (Gnattest_T);
      Durability: constant Positive := PlayerShip.Modules(1).Durability;

   begin

      PlayerShip.Modules(1).Durability := PlayerShip.Modules(1).Durability - 10;
      RepairShip(1);
      Assert(PlayerShip.Modules(1).Durability = Durability, "Failed to repair selected player ship module in base.");
      PlayerShip.Modules(1).Durability := PlayerShip.Modules(1).Durability - 10;
      RepairShip(0);
      Assert(PlayerShip.Modules(1).Durability = Durability, "Failed to repair player ship module in base.");

--  begin read only
   end Test_RepairShip_test_repairship;
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
end Bases.Ship.Test_Data.Tests;