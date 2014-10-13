package classes.Engine.Combat 
{
	import classes.Creature;
	import classes.Engine.Interfaces.rand;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public function calculateMeleeMiss(attacker:Creature, target:Creature, overrideAttack:int = -1, missModifier:Number = 1.0):Boolean
	{
		// Perk forced misses
		if (target.hasPerk("Melee Immune")) return true;
		
		if (overrideAttack == -1) overrideAttack = attacker.meleeWeapon.attack;
		
		// Base miss
		if (!target.isImmobilized() && rand(100) + attacker.physique() / 5 + overrideAttack - target.reflexes() / 5 < 10 * missModifier)
		{
			return true;
		}
		
		// Evasion
		if (target.evasion() >= rand(100) + 1)
		{
			return true;
		}
		
		// Lucky Breaks
		if (target.hasPerk("Lucky Breaks") && rand(100) <= 9) return true;
		
		return false;
	}

}