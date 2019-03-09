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

with Ada.Containers.Hashed_Maps; use Ada.Containers;
with Ada.Containers.Vectors;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Hash;
with DOM.Readers; use DOM.Readers;
with Crew; use Crew;

package Mobs is

   type MobInventoryRecord is -- Data structure for mobs inventory
   record
      ProtoIndex: Unbounded_String; -- Proto index of item in mob inventory
      MinAmount: Natural; -- Minimal amount of item in mob inventory
      MaxAmount: Natural; -- Maximum amount of item in mob inventory
   end record;
   package MobInventory_Container is new Vectors(Positive, MobInventoryRecord);
   type ProtoMobRecord is -- Data structure for mobs prototypes
   record
      Skills: Skills_Container
        .Vector; -- Names indexes, levels and experience in skills of mob
      Attributes: Attributes_Container
        .Vector; -- Levels and experience in attributes of mob
      Order: Crew_Orders; -- Current order for mob
      Priorities: Orders_Array; -- Priority of orders of mob
      Inventory: MobInventory_Container.Vector; -- List of mob inventory
      Equipment: Equipment_Array; -- Items indexes from inventory used by mob: 1 - weapon, 2 - shield, 3 - helmet, 4 - torso, 5 - arms, 6 - legs, 7 - tool
   end record;
   package ProtoMobs_Container is new Hashed_Maps(Unbounded_String,
      ProtoMobRecord, Ada.Strings.Unbounded.Hash, "=");
   ProtoMobs_List: ProtoMobs_Container.Map;
   Mobs_Invalid_Data: exception; -- Raised when invalid data found in mobs file

   procedure LoadMobs(Reader: Tree_Reader); -- Load mobs from files

end Mobs;
