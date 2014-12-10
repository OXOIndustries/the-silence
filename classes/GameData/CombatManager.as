package classes.GameData 
{
	import classes.Creature;
	import classes.GameData.Ships.TheSilence;
	import classes.Engine.Interfaces.clearOutput;
	/**
	 * ...
	 * @author Gedan
	 */
	public class CombatManager 
	{
		private static var combatContainer:CombatContainer = null;
		
		public static function get inCombat():Boolean
		{
			return (inGroundCombat || inSpaceCombat);
		}
		
		public static function get inGroundCombat():Boolean
		{
			if (combatContainer == null) return false;
			if (combatContainer.combatMode == CombatContainer.COMBAT_GROUND) return true;
			return false;
		}
		
		public static function get inSpaceCombat():Boolean
		{
			if (combatContainer == null) return false;
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
			if (args.length == 0) throw new Error("Invalid Arguments");
			if (args[0] is Array) combatContainer.setPlayers(args[0]);
			else combatContainer.setPlayers(args);
		}
		
		public static function setEnemies(... args):void
		{
			if (args.length == 0) throw new Error("Invalid Arguments");
			if (args[0] is Array) combatContainer.setEnemies(args[0]);
			else combatContainer.setEnemies(args);
		}
		
		// Victory & Loss Condition indicators
		public static const ENTIRE_PARTY_DEFEATED:String = "all_defeated";
		public static const SURVIVE_WAVES:String = "survival";
		public static const ESCAPE:String = "escape";
		
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
			combatContainer.lossArgument = arg;
		}
		
		public static function lossScene(func:Function):void
		{
			combatContainer.lossScene(func);
		}
		
		public static function entryScene(func:Function):void
		{
			combatContainer.entryFunction = func;
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
		
		public static function resetCombat():void
		{
			clearOutput();
			
			var exec:Function = combatContainer.entryFunction;
			combatContainer.doCombatCleanup();
			combatContainer = null;
			
			var players:Array = CharacterIndex.PlayerGroup.getParty();
			for (var i:int = 0; i < players.length; i++)
			{
				var char:Creature = players[i];
				char.HP(char.HPMax());
				char.shieldsRaw = char.shieldsMax();
				
				char.clearCombatStatuses();
			}
			
			var ship:TheSilence = ShipIndex.theSilence;
			ship.actualShieldHP = ship.maxShieldHP();
			ship.actualHullHP = ship.maxHullHP();
			ship.actualCapacitorCharge = ship.maxCapacitorCharge();
			
			exec();
		}
		
		public static function get GenericVictory():Function
		{
			return combatContainer.genericVictory;
		}
		
		public static function get GenericLoss():Function
		{
			return combatContainer.genericLoss;
		}
	}

}