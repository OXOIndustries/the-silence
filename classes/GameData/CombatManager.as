package classes.GameData 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public class CombatManager 
	{
		private static var combatContainer:CombatContainer = null;
		
		public static function get inGroundCombat():Boolean
		{
			if (combatContainer == null) return false;
			if (combatContainer.combatMode == CombatContainer.COMBAT_GROUND) return true;
			return false;
		}
		
		public static function get inSpaceCombat():Boolean
		{
			if (combatContainer.combatMode == CombatContainer.COMBAT_SPACE) return true;
			return false;
		}
		
		public static function newGroundCombat():void
		{
			combatContainer = new GroundCombat();
		}
		
		public static function newSpaceCombat():void
		{
			combatContainer = new SpaceCombat();
		}
		
		public static function setPlayers(... args):void
		{
			combatContainer.setPlayers.apply(null, args);
		}
		
		public static function setEnemies(... args):void
		{
			combatContainer.setEnemies.call(null, args);
		}
		
		// Victory & Loss Condition indicators
		public static const ENTIRE_PARTY_DEFEATED:String = "all_defeated";
		public static const SURVIVE_WAVES:String = "survival";
		
		public static function victoryCondition(condition:String, arg:Number = Number.NaN):void
		{
			combatContainer.victoryCondition = condition;
			combatContainer.victoryArgument = arg;
		}
		
		public static function victoryScene(func:Function):void
		{
			combatContainer.victoryScene(func);
		}
		
		public static function lossCondition(condition:String, arg:Number = Number.NaN):void 
		{
			combatContainer.lossCondition = condition;
			combatContainer.victoryArgument = arg;
		}
		
		public static function lossScene(func:Function):void
		{
			combatContainer.lossScene(func);
		}
		
		public static function beginCombat():void
		{
			combatContainer.beginCombat();
		}
		
		public static function postCombat():void
		{
			combatContainer.doCombatCleanup();
			combatContainer = null;
		}
	}

}