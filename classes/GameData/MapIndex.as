package classes.GameData 
{
	import classes.GameData.Map.Data.SilenceSector;
	import classes.GameData.Map.Room;
	import classes.GameData.Map.Sector;
	import classes.GameData.Map.Ship;
	
	import classes.Engine.Interfaces.*;
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
		
		public static function GetRoom(name:String):Room
		{
			return sector.GetSystem("SilenceSystem").GetLocation("TheSilence").GetRoom(name);
		}
		
		public static function executeRoom(name:String):void
		{
			var room:Room = GetRoom(name);
			setLocation(room.RoomName, "", "");
			
			clearMenu();
			showBust("none");
			
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
		
		public static function Move(tarRoom:String):void
		{
			
		}
		
	}

}