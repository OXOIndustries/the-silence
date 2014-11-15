package classes.Engine.Combat.SpaceCombat 
{
	import classes.GameData.Items.ShipModules.OffensiveModule;
	import classes.GameData.Ships.Ship;
	/**
	 * ...
	 * @author Gedan
	 */
	public function calculateCritical(target:Ship, attacker:Ship, weapon:OffensiveModule, chanceModifier:Number = 1.0):Boolean
	{
		// Early exit for weapons that have 0 crit.
		if (weapon.criticalChance <= 0) return false;
		
		// Calculate the tracking of the weapon
		var tracking:Number = (weapon.trackingModifier * attacker.trackingModifierMultiplier()) + attacker.trackingModifierBonus();
		
		// calculate the base crit chance of the weapon
		var critChance:Number = weapon.criticalChance * chanceModifier;
		
		// Modify the weapons tracking based on agility difference between the ships.
		if (target.agility() != attacker.agility()) tracking *= (target.agility() - attacker.agility());
		
		// Constrain the tracking influence from 1 > tracking > 3, then apply it to the base chance
		critChance *= Math.max(1, Math.min(3.0, tracking));
		
		if (rand(100) <= critChance)
		{
			return true;
		}
		
		return false;
	}

}