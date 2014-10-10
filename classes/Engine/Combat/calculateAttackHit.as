package classes.Engine.Combat 
{
	import classes.Creature;
	import classes.GameData.Combat.GroundAttack;
	/**
	 * ...
	 * @author Gedan
	 */
	public function calculateAttackHit(attacker:Creature, target:Creature, attack:GroundAttack):Boolean
	{
		var accuracy:Number;
		
		if (attack.attackStatSelection == GroundAttack.ATTACK_STATS_MELEE)
		{
			accuracy = attacker.getMeleeAccuracy();
		}
		else if (attack.attackStatSelection == GroundAttack.ATTACK_STATS_RANGED)
		{
			accuracy = attacker.getRangedAccuracy();
		}
		else 
		{
			accuracy = attacker.getTechAccuracy();
		}
	}

}