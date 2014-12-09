package classes.GameData.Items.ShipModules.Offensive.Lasers 
{
	import classes.GameData.Items.ShipModules.OffensiveModule;
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	import classes.GameData.Ships.Ship;
	
	import classes.Engine.Combat.SpaceCombat.AttackDamageResult;
	import classes.Engine.Combat.SpaceCombat.formatDamageOutput;
	import classes.Engine.Interfaces.output;
	import classes.Engine.Utility.possessive;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class ReaperLightLaserTurret extends OffensiveModule
	{
		
		public function ReaperLightLaserTurret() 
		{
			moduleShortName = "LL Turret";
			moduleFullName = "Reaper Armaments Light Laser Turret";
			moduleDescription = "";
			
			powerconsumption = 3;
			powergrid = 3;
			moduleRemovable = true;
			weaponType = OffensiveModule.WEAPON_TYPE_LASER;
			trackingModifier = 3.5;
			criticalChance = 5.0;
			autoFires = true;
			damage = new ResistanceCollection(5.0, 0.0, 0.0, 1.0);
		}
		
		override public function attackTarget(target:Ship, attacker:Ship, outputForWeaponCount:int = 1):AttackDamageResult
		{
			// Calculate actual damage by calling the base implementor of attackTarget
			// Basically, AttackDamageResult contains all of the specific attack outcome details in one blob, that we can then
			// check to figure out what we /actually/ need to display. In the process, we can get a little more fancy with 
			// how and what we can display!
			var damageOutcome:AttackDamageResult = super.attackTarget(target, attacker, outputForWeaponCount);
			
			output("\n\nYour tactical display flashes a handful of times; " + possessive(attacker.longName) + " targeting computers are finalizing it's calculations. It pips once, indicating the analysis is complete, before a subtle hum builds somewhere deep within the bowels of your ship. A moment later, a");
			if (outputForWeaponCount == 2) output(" pair of");
			output(" brilliant luminescent bolt");
			if (outputForWeaponCount == 2) output("s");
			output(" track");
			if (outputForWeaponCount == 1) output("s");
			output(" into your camera drones view of the enemy ship, fired from your");
			if (outputForWeaponCount == 2) output(" matched pair of");
			output(" light laser turret");
			if (outputForWeaponCount == 2) output("s");
			output(".");
			
			if (damageOutcome.numMisses > 0)
			{
				if (damageOutcome.numMisses == 2) output(" Both bolts narrowly miss their target, streaking off into the depths of space.");
				if (damageOutcome.numMisses == 1 && outputForWeaponCount == 1) output(" The bolt narrowly misses it's target, streaking off into the depths of space.");
				
				if (damageOutcome.numMisses == 1 && outputForWeaponCount == 2) output(" One bolt narrowly misses it's target, streaking off into the depths of space- the other strikes true");
			}
			
			if (damageOutcome.numHits > 0 || damageOutcome.numCrits > 0)
			{
				if (damageOutcome.numHits + damageOutcome.numCrits == 2) output(" Both bolts strike true,");
				if (damageOutcome.numHits + damageOutcome.numCrits == 1 && outputForWeaponCount == 1) output(" The bolt strikes true,");
			
				if (damageOutcome.shieldDamage > 0 && damageOutcome.hullDamage == 0)
				{
					output(" splashing against " + possessive(target.longName) + " shields.");
					if (damageOutcome.numCrits > 0)
					{
						output(" The energy shell surrounding the ship seems to ripple against");
						if (damageOutcome.numCrits + damageOutcome.numHits == 1) output(" one of");
						else output(" both of");
						output(" the bolts angrily; there's a certain sense of satisfaction building deep in your gut, the knowledge that Rourke's baby got <i>teeth</i>.");
					}
				}
				// Only show shieldbreak message if more than 5% of shields was available to wreck
				else if (damageOutcome.shieldDamage > 0 && damageOutcome.hullDamage > 0)
				{
					output(" annihilating");
					if (damageOutcome.numCrits + damageOutcome.numHits == 1) output(" itself");
					else output(" themselves");
					output(" against the protective bubble of shielding surrounding the other ship, triggering a ripple to propogate across its surface; the shields emitters having finally been pushed past their limits!");
				}
				// Against hull- ignore shields if < 5% shield HP was removed
				else
				{
					output(" scorching " + possessive(target.longName) + " exterior.");
					if (damageOutcome.numCrits > 0) 
					{
						output(" A split second after the bolt");
						if (damageOutcome.numCrits + damageOutcome.numHits == 2) output("s");
						output(" finish diffracting into countless sparkles into the void, the drones view highlights the burnt exterior of the other ship - it looks like");
						if (damageOutcome.numCrits == 1 && outputForWeaponCount > 1) output(" one of");
						output(" the bolt");
						if (outputForWeaponCount > 1) output("s");
						output(" managed to strike perfectly.");
					}
				}
				
				if (damageOutcome.totalDamage > 0) output(formatDamageOutput(damageOutcome));
			}
			
			return damageOutcome;
		}
	}

}