--  This package has been generated automatically by GNATtest.
--  You are allowed to add your code to the bodies of test routines.
--  Such changes will be kept during further regeneration of this file.
--  All code placed outside of test routine bodies will be lost. The
--  code intended to set up and tear down the test environment should be
--  placed into Statistics.Test_Data.

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
package body Statistics.Test_Data.Tests is

--  begin read only
--  id:2.2/01/
--
--  This section can be used to add global variables and other elements.
--
--  end read only

--  begin read only
--  end read only
--  begin read only
   procedure Wrap_Test_UpdateDestroyedShips_708ec3_001497
     (ShipName: Unbounded_String) is
   begin
      begin
         pragma Assert(ShipName /= Null_Unbounded_String);
         null;
      exception
         when System.Assertions.Assert_Failure =>
            AUnit.Assertions.Assert
              (False,
               "req_sloc(statistics.ads:0):Test_UpdateDestroyedShips test requirement violated");
      end;
      GNATtest_Generated.GNATtest_Standard.Statistics.UpdateDestroyedShips
        (ShipName);
      begin
         pragma Assert(True);
         null;
      exception
         when System.Assertions.Assert_Failure =>
            AUnit.Assertions.Assert
              (False,
               "ens_sloc(statistics.ads:0:):Test_UpdateDestroyedShips test commitment violated");
      end;
   end Wrap_Test_UpdateDestroyedShips_708ec3_001497;
--  end read only

--  begin read only
   procedure Test_UpdateDestroyedShips_test_updatedestroyedships
     (Gnattest_T: in out Test);
   procedure Test_UpdateDestroyedShips_708ec3_001497
     (Gnattest_T: in out Test) renames
     Test_UpdateDestroyedShips_test_updatedestroyedships;
--  id:2.2/708ec30adf523180/UpdateDestroyedShips/1/0/test_updatedestroyedships/
   procedure Test_UpdateDestroyedShips_test_updatedestroyedships
     (Gnattest_T: in out Test) is
      procedure UpdateDestroyedShips(ShipName: Unbounded_String) renames
        Wrap_Test_UpdateDestroyedShips_708ec3_001497;
--  end read only

      pragma Unreferenced(Gnattest_T);

   begin

      UpdateDestroyedShips(To_Unbounded_String("Tiny pirates ship"));
      Assert
        (Gamestats.DestroyedShips.Length = 1,
         "Failed to add ship to destroyed ships list.");
      UpdateDestroyedShips(To_Unbounded_String("Sfdsfdsf"));
      Assert
        (Gamestats.DestroyedShips.Length = 1,
         "Failed to not add non existing ship to destroyed ships list.");

--  begin read only
   end Test_UpdateDestroyedShips_test_updatedestroyedships;
--  end read only

--  begin read only
   procedure Wrap_Test_ClearGameStats_97edec_31f9dd is
   begin
      GNATtest_Generated.GNATtest_Standard.Statistics.ClearGameStats;
   end Wrap_Test_ClearGameStats_97edec_31f9dd;
--  end read only

--  begin read only
   procedure Test_ClearGameStats_test_cleargamestats(Gnattest_T: in out Test);
   procedure Test_ClearGameStats_97edec_31f9dd(Gnattest_T: in out Test) renames
     Test_ClearGameStats_test_cleargamestats;
--  id:2.2/97edec1268a24200/ClearGameStats/1/0/test_cleargamestats/
   procedure Test_ClearGameStats_test_cleargamestats
     (Gnattest_T: in out Test) is
      procedure ClearGameStats renames Wrap_Test_ClearGameStats_97edec_31f9dd;
--  end read only

      pragma Unreferenced(Gnattest_T);

   begin

      ClearGameStats;
      Assert
        (Gamestats.DestroyedShips.Length = 0,
         "Failed to clear game statistics.");

--  begin read only
   end Test_ClearGameStats_test_cleargamestats;
--  end read only

--  begin read only
   procedure Wrap_Test_UpdateFinishedGoals_9c0615_51796d
     (Index: Unbounded_String) is
   begin
      begin
         pragma Assert(Index /= Null_Unbounded_String);
         null;
      exception
         when System.Assertions.Assert_Failure =>
            AUnit.Assertions.Assert
              (False,
               "req_sloc(statistics.ads:0):Test_UpdateFinishedGoals test requirement violated");
      end;
      GNATtest_Generated.GNATtest_Standard.Statistics.UpdateFinishedGoals
        (Index);
      begin
         pragma Assert(True);
         null;
      exception
         when System.Assertions.Assert_Failure =>
            AUnit.Assertions.Assert
              (False,
               "ens_sloc(statistics.ads:0:):Test_UpdateFinishedGoals test commitment violated");
      end;
   end Wrap_Test_UpdateFinishedGoals_9c0615_51796d;
