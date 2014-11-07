package classes.GameData.Items.ShipModules 
{
	import classes.DataManager.Serialization.ItemSaveable;
	import classes.DataManager.Serialization.VersionedSaveable;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class ShipModule extends ItemSaveable
	{
		public static const TYPE_WEAPON:String = "weapon";
		public static const TYPE_DEFENSIVE:String = "defensive";
		public static const TYPE_NAVIGATION:String = "navigation";
		public static const TYPE_UTILITY:String = "utility";
		
		// Specialised modules, of which only one may be present on a ship at a time.
		public static const TYPE_LIGHTDRIVE:String = "lightdrive";
		public static const TYPE_SHIELD:String = "shield";
		public static const TYPE_ENGINE:String = "engine";
		public static const TYPE_REACTOR:String = "reactor";
		public static const TYPE_CAPACITOR:String = "capacitor";
		
		public function ShipModule() 
		{
			
		}
		
		public var type:String = TYPE_UTILITY;
		public var powergrid:int = 100;
		public var powerconsumption:Number = 10;
		public var moduleRemovable:Boolean = true;
		
		public var moduleShortName:String = "";
		public var moduleFullName:String = "";
		public var moduleDescription:String = "";
		
	}

}