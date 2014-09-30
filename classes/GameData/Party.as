package classes.GameData 
{
	import classes.DataManager.Serialization.UnversionedSaveable;
	/**
	 * ...
	 * @author Gedan
	 */
	public class Party extends UnversionedSaveable
	{
		private var _charactersInParty:Array;
				
		public function Party() 
		{
			_charactersInParty = new Array();
		}
		
		
	}

}