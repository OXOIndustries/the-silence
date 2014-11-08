package classes.GameData.Items.ShipModules 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public class NavigationModule extends ShipModule
	{
		public static const NAV_UNDEF:String = "undef";
		public static const NAV_MASKER:String = "masker";
		
		public function NavigationModule() 
		{
			type = ShipModule.TYPE_NAVIGATION;
		}
		
		public var navType:String = NAV_UNDEF;
		public var escapeChanceMultiplier:Number = 0;
	}

}