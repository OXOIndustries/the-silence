package classes.GameData.Items.ShipModules.Offensive.Spinal 
{
	import classes.Engine.Combat.SpaceCombat.AttackDamageResult;
	import classes.GameData.Items.ShipModules.OffensiveModule;
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	import classes.GameData.Ships.Ship;
	
	import classes.Engine.Combat.SpaceCombat.formatDamageOutput;
	import classes.Engine.Combat.SpaceCombat.calculateDamage;
	import classes.Engine.Interfaces.output;
	
	import classes.Engine.Utility.possessive;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class VW490TMassDriver extends OffensiveModule
	{
		
		public function VW490TMassDriver() 
		{
			moduleShortName = "490T MDriver";
			moduleFullName = "Voidworks Modified 490T Mass Driver";
			moduleDescription = "";
			
			powerconsumption = 390;
			powergrid = 400;
			moduleRemovable = false;
			weaponType = OffensiveModule.WEAPON_TYPE_SPINAL;
			trackingModifier = -1;
			autoFires = false;
			criticalChance = 0.0;
			damage = new ResistanceCollection(0, 180, 10, 40);
		}
		
		override public function attackTarget(target:Ship, attacker:Ship, outputForWeaponCount:int = 1):AttackDamageResult
		{
			var dResult:AttackDamageResult;
			
			output("\n\nYou glance at the camera drones view of " + attacker.longName + " just in time to catch faint traces of electricity jumping from the tips of a large channel, grounding themselves against the hull as power is channeled into a <i>seriously</i> oversized weapon system.");

			if (target.isImmobilised) 
			{
				// Immobilised
				output(" Logan is frantically wrestling with " + possessive(target.longName) + " engine controls, trying to free the ship from the gravity anchor strangling your ships ability to move and potentially avoid the incoming attack.");
				
				output("\n\nThere's a resounding boom as you're thrown from your command chair. You shake off the daze of taking such a shocking impact and take stock of your ship- only the emergency lights are working, and the ships tactical displays are garbled, presumably rebooting. You don't even need to wait for TacCom to finish re-initializing to know just how much damage that shot must have inflicted!");
				
				dResult = calculateDamage(target, attacker, this);
				
				output(formatDamageOutput(dResult));
			}
			else
			{
				// Not immobilised
				output(" Logan gasps, looking up at the display for herself only to be greeted to the sight of the barrel of a gargantuan gun staring straight back. She frantically works to make " + target.longName + " as hard a target as possible to hit. She yanks the control stick to one side at the last moment, a huge mass of metal sailing past your ship by the slimmest of margins.");
				dResult = new AttackDamageResult();
				dResult.numMisses++;
				dResult.totalAttacks++;
			}
			
			return dResult;
		}
		
	}

}