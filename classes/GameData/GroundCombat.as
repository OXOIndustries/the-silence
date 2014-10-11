package classes.GameData 
{
	import classes.Creature;
	
	import classes.Engine.Combat.*;
	
	import classes.GameData.Characters.PlayerCharacter;
	import classes.GameData.Characters.Pyra;
	import classes.GameData.Characters.Tarik;
	
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
		
		public function setPlayers(... args):void
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
		public function setEnemies(... args):void
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
				_roundCounter++;
				_attackSelections = new Object();
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
			
			if (!doneRoundActions())
			{
				updateStatusEffects();
			}
			
			generateCombatMenu();
			
			_initForRound = _roundCounter;
		}
		
		private function generateCombatMenu():void
		{
			addButton(4, "Execute", processCombat);
			addButton(14, "Escape", attemptEscape);
			
			for (var i:int = 0; i < _friendlies.length; i++)
			{
				generateCombatMenuForCreature(_friendlies[i], i);
			}
		}
		
		private function generateCombatMenuFor(target:Creature, offset:int):void
		{
			addDisabledButton((offset * 5), target.short + ":");
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
		
		private function standUp(target:Creature):void
		{
			_attackSelections[target.INDEX].type = "stand";
			_attackSelections[target.INDEX].func = doStandUp;
			_attackSelections[target.INDEX].target = undefined;
			generateCombatMenu();
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
		
		private function cleave(attacker:Creature, target:Creature):void
		{
			
		}
		
		private function battlecry(attacker:Creature, target:Creature):void
		{
			
		}
		
		private function stunningStrike(attacker:Creature, target:Creature):void
		{
			
		}
		
		private function flamethrower(attacker:Creature, target:Creature):void
		{
			
		}
		
		private function paralyticDarts(attacker:Creature, target:Creature):void
		{
			
		}
		
		private function shieldBoost(attacker:Creature, target:Creature):void
		{
			
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
			
		}
		
		private function showCombatDescriptions():void
		{
			for (var i:int = 0; i < _hostiles.length; i++)
			{
				displayHostileStatus(_hostiles[i]);
			}
		}
		
		private function displayHostileStatus(target:Creature):void
		{
			
		}
		
		private function processCombat():void
		{

		}
		
		private function applyPlayerActions():void
		{
			
		}
		
		private function generateAIActions():void
		{
			
		}
		
		private function updateStatusEffects():void
		{
			for (var i:int = 0; i < _friendlies.length; i++)
			{
				updateStatusEffectsFor(_friendlies[i]);
			}
			for (i = 0; i < _hostiles.length; i++)
			{
				updateStatusEffectsFor(_hostiles[i]);
			}
		}
		
		private function updateStatusEffectsFor(target:Creature):void
		{
			if (target.hasStatusEffect("Plasma Burn"))
			{
				output("\n\nFirey green plasma continues to wear down " + ((target is PlayerCharacter) ? "your" : target.a + possessive(target.short)) + " defenses");
				target.addStatusValue("Plasma Burn", 1, -1);
				if (target.statusEffectv1("Plasma Burn") < 0) output(", but the green fire looks like it's finally died out.");
				calculateDamage(null, target, 3, GLOBAL.PLASMA, "");
		}
		
		private function playerVictoryCondition():Boolean
		{
			
		}
		
		private function playerLossCondition():Boolean
		{
			
		}
		
		override public function doCombatCleanup():void
		{
			
		}
	}

}