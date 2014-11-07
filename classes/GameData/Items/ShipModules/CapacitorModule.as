package classes.GameData.Items.ShipModules 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public class CapacitorModule extends ShipModule
	{
		
		public function CapacitorModule() 
		{
			type = ShipModule.TYPE_CAPACITOR;
		}
		
		// Total power that the capacitor can store.
		public var powerStorage:int = 500;
	}

}