package classes.GameData.Ships 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public class Constellation extends Ship
	{
		
		public function Constellation() 
		{
			this.version = 1;
			
			INDEX = "CONSTELLATION";
			shortName = "constellation";
			longName = "constellation";
			description = "Some description.";
			a = "the ";
			A = "The ";
			
			currentLocation = "SilenceSystem";
			shipInterior = "TheConstellation.BreachCommand";
		}
		
	}

}