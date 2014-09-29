package classes.GameData.Map 
{
	import classes.GameData.Content.BaseContent;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class Room
	{
		public function Room() 
		{
			
		}
		
		public var ParentLocation:BaseLocation;
		
		public var RoomIndex:String;		// Unique name within a Locale
		public var RoomName:String;			// Name to show on the UI
		public var ShortName:String;		// Shorter name to use for button interfaces.
		
		public var EntryFunction:Function;	// Function to run when entered.
		
		public var MoveTime:Number = 5;		// Minutes to pass when leaving.
		
		public var RoomFlags:Array = [];	// "Markup" of the room.
		
		public var NorthExit:String = "";
		public var NorthCondition:Function;
		
		public var EastExit:String = "";
		public var EastCondition:Function;
		
		public var SouthExit:String = "";
		public var SouthCondition:Function;
		
		public var WestExit:String = "";
		public var WestCondition:Function;
		
		public var InExit:String = "";
		public var InCondition:Function;
		public var InName:String = undefined;
		
		public var OutExit:String = "";
		public var OutCondition:Function;
		public var OutName:String = undefined;
		
		public var CanSaveInRoom:Boolean = true;
		
		public var ElevatorRooms:Array = [];
		
		public var MapPosition:Vector3D = null;
		public var MapIndex:int = -1;
		
		public function HasFlag(arg:int):Boolean
		{
			if (RoomFlags.indexOf(arg) != -1) return true;
			return false;
		}
		
		public function AddFlag(arg:int):void
		{
			if (RoomFlags.indexOf(arg) == -1)
			{
				RoomFlags.push(arg);
			}
		}
		
		public function RemoveFlag(arg:int):void
		{
			var idx:int = RoomFlags.indexOf(arg);
			if (idx != -1)
			{
				RoomFlags.splice(idx, 1);
			}
		}
	}

}