package classes.GameData.Items.ShipModules 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public class EngineModule extends ShipModule
	{
		
		public function EngineModule() 
		{
			type = ShipModule.TYPE_ENGINE;
		}
		
		// Bonus multiplier applied to the ship hulls agility.
		public var agilityModifier:Number = 1.0;
		
		// Used as an additional input to agility, but isolated as the speed bonus will revolve around the speed of both ships.
		public var maneuveringSpeed:Number = 5.0;
	}

}