package classes.GameData.Items.ShipModules.Offensive.Projectile 
{
	import classes.Engine.Combat.SpaceCombat.AttackDamageResult;
	import classes.GameData.Items.ShipModules.OffensiveModule;
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	import classes.GameData.Ships.Ship;
	import classes.Engine.Interfaces.output;
	import classes.Engine.Combat.SpaceCombat.formatDamageOutput;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class GoblinAutocannon extends OffensiveModule
	{
		
		public function GoblinAutocannon() 
		{
			moduleShortName = "Goblin AC";
			moduleFullName = "Synchrotech ‘Goblin’ Autocannon";
			moduleDescription = "";
			
			powerconsumption = 2;
			powergrid = 40;
			moduleRemovable = true;
			weaponType = OffensiveModule.WEAPON_TYPE_AUTOCANNON;
			trackingModifier = 3.0;
			criticalChance = 8.0;
			autoFires = true;
			damage = new ResistanceCollection(0, 2, 7, 2);
		}
		
		override public function attackTarget(target:Ship, attacker:Ship, outputForWeaponCount:int = 1):AttackDamageResult
		{
			var damageOutcome:AttackDamageResult = super.attackTarget(target, attacker, outputForWeaponCount);
			
			output("\n\nA stream of yellow-orange spews from the two turrets perched on either side of possessive(attacker.shipName) hull in your ships direction. The perfect line issuing from the rotating barrels of the twinned autocannons begins to split and fragment as it nears, the turrets attempting to compensate for the trajectories of both ships.");

			// Misses
			if (damageOutcome.numMisses > 0)
			{
				if (damageOutcome.numMisses == 1) output(" One of");
				else output(" Both of");
				output(" the streams whiff entirely, the comparatively low velocity of the expended projectiles making");
				if (damageOutcome.numMisses == 1) output(" a good portion of");
				output(" them easy to evade for a pilot as seasoned as Logan.");
			}

			if (damageOutcome.numHits + damageOutcome.numCrits > 0)
			{
				// Hit
				if (damageOutcome.numMisses > 0) output(" Though one");
				else output(" Both");
				output(" stream");
				if (damageOutcome.numMisses == 0) output("s");
				output(" of searing lead crash");
				if (damageOutcome.numMisses > 0) output("es");
				output(" into your ships");
				if (damageOutcome.shieldDamage > 0) output(" protective shields");
				else output(" armored hull");
				output(", each individual hit accompanied by minute explosion as the warhead-tipped bullets slam into their target");
				if (damageOutcome.shieldDamage > 0 && damageOutcome.hullDamage > 0) output(", the rapid-pace of the micro-explosions overloading your ships shield emitters in the process");
				output(".");
				
				output(formatDamageOutput(damageOutcome));
			}
			
			return damageOutcome;
		}
	}

}