package classes.GameData 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public class SpaceCombat extends CombatContainer
	{
		private var _initForRound:int = -1;
		public function doneRoundActions():Boolean
		{
			if (!_initForRound == _roundCounter) return true;
			return false;
		}
		
		private var _attackSelections:Object = { };
		
		public function SpaceCombat() 
		{
			_combatMode = CombatContainer.COMBAT_SPACE;
		}
	}

}