package classes.Engine.Combat 
{
	import classes.Creature;
	import classes.Engine.Interfaces.rand;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public function calculateRangedMiss(attacker:Creature, target:Creature, overrideAttack:int = -1, missModifier:Number = 1.0):Boolean
	{
		// Perk forced misses
		if (target.hasPerk("Ranged Immune")) return true;
		
		// If override wasn't specified, grab the correct attack value
		if (overrideAttack == -1) overrideAttack = attacker.rangedWeapon.attack;
		
		// Base miss
		if (!target.isImmobilized() && rand(100) + attacker.aim() / 5 + overrideAttack - target.reflexes() / 3 < 10 * missModifier)
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