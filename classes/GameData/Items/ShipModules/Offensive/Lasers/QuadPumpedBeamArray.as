package classes.GameData.Items.ShipModules.Offensive.Lasers 
{
	import classes.Engine.Combat.SpaceCombat.AttackDamageResult;
	import classes.GameData.Items.ShipModules.OffensiveModule;
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	import classes.GameData.Ships.Ship;
	
	import classes.Engine.Interfaces.output;
	import classes.Engine.Combat.SpaceCombat.formatDamageOutput;
	
	import classes.Engine.Utility.possessive;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class QuadPumpedBeamArray extends OffensiveModule
	{
		
		public function QuadPumpedBeamArray() 
		{
			moduleShortName = "QP Beams";
			moduleFullName = "Voidworks modified Quad-Pumped Beam Array";
			moduleDescription = "";
			
			powerconsumption = 15;
			powergrid = 25;
			moduleRemovable = true;
			weaponType = OffensiveModule.WEAPON_TYPE_LASER;
			trackingModifier = 3;
			criticalChance = 7;
			autoFires = true;
			damage = new ResistanceCollection(14, 0, 0, 2);
		}
		
		override public function attackTarget(target:Ship, attacker:Ship, outputForWeaponCount:int = 1):AttackDamageResult
		{
			var damageOutcome:AttackDamageResult = super.attackTarget(target, attacker, outputForWeaponCount);
			
			output("\n\nYour tactical display flashes a brief warning, alerting you and your crew of a buildup of power in " + possessive(attacker.longName) + " weapon systems.");

			output(" Logan reacts on instinct almost immediately, throwing " + target.longName + " into an evasive roll just as two bright green shafts of light appear from the hull of the hostile ship");
			
			// Any miss
			if (damageOutcome.numMisses > 0)
			{	
				if (damageOutcome.numMisses == 2) output(", both of them narrowly missing your ship!");
				else 
				{
					output(". One barely scrapes the very edges of your ships");
					if (target.actualShieldHP > target.maxShieldHP() * 0.05) output(" protective shields");
					else output(" gleaming hull");
				}
			}

			if (damageOutcome.numHits + damageOutcome.numCrits > 0)
			{
				// Shields
				if (damageOutcome.shieldDamage > 0)
				{
					if (damageOutcome.numMisses == 1) output(", the other");
					else output(", both");
					output(" of them connecting with your ships shields briefly before enlarging- the other ship pumping power into");
					if (damageOutcome.numMisses == 1) output(" it");
					else output(" them");
					output(" once");
					if (damageOutcome.numMisses == 1) output(" it has");
					else output(" they have");
					output(" found");
					if (damageOutcome.numMisses == 1) output(" its");
					else output(" their");
					output(" mark. The bridge computers whine in protest, your shield generator working overtime to resist the incoming fire.");
					
					if (damageOutcome.hullDamage > 0)
					{
						output(" The whining intensifies in time with an ominous shudder as your ships shields fail!");
					}
				}
				else
				{
					if (damageOutcome.numMisses == 1) output(", the other");
					else output(", both");
					output(" of them connecting with your ships exterior briefly before enlarging- the other ship pumping power into");
					if (damageOutcome.numMisses == 1) output(" it");
					else output(" them");
					output(" once");
					if (damageOutcome.numMisses == 1) output(" it has");
					else output(" they have");
					output(" found");
					if (damageOutcome.numMisses == 1) output(" its");
					else output(" their");
					output(" mark. The bridge computers whine in protest, alarms flaring across dozens of systems as the lasers scorch through the protective layers of armor coating your ships hull.");
				}
				
				output(formatDamageOutput(damageOutcome));
			}
			
			return damageOutcome;
		}
		
	}

}