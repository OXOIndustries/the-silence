package classes.GameData.Items.ShipModules 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public class DefensiveModule extends ShipModule
	{
		public static const DEF_UNDEFINED:String = "undef";
		public static const DEF_FREQUENCY_MODULATOR:String = "resistances";
		public static const DEF_HARVESTER:String = "harvester";
		public static const DEF_EVASIVE:String = "evasive";
		public static const DEF_EMISSION:String = "emission";
		public static const DEF_ECCMARRAY:String = "eccm";
		public static const DEF_SBATTERY:String = "sbattery";
		public static const DEF_SRECHARGER:String = "srecharger";
		public static const DEF_HULLREP:String = "hullrep";
		
		public function DefensiveModule() 
		{
			type = ShipModule.TYPE_DEFENSIVE;
		}
		
		public var defensiveType:String = DEF_UNDEFINED;
		
	}

}