package classes.GameData.Items.ShipModules 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public class ReactorModule extends ShipModule
	{
		
		public function ReactorModule() 
		{
			type = ShipModule.TYPE_REACTOR;
		}
		
		// Power generated per round.
		// Power not immedately consumed is split between the capacitor and the shields.
		public var powerGenerated:int = 100;
	}

}