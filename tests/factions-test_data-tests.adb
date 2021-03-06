--  This package has been generated automatically by GNATtest.
--  You are allowed to add your code to the bodies of test routines.
--  Such changes will be kept during further regeneration of this file.
--  All code placed outside of test routine bodies will be lost. The
--  code intended to set up and tear down the test environment should be
--  placed into Factions.Test_Data.

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
package body Factions.Test_Data.Tests is

--  begin read only
--  id:2.2/01/
--
--  This section can be used to add global variables and other elements.
--
--  end read only

--  begin read only
--  end read only
--  begin read only
   function Wrap_Test_GetReputation_f138bb_fd71d1
     (SourceFaction, TargetFaction: Unbounded_String) return Integer is
   begin
      begin
         pragma Assert
           ((Factions_Container.Contains(Factions_List, SourceFaction) and
             Factions_Container.Contains(Factions_List, TargetFaction)));
         null;
      exception
         when System.Assertions.Assert_Failure =>
            AUnit.Assertions.Assert
              (False,
               "req_sloc(factions.ads:0):Test_GetReputation test requirement violated");
      end;
      declare
         Test_GetReputation_f138bb_fd71d1_Result: constant Integer :=
           GNATtest_Generated.GNATtest_Standard.Factions.GetReputation
             (SourceFaction, TargetFaction);
      begin
         begin
            pragma Assert(True);
            null;
         exception
            when System.Assertions.Assert_Failure =>
               AUnit.Assertions.Assert
                 (False,
                  "ens_sloc(factions.ads:0:):Test_GetReputation test commitment violated");
         end;
         return Test_GetReputation_f138bb_fd71d1_Result;
      end;
   end Wrap_Test_GetReputation_f138bb_fd71d1;
--  end read only

--  begin read only
   procedure Test_GetReputation_test_getreputation(Gnattest_T: in out Test);
   procedure Test_GetReputation_f138bb_fd71d1(Gnattest_T: in out Test) renames
     Test_GetReputation_test_getreputation;
--  id:2.2/f138bbb5c8b2b971/GetReputation/1/0/test_getreputation/
   procedure Test_GetReputation_test_getreputation(Gnattest_T: in out Test) is
      function GetReputation
        (SourceFaction, TargetFaction: Unbounded_String) return Integer renames
        Wrap_Test_GetReputation_f138bb_fd71d1;
--  end read only

      pragma Unreferenced(Gnattest_T);

   begin

      Assert
        (GetReputation
           (To_Unbounded_String("POLEIS"), To_Unbounded_String("POLEIS")) =
         0,
         "Failed to get reputation for Poleis to Poleis.");
      Assert
        (GetReputation
           (To_Unbounded_String("POLEIS"), To_Unbounded_String("PIRATES")) =
         -10,
         "Failed to get reputation for Poleis to Pirates.");

--  begin read only
   end Test_GetReputation_test_getreputation;
--  end read only

--  begin read only
   function Wrap_Test_IsFriendly_868bec_b689c9
     (SourceFaction, TargetFaction: Unbounded_String) return Boolean is
   begin
      begin
         pragma Assert
           ((Factions_Container.Contains(Factions_List, SourceFaction) and
             Factions_Container.Contains(Factions_List, TargetFaction)));
         null;
      exception
         when System.Assertions.Assert_Failure =>
            AUnit.Assertions.Assert
              (False,
               "req_sloc(factions.ads:0):Test_IsFriendly test requirement violated");
      end;
      declare
         Test_IsFriendly_868bec_b689c9_Result: constant Boolean :=
           GNATtest_Generated.GNATtest_Standard.Factions.IsFriendly
             (SourceFaction, TargetFaction);
      begin
         begin
            pragma Assert(True);
            null;
         exception
            when System.Assertions.Assert_Failure =>
               AUnit.Assertions.Assert
                 (False,
                  "ens_sloc(factions.ads:0:):Test_IsFriendly test commitment violated");
         end;
         return Test_IsFriendly_868bec_b689c9_Result;
      end;
   end Wrap_Test_IsFriendly_868bec_b689c9;
--  end read only

--  begin read only
   procedure Test_IsFriendly_test_isfriendly(Gnattest_T: in out Test);
   procedure Test_IsFriendly_868bec_b689c9(Gnattest_T: in out Test) renames
     Test_IsFriendly_test_isfriendly;
--  id:2.2/868bec8bf6fd9c98/IsFriendly/1/0/test_isfriendly/
   procedure Test_IsFriendly_test_isfriendly(Gnattest_T: in out Test) is
      function IsFriendly
        (SourceFaction, TargetFaction: Unbounded_String) return Boolean renames
        Wrap_Test_IsFriendly_868bec_b689c9;
--  end read only

      pragma Unreferenced(Gnattest_T);

   begin

      Assert
        (IsFriendly
           (To_Unbounded_String("POLEIS"),
            To_Unbounded_String("INDEPENDENT")) =
         True,
         "Failed to check two friendly factions.");
      Assert
        (IsFriendly
           (To_Unbounded_String("POLEIS"), To_Unbounded_String("PIRATES")) =
         False,
         "Failed to check two unfriendly factions.");

--  begin read only
   end Test_IsFriendly_test_isfriendly;
--  end read only

--  begin read only
   function Wrap_Test_GetRandomFaction_47dd81_103989 return Unbounded_String is
   begin
      declare
         Test_GetRandomFaction_47dd81_103989_Result: constant Unbounded_String :=
           GNATtest_Generated.GNATtest_Standard.Factions.GetRandomFaction;
      begin
         return Test_GetRandomFaction_47dd81_103989_Result;
      end;
   end Wrap_Test_GetRandomFaction_47dd81_103989;
--  end read only

--  begin read only
   procedure Test_GetRandomFaction_test_getrandomfaction
     (Gnattest_T: in out Test);
   procedure Test_GetRandomFaction_47dd81_103989
     (Gnattest_T: in out Test) renames
     Test_GetRandomFaction_test_getrandomfaction;
--  id:2.2/47dd8179e978586a/GetRandomFaction/1/0/test_getrandomfaction/
   procedure Test_GetRandomFaction_test_getrandomfaction
     (Gnattest_T: in out Test) is
      function GetRandomFaction return Unbounded_String renames
        Wrap_Test_GetRandomFaction_47dd81_103989;
--  end read only

      pragma Unreferenced(Gnattest_T);
      FactionName: Unbounded_String := Null_Unbounded_String;

   begin

      FactionName := GetRandomFaction;
      Assert
        (FactionName /= Null_Unbounded_String,
         "Failed to get random faction name. Empty name.");
      Assert
        (Factions_List.Contains(FactionName),
         "Failed to get random faction name. Got not existing name.");

--  begin read only
   end Test_GetRandomFaction_test_getrandomfaction;
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
end Factions.Test_Data.Tests;
