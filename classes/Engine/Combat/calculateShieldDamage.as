package classes.Engine.Combat 
{
	import classes.Creature;
	/**
	 * ...
	 * @author Gedan
	 */
	public function calculateShieldDamage(attacker:Creature, target:Creature, damage:int, damageType:int, special:String = ""):Array
	{
		var initDamage:Number = damage;
		var soakedDamage:Number = 0;
		var leftoverDamage:Number = 0;
		var shieldDefense:Number = 0;
		
		shieldDefense += target.shieldDefense();
		
		if (special == "ranged" && attacker.hasPerk("Armor Piercing"))
		{
			if (shieldDefense > 0) shieldDefense -= (attacker.level + rand(3));
			if (shieldDefense < 0) shieldDefense = 0;
		}
		
		damage -= shieldDefense;
		
		damage *= target.getShieldResistance(damageType);
		
		damage = Math.round(damage);
		
		// Cap damage to available shields
		if (damage > target.shieldsRaw)
		{
			damage = target.shieldsRaw;
			soakedDamage = (damage - shieldDefense) / target.getShieldResistance(damageType);
			leftoverDamage = initDamage - soakedDamage;
			
			if (leftoverDamage < 0) leftoverDamage = 0;
		}
		
		if (damage < 1) damage = 1;
		
		target.shieldsRaw -= damage;
		if (target.shieldsRaw < 0) target.shieldsRaw = 0;
		return [damage, leftoverDamage];
	}
}