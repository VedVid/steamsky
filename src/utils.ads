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

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Game; use Game;

package Utils is

-- ****f* Utils/GetRandom
-- FUNCTION
-- Return random number from Min to Max range
-- SOURCE
   function GetRandom(Min, Max: Integer) return Integer;
-- ****
-- ****f* Utils/DaysDifference
-- FUNCTION
-- Return days difference between selected date and current game date
-- SOURCE
   function DaysDifference(DateToCompare: Date_Record) return Natural;
-- ****
-- ****f* Utils/GenerateRoboticName
-- FUNCTION
-- Generate robotic type name for bases, mobs, ships, etc
-- SOURCE
   function GenerateRoboticName return Unbounded_String;
-- ****

end Utils;
