package classes.Engine.Combat.SpaceCombat 
{
	import classes.GameData.Items.ShipModules.OffensiveModule;
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	import classes.GameData.Ships.Ship;
	/**
	 * ...
	 * @author Gedan
	 */
	public function calculateShieldDamage(target:Ship, attacker:Ship, weapon:OffensiveModule, damage:ResistanceCollection, damageResult:AttackDamageResult):void
	{
		// early exit if the target has zero shields.
		if (target.shieldPercent() <= 0.0) return;
		
		// Get the shield resistances from the target, and use them to reduce the damage available.
		var damageToShields:ResistanceCollection = damageResult.remainingDamage.getCopy();
		
		// Store the total damage before and after resistances- we'll use this to try and approximate *how much*
		// damage we used to break through the shields if we get all the way through
		var initialTotalDamage:Number = damageToShields.getTotal();
		
		damageToShields.applyResistances(target.actualShieldResistances());
		
		var damageAfterResistances:Number = damageToShields.getTotal();
		
		// If the damage doesn't shieldbreak, we done after storing values and returning.
		if (damageAfterResistances <= target.actualShieldHP)
		{
			damageResult.typedShieldDamage = damageToShields;
			damageResult.shieldDamage = damageAfterResistances;
			
			damageResult.typedTotalDamage = damageAfterResistances;
			damageResult.totalDamage = damageToShields;
			
			damageResult.remainingDamage = new ResistanceCollection();
			
			target.actualShieldHP -= damageAfterResistances;
			
			return;
		}
		else
		{
			// Get a percent of the difference between damage and available shields
			// if we only need 50% of the total damage to shields to break them, then 50% of the *unmodded* damage needs to hit hull.
			var damDiff:Number = target.actualShieldHP / damageAfterResistances;
			
			// Use this percentage to reduce the damage prior to shield resistances
			damageResult.remainingDamage.multiply(1 - damDiff);
			
			// Store all the shit
			damageResult.shieldDamage = target.actualShieldHP;
			damageResult.typedShieldDamage = damageToShields;
			damageResult.typedShieldDamage.multiply(damDiff);
			
			damageResult.totalDamage = target.actualShieldHP;
			damageResult.typedTotalDamage = damageResult.typedShieldDamage;
			
			target.actualShieldHP = 0;
		}
	}

}