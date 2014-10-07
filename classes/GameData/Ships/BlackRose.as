package classes.GameData.Ships 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public class BlackRose extends Ship
	{
		
		public function BlackRose() 
		{
			this.version = 1;
			
			INDEX = "BLACKROSE";
			shortName = "black rose";
			longName = "black rose";
			description = "Some description.";
			a = "the ";
			A = "The ";
			
			currentLocation = "SilenceSystem";
			shipInterior = "TheBlackRose.Airlock";
		}
		
	}

}