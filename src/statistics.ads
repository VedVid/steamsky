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

with Ada.Containers.Vectors; use Ada.Containers;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Crew; use Crew;

package Statistics is

-- ****t* Statistics/Statistics_Data
-- FUNCTION
-- Data for finished goals, destroyed ships and killed mobs
-- SOURCE
   type Statistics_Data is record
      Index: Unbounded_String; -- Index of goal or ship name or name of fraction of killed mobs
      Amount: Positive; -- Amount of finished goals or ships or mobs of that type
   end record;
-- ****

-- ****t* Statistics/Statistics_Container
-- SOURCE
   package Statistics_Container is new Vectors(Positive, Statistics_Data);
-- ****

-- ****t* Statistics/GameStats_Data
-- FUNCTION
-- Data for game statistics
-- SOURCE
   type GameStats_Data is record
      DestroyedShips: Statistics_Container
        .Vector; -- Data for all destroyed ships by player
      BasesVisited: Positive; -- Amount of visited bases
      MapVisited: Positive; -- Amount of visited map fields
      DistanceTraveled: Natural; -- Amount of map fields travelled
      CraftingOrders: Statistics_Container
        .Vector; -- Data for finished crafting orders
      AcceptedMissions: Natural; -- Amount of accepted missions
      FinishedMissions: Statistics_Container
        .Vector; -- Data for all finished missions
      FinishedGoals: Statistics_Container
        .Vector; -- Data for all finished goals
      KilledMobs: Statistics_Container
        .Vector; -- Data for all mobs killed by player
      Points: Natural; -- Amount of gained points
   end record;
-- ****
-- ****v* Statistics/GameStats
-- FUNCTION
-- Game statistics
-- SOURCE
   GameStats: GameStats_Data;
-- ****

-- ****f* Statistics/UpdateDestroyedShips
-- FUNCTION
-- Add new destroyed ship to list
-- SOURCE
   procedure UpdateDestroyedShips(ShipName: Unbounded_String) with
      Pre => ShipName /= Null_Unbounded_String;
-- ****
-- ****f* Statistics/ClearGameStats;
-- FUNCTION
-- Clear game statistics
-- SOURCE
   procedure ClearGameStats;
-- ****
-- ****f* Statistics/UpdateFinishedGoals
-- FUNCTION
-- Add new finished goal to list
-- SOURCE
   procedure UpdateFinishedGoals(Index: Unbounded_String) with
      Pre => Index /= Null_Unbounded_String;
-- ****
-- ****f* Statistics/UpdateFinishedMissions
-- FUNCTION
-- Add new finished mission to list
-- SOURCE
   procedure UpdateFinishedMissions(MType: Unbounded_String) with
      Pre => MType /= Null_Unbounded_String;
-- ****
-- ****f* Statistics/UpdateCraftingOrders
-- FUNCTION
-- Add new finished crafting order to list
-- SOURCE
   procedure UpdateCraftingOrders(Index: Unbounded_String) with
      Pre => Index /= Null_Unbounded_String;
-- ****
-- ****f* Statistics/UpdateKilledMobs
-- FUNCTION
-- Add new killed mob to list
-- SOURCE
   procedure UpdateKilledMobs
     (Mob: Member_Data; FractionName: Unbounded_String) with
      Pre => FractionName /= Null_Unbounded_String;
-- ****
-- ****f* Statistics/GetGamePoints
-- FUNCTION
-- Get amount of gained points multiplied by difficulty bonus
-- SOURCE
   function GetGamePoints return Natural;
-- ****

end Statistics;
