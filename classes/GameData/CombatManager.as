package classes.GameData 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public class CombatManager 
	{
		public static const COMBAT_NONE:int = 0;
		public static const COMBAT_GROUND:int = 1;
		public static const COMBAT_SPACE:int = 2;
		
		private static var combatMode:int = COMBAT_NONE;
		
		public static function get inGroundCombat():Boolean
		{
			if (combatMode == COMBAT_GROUND) return true;
			return false;
		}
		
		public static function get inSpaceCombat():Boolean
		{
			if (combatMode == COMBAT_SPACE) return true;
			return false;
		}
		
		public static function newGroundCombat():void
		{
			
		}
		
		public static function newSpaceCombat():void
		{
			
		}
		
		public static function setPlayers(... args):void
		{
			
		}
		
		public static function setEnemies(... args):void
		{
			
		}
		
		// Victory & Loss Condition indicators
		public static const ENTIRE_PARTY_DEFEATED:String = "all_defeated";
		public static const SURVIVE_WAVES:String = "survival";
		
		public static function victoryCondition(condition:String, arg:Number = Number.NaN):void
		{
			
		}
		
		public static function victoryScene(func:Function):void
		{
			
		}
		
		public static function lossCondition(condition:String, arg:Number = Number.NaN):void 
		{
			
		}
		
		public static function lossScene(func:Function):void
		{
			
		}
		
		public static function beginCombat():void
		{
			
		}
		
		public static function postCombat():void
		{
			
		}
	}

}