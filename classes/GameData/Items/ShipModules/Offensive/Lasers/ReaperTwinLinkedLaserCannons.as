package classes.GameData.Items.ShipModules.Offensive.Lasers 
{
	import classes.Engine.Combat.SpaceCombat.AttackDamageResult;
	import classes.Engine.Combat.SpaceCombat.formatDamageOutput;
	import classes.GameData.Items.ShipModules.OffensiveModule;
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	import classes.GameData.Ships.Ship;
	
	import classes.Engine.Interfaces.output;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class ReaperTwinLinkedLaserCannons extends OffensiveModule
	{
		public function ReaperTwinLinkedLaserCannons() 
		{
			moduleShortName = "TX LCannon";
			moduleFullName = "Reaper Armaments Twin-Linked Forward Firing Laser Cannon";
			moduleDescription = "";
			
			powerconsumption = 10;
			powergrid = 20;
			moduleRemovable = true;
			weaponType = OffensiveModule.WEAPON_TYPE_LASER;
			damage = new ResistanceCollection(6.5, 0.0, 0.0, 3.5);
			trackingModifier = 3.0;
			criticalChance = 5.0;
			autoFires = true;
		}
		
		override public function attackTarget(target:Ship, attacker:Ship, outputForWeaponCount:int = 1):AttackDamageResult
		{
			var damageOutcome:AttackDamageResult = super.attackTarget(target, attacker, outputForWeaponCount);
			
			output("\n\nA groan filters through your ships hull, permeating the interior space with an ominous rumble, as");
			if (outputForWeaponCount == 1) output(" one of");
			else output(" both of");
			output(" " + possessive(attacker.shipName) + " laser cannons cycle through their firing sequence. The sound comes to a stop, only to be replaced with a new rumble, a much higher pitched almost-whine, coupled with a");
			if (outputForWeaponCount == 2) output(" pair of");
			output(" fat, iridescent shaft");
			if (outputForWeaponCount == 2) output("s");
			output(" of light suddenly appearing on your tactical displays view of the hostile ship.");
			
			if (damageOutcome.numMisses > 0)
			{
				if (damageOutcome.numMisses == 2) output(" Both beams narrowly miss their target, your targeting computer registering its own failure and cutting power to the laser cannons to conserve power.");
				if (damageOutcome.numMisses == 1 && outputForWeaponCount == 1) output(" The beam narrowly misses its target, your targeting computer registering its own failure and cutting power to the laser cannon to conserve power.");
				if (damageOutcome.numMisses == 1 && outputForWeaponCount == 2) output(" One beam narrowly misses its target, your targeting computer registering the failed hit and cutting power to the cannon in the process.");
			}
			
			if (damageOutcome.numHits > 0 || damageOutcome.numCrits > 0)
			{
				if (damageOutcome.numHits + damageOutcome.numCrits == 2) output(" The shafts of light connect with their target, closely followed by the targeting computer pumping a much larger burst of energy into the emitters. The beams enlarge in response,");
				else if (outputForWeaponCount == 1) output(" The shaft of light connects with its target, closely followed by the targeting computer pumping a much larger burst of energy into the emitters. The beam enlarges in response,");
				else if (outputForWeaponCount == 2) output(" The other shaft of light connects with its target, closely followed by the targeting computer pumping a much larger burst of energy into the emitter. The beam enlarges in response,");
				
				if (damageOutcome.shieldDamage > target.maxShieldHP() * 0.05 && damageOutcome.hullDamage == 0)
				{
					output(" threatening to overload " + possessive(target.shipName) + " shield emitters through raw power.");
					if (damageOutcome.numCrits > 0)
					{
						output(" The targets shields ripple against the beam");
						if (damageOutcome.numHits + damageOutcome.numCrits == 2) output("s");
						output(" of pure power smashing into them, fighting back against the incoming fire.");
					}
				}
				else if (damageOutcome.shieldDamage > target.maxShieldHP() * 0.05 && damageOutcome.hullDamage > 0)
				{
					output(" the energy field starting to wane against the sustained burst of laser energy as");
					if (damageOutcome.numHits + damageOutcome.numCrits == 2) output(" twinned");
					output(" pillars of photonic energy drill clean through your targets shields!");
				}
				else
				{
					output(" overheating " + possessive(target.shipName) + " armored exterior with an intense burst of power.");
					if (damageOutcome.numCrits > 0)
					{
						output(" Once the targeting computer cuts power to the beams, the camera drones view of the targets hull clearly shows the");
						if (damageOutcome.numCrits + damageOutcome.numHits == 2) output(" two");
						output(" spot");
						if (damageOutcome.numCrits + damageOutcome.numHits == 2) output("s");
						output(" where the beam");
						if (damageOutcome.numCrits + damageOutcome.numHits == 2) output("s");
						output(" found home; and the glowing-red exterior");
						if (damageOutcome.numCrits + damageOutcome.numHits == 1) output(" it");
						else output(" they");
						output(" left in");
						if (damageOutcome.numCrits + damageOutcome.numHits == 2) output(" their");
						else output(" its");
						output(" wake.");
					}
				}
				
				if (damageOutcome.totalDamage > 0) output(formatDamageOutput(damageOutcome));
			}
			
			return damageOutcome;
		}
	}

}