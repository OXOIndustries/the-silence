package classes.Engine.Combat 
{
	import classes.Creature;
	import classes.Engine.Interfaces.rand;
	import classes.GameData.Characters.PlayerCharacter;
	import classes.Engine.Utility.possessive;
	/**
	 * ...
	 * @author Gedan
	 */
	public function calculateDamage(attacker:Creature, target:Creature, baseDamage:int, damageType:int, special:String = "", supressOutput:Boolean = false):Number
	{
		var randomizer:Number = (rand(31) + 85) / 100;
		var damage:Number = baseDamage * randomizer;
		
		if (target.hasStatusEffect("Damage Reduction"))
		{
			damage *= Number(target.statusEffectv2("Damage Reduction") / 100.0);
		}
		
		var shieldDamage:Array = [];
		
		if (target.shieldsRaw > 0)
		{
			shieldDamage = calculateShieldDamage(attacker, target, damage, damageType, special);
			damage = shieldDamage[1];
			
			if (target.shieldsRaw > 0)
			{
				if (!supressOutput)
				{
					if (target is PlayerCharacter)
					{
						output(" Your shield crackles but holds. (<b>" + shieldDamage[0] + "</b>)");
					}
					else
					{
						if (target.plural) output(" " + target.a + possessive(target.short) + " shields crackle but hold. (<b>" + shieldDamage[0] + "</b>)");
						else output(" " + target.a + possessive(target.short) + " shields crackles but holds. (<b>" + shieldDamage[0] + "</b>)");
					}
				}
			}
			else
			{
				if (!supressOutput)
				{
					if (target is PlayerCharacter)
					{
						output(" There is a concussive boom and a tingling aftershock of energy as your shield is breached. (<b>" + shieldDamage[0] + "</b>)");
					}
					else
					{
						if (!target.plural) output(" There is a concussive boom and a tingling aftershock of energy as " + target.a + possessive(target.short) + " shield is breached. (<b>" + shieldDamage[0] + "</b>)");
						else output(" There is a concussive boom and a tingling aftershock of energy as " + target.a + possessive(target.short) + " shields are breached. (<b>" + shieldDamage[0] + "</b>)");
					}
				}
			}
		}
		
		if (damage >= 1)
		{
			damage = calculateHealthDamage(attacker, target, damage, damageType, special);
			if (shieldDamage[0] > 0)
			{
				if (!supressOutput)
				{
					if (target is PlayerCharacter)
					{
						output(" The attack continues on to connect with you! (<b>" + damage + "</b>)");
					}
					else
					{
						output(" The attack continues on to connect with " + target.a + target.short + "! (<b>" + damage + "</b>)");
					}
				}
			}
			else
			{
				if (!supressOutput)
				{
					output(" (<b>" + damage + "</b>)");
				}
			}
		}
	}
}