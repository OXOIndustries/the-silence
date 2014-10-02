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
		
		public function ShipModule() 
		{
			
		}
		
		public var type:String = TYPE_UTILITY;
		public var powergrid:int = 100;
		public var moduleRemovable:Boolean = true;
		
		public var moduleShortName:String = "";
		public var moduleFullName:String = "";
		public var moduleDescription:String = "";
		
	}

}