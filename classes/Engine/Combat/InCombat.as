package classes.Engine.Combat 
{
	import classes.GameData.CombatManager;
	/**
	 * ...
	 * @author Gedan
	 */
	public function InCombat():Boolean
	{
		return CombatManager.inCombat;
	}

}