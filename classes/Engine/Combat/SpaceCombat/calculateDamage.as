package classes.Engine.Combat.SpaceCombat 
{
	import classes.GameData.Items.ShipModules.OffensiveModule;
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	import classes.GameData.Ships.Ship;
	/**
	 * ...
	 * @author Gedan
	 */
	public function calculateDamage(target:Ship, attacker:Ship, weapon:OffensiveModule, critChanceMulti:Number = 1.0):AttackDamageResult
	{
		// result container
		var damageResult:AttackDamageResult = new AttackDamageResult();
		
		// Calculate the actual damage of the weapon
		damageResult.remainingDamage = weapon.damage.getCopy();
		
		if (calculateCritical(target, attacker, weapon, critChanceMulti))
		{
			damageResult.remainingDamage.multiply(weapon.criticalMultiplier + attacker.criticalDamageMultiplier());
			damageResult.wasCrit = true;
		}
		
		// I could compress this down into a single function taking the resistance collection of the type as an arg, thus runnign the same thing with diff args, but the "damage bleedover" from shields->hull will be a complex problem.
		calculateShieldDamage(target, attacker, weapon, damageResult);
		
		if (damageResult.remainingDamage.getTotal() > 0)
		{
			calculateHullDamage(target, attacker, weapon, damageResult);
		}
		
		return damageResult;
	}

}