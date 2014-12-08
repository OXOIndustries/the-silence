package classes.GameData.Items.ShipModules.Offensive.Special 
{
	import classes.Engine.Combat.SpaceCombat.AttackDamageResult;
	import classes.GameData.Items.ShipModules.OffensiveModule;
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	import classes.GameData.Ships.Ship;
	
	import classes.Engine.Interfaces.output;
	import classes.Engine.Combat.SpaceCombat.formatDamageOutput;
	import classes.GameData.StatusEffect;
	
	import classes.Resources.StatusIcons;
	
	import classes.Engine.Utility.possessive;	
	/**
	 * ...
	 * @author Gedan
	 */
	public class SingularityAnchor extends OffensiveModule
	{
		
		public function SingularityAnchor() 
		{
			moduleShortName = "GravAnchor";
			moduleFullName = "KihaCorp Singularity Anchor";
			moduleDescription = "";
			
			powerconsumption = 10;
			powergrid = 150;
			moduleRemovable = true;
			weaponType = OffensiveModule.WEAPON_TYPE_IMMOBILISE;
			trackingModifier = 3.0;
			criticalChance = 0;
			damage = new ResistanceCollection(0, 0, 4, 0);
			autoFires = false;
		}
		
		override public function attackTarget(target:Ship, attacker:Ship, outputForWeaponCount:int = 1):AttackDamageResult
		{
			var damageOutcome:AttackDamageResult = super.attackTarget(target, attacker, outputForWeaponCount);
			
			output("\n\n“Warning: Missile Lock” blares from your ships computer. A rather large missile is soon ejected from " + possessive(attacker.longName) + " launch bay, it's course clear as it hurtles towards you faster than " + target.longName + " can outrun it.");

			// Miss
			if (damageOutcome.numMisses > 0)
			{
				output(" With a well-timed wiggle of the control stick, Logan manages to trigger the detonation of the missile early, saving just enough momentum to carry your ship out of reach of the warhead before it detonates.");
			}
			else
			{
				// Hit
				output(" The missile detonates just off of your ships starboard bow and you lurch forward in your command seat. You were expecting something more... forceful given the size of the missile- and it's with a terrible, dawning realisation that you come to truly appreciate just what it was that " + attacker.longName + " launched as you lurch forward in your command chair. Your ship is caught in the gravity of a micro-singularity, effectively immobile!");
				
				target.addStatusEffect(new StatusEffect("Singularity Anchor", { }, 3, StatusEffect.DURATION_ROUNDS, StatusIcons.Constrict, true, "applyImmobilise", "removeImmobilise"));
			}
			
			return damageOutcome;
		}
	}
}