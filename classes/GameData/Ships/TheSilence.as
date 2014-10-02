package classes.GameData.Ships 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public class TheSilence extends Ship
	{
		
		public function TheSilence() 
		{
			this.version = 1;
			
			INDEX = "SILENCE";
			shortName = "silence";
			longName = "silence";
			description = "Some description";
			a = "the ";
			A = "The ";
			
			currentLocation = "SilenceSystem";
			shipInterior = "TheSilence.Airlock";
			airlockConnectsTo = "";
			
			// TODO: Actual modules
			maxOffensiveModules = 5;
			maxDefensiveModules = 2;
			maxNavigationModules = 2;
		}
		
	}

}