package classes.GameData.Items.ShipModules.Offensive.Missiles 
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
	public class SteeleTechVanguardXXVIIMissileSystem extends OffensiveModule
	{
		
		public function SteeleTechVanguardXXVIIMissileSystem() 
		{
			moduleShortName = "V-XXVII FoF";
			moduleFullName = "Steele Tech Vanguard-XXVII Missile System";
			moduleDescription = "";
			
			powerconsumption = 3;
			powergrid = 40;
			moduleRemovable = true;
			weaponType = OffensiveModule.WEAPON_TYPE_MISSILE;
			damage = new ResistanceCollection(0.0, 2.0, 9.0, 1.0);
			trackingModifier = 3.0;
			criticalChance = 0.0;
			autoFires = true;
		}
		
		override public function attackTarget(target:Ship, attacker:Ship, outputForWeaponCount:int = 1):AttackDamageResult
		{
			var damageOutcome:AttackDamageResult = super.attackTarget(target, attacker, outputForWeaponCount);
			
			output("\n\nYour tactical display indicates that the Vanguard launcher has finished preparing a missile. No sooner has the message been displayed, " + possessive(attacker.longName) + " targeting computers takes over, interfacing with the launchers system and issuing the order to fire.");

			output("\n\nThe launcher door slides open with a clang, reverberating across the hull of your ship- the distinctive sound of an old school liquid-proppellant powered engine engaging soon follows, a single missile streaking out of the ejection port and towards its target. It filters into the camera drones field of view.");
			
			if (damageOutcome.numMisses == 1)
			{
				output(" The missile glances off " + possessive(target.longName));
				
				if (target.shieldPercent() >= 0.05) output(" protective bubble of shielding,");
				output(" its angle of approach too shallow to properly trigger detonation and leaving it to drift off uselessly into space now that it's small reserve of fuel is depleted.");
			}
			else
			{
				output(" The missile slams into");
				
				if (damageOutcome.shieldDamage > 0 && damageOutcome.hullDamage == 0)
				{
					output(" the shimmering protective field, exploding into a blindingly intense flash of light as it's warhead triggers");
				}
				else if (damageOutcome.shieldDamage > 0 && damageOutcome.hullDamage > 0)
				{
					output(" the shimmering protective field. The resulting explosion of the warheads detonation sets a wave rolling through the shield bubble encircling the other ships hull, the shockwave travelling along the energy-bound particle field as the emitters fail to resist the explosive force. Your targets shields have failed!");
				}
				else
				{
					output(" the glimmering metallic hull, exploding into a blindingly intense flash of light as it's warhead triggers on impact, stripping away layer after layer of carefully crafted protective armor with nuclear-powered force.");
				}
				
				output(formatDamageOutput(damageOutcome));
			}
			
			return damageOutcome;
		}
	}

}