package classes.Engine.Combat 
{
	import classes.Creature;
	/**
	 * ...
	 * @author Gedan
	 */
	public function calculateMiss(attacker:Creature, target:Creature, isMelee:Boolean = false, overrideAttack:int = -1, missModifier:Number = 1.0):Boolean
	{
		if (isMelee) return calculateMeleeMiss(attacker, target, overrideAttack, missModifier);
		else return calculateRangedMiss(attacker, target, overrideAttack, missModifier);
	}
}