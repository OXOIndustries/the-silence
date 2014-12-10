package classes.GameData 
{
	import classes.StorageClass;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class CombatContainer 
	{
		public static const COMBAT_NONE:int = 0;
		public static const COMBAT_GROUND:int = 1;
		public static const COMBAT_SPACE:int = 2;
		
		public var genericLoss:Function;
		public var genericVictory:Function;
		
		protected var _combatMode:int = COMBAT_NONE;
		public function get combatMode():int { return _combatMode; }
		
		protected var _roundCounter:int = 0;
		public function get roundCounter():int { return _roundCounter; }
		
		protected var _entryFunction:Function;
		
		public function get entryFunction():Function { return _entryFunction; }
		public function set entryFunction(v:Function):void { _entryFunction = v; }
		
		protected var _victoryFunction:Function;
		protected var _lossFunction:Function;
		public function victoryScene(func:Function):void
		{
			_victoryFunction = func;
		}
		public function lossScene(func:Function):void
		{
			_lossFunction = func;
		}
		
		public function CombatContainer() 
		{
			
		}
		
		protected var _friendlies:Array = null;
		protected var _hostiles:Array = null;
		
		public var noImportProcess:Boolean = false;
		
		public function setPlayers(... args):void
		{
			throw new Error("OVERRIDE ME");
		}
		public function setEnemies(... args):void 
		{
			throw new Error("OVERRIDE ME");
		}
		
		public var victoryCondition:String = CombatManager.ENTIRE_PARTY_DEFEATED;
		public var victoryArgument:Number = Number.NaN;
		public var lossCondition:String = CombatManager.ENTIRE_PARTY_DEFEATED;
		public var lossArgument:Number = Number.NaN;
		
		protected var _combatEffects:Object = {};
		public function addCombatEffect(effect:StorageClass):void
		{
			if (!hasCombatEffect(effect.storageName))
			{
				_combatEffects[effect.storageName] = effect;
			}
		}
		public function removeCombatEffect(index:String):void
		{
			if (hasCombatEffect(index))
			{
				delete _combatEffects[index];
			}
		}
		public function hasCombatEffect(index:String):Boolean
		{
			if (_combatEffects[index] != undefined) return true;
			return false;
		}
		
		public function doCombatCleanup():void
		{
			throw new Error("OVERRIDE ME");
		}
		
		public function beginCombat():void
		{
			throw new Error("OVERRIDE ME");
		}
	}
}