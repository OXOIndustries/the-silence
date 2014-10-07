package classes.GameData 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public class CombatContainer 
	{
		public static const COMBAT_NONE:int = 0;
		public static const COMBAT_GROUND:int = 1;
		public static const COMBAT_SPACE:int = 2;
		
		protected var _combatMode:int = COMBAT_NONE;
		public function get combatMode():int { return _combatMode; }
		
		public function CombatContainer() 
		{
			
		}
	}

}