package classes.Engine.Combat 
{
	import classes.Creature;
	/**
	 * ...
	 * @author Gedan
	 */
	public function calculateHealthDamage(attacker:Creature, target:Creature, damage:int, damageType:int, special:String = ""):Number
	{
		var defense:Number = target.defense();
		
		if (special == "ranged" && target.hasPerk("Armor Piercing"))
		{
			if (defense > 0) temp -= (target.level + rand(3));
			if (defense < 0) temp = 0;
		}
		
		damage -= defense;
		
		damage *= target.getResistance(damageType);
		
		damage = Math.round(damage);
		
		if (damage > target.HP())
		{
			damage = target.HP();
		}
		
		if (damage < 1) damage = 1;
		victim.HP( -damage);
		
		return damage;
	}

}