package classes.GameData 
{
	import classes.GameData.Map.BaseLocation;
	import classes.GameData.Map.Data.Ships.TheSilenceInterior;
	import classes.GameData.Map.Data.SilenceSector;
	import classes.GameData.Map.Place;
	import classes.GameData.Map.Room;
	import classes.GameData.Map.Sector;
	import classes.GameData.Map.Ship;
	import classes.GameData.Map.System;
	
	import classes.Engine.Interfaces.*;
	import classes.Engine.mainGameMenu;
	import classes.GameData.GameState;
	
	import classes.GLOBAL;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class MapIndex 
	{
		public static var sector:SilenceSector;
		
		{
			MapIndex.init();
		}
		
		public static function init():void
		{
			sector = new SilenceSector();
		}
		
		public static function displayRoom(room:String):void
		{
			var roomO:Room = FindRoom(room);
			executeRoom(roomO);
		}
		
		public static function executeRoom(room:Room):void
		{
			if (room.ParentLocation is Ship)
			{
				setLocation(room.RoomName, "SHIP: " + room.ParentLocation.LocationName, room.ParentLocation.ParentSystem.SystemName);
			}
			else
			{
				setLocation(room.RoomName, room.ParentLocation.LocationName, room.ParentLocation.ParentSystem.SystemName);
			}
			
			clearMenu();
			
			GameState.inSceneBlockSaving = false;
			GameState.encountersDisabled = true;
			
			addDisabledButton(2, "Inventory");
			addDisabledButton(3, "Masturbate");
			
			if (room.HasFlag(GLOBAL.BED))
			{
				addDisabledButton(4, "Sleep");
			}
			else
			{
				addDisabledButton(4, "Rest");
			}
			
			if (room.EntryFunction != undefined)
			{
				if (room.EntryFunction()) return;
			}

			if (DirectionCheck(room.NorthExit, room.NorthCondition))
				addButton(6, "North", Move, room.NorthExit);
			if (DirectionCheck(room.EastExit, room.EastCondition))
				addButton(12, "East", Move, room.EastExit);
			if (DirectionCheck(room.SouthExit, room.SouthCondition))
				addButton(11, "South", Move, room.SouthExit);
			if (DirectionCheck(room.WestExit, room.WestCondition))
				addButton(10, "West", Move, room.WestExit);
			if (DirectionCheck(room.InExit, room.InCondition))
				addButton(5, room.InName, Move, room.InExit);
			if (DirectionCheck(room.OutExit, room.OutCondition))
				addButton(7, room.OutName, Move, room.OutExit);
				
			// Show the minimap too!
			//this.userInterface.showMinimap();
			//var map:* = mapper.generateMap(currentLocation);
			//this.userInterface.setMapData(map);
			//
			// Enable the perk list button
			//(userInterface as GUI).perkDisplayButton.Activate();
		}
		
		private static function DirectionCheck(tarRoom:String, lockFunc:Function):Boolean
		{
			if (tarRoom)
			{
				if (lockFunc && lockFunc())
				{
					return true;
				}
				if (lockFunc && !lockFunc())
				{
					return false;
				}
				return true;
			}
			return false;
		}
		
		public static function Move(name:String):void
		{
			var room:Room = FindRoom(name);
			
			if (room != null)
			{
				processTime(room.MoveTime);
				
				var loc:String = "";
				if (room.ParentLocation is Ship)
				{
					loc = room.ParentLocation.LocationIndex + "." + room.RoomIndex;
				}
				else
				{
					loc = room.ParentLocation.ParentSystem.SystemIndex + "." + room.ParentLocation.LocationIndex + "." + room.RoomIndex;
				}
				GameState.currentLocation = loc;
				
				mainGameMenu();
			}
			else
			{
				throw new Error("Could not find the desired room!");
			}
		}
		
		public static function FindRoom(name:String):Room
		{
			if (name.indexOf(".") == -1)
			{
				name = RebuildFQName(name);
			}
			
			var exploded:Array = name.split(".");
			var room:Room;
			
			// Should be a ship -- ShipName.RoomName
			if (exploded.length == 2)
			{
				var ship:Ship = sector.GetShip(exploded[0]);
				room = ship.GetRoom(exploded[1]);
			}
			// Otherwise should be some a room nested within a system
			else
			{
				var system:System = sector.GetSystem(exploded[0]);
				var location:BaseLocation = system.GetLocation(exploded[1]);
				room = location.GetRoom(exploded[2]);
			}
			
			return room;
		}
		
		private static function RebuildFQName(name:String):String
		{
			var current:String = GameState.currentLocation;
			current = current.slice(0, current.lastIndexOf("."));
			current += "." + name;
			
			return current;
		}
	}
}