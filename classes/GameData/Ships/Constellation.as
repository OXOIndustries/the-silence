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
			this._latestVersion = 1;
			
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