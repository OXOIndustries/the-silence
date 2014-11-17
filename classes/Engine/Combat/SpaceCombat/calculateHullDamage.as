package classes.Engine.Combat.SpaceCombat 
{
	import classes.GameData.Items.ShipModules.OffensiveModule;
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	import classes.GameData.Ships.Ship;
	/**
	 * ...
	 * @author Gedan
	 */
	public function calculateHullDamage(target:Ship, attacker:Ship, weapon:OffensiveModule, damageResult:AttackDamageResult):void
	{
		if (target.actualHullHP <= 0) return false;
		
		var damageToHull:ResistanceCollection = damageResult.remainingDamage.getCopy();
		
		var initialTotalDamage:Number = damageToHull.getTotal();
		
		damageToHull.applyResistances(target.actualHullResistances());
		
		var damageAfterResistances:Number = damageToHull.getTotal();
		
		if (damageAfterResistances <= target.actualHullHP)
		{
			damageResult.typedHullDamage = damageToHull;
			damageResult.hullDamage = damageAfterResistances;
			
			damageResult.typedTotalDamage.add(damageToHull);
			
			damageResult.remainingDamage = new ResistanceCollection();
			
			target.actualHullHP -= damageAfterResistances;
			
			return;
		}
		else
		{
			var damDiff:Number = target.actualHullHP / damageAfterResistances;
			
			damageResult.remainingDamage.multiply(1 - damDiff);
			
			damageResult.hullDamage = target.actualHullHP;
			damageResult.typedHullDamage = damageToHull;
			damageResult.typedHullDamage.multiply(damDiff);
			
			damageResult.totalDamage += target.actualHullHP;
			damageResult.typedTotalDamage.add(damageToHull);
			
			target.actualHullHP = 0;
		}
	}

}