package classes.GameData 
{
	import classes.GameData.Ships.BlackRose;
	import classes.GameData.Ships.TheSilence;
	import classes.GameData.Ships.Constellation;
	/**
	 * ...
	 * @author Gedan
	 */
	public class ShipIndex 
	{
		public static var Ships:Object;
		
		{
			Ships = new Object();
			
			ShipIndex.init(false);
		}
		
		public static function init(justUpdate:Boolean = false):void
		{
			initFor("SILENCE", TheSilence, justUpdate);
			initFor("CONSTELLATION", Constellation, justUpdate);
			initFor("BLACKROSE", BlackRose, justUpdate);
		}
		
		private static function initFor(idx:String, classT:Class, justUpdate:Boolean):void
		{
			if (!justUpdate || (justUpdate && Ships[idx] == undefined))
			{
				Ships[idx] = new classT();
			}
		}
		
		public static function get theSilence():TheSilence
		{
			return ShipIndex.Ships["SILENCE"];
		}
		
		public static function get theConstellation():Constellation
		{
			return ShipIndex.Ships["CONSTELLATION"];
		}
		
		public static function get theBlackRose():BlackRose
		{
			return ShipIndex.Ships["BLACKROSE"];
		}
		
	}

}