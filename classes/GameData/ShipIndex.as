package classes.GameData 
{
	import classes.GameData.Ships.TheSilence;
	/**
	 * ...
	 * @author Gedan
	 */
	public class ShipIndex 
	{
		public static var Ships:Object;
		
		public function ShipIndex() 
		{
			Ships = new Object();
			
			ShipIndex.init(false);
		}
		
		public static function init(justUpdate:Boolean = false):void
		{
			initFor("SILENCE", TheSilence, justUpdate);
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
		
	}

}