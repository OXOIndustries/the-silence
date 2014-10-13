package classes.GameData 
{
	import classes.Creature;
	
	import classes.Engine.Combat.*;
	import classes.Engine.Interfaces.*;
	import classes.Engine.mainGameMenu;
	
	import classes.Engine.Utility.num2Text;
	import classes.Engine.Utility.upperCase;
	
	import classes.GameData.Characters.PlayerCharacter;
	import classes.GameData.Characters.Pyra;
	import classes.GameData.Characters.Tarik;
	
	import classes.Engine.Utility.possessive;
	
	import classes.GLOBAL;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class GroundCombat extends CombatContainer
	{
		private var _initForRound:int = -1;
		public function doneRoundActions():Boolean
		{
			if (_initForRound == _roundCounter) return true;
			return false;
		}
		
		private var _attackSelections:Object = { };
		
		public function GroundCombat() 
		{
			_combatMode = CombatContainer.COMBAT_GROUND;
			_roundCounter = 0;
		}
		
		override public function setPlayers(... args):void
		{
			if (args.length > 1)
			{
				_friendlies = args;
			}
			else if (args.length == 1)
			{
				if (args[0] is Array)
				{
					_friendlies = args[0];
				}
				else
				{
					_friendlies = [args[0]];
				}
			}
			
			for (var i:int = 0; i < _friendlies.length; i++)
			{
				if (!(_friendlies[i] is Creature)) throw new Error("Attempted to use a non-creature object in Ground Combat.");
			}
		}
		override public function setEnemies(... args):void
		{
			if (args.length > 1)
			{
				_hostiles = args;
			}
			else if (args.length == 1)
			{
				if (args[0] is Array)
				{
					_hostiles = args[0];
				}
				else
				{
					_hostiles = [args[0]];
				}
			}
			
			for (var i:int = 0; i < _hostiles.length; i++)
			{
				if (!(_hostiles[i] is Creature)) throw new Error("Attempted to use a non-creature object in Ground Combat.");
			}
		}
		
		override public function beginCombat():void
		{
			validateContainer();
			showCombatMenu();
			showCombatDescriptions();
			showCombatUI();
		}
		
		private function validateContainer():void
		{
			if (_victoryFunction == null) throw new Error("No victory function has been specified.");
			if (_lossFunction == null) throw new Error("No loss function has been specified.");
		}
		
		private function showCombatMenu():void
		{
			clearMenu();
			showCombatDescriptions();
			
			if (!doneRoundActions())
			{
				clearOutput();
				_roundCounter++;
				_attackSelections = new Object();
				
				for (var i:int = 0; i < _friendlies.length; i++)
				{
					_attackSelections[_friendlies[i].INDEX] = new Object();
				}
			}
			
			if (playerVictoryCondition())
			{
				addButton(0, "Victory", _victoryFunction);
				return;
			}
			
			if (playerLossCondition())
			{
				addButton(0, "Defeat", _lossFunction);
				return;
			}
			
			generateCombatMenu();
			showCombatDescriptions();
			showCombatUI();
			
			_initForRound = _roundCounter;
		}
		
		private function generateCombatMenu():void
		{
			addButton(4, "Execute", processCombat);
			//addButton(14, "Escape", attemptEscape);
			
			for (var i:int = 0; i < _friendlies.length; i++)
			{
				generateCombatMenuFor(_friendlies[i], i);
			}
		}
		
		private function generateCombatMenuFor(target:Creature, offset:int):void
		{
			addDisabledButton((offset * 5), target.short + ":");
			if (target.isDefeated)
			{
				addDisabledButton(1 + (offset * 5), "DEFEATED");
				return;
			}
			
			if (target.hasStatusEffect("Stunned"))
			{
				addButton(1 + (offset * 5), "Recover", stunRecover, target);
				return;
			}
			if (target.hasStatusEffect("Grappled"))
			{
				addButton(2 + (offset * 5), "Struggle", grappleStruggle, target);
				return;
			}
			if (target.hasStatusEffect("Trip"))
			{
				addButton(3 + (offset * 5), "Stand Up", standUp, target);
				return;
			}
			
			if (_attackSelections[target.INDEX].type != "attack")
				addButton(1 + (offset * 5), "Attack", attackMenu, target);
			else
				addButton(1 (offset * 5), _attackSelections[target.INDEX].label, attackMenu, target);
			
			if (_attackSelections[target.INDEX].type != "special")
				addButton(2 + (offset * 5), "Specials", specialsMenu, target);
			else
				addButton(2 + (offset * 5), _attackSelections[target.INDEX].label, specialsMenu, target);
		}
		
		private function attemptEscape():void
		{
			if (hasCombatEffect("Escape Blocked"))
			{
				clearOutput();
				output("You can't run from this fight!");
			}
			else
			{
				if (rand(5) == 0)
				{
					clearOutput();
					output("You ran away from the fight!");
					clearMenu();
					addButton(0, "Next", function():void {
						CombatManager.postCombat();
						mainGameMenu();
					});
					return;
				}
				else
				{
					clearOutput();
					output("You failed to escape!");
				}
			}
			
			processCombat();
		}
		
		private function stunRecover(target:Creature):void
		{
			_attackSelections[target.INDEX].type = "recover";
			_attackSelections[target.INDEX].func = doStunRecover;
			_attackSelections[target.INDEX].target = undefined;
			generateCombatMenu();
		}
		
		private function grappleStruggle(target:Creature):void
		{
			_attackSelections[target.INDEX].type = "struggle";
			_attackSelections[target.INDEX].func = doStruggleRecover;
			_attackSelections[target.INDEX].target = undefined;
			generateCombatMenu();
		}
		
		private function doStunRecover(target:Creature):void
		{
			
		}
		
		private function doStruggleRecover(target:Creature):void
		{
			
		}
		
		private function standUp(target:Creature):void
		{
			_attackSelections[target.INDEX].type = "stand";
			_attackSelections[target.INDEX].func = doStandUp;
			_attackSelections[target.INDEX].target = undefined;
			generateCombatMenu();
		}
		
		private function doStandUp(target:Creature):void
		{
			
		}
		
		private function targetSelectionMenu(target:Creature):void
		{
			clearMenu();
			for (var i:int = 0; i < _hostiles.length; i++)
			{
				addButton(i, _hostiles[i].short, selectTarget, [i, target]);
			}
		}
		
		private function selectTarget(... args):void
		{
			_attackSelections[args[1].INDEX].target = args[0];
			
			generateCombatMenu();
		}
		
		private function attackMenu(target:Creature):void
		{
			clearMenu();
			if (target.meleeWeapon != null)
			{
				addButton(0, target.meleeWeapon.attackVerb, selectMeleeAttack, target);
			}
			else
			{
				addDisabledButton(0, "Melee");
			}
			
			if (target.rangedWeapon != null)
			{
				addButton(1, target.rangedWeapon.attackVerb, selectRangedAttack, target);
			}
			else
			{
				addDisabledButton(1, "Ranged");
			}
		}
		
		private function selectMeleeAttack(target:Creature):void
		{
			_attackSelections[target.INDEX].type = "attack";
			_attackSelections[target.INDEX].label = target.meleeWeapon.attackVerb;
			_attackSelections[target.INDEX].func = doMeleeAttack;
			
			targetSelectionMenu(target);
		}
		
		private function selectRangedAttack(target:Creature):void
		{
			_attackSelections[target.INDEX].type = "attack";
			_attackSelections[target.INDEX].label = target.rangedWeapon.attackVerb;
			_attackSelections[target.INDEX].func = doRangedAttack;
			
			targetSelectionMenu(target);
		}
		
		private function specialsMenu(target:Creature):void
		{
			clearMenu();
			
			// Ideally I'd shift this kinda thing into the creature objects themselves and let either the menu be generated there,
			// or index attacks in the creature objects and build it in a far more dynamic and reusable way.
			
			if (target is PlayerCharacter)
			{
				addButton(0, "Charge Shot", selectSpecialAttack, [chargeShot, target, "Charge Shot"]);
				addButton(1, "Targeting Shot", selectSpecialAttack, [targetingShot, target, "Targeting Shot"]);
				addButton(2, "Stimulant Boost", selectSpecialAttack, [stimulantBoost, target, "Stimulant Boost"]);
			}
			else if (target is Tarik)
			{
				addButton(0, "Cleave", selectSpecialAttack, [cleave, target, "Cleave"]);
				addButton(1, "Battlecry", selectSpecialAttack, [battlecry, target, "Battlecry"]);
				addButton(2, "Stunning Strike", selectSpecialAttack, [stunningStrike, target, "Stunning Strike"]);
			}
			else if (target is Pyra)
			{
				addButton(0, "Flamethrower", selectSpecialAttack, [flamethrower, target, "Flamethrower"]);
				addButton(1, "Paralytic Darts", selectSpecialAttack, [paralyticDarts, target, "Paralytic Darts"]);
				addButton(2, "Shield Boost", selectSpecialAttack, [shieldBoost, target, "Shield Boost"]);
			}
			
			addButton(14, "Back", generateCombatMenu);
		}
		
		public function doMeleeAttack(attacker:Creature, target:Creature):void
		{
			if (attacker is PlayerCharacter)
			{
				output("\n\nYou flick on the blade of your hardlight sword and charge, hacking a deadly arc toward " + target.a + target.short + ".");
			}
			else if (attacker is Tarik)
			{
				output("\n\nTarik swings his massive greataxe,");
			}
			else if (attacker is Pyra)
			{
				output("\n\n<i>“Batter up!”</i> Pyra cheers, leaping toward " + target.a + target.short + " with her wrench held in a two-handed grip. She swings");
			}
			
			if (calculateMiss(attacker, target, true))
			{
				if (attacker is PlayerCharacter)
				{
					output(" Your strike is parried!");
				}
				else if (attacker is Tarik)
				{
					output(" missing " + target.a + target.short + ".");
				}
				else if (attacker is Pyra)
				{
					output(" wide, staggering forward with the momentum of her missed attack.");
				}
			}
			else
			{
				if (attacker is PlayerCharacter)
				{
					output(" It hits!");
					calculateDamage(attacker, target, attacker.meleeWeapon.damage, attacker.meleeWeapon.damageType, "melee");
				}
				else if (attacker is Tarik)
				{
					output(" bringing it down in a brutal hit on " + target.a + target.short + ".");
					calculateDamage(attacker, target, attacker.meleeWeapon.damage, attacker.meleeWeapon.damageType, "melee");
				}
				else if (attacker is Pyra)
				{
					output(" straight into " + target.a + possessive(target.short) + " knee.");
					calculateDamage(attacker, target, attacker.meleeWeapon.damage, attacker.meleeWeapon.damageType, "melee");
				}
			}
		}
		
		public function doRangedAttack(attacker:Creature, target:Creature):void
		{
			if (attacker is PlayerCharacter)
			{
				output("\n\nYou fire a bolt of superheated plasma at " + target.a + target.short + ".");
			}
			else if (attacker is Tarik)
			{
				output("\n\nTarik grabs one of the smaller axes from the bandolier across his broad chest and hucks it at " + target.a + target.short +",");
			}
			else if (attacker is Pyra)
			{
				// Pyra never misses -- or at least, 5 pellets will hit, 5 will roll for hit using standard mechanics.
				output("\n\nPyra levels her shotgun at " + target.a + target.short + " and pulls the trigger, scattering a mass of metal pellets in their direction.");
				
				var damage:int = 0;
				for (var i:int = 0; i < 5; i++)
				{
					if (!calculateMiss(attacker, target, false, -1, 3.0))
					{
						damage += calculateDamage(attacker, target, attacker.rangedWeapon.damage, attacker.rangedWeapon.damageType, "ranged",  true);
					}
					damage += calculateDamage(attacker, target, attacker.rangedWeapon.damage, attacker.rangedWeapon.damageType, "ranged",  true);
				}
				
				return;
			}
			
			if (calculateMiss(attacker, target, false))
			{
				if (attacker is PlayerCharacter)
				{
					output(" Your shot goes wide, burning into a bulkhead!");
				}
				else if (attacker is Tarik)
				{
					output(" though his throw goes wide.");
				}
			}
			else
			{
				if (attacker is PlayerCharacter)
				{
					output(" It hits!");
					calculateDamage(attacker, target, attacker.rangedWeapon.damage, attacker.rangedWeapon.damageType, "ranged");
				}
				else if (attacker is Tarik)
				{
					output(" scoring a direct hit.");
					calculateDamage(attacker, target, attacker.rangedWeapon.damage, attacker.rangedWeapon.damageType, "ranged");
				}
			}
		}
		
		private function chargeShot(attacker:Creature, target:Creature):void
		{
			output("\n\nYou hold down the trigger on your plasma pistol, just for a second, letting a charge build up before you let the bolt of green go screaming towards ");
			
			if (_hostiles.length > 1)
			{
				var num:int = 0;
				for (var i:int = 0; i < _hostiles.length; i++)
				{
					if (_hostiles[i].short == target.short)
					{
						num++;
					}
				}
			}
			if (num > 1) output(" one of " + target.a);
			output(target.a + target.short + ".");
			
			if (calculateMiss(attacker, target, false))
			{
				output(" Your shot blasts into the bulkhead harmlessly, sizzling into the metal.");
			}
			else
			{
				calculateDamage(attacker, target, attacker.rangedWeapon.damage * 1.25, attacker.rangedWeapon.damageType, "ranged");
				
				if (rand(2) == 0)
				{
					output(" The bolt explodes across " + target.a + target.short + ", slathering " + target.mfn("him", "her", "it") + " in burning hot green plasma. " + target.mfn("He", "She", "It") + " is burning!");
					target.createStatusEffect("Plasma Burn", 3, 0, 0, 0, false, "Plasma_Burn", "Burning plasma hot!", true, 0);
				}
			}
		}
		
		private function targetingShot(attacker:Creature, target:Creature):void
		{
			output("\n\nYou fire a bolt of superheated plasma at " + target.a + target.short + ".");
			
			if (calculateMiss(attacker, target, false, attacker.rangedWeapon.attack * 1.25, 0.75))
			{
				output(" Your shot goes wide, burning into a bulkhead!");
			}
			else
			{
				calculateDamage(attacker, target, attacker.rangedWeapon.damage, attacker.rangedWeapon.damageType, "ranged");
				
				output(" You key a button on the holoband at your wrist, uploading new targeting data to your companions' heads-up displays. Accuracy increased!");
				
				for (var i:int = 0; i < _friendlies.length; i++)
				{
					(_friendlies[i] as Creature).createStatusEffect("Targeting Shot", 2, 0, 0, 0, false, "Targeting_Shot", "Targeting Shot", true, 0);
				}
			}
		}
		
		private function stimulantBoost(attacker:Creature, target:Creature = null):void
		{
			output("\n\nYou punch in a command on the holoband at your wrist, unleashing a surge of emergency doctor nanomachines and adrenaline into your companions' systems. Health restored!");
			
			for (var i:int = 0; i < _friendlies.length; i++)
			{
				var hpGain:int = (_friendlies[i] as Creature).HPMax() * 0.25;
				
				if (hpGain > (_friendlies[i] as Creature).HPMax() - (_friendlies[i] as Creature).HP())
				{
					hpGain = _friendlies[i].HPMax() - _friendlies[i].HP();
				}
				
				if (hpGain > 0) 
				{
					if (_friendlies[i] is PlayerCharacter) output("\nYou gained " + hpGain + " health!");
					else output("\n" + _friendlies[i].short + " + gained " + hpGain + " health!");
				}
			}
		}
		
		private function cleave(attacker:Creature, target:Creature = null):void
		{
			output("\n\nTarik lunges towards the enemy, swinging his tremendous greataxe in a vicious arc, letting the momentum carry him until he looks like he's spinning -- a twirling pillar of death!");
			
			var managedAHit:Boolean = false;
			for (var i:int = 0; i < _hostiles.length; i++)
			{
				if (!calculateMiss(attacker, _hostiles[i], true, -1, 1.25))
				{
					managedAHit = true;
					output("\nHe strikes " + _hostiles[i].a + _hostiles[i].short + " in his furious attacks!");
					calculateDamage(attacker, _hostiles[i], attacker.meleeWeapon.damage, attacker.meleeWeapon.damageType, "melee");
				}
			}
			
			if (!managedAHit)
			{
				output(" His furious attacks all gone wide, leaving not a scratch on your foes!");
			}
		}
		
		private function battlecry(attacker:Creature, target:Creature = null):void
		{
			output("\n\nTarik lets out a howling battlecry that echoes through the corridor, drawing everyone's attention solely to the berserking cat-snake.");
			attacker.createStatusEffect("Focus Fire", 3, 0, 0, 0, false, "Focus", "Focus Fire", true, 0);
			attacker.createStatusEffect("Damage Reduction", 3, 75.0, 0, 0, true, "", "", true, 0);
		}
		
		private function stunningStrike(attacker:Creature, target:Creature):void
		{
			// (Normal dmg, stuns for 1-2 turns. Phys save negates
			output("\n\nTarik leaps at " + target.a + target.short + ", bringing his greataxe up for an overhead strike.");
			if (calculateMiss(attacker, target, true))
			{
				output(" However, "+ target.a + target.short +" dodges out of the way just in time, leaving Tarik's axe buried in the bulkhead, the kittynaga struggling to pull it free.");
			}
			else
			{ 
				output(" The blow connects with bone-crunching force,");
				var damage = calculateDamage(attacker, target, attacker.meleeWeapon.damage, attacker.meleeWeapon.damageType, "melee", true);
				if (target.HP() <= 0)
				{
					output(" cleaving right into " + target.a + target.short + ", throwing it lifelessly to the ground");
				}
				else
				{
					output(" leaving " + target.a + target.short);
					if (target.physique() / target.physiqueMax() > 0.5) 
					{
						output(" momentarily");
					}
					else
					{
						target.createStatusEffect("Stunned", 2, 0, 0, 0, false, "Stun", "Stunned", true, 0);
					}
					output(" staggered by the sheet weight of the impact. + (<b>" + damage + "</b>)");
				}
			}		
		}
		
		private function flamethrower(attacker:Creature, target:Creature):void
		{
			output("\n\nPyra pulls a nozzle from her bulky backpack and levels it at " + target.a + target.short + ". She giggles maniacally before unleashing a huge gout of flame, bathing " + target.mfn("him", "her", "it") +" in roiling fire.");
			
			calculateDamage(attacker, target, 15, GLOBAL.THERMAL, "special", false);
			
			output(" Flames continue to lick at " + target.a + possessive(target.short) + " extremities. " + target.mfn("He","She","It") + " is burning now!");
			target.createStatusEffect("Flamethrower Burn", 4, 0, 0, 0, false, "DoT", "Flamethrower Burn", true, 0);
		}
		
		private function paralyticDarts(attacker:Creature, target:Creature):void
		{
			output("\n\nPyra levels her wrist-launcher at " + target.a + target.short + " and fires all three barrels, launching a trio of tiny, venom-laced darts downrange.");
			
			if (target.originalRace == "Machine")
			{
				output(" The venom has no effect - which isn't suprising given the inorganic nature of the target.");
			}
			else if (target.shieldsRaw > 0)
			{
				output(" The darts harmlessly bounce off of their targets shield. Huh.");
			}
			else
			{
				var numHits:int = 0;
				for (var i:int = 0; i < 3; i++)
				{
					if (!calculateMiss(attacker, target, false, 3, 0))
					{
						numHits++;
					}
				}
				
				if (numHits == 0)
				{
					output(" All three miss their target entirely!");
				}
				else
				{
					output(upperCase(num2Text(numHits)) + " manage" + ((numHits == 1) ? "s" : "") + " to hit! " + target.a + target.short + " is slowed!");
					target.createStatusEffect("Paralytic Venom", 3, numHits, 0, 0, false, "Stats", "Paralytic Venom", true, 0);
					target.aimMod -= numHits;
					target.reflexesMod -= numHits;
				}
			}
		}
		
		private function shieldBoost(attacker:Creature, target:Creature):void
		{
			output("\n\nPyra brings up her tiny holoband screen and starts typing furiously, trying to boost the crew's shield generators. Shields restored!");
			
			for (var i:int = 0; i < _friendlies.length; i++)
			{
				var sGain:int = (_friendlies[i] as Creature).shieldsMax() * 0.25;
				
				if (sGain > (_friendlies[i] as Creature).shieldsMax() - (_friendlies[i] as Creature).shieldsRaw)
				{
					sGain = _friendlies[i].shieldsMax() - _friendlies[i].shieldsRaw;
				}
				
				if (sGain > 0)
				{
					if (_friendlies[i] is PlayerCharacter) output("\nYou gained " + sGain + " shields!");
					else output("\n" + _friendlies[i].short + " gained " + sGain + " shields!");
				}
			}
		}
		
		private function selectSpecialAttack(args:Array):void
		{
			var func:Function = args[0];
			var caster:Creature = args[1];
			var label:String = args[2];
			
			_attackSelections[caster.INDEX].type = "special";
			_attackSelections[caster.INDEX].label = label;
			_attackSelections[caster.INDEX].func = func;
			
			// Requires Targets
			var reqTarget:Array = [
				"Charge Shot",
				"Targeting Shot",
				"Stunning Strike",
				"Flamethrower",
				"Paralytic Darts"
			]
			
			if (reqTarget.indexOf(label) != -1) targetSelectionMenu(caster);
			else generateCombatMenu();
		}
		
		private function showCombatUI():void
		{
			userInterface().showPlayerParty();
			userInterface().setPlayerPartyData(_friendlies);
			userInterface().showEnemyParty();
			userInterface().setEnemyPartyData(_hostiles);
		}
		
		private function showCombatDescriptions():void
		{
			output("You're fighting " + num2Text(enemiesAlive()) + " hostiles.");
			
			for (var i:int = 0; i < _hostiles.length; i++)
			{
				displayHostileStatus(_hostiles[i]);
			}
		}
		
		private function displayHostileStatus(target:Creature):void
		{
			if (target.HP() <= 0)
			{
				output("\n\n<b>You've knocked the resistance out of " + target.a + target.short + ".</b>");
			}
			else if (target.lust() >= target.lustMax())
			{
				output("\n\n<b>" + target.capitalA + target.short + ((target.plural == true) ? " are" : " is") + " too turned on to fight.</b>");
			}
			else
			{
				output("\n\n" + target.long);
			}
		}
		
		private function processCombat():void
		{
			applyPlayerActions();
			updateStatusEffects(_friendlies);
			
			for (var i:int = 0; i < _hostiles.length; i++)
			{
				if (_hostiles[i].isDefeated && _hostiles[i].alreadyDefeated == false)
				{
					_hostiles[i].alreadyDefeated == true;
					output("\n\n" + _hostiles[i].capitalA + _hostiles[i].short + " falls to the ground,");
					if (_hostiles[i].HP() <= 0) output(" defeated.");
					else output(" stricken with lust.");
				}
			}
			
			generateAIActions();
			updateStatusEffects(_hostiles);
			
			for (var i:int = 0; i < _friendlies.length; i++)
			{
				if (_hostiles[i].isDefeated && _friendlies[i].alreadyDefeated == false)
				{
					_friendlies[i].alreadyDefeated == true;
					if (_friendlies[i] is PlayerCharacter) output("\n\nYou fall to the ground,");
					else output("\n\n" + _friendlies[i].capitalA + _friendlies[i].short + " falls to the ground,");
					if (_hostiles[i].HP() <= 0) output(" defeated.");
					else output(" stricken with lust.");
				}
			}
		}
		
		private function applyPlayerActions():void
		{
			for (var i:int = 0; i < _friendlies.length; i++)
			{
				if (_friendlies[i].HP() >= 0)
				{
					var func:Function = _attackSelections[_friendlies[i].INDEX].func;
					if (func != null) func(_friendlies[i], _attackSelections[_friendlies[i].INDEX].target);
				}
			}
		}
		
		private function generateAIActions():void
		{
			for (var i:int = 0; i < _hostiles.length; i++)
			{
				_hostiles[i].groundCombatAI(_hostiles, _friendlies);
			}
		}
		
		private function updateStatusEffects(group:Array):void
		{
			for (var i:int = 0; i < group.length; i++)
			{
				updateStatusEffectsFor(group[i]);
			}
		}
		
		private function updateStatusEffectsFor(target:Creature):void
		{
			if (target.hasStatusEffect("Plasma Burn"))
			{
				output("\n\nFirey green plasma continues to wear down " + ((target is PlayerCharacter) ? "your" : target.a + possessive(target.short)) + " defenses");
				target.addStatusValue("Plasma Burn", 1, -1);
				if (target.statusEffectv1("Plasma Burn") < 0)
				{
					output(", but the green fire looks like it's finally dying out.");
					target.removeStatusEffect("Plasma Burn");
				}
				else output(".");
				output(" (<b>" + calculateDamage(null, target, 3, GLOBAL.PLASMA, "dot", true) + "</b>)");
			}
			if (target.hasStatusEffect("Flamethrower Burn"))
			{
				output("\n\nOrange flames continue to lick at " + ((target is PlayerCharacter) ? "your" : target.a + possessive(target.short)) + " defenses");
				target.addStatusValue("Flamethrower Burn", 1, -1);
				if (target.statusEffectv1("Flamethrower Burn") < 0) 
				{
					output(", but the fire looks like it's finally dying out.");
					target.removeStatusEffect("Flamethrower Burn");
				}
				else output(".");
				output(" (<b>" + calculateDamage(null, target, 3, GLOBAL.THERMAL, "dot", true) + "</b>)");
			}
			if (target.hasStatusEffect("Damage Reduction"))
			{
				target.addStatusValue("Damage Reduction", 1, -1);
			}
			if (target.hasStatusEffect("Focus Fire"))
			{
				target.addStatusValue("Focus Fire", 1, -1);
				if (target.statusEffectv1("Focus Fire") < 0)
				{
					output("\n\n" + target.a + possessive(target.short) + " furious challenge seems to fade from the battle.");
				}
			}
			if (target.hasStatusEffect("Paralytic Venom"))
			{
				target.addStatusValue("Paralytic Venom", 1, -1);
				if (target.statusEffectv1("Paralytic Venom") < 0)
				{
					output("\n\nThe venom affecting " + target.a + target.short + " seems to be wearing off.");
					target.aimMod += target.statusEffectv2("Paralytic Venom");
					target.reflexesMod += target.statusEffectv2("Paralytic Venom");
					target.removeStatusEffect("Paralytic Venom");
				}
			}
		}
		
		private function playerVictoryCondition():Boolean
		{
			if (victoryCondition == CombatManager.ENTIRE_PARTY_DEFEATED)
			{
				for (var i:int = 0; i < _hostiles.length; i++)
				{
					if (_hostiles[i].HP() >= 0 && _hostiles[i].lust() <= _hostiles[i].lustMax()) return false;
				}
				return true;
			}
			else if (victoryCondition == CombatManager.SURVIVE_WAVES)
			{
				if (_roundCounter >= victoryArgument) return true;
				return false;
			}
			
			return false;
		}
		
		private function playerLossCondition():Boolean
		{
			if (lossCondition == CombatManager.ENTIRE_PARTY_DEFEATED)
			{
				for (var i:int = 0; i < _friendlies[i].length; i++)
				{
					if (_friendlies[i].HP() >= 0 && _friendlies[i].lust() <= _friendlies[i].lustMax()) return false;
				}
				return true;
			}
			else if (lossCondition == CombatManager.SURVIVE_WAVES)
			{
				if (_roundCounter >= lossArgument) return true;
				return false;
			}
			
			return false;
		}
		
		override public function doCombatCleanup():void
		{
			doCleanup(_friendlies);
			doCleanup(_hostiles);
		}
		
		private function doCleanup(group:Array):void
		{
			for (var i:int = 0; i < group.length; i++)
			{
				doCleanupFor(group[i]);
			}
		}
		
		private function doCleanupFor(target:Creature):void
		{
			// Remove all combat effects
			target.clearCombatStatuses();
			target.alreadyDefeated = false;
		}
		
		public function enemiesAlive():int
		{
			var num:int = 0;
			for (var i:int = 0; i < _hostiles.length; i++)
			{
				if (_hostiles[i].HP() > 0) num++;
			}
			return num;
		}
	}

}