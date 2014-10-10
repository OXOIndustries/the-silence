package classes.GameData.Combat 
{
	import classes.Creature;
	import classes.GLOBAL;
	/**
	 * This is the base implementor for any attack used during ground combat.
	 * The idea is to generate an attack class, and index it inside the main CombatManager instance.
	 * Creatures store only the /indexes/ of attacks they have access to. When building a combat menu for a character, we can use that list to generate all the menus.
	 * This allows us to pretty easily reuse attacks across multiple creatures, as long as the attack text is written to support the idea that any given attack could be used by
	 * any creature, against any other creature or even itself.
	 * @author Gedan
	 */
	public class GroundAttack 
	{
		// All Attack names must be unique - they will be used to automatically generate effects applied to various Creatures to manage how the attack works.
		public var shortName:String = "";
		public var longName:String = "";
		public var tooltip:String = "";
		
		// Classification will be used to automatically wire up menus for all attacks
		public var attackClassification:int = 0;
		public static const ATTACK_TYPE_DEFAULT_RANGED:int = 0;
		public static const ATTACK_TYPE_DEFAULT_MELEE:int = 1;
		public static const ATTACK_TYPE_SPECIAL:int = 2;
		public static const ATTACK_TYPE_ABILITY:int = 3;
		
		public var attackStatSelection:int = 0;
		public static const ATTACK_STATS_RANGED:int = 0;
		public static const ATTACK_STATS_MELEE:int = 1;
		public static const ATTACK_STATS_TECH:int = 2;
		public static const ATTACK_STATS_PSIONIC:int = 3;
		
		public var attackCanTarget:int = 0;
		public static const ATTACK_TYPE_ANY:int = 0;
		public static const ATTACK_TYPE_HOSTILES:int = 1;
		public static const ATTACK_TYPE_FRIENDLIES:int = 2;
		public static const ATTACK_TYPE_SELF:int = 3;
		public static const ATTACK_TYPE_FRIENDLIES_AND_SELF:int = 4;
		
		public var baseEnergy:Number = Number.NaN;
		public var baseCooldown:Number = Number.NaN;
		public var baseCharges:Number = Number.NaN;
		
		public var damageType:int = GLOBAL.KINETIC;
		public var baseDamage:int = 10;
		public var isAreaOfEffect:Boolean = false;
		public var aoeFoF:Boolean = true;
		
		public var missModifier:Number = 1.0;
		
		public function generateAttackText(attacker:Creature, target:Creature, damage:Number):void
		{
			
		}
		
		public function calculateAttackDamage(attacker:Creature, target:Creature):Number
		{
			
		}
		
		public function invoke(attacker:Creature, target:Creature):void
		{
			
		}
		
		/**
		 * Determine if this attack is available for usage for the creature attempting to utilise it.
		 * @return
		 */
		public function isAvailable(attacker:Creature):Boolean
		{
			if (baseEnergy != Number.NaN)
			{
				if (attacker.energy() >= baseEnergy) return true;
				return false;
			}
			else if (baseCooldown != Number.NaN)
			{
				if (attacker.hasStatusEffect(shortName + " attack cooldown")) return false;
				return true;
			}
			else if (baseCharges != Number.NaN)
			{
				if (attacker.hasStatusEffect(shortName + " charges used"))
				{
					if (baseCharges - attacker.statusEffectv1(shortName + " charges used") > 0) return true;
					return false;
				}
			}
			return true;
		}
		
		public function GroundAttack() 
		{
			
		}
		
	}

}