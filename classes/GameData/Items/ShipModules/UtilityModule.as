package classes.GameData.Items.ShipModules 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public class UtilityModule extends ShipModule
	{
		public static const UTIL_UNDEF:String = "undef";
		public static const UTIL_CREWQ:String = "crewq";
		public static const UTIL_HOLODECK:String = "holodeck";
		public static const UTIL_JAIL:String = "jail";
		public static const UTIL_SCANNER:String = "scanner";
		public static const UTIL_MEDICAL:String = "medical"
		
		public function UtilityModule() 
		{
			type = ShipModule.TYPE_UTILITY;
		}
		
		public var utililtyType:String = UTIL_UNDEF;
		
		public var bonusCrewComplement:int = 0;
	}

}