--  end read only

--  begin read only
   procedure Test_UpdateFinishedGoals_test_updatefinishedgoals
     (Gnattest_T: in out Test);
   procedure Test_UpdateFinishedGoals_9c0615_51796d
     (Gnattest_T: in out Test) renames
     Test_UpdateFinishedGoals_test_updatefinishedgoals;
--  id:2.2/9c061556f3d17076/UpdateFinishedGoals/1/0/test_updatefinishedgoals/
   procedure Test_UpdateFinishedGoals_test_updatefinishedgoals
     (Gnattest_T: in out Test) is
      procedure UpdateFinishedGoals(Index: Unbounded_String) renames
        Wrap_Test_UpdateFinishedGoals_9c0615_51796d;
--  end read only

      pragma Unreferenced(Gnattest_T);

   begin

      UpdateFinishedGoals(To_Unbounded_String("1"));
      Assert
        (Gamestats.FinishedGoals.Length = 1,
         "Failed to add goal to finished goals list.");
      UpdateFinishedGoals(To_Unbounded_String("Sfdsfdsf"));
      Assert
        (Gamestats.FinishedGoals.Length = 1,
         "Failed to not add non existing goal to finished goals list.");

--  begin read only
   end Test_UpdateFinishedGoals_test_updatefinishedgoals;
--  end read only

--  begin read only
   procedure Wrap_Test_UpdateFinishedMissions_cda9ad_a624ba
     (MType: Unbounded_String) is
   begin
      begin
         pragma Assert(MType /= Null_Unbounded_String);
         null;
      exception
         when System.Assertions.Assert_Failure =>
            AUnit.Assertions.Assert
              (False,
               "req_sloc(statistics.ads:0):Test_UpdateFinishedMissions test requirement violated");
      end;
      GNATtest_Generated.GNATtest_Standard.Statistics.UpdateFinishedMissions
        (MType);
      begin
         pragma Assert(True);
         null;
      exception
         when System.Assertions.Assert_Failure =>
            AUnit.Assertions.Assert
              (False,
               "ens_sloc(statistics.ads:0:):Test_UpdateFinishedMissions test commitment violated");
      end;
   end Wrap_Test_UpdateFinishedMissions_cda9ad_a624ba;
--  end read only

--  begin read only
   procedure Test_UpdateFinishedMissions_test_updatefinishedmissions
     (Gnattest_T: in out Test);
   procedure Test_UpdateFinishedMissions_cda9ad_a624ba
     (Gnattest_T: in out Test) renames
     Test_UpdateFinishedMissions_test_updatefinishedmissions;
--  id:2.2/cda9ad2228e90d47/UpdateFinishedMissions/1/0/test_updatefinishedmissions/
   procedure Test_UpdateFinishedMissions_test_updatefinishedmissions
     (Gnattest_T: in out Test) is
      procedure UpdateFinishedMissions(MType: Unbounded_String) renames
        Wrap_Test_UpdateFinishedMissions_cda9ad_a624ba;
--  end read only

      pragma Unreferenced(Gnattest_T);

   begin

      UpdateFinishedMissions(To_Unbounded_String("DESTROY"));
      Assert
        (Gamestats.FinishedMissions.Length = 1,
         "Failed to add mission to finished missions list.");
      UpdateFinishedMissions(To_Unbounded_String("Sfdsfdsf"));
      Assert
        (Gamestats.FinishedGoals.Length = 1,
         "Failed to not add non existing mission to finished missions list.");

--  begin read only
   end Test_UpdateFinishedMissions_test_updatefinishedmissions;
--  end read only

--  begin read only
   procedure Wrap_Test_UpdateCraftingOrders_24cc96_7fc6ac
     (Index: Unbounded_String) is
   begin
      begin
         pragma Assert(Index /= Null_Unbounded_String);
         null;
      exception
         when System.Assertions.Assert_Failure =>
            AUnit.Assertions.Assert
              (False,
               "req_sloc(statistics.ads:0):Test_UpdateCraftingOrders test requirement violated");
      end;
      GNATtest_Generated.GNATtest_Standard.Statistics.UpdateCraftingOrders
        (Index);
      begin
         pragma Assert(True);
         null;
      exception
         when System.Assertions.Assert_Failure =>
            AUnit.Assertions.Assert
              (False,
               "ens_sloc(statistics.ads:0:):Test_UpdateCraftingOrders test commitment violated");
      end;
   end Wrap_Test_UpdateCraftingOrders_24cc96_7fc6ac;
--  end read only

--  begin read only
   procedure Test_UpdateCraftingOrders_test_updatecraftingorders
     (Gnattest_T: in out Test);
   procedure Test_UpdateCraftingOrders_24cc96_7fc6ac
     (Gnattest_T: in out Test) renames
     Test_UpdateCraftingOrders_test_updatecraftingorders;
--  id:2.2/24cc9698c39e0070/UpdateCraftingOrders/1/0/test_updatecraftingorders/
   procedure Test_UpdateCraftingOrders_test_updatecraftingorders
     (Gnattest_T: in out Test) is
      procedure UpdateCraftingOrders(Index: Unbounded_String) renames
        Wrap_Test_UpdateCraftingOrders_24cc96_7fc6ac;
--  end read only

      pragma Unreferenced(Gnattest_T);

   begin

      UpdateCraftingOrders(To_Unbounded_String("1"));
      Assert
        (GameStats.CraftingOrders.Length = 1,
         "Failed to add finished crafting order to game statistics.");

--  begin read only
   end Test_UpdateCraftingOrders_test_updatecraftingorders;
--  end read only

--  begin read only
   procedure Wrap_Test_UpdateKilledMobs_0403d9_0ca136
     (Mob: Member_Data; FractionName: Unbounded_String) is
   begin
      begin
         pragma Assert(FractionName /= Null_Unbounded_String);
         null;
      exception
         when System.Assertions.Assert_Failure =>
            AUnit.Assertions.Assert
              (False,
               "req_sloc(statistics.ads:0):Test_UpdateKilledMobs test requirement violated");
      end;
      GNATtest_Generated.GNATtest_Standard.Statistics.UpdateKilledMobs
        (Mob, FractionName);
      begin
         pragma Assert(True);
         null;
      exception
         when System.Assertions.Assert_Failure =>
            AUnit.Assertions.Assert
              (False,
               "ens_sloc(statistics.ads:0:):Test_UpdateKilledMobs test commitment violated");
      end;
   end Wrap_Test_UpdateKilledMobs_0403d9_0ca136;
--  end read only

--  begin read only
   procedure Test_UpdateKilledMobs_test_updatekilledmobs
     (Gnattest_T: in out Test);
   procedure Test_UpdateKilledMobs_0403d9_0ca136
     (Gnattest_T: in out Test) renames
     Test_UpdateKilledMobs_test_updatekilledmobs;
--  id:2.2/0403d9266b43dc2c/UpdateKilledMobs/1/0/test_updatekilledmobs/
   procedure Test_UpdateKilledMobs_test_updatekilledmobs
     (Gnattest_T: in out Test) is
      procedure UpdateKilledMobs
        (Mob: Member_Data; FractionName: Unbounded_String) renames
        Wrap_Test_UpdateKilledMobs_0403d9_0ca136;
--  end read only

      pragma Unreferenced(Gnattest_T);

   begin

      UpdateKilledMobs(PlayerShip.Crew(2), To_Unbounded_String("POLEIS"));
      Assert
        (Gamestats.KilledMobs.Length = 1,
         "Failed to add killed mob to game statistics.");

--  begin read only
   end Test_UpdateKilledMobs_test_updatekilledmobs;
--  end read only

--  begin read only
   function Wrap_Test_GetGamePoints_e274aa_4eed1d return Natural is
   begin
      declare
         Test_GetGamePoints_e274aa_4eed1d_Result: constant Natural :=
           GNATtest_Generated.GNATtest_Standard.Statistics.GetGamePoints;
      begin
         return Test_GetGamePoints_e274aa_4eed1d_Result;
      end;
   end Wrap_Test_GetGamePoints_e274aa_4eed1d;
--  end read only

--  begin read only
   procedure Test_GetGamePoints_test_getgamepoints(Gnattest_T: in out Test);
   procedure Test_GetGamePoints_e274aa_4eed1d(Gnattest_T: in out Test) renames
     Test_GetGamePoints_test_getgamepoints;
--  id:2.2/e274aadb0dece247/GetGamePoints/1/0/test_getgamepoints/
   procedure Test_GetGamePoints_test_getgamepoints(Gnattest_T: in out Test) is
      function GetGamePoints return Natural renames
        Wrap_Test_GetGamePoints_e274aa_4eed1d;
--  end read only

      pragma Unreferenced(Gnattest_T);

   begin

      Assert(GetGamePoints > -1, "This test can only crash.");

--  begin read only
   end Test_GetGamePoints_test_getgamepoints;
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
end Statistics.Test_Data.Tests;
