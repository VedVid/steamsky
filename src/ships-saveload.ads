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

with DOM.Core; use DOM.Core;

package Ships.SaveLoad is

-- ****f* Ships.SaveLoad/SavePlayerShip
-- FUNCTION
-- Save player ship to file
-- SOURCE
   procedure SavePlayerShip(SaveData: Document; MainNode: DOM.Core.Element);
-- ****
-- ****f* Ships.SaveLoad/LoadPlayerShip
-- FUNCTION
-- Load saved player ship from file
-- SOURCE
   procedure LoadPlayerShip(SaveData: Document);
-- ****

end Ships.SaveLoad;
