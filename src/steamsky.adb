--    Copyright 2016-2018 Bartek thindil Jasicki
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

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Directories; use Ada.Directories;
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with GNAT.Directory_Operations; use GNAT.Directory_Operations;
with Gtk.Main; use Gtk.Main;
with Gtk.Settings; use Gtk.Settings;
with Gtkada.Bindings; use Gtkada.Bindings;
with Glib; use Glib;
with Game; use Game;
with Config; use Config;
with Log; use Log;
with HallOfFame; use HallOfFame;
with MainMenu; use MainMenu;

procedure SteamSky is

   function UpdatePath
     (Path: in out Unbounded_String;
      PathName: String) return Boolean is
   begin
      if Element(Path, Length(Path)) /= Dir_Separator then
         Append(Path, Dir_Separator);
      end if;
      if not Ada.Directories.Exists(To_String(Path)) then
         if PathName /= "Save" then
            Put_Line
              ("Directory " &
               To_String(Path) &
               " not exists. You must use existing directory as " &
               To_Lower(PathName) &
               " directory.");
            return False;
         end if;
         Create_Path(To_String(Path));
      end if;
      LogMessage
        (PathName & " directory sets to: " & To_String(Path),
         Everything);
      return True;
   end UpdatePath;

begin
   Set_Directory(Dir_Name(Command_Name));
   -- Command line arguments
   for I in 1 .. Argument_Count loop
      if Argument(I)'Length > 8 then
         if Argument(I)(1 .. 8) = "--debug=" then
            for J in Debug_Types loop
               if To_Upper(Argument(I)(9 .. (Argument(I)'Last))) =
                 Debug_Types'Image(J) then
                  DebugMode := J;
                  exit;
               end if;
            end loop;
            StartLogging;
         elsif Argument(I)(1 .. 8) = "--datadi" then
            DataDirectory :=
              To_Unbounded_String(Argument(I)(11 .. (Argument(I)'Last)));
            if not UpdatePath(DataDirectory, "Data") then
               return;
            end if;
         elsif Argument(I)(1 .. 8) = "--savedi" then
            SaveDirectory :=
              To_Unbounded_String(Argument(I)(11 .. (Argument(I)'Last)));
            if not UpdatePath(SaveDirectory, "Save") then
               return;
            end if;
         elsif Argument(I)(1 .. 8) = "--docdir" then
            DocDirectory :=
              To_Unbounded_String(Argument(I)(10 .. (Argument(I)'Last)));
            if not UpdatePath(DocDirectory, "Documentation") then
               return;
            end if;
         end if;
      end if;
   end loop;

   if not LoadData then
      Put_Line
        ("Can't load game data. Probably missing file " &
         To_String(DataDirectory) &
         "game.dat");
      return;
   end if;

   LoadConfig;
   LoadHallOfFame;

   --  Initializes GtkAda
   Init;
   Set_On_Exception(On_Exception'Access);
   Set_Long_Property
     (Get_Default,
      "gtk-enable-animations",
      Glong(GameSettings.AnimationsEnabled),
      "");
   CreateMainMenu;
   Main;

   EndLogging;
exception
   when An_Exception : others =>
      SaveException(An_Exception, True);
end SteamSky;
