package classes.GameData.Map 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public class EnemyEncounter 
	{
		public function EnemyEncounter() 
		{
			
		}
		
		public var EnemyType:Class;
		
		public function IsEnabled():Boolean
		{
			return false;
		}
		
		public function EncounterFunction():Boolean
		{
			return false;
		}
	}

}