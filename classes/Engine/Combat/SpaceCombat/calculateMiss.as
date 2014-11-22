package classes.Engine.Combat.SpaceCombat 
{
	import classes.GameData.Items.ShipModules.OffensiveModule;
	import classes.GameData.Ships.Ship;
	import classes.Engine.Interfaces.rand;
	
	/**
	 * @author Gedan
	 */
	public function calculateMiss(target:Ship, attacker:Ship, weapon:OffensiveModule, chanceModifier:Number = 5.0):Boolean
	{
		var tracking:Number = (weapon.trackingModifier * attacker.trackingModifierMultiplier()) + attacker.trackingModifierBonus();
		
		// Evasion chance starts at 5%
		var evasionChance:Number = chanceModifier;
		
		// Ship agility acts as a mutliplier for this number
		if (target.agility() != attacker.agility())	evasionChance *= (target.agility() - attacker.agility());
		// Ship speeds also come into play.
		if (target.maneuveringSpeed() != attacker.maneuveringSpeed()) evasionChance += (target.maneuveringSpeed() - attacker.maneuveringSpeed());
		
		// cap chance to 15
		if (evasionChance > 15.0) evasionChance = 15.0;
		evasionChance -= tracking;
		
		// Any evasion = BRING ME YOUR RAND
		if (evasionChance > 0)
		{
			if (rand(100) < evasionChance) return true;
			return false;
		}
		else
		{
			return false;
		}
		
	}

}