package classes.GameData.Map.Data.Ships 
{
	import classes.GameData.Map.Room;
	import classes.GameData.Map.Ship;
	import classes.GameData.GameState;
	import classes.GameData.ContentIndex;
	import classes.GLOBAL;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class BlackRoseInterior extends Ship
	{
		
		public function BlackRoseInterior() 
		{
			LocationIndex = "TheBlackRose";
			LocationName = "BLACKROSE";
			
			var airlock:Room = new Room();
			airlock.RoomIndex = "Airlock";
			airlock.RoomName = "Black Rose: Airlock";
			airlock.ShortName = "Blk.Rse. Arlk";
			airlock.EntryFunction = ContentIndex.theBlackRose.airlockFunction;
			airlock.MoveTime = 1;
			airlock.AddFlag(GLOBAL.AIRLOCK);
			airlock.AddFlag(GLOBAL.INDOOR);
			AddRoom(airlock);
		}
		
	}

}