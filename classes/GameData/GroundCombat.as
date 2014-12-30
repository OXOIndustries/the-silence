package classes.GameData 
{
	import classes.Creature;
	import classes.GameData.Characters.BlackVoidPirate;
	import classes.GameData.Characters.Logan;
	import classes.GameData.Characters.MirianBragga;
	import classes.GameData.Items.Protection.EnhancedShield;
	import classes.StorageClass;
	import classes.UIComponents.SideBarComponents.LocationHeader;
	
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
	
	import classes.StringUtil;
	
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
			
			genericVictory = function():void {
				
				var healedSome:Boolean = false;
				
				for (var i:int = 0; i < _friendlies.length; i++)
				{
					var tCreature:Creature = _friendlies[i] as Creature;
					if (tCreature.HP() / tCreature.HPMax() <= 0.2)
					{
						if (!healedSome)
						{
							output("\n\n");
							output("You and your team has to make do with what little first-aid equipment you have to hand, patching yourselves up as best you can.");
							healedSome = true;
						}
						
						tCreature.HP(tCreature.HPMax() * 0.2);					
					}
				}
				
				clearMenu();
				addButton(0, "Next", mainGameMenu);
			}
		
			genericLoss = function():void {
				clearMenu();
				addButton(0, "Next", mainGameMenu);
			}
		}
		
		override public function setPlayers(... args):void
		{
			if (args.length > 1)
			{
				_friendlies = args;
			}
			else if (args.length == 1)
			{
				if (args[0] is Party)
				{
					_friendlies = (args[0] as Party).getCombatParty();
				}
				else if (args[0] is Array)
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
				_friendlies[i].arrayIdx = i;
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
				if (args[0] is Party)
				{
					_hostiles = (args[0] as Party).getCombatParty();
				}
				else if (args[0] is Array)
				{
					_hostiles = args[0];
				}
				else
				{
					_hostiles = [args[0]];
				}
			}
			
			var appends:Array = ["A", "B", "C", "D"];
			var appendNum:int = 0;
			
			for (var i:int = 0; i < _hostiles.length; i++)
			{
				if (!(_hostiles[i] is Creature)) throw new Error("Attempted to use a non-creature object in Ground Combat.");
				
				// Append ident chars to creature names
				if ((_hostiles[i] as Creature).isUniqueInFight == false)
				{
					_hostiles[i].short += " " + appends[appendNum];
					_hostiles[i].long += " " + appends[appendNum];
					_hostiles[i].btnTargetText += " " + appends[appendNum];
					appendNum++;
				}
				
				_hostiles[i].arrayIdx = i;
			}
			
			userInterface().initHostilePartyBars();
		}
		
		override public function beginCombat():void
		{
			validateContainer();
			showCombatDescriptions();
			showCombatUI();
			showCombatMenu();
		}
		
		private function validateContainer():void
		{
			if (_victoryFunction == null) throw new Error("No victory function has been specified.");
			if (_lossFunction == null) throw new Error("No loss function has been specified.");
		}
		
		private function showCombatMenu():void
		{
			clearOutput();
			clearMenu();
			
			removeAllButtonHighlights();
			
			if (!doneRoundActions())
			{
				_roundCounter++;
				_attackSelections = new Object();
				
				for (var i:int = 0; i < _friendlies.length; i++)
				{
					_attackSelections[_friendlies[i].INDEX] = new Object();
				}
			}
			
			showCombatUI();
			
			if (checkForVictory()) return;
			if (checkForLoss()) return;
			
			generateCombatMenu();
			showCombatDescriptions();
			
			_initForRound = _roundCounter;
		}
		
		private function checkForVictory():Boolean
		{
			if (playerVictoryCondition())
			{
				showCombatUI();
				clearMenu();
				addButton(0, "Victory", _victoryFunction);
				return true;
			}
			return false;
		}
		
		private function checkForLoss():Boolean
		{
			if (playerLossCondition())
			{
				showCombatUI();
				clearMenu();
				addButton(0, "Defeat", _lossFunction);
				return true;
			}
			return false;
		}
		
		private function generateCombatMenu():void
		{	
			removeAllButtonHighlights();
			
			addButton(4, "Execute", processCombat);
			if (GameState.debug) addButton(9, "Cheat", cheatKillEverything);
			//addButton(14, "Escape", attemptEscape);
			
			for (var i:int = 0; i < _friendlies.length; i++)
			{
				generateCombatMenuFor(_friendlies[i], i);
			}
		}
		
		private function cheatKillEverything():void
		{
			for (var i:int = 0; i < _hostiles.length; i++)
			{
				(_hostiles[i] as Creature).HPRaw = 0;
			}
		}
		
		private function generateCombatMenuFor(target:Creature, offset:int):void
		{
			addDisabledButton((offset * 5), target.short + ":");
			if (target.isDefeated())
			{
				addDisabledButton(1 + (offset * 5), "DEFEATED");
				return;
			}
			
			if (target.hasStatusEffect("Stunned"))
			{
				addDisabledButton(1 + (offset * 5), "Stunned", "Stunned", "This character is currently stunned!");
				return;
			}
			if (target.hasStatusEffect("Grappled"))
			{
				addDisabledButton(2 + (offset * 5), "Struggle", "Grappled", "This character is currently grappled, and will attempt to free themselves!");
				return;
			}
			if (target.hasStatusEffect("Tripped"))
			{
				
			}
			
			if (target.defaultsToMelee) addButton(1 + (offset * 5), StringUtil.toTitleCase(target.meleeWeapon.attackVerb), selectMeleeAttack, target);
			else addButton(1 + (offset * 5), StringUtil.toTitleCase(target.rangedWeapon.attackVerb), selectRangedAttack, target);
				
			if (_attackSelections[target.INDEX].type == "attack")
			{
				highlightButton(1 + (offset * 5));
				
				if (_attackSelections[target.INDEX].target != undefined)
				{
					addDisabledButton(3 + (offset * 5), _attackSelections[target.INDEX].target.btnTargetText);
				}
			}
			
			if (target.hasStatusEffect("Tripped"))
			{
				addButton(2 + (offset * 5), "Stand Up", standUp, target, "Stand Up", "Consume a combat action to stand back up.");
				
				if (_attackSelections[target.INDEX].type != "stand")
				{
					dehighlightButton(2 + (offset * 5));
				}
				else
				{
					highlightButton(2 + (offset * 5));
				}
			}
			else
			{
				if (_attackSelections[target.INDEX].type != "special")
				{
					addButton(2 + (offset * 5), "Specials", specialsMenu, target);
				}
				else
				{
					highlightButton(2 + (offset * 5));
					
					addButton(2 + (offset * 5), _attackSelections[target.INDEX].label, specialsMenu, target);
					
					if (_attackSelections[target.INDEX].target != undefined)
					{
						addDisabledButton(3 + (offset * 5), _attackSelections[target.INDEX].target.btnTargetText);
					}
				}
			}
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
			delete _attackSelections[target.INDEX].target;
			showCombatMenu();
		}
		
		private function grappleStruggle(target:Creature):void
		{
			_attackSelections[target.INDEX].type = "struggle";
			_attackSelections[target.INDEX].func = doStruggleRecover;
			delete _attackSelections[target.INDEX].target;
			showCombatMenu();
		}
		
		private function doStunRecover(target:Creature):void
		{
			if (target.hasStatusEffect("Stunned"))
			{
				target.addStatusValue("Stunned", 1, -1);
				
				if (target.statusEffectv1("Stunned") <= 0)
				{
					if (target.statusEffectv2("Stunned") == 0)
					{
						output("\n\n" + target.a + target.short + " shakes off the effects of the stun. <b>" + target.a + target.short + " is no longer stunned!</b>");
					}
					else
					{
						if (_hostiles.indexOf(target) == -1)
						{
							_hostiles[target.statusEffectv2("Stunned")].doStunRecoverFor(target);
						}
						else
						{
							_friendlies[target.statusEffectv2("Stunned")].doStunRecoverFor(target);
						}
					}
					
					target.removeStatusEffect("Stunned");
				}
			}
		}
		
		private function doStruggleRecover(target:Creature):void
		{
			if (target.hasStatusEffect("Grappled"))
			{
				target.addStatusValue("Grappled", 1, -1);
				
				if (target.statusEffectv1("Grappled") <= 0)
				{
					if (target.statusEffectv2("Grappled") == 0)
					{
						if (target is PlayerCharacter)
						{
							output("\n\nYou wriggle out of the grapple. <b>You are no longer grappled!</b>");
						}
						else
						{
							output("\n\n" + target.a + target.short + " wriggles out of the grapple. <b>" + target.a + target.short + " is no longer grappled!</b>");
						}
					}
					else
					{
						if (_hostiles.indexOf(target) == -1)
						{
							_hostiles[target.statusEffectv2("Grappled")].doGrappleEscapeFor(target);
						}
						else
						{
							_friendlies[target.statusEffectv2("Grappled")].doGrappleEscapeFor(target);
						}	
					}
					
					target.removeStatusEffect("Grappled");
				}
			}
		}
		
		private function standUp(target:Creature):void
		{
			_attackSelections[target.INDEX].type = "stand";
			_attackSelections[target.INDEX].func = doStandUp;
			delete _attackSelections[target.INDEX].target;
			showCombatMenu();
		}
		
		private function doStandUp(target:Creature):void
		{
			if (target is PlayerCharacter) output("\n\nYou clamber back to your " + target.feet() + ".");
			else output(target.a + target.short + " clambers back to their " + target.feet() + ".");
			
			target.removeStatusEffect("Tripped");
		}
		
		private function targetSelectionMenu(target:Creature):void
		{
			clearMenu();
			addDisabledButton(0, target.short);
			addDisabledButton(1, _attackSelections[target.INDEX].label);
			
			removeAllButtonHighlights();
			
			var btnOffset:int = 0;
			
			for (var i:int = 0; i < _hostiles.length; i++)
			{
				if (!_hostiles[i].isDefeated()) 
				{
					addButton(btnOffset + 5, _hostiles[i].btnTargetText, selectTarget, [i, target]);
					btnOffset++;
				}
			}
		}
		
		private function selectTarget(args:Array):void
		{
			_attackSelections[args[1].INDEX].target = _hostiles[args[0]];
			
			clearMenu();
			showCombatMenu();
		}
		
		private function attackMenu(target:Creature):void
		{
			clearMenu();
			addDisabledButton(0, target.short);
			
			removeAllButtonHighlights();
			
			if (target.meleeWeapon != null)
			{
				addButton(5, StringUtil.toTitleCase(target.meleeWeapon.attackVerb), selectMeleeAttack, target);
			}
			else
			{
				addDisabledButton(0, "Melee");
			}
			
			if (target.rangedWeapon != null)
			{
				addButton(6, StringUtil.toTitleCase(target.rangedWeapon.attackVerb), selectRangedAttack, target);
			}
			else
			{
				addDisabledButton(1, "Ranged");
			}
		}
		
		private function selectMeleeAttack(target:Creature):void
		{
			_attackSelections[target.INDEX].type = "attack";
			_attackSelections[target.INDEX].label = StringUtil.toTitleCase(target.meleeWeapon.attackVerb);
			_attackSelections[target.INDEX].func = doMeleeAttack;
			
			targetSelectionMenu(target);
		}
		
		private function selectRangedAttack(target:Creature):void
		{
			_attackSelections[target.INDEX].type = "attack";
			_attackSelections[target.INDEX].label = StringUtil.toTitleCase(target.rangedWeapon.attackVerb);
			_attackSelections[target.INDEX].func = doRangedAttack;
			
			targetSelectionMenu(target);
		}
		
		private function specialsMenu(target:Creature):void
		{
			clearMenu();
			
			removeAllButtonHighlights();
			
			// Ideally I'd shift this kinda thing into the creature objects themselves and let either the menu be generated there,
			// or index attacks in the creature objects and build it in a far more dynamic and reusable way.
			
			if (target is PlayerCharacter)
			{
				if (!target.hasStatusEffect("ChargeShotCooldown")) addButton(0, "ChargeShot", selectSpecialAttack, [chargeShot, target, "ChargeShot"], "Charge Shot", "A charged shot dealing increased damage. Requires a three-round cooldown before you can risk overloading your pistols plasma emitters again.");
				else addDisabledButton(0, "ChargeShot", "Charged Shot", "Overcharging your plasma pistol again so quickly runs the risk over overloading the emitter!\n\nCooldown remaining: " + target.statusEffectv1("ChargeShotCooldown") + " rounds.");
				
				if (!target.hasStatusEffect("TargetShotCooldown")) addButton(1, "TargetShot", selectSpecialAttack, [targetingShot, target, "TargetShot"], "Targeting Shot", "Fire a specialised energy marker signal, improving your companions accuracy against the marked target for a single round. Requires two rounds to regenerate the marker-particles.");
				else addDisabledButton(1, "TargetShot", "Targeting Shot", "Your plasma caster is gradually regenerating the unique particles required to mark a target.\n\nCooldown remaining: " + target.statusEffectv1("TargetShotCooldown") + " rounds.");
				
				if (!target.hasStatusEffect("StimBoostCooldown")) addButton(2, "StimBoost", selectSpecialAttack, [stimulantBoost, target, "StimBoost"], "Stimulant Boost", "Release a localised cloud of emergency doctor nanomachines, healing you and your companions. Can only be used once per combat encounter.");
				else addDisabledButton(2, "StimBoost", "Stimulant Boost", "You've already used the only container of nanomachines you had to hand!");
				if (!target.hasStatusEffect("ForceEdgeCooldown")) addButton(3, "Force Edge", selectSpecialAttack, [forceEdge, target, "Force Edge"], "Force Edge", "Make a devestating melee attack with your hard-light force edge.");
				else addDisabledButton(3, "Force Edge", "Force Edge", "Your hard-light blade requires 3 rounds to recharge after use.\n\nCooldown remaining: " + target.statusEffectv1("ForceEdgeCooldown") + " rounds.");
			}
			else if (target is Tarik)
			{
				if (!target.hasStatusEffect("CleaveCooldown")) addButton(0, "Cleave", selectSpecialAttack, [cleave, target, "Cleave"], "Cleave", "A sweeping strike that will hit all enemies present. Requires two-rounds for Tarik to recuperate after his last cleave attack.");
				else addDisabledButton(0, "Cleave", "Cleave", "Tarik needs some time to recuperate after his last furiously cleave.\n\nCooldown remaining: " + target.statusEffectv1("CleaveCooldown") + " rounds.");
				
				if (!target.hasStatusEffect("BattlecryCooldown")) addButton(1, "Battlecry", selectSpecialAttack, [battlecry, target, "Battlecry"], "Battlecry", "Draw the ire of all hostiles present for 3 rounds, additionally increases defense for the duration. Requires 4 rounds for Tariks shield generator to recharge adequately to provide a defensive buff for the duration.");
				else addDisabledButton(1, "Battlecry", "Battlecry", "Tariks shield generator is still recharging!\n\nCooldown remaining: " + target.statusEffectv1("BattlecryCooldown") + " rounds.");
				
				if (!target.hasStatusEffect("StunStrikeCooldown")) addButton(2, "StunStrike", selectSpecialAttack, [stunningStrike, target, "StunStrike"], "Stunning Strike", "A savage attack that has a chance to stun the target for 2 rounds. 3 round cooldown.");
				else addDisabledButton(2, "StunStrike", "Stunning Strike", "Tarik cannot make another stun attempt yet!\n\nCooldown remaining: " + target.statusEffectv1("StunStrikeCooldown") + " rounds.");
				
				if (!target.hasStatusEffect("Throwing Axes Used") || target.statusEffectv1("Throwing Axes Used") < 4)
				{
					var axesLeft:int = 4;
					if (target.hasStatusEffect("Throwing Axes Used")) axesLeft -= target.statusEffectv1("Throwing Axes Used");
					
					addButton(3, "ThrowAxe", selectSpecialAttack, [throwingAxe, target, "ThrowAxe"], "Throwing Axe", "Hucks one of Tarik's throwing axes at the target.\n\nAxes remaining: " + axesLeft);
				}
				else addDisabledButton(3, "ThrowAxe", "Throwing Axes", "Tarik only has 4 throwing axes per encounter.\n\nAxes remaining: 0");
			}
			else if (target is Pyra)
			{
				if (!target.hasStatusEffect("F.ThrowerCooldown")) addButton(0, "F.Thrower", selectSpecialAttack, [flamethrower, target, "F.Thrower"], "Flamethrower", "Single-target fire damage, inflicting a burning damage over time effect to it's target. Requires 3 rounds to cool off after each attack.");
				else addDisabledButton(0, "F.Thrower", "Flamethrower", "Pyras flamethrower is still cooling down from the last attack.\n\nCooldown remaining: " + target.statusEffectv1("F.ThrowerCooldown") + " rounds.");
				
				if (!target.hasStatusEffect("ParaDartsCooldown")) addButton(1, "ParaDarts", selectSpecialAttack, [paralyticDarts, target, "ParaDarts"], "Paralytic Darts", "Venom-tipped darts that reduces the targets combat capabilities. Has no effect on mechanical targets. 3 round cooldown to reset a new set of venom-tipped darts.");
				else addDisabledButton(1, "ParaDarts", "Paralytic Darts", "Pyra is still trying to load another set of darts into her wrist-mounted launcher!\n\nCooldown remaining: " + target.statusEffectv1("ParaDartsCooldown") + " rounds.");
				
				if (!target.hasStatusEffect("ShieldBoostCooldown")) addButton(2, "S.Boost", selectSpecialAttack, [shieldBoost, target, "S.Boost"], "Shield Boost", "Boosts the parties shield generators, restoring shields in the process. Can only be used once per combat encounter.");
				else addDisabledButton(2, "S.Boost", "Shield Boost", "Attempting to overcharge the parties shield generators again so soon only risks burning them out!");
				
				if (!target.hasStatusEffect("ShotgunReload")) addButton(3, "Shotgun", selectSpecialAttack, [shotgunBlast, target, "Shotgun"], "Shotgun", "Peppers the target with a devestating shotgun blast.");
				else addButton(3, "ReloadShotty", selectSpecialAttack, [reloadShotgun, target, "Reload"], "Reload Shotgun", "Pyra has to spend a round reloading her shotgun before she can fire it again.");
			}
			else if (target is Logan)
			{
				if (!target.hasStatusEffect("BurstFireCooldown")) addButton(0, "BurstFire", selectSpecialAttack, [burstFire, target, "BurstFire"], "Burst Fire", "Fire a burst from Logan's handgun.\n\nRequires 2 rounds to cool off after each attack.");
				else addDisabledButton(0, "BurstFire", "Burst Fire", "Logans handgun barrel is still dangerously hot after the last burst of fire.\n\nCooldown remaining: " + target.statusEffectv1("BurstFireCooldown") + " rounds.");
				
				if (!target.hasStatusEffect("LoganTeaseUsed")) addButton(1, "Tease", selectSpecialAttack, [loganTease, target, "Tease"], "Tease", "Logan might not be the most proficient combatant- but she sure knows how to leverage every tool she can.");
				else addDisabledButton(1, "Tease", "Tease", "Flashing your enemies again would probably be a waste of time- they probably wouldn't fall for the same shenanigans again.");
				
				if (!target.hasStatusEffect("TailSlapCooldown")) addButton(2, "TailSlap", selectSpecialAttack, [tailSlap, target, "TailSlap"], "Tail Slap", "Make an attempt to knock a target down. 2 round cooldown.");
				else addDisabledButton(2, "TailSlap", "Tail Slap", "Logan needs a moment to recover!\n\nCooldown remaining: " + target.statusEffectv1("TailSlapCooldown") + " rounds.");
			}
			
			addButton(13, "None", clearSpecialAttack, target, "Clear Selection", "Clear any existing special attack selection.");
			addButton(14, "Back", showCombatMenu, undefined, "Back", "Added in Specials Menu");
		}
		
		private function clearSpecialAttack(target:Creature):void
		{
			if (_attackSelections[target.INDEX] != undefined && _attackSelections[target.INDEX].type == "special")
			{
				_attackSelections[target.INDEX] = { };
			}
			showCombatMenu();
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
				
				var hits:int = 3;
				for (var i:int = 0; i < 5; i++)
				{
					if (!calculateMiss(attacker, target, false, -1, 3.0))
					{
						hits++;
					}
				}

				calculateDamage(attacker, target, attacker.rangedWeapon.damage * hits, attacker.rangedWeapon.damageType, "ranged");
				
				return;
			}
			else if (attacker is Logan)
			{
				output("\n\nLogan steadies her machine pistol in both hands, squeezing off a shot"); 
				
				if (!calculateMiss(attacker, target, false))
				{
					output(" that connects with " + target.a + target.short + ".");
					calculateDamage(attacker, target, attacker.rangedWeapon.damage, attacker.rangedWeapon.damageType, "ranged");
				}
				else
				{
					output(" that goes wide, plinking into a bulkhead behind " + target.a + target.short + ".");
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
			attacker.createStatusEffect("ChargeShotCooldown", 3, 0, 0, 0, true, "", "", true, 0);
			
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
			attacker.createStatusEffect("TargetShotCooldown", 2, 0, 0, 0, true, "", "", true, 0);
			
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
		
		private function stimulantBoost(attacker:Creature):void
		{
			attacker.createStatusEffect("StimBoostCooldown", 0, 1, 0, 0, true, "", "", true, 0);
			
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
					else output("\n" + _friendlies[i].short + " gained " + hpGain + " health!");
					_friendlies[i].HP(hpGain);
				}
			}
		}
		
		private function forceEdge(attacker:Creature, target:Creature):void
		{
			attacker.createStatusEffect("ForceEdgeCooldown", 3, 0, 0, 0, true, "", "", true, 0);
			doMeleeAttack(attacker, target);
		}
		
		private function cleave(attacker:Creature):void
		{
			attacker.createStatusEffect("CleaveCooldown", 2, 0, 0, 0, true, "", "", true, 0);
			
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
		
		private function battlecry(attacker:Creature):void
		{
			attacker.createStatusEffect("BattlecryCooldown", 5, 0, 0, 0, true, "", "", true, 0);
			
			output("\n\nTarik lets out a howling battlecry that echoes through the corridor, drawing everyone's attention solely to the berserking cat-snake.");
			attacker.createStatusEffect("Focus Fire", 3, 0, 0, 0, false, "Focus", "Focus Fire", true, 0);
			attacker.createStatusEffect("Damage Reduction", 3, 75.0, 0, 0, true, "", "", true, 0);
		}
		
		private function stunningStrike(attacker:Creature, target:Creature):void
		{
			attacker.createStatusEffect("StunStrikeCooldown", 3, 0, 0, 0, true, "", "", true, 0);
			
			// (Normal dmg, stuns for 1-2 turns. Phys save negates
			output("\n\nTarik leaps at " + target.a + target.short + ", bringing his greataxe up for an overhead strike.");
			if (calculateMiss(attacker, target, true))
			{
				output(" However, "+ target.a + target.short +" dodges out of the way just in time, leaving Tarik's axe buried in the bulkhead, the kittynaga struggling to pull it free.");
			}
			else
			{ 
				output(" The blow connects with bone-crunching force,");
				var damage:Number = calculateDamage(attacker, target, attacker.meleeWeapon.damage, attacker.meleeWeapon.damageType, "melee", true);
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
						target.createStatusEffect("Stunned", 2, attacker.arrayIdx, 0, 0, false, "Stun", "Stunned", true, 0);
					}
					output(" staggered by the sheet weight of the impact. (<b>" + damage + "</b>)");
				}
			}		
		}
		
		private function throwingAxe(attacker:Creature, target:Creature):void
		{
			if (!attacker.hasStatusEffect("Throwing Axes Used")) attacker.createStatusEffect("Throwing Axes Used", 0, 0, 0, 0, true, "", "", true, 0);
			attacker.addStatusValue("Throwing Axes Used", 1, 1);
			
			doRangedAttack(attacker, target);
		}
		
		private function flamethrower(attacker:Creature, target:Creature):void
		{
			attacker.createStatusEffect("F.ThrowerCooldown", 3, 0, 0, 0, true, "", "", true, 0);
			
			output("\n\nPyra pulls a nozzle from her bulky backpack and levels it at " + target.a + target.short + ". She giggles maniacally before unleashing a huge gout of flame, bathing " + target.mfn("him", "her", "it") +" in roiling fire.");
			
			calculateDamage(attacker, target, 15, GLOBAL.THERMAL, "special", false);
			
			output(" Flames continue to lick at " + target.a + possessive(target.short) + " extremities. " + target.mfn("He","She","It") + " is burning now!");
			target.createStatusEffect("Flamethrower Burn", 4, 0, 0, 0, false, "DoT", "Flamethrower Burn", true, 0);
		}
		
		private function paralyticDarts(attacker:Creature, target:Creature):void
		{
			attacker.createStatusEffect("ParaDartsCooldown", 3, 0, 0, 0, true, "", "", true, 0);
			
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
					if (!calculateMiss(attacker, target, false, 3, 1))
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
		
		private function shieldBoost(attacker:Creature):void
		{
			attacker.createStatusEffect("ShieldBoostCooldown", 0, 1, 0, 0, true, "", "", true, 0);
			
			output("\n\nPyra brings up her tiny holoband screen and starts typing furiously, trying to boost the crew's shield generators. Shields restored!");
			
			for (var i:int = 0; i < _friendlies.length; i++)
			{
				var sMult:Number = 0.25;
				if (attacker.shield is EnhancedShield) sMult += 0.1;
				
				var sGain:int = (_friendlies[i] as Creature).shieldsMax() * sMult;
				
				if (sGain > (_friendlies[i] as Creature).shieldsMax() - (_friendlies[i] as Creature).shieldsRaw)
				{
					sGain = _friendlies[i].shieldsMax() - _friendlies[i].shieldsRaw;
				}
				
				if (sGain > 0)
				{
					if (_friendlies[i] is PlayerCharacter) output("\nYou gained " + sGain + " shields!");
					else output("\n" + _friendlies[i].short + " gained " + sGain + " shields!");
					_friendlies[i].shieldsRaw += sGain;
				}
			}
		}
		
		private function shotgunBlast(attacker:Creature, target:Creature):void
		{
			attacker.createStatusEffect("ShotgunReload", 0, 0, 0, 0, true, "", "", true, 0);
			doRangedAttack(attacker, target);
		}
		
		private function reloadShotgun(attacker:Creature):void
		{
			attacker.removeStatusEffect("ShotgunReload");
			output("\n\nPyra fumbles with her oversized shotgun, the huge shells compared to her tiny fingers taking every ounce of effort she can muster in order to slide a replacement into the weapons breach.");
		}
		
		private function burstFire(attacker:Creature, target:Creature):void
		{
			attacker.createStatusEffect("BurstFireCooldown", 2, 0, 0, 0, true, "", "", true, 0);
			
			output("\n\n<i>“Die, you fucks!”</i> Logan screams, flipping her machine pistol to automatic and firing from the hip, spraying lead at " + target.a + target.short + ".");
			
			var numHits:int = 0;
			for (var i:int = 0; i < 3; i++)
			{
				if (!calculateMiss(attacker, target, false))
				{
					numHits++;
				}
			}
			
			if (numHits != 0)
			{
				var numT:Array = ["One", "Two", "Three"];
				
				output(" " + numT[numHits - 1] + " shot");
				if (numHits > 1) output("s");
				output(" connect.");
				
				output(" <i>“Die, die, die!”</i>");
				
				calculateDamage(attacker, target, attacker.rangedWeapon.damage, attacker.rangedWeapon.damageType, "ranged");
			}
			else
			{
				output(" Her entire burst goes completely wide!");
			}
		}
		
		private function loganTease(attacker:Creature, target:Creature):void
		{
			attacker.createStatusEffect("LoganTeaseUsed", 0, 0, 0, 0, true, "", "", true, 0);
			
			output("\n\n<i>“Hey, you!”</i> Logan shouts at " + target.a + target.short + ". As soon as she gets " + target.mfn("his", "her", "its") + " attention, Logan lifts her shirt up. " + target.capitalA + target.short + " is ");
			
			if (target.originalRace == "Machine" || target is MirianBragga)
			{
				output("clearly unimpressed by the display.");
			}
			else
			{
				output("visibly stunned by the display!");
				target.createStatusEffect("Stunned", 3, 0, 0, 0, true, "", "", true, 0);
			}
			
			// "Hey, you!" Logan shouts at {target}. As soon as she gets {his/her} attention, Logan lifts her shirt up, letting her boobs pop free. She does a little bounce, making her bust jiggle enticingly... before slipped a clawed hand down under her belt and yanking <i>that</i> down, revealing a massive slab of meat hanging between her legs big enough to make a horse jealous. {Target} is {visibly stunned by the display // clearly unimpressed by the display}. 
			
		}
		
		private function tailSlap(attacker:Creature, target:Creature):void
		{
			attacker.createStatusEffect("TailSlapCooldown", 2, 0, 0, 0, true, "", "", true, 0);
			
			output("\n\nLogan rushes forward, sliding under " + target.a + target.short + "’s guard and spinning around, striking " + target.mfn("his", "her", "its") + " legs with her big, thick reptilian tail.");
			
			if (rand(3) <= 1)
			{
				target.createStatusEffect("Stunned", 1, 0, 0, 0, true, "", "", true, 0);
				output(" " + target.capitalA + target.short + " teeters and falls backwards in a heap on the deck.");
				
				calculateDamage(attacker, target, 5, GLOBAL.KINETIC, "melee");
			}
			else
			{
				output(" " + target.capitalA + target.short + " manages to keep " + target.mfn("his", "her", "its") + " feet firmly on the deck.");
			}
		}
		
		private function selectSpecialAttack(args:Array):void
		{
			clearMenu();
			
			var func:Function = args[0];
			var caster:Creature = args[1];
			var label:String = args[2];
			
			_attackSelections[caster.INDEX].type = "special";
			_attackSelections[caster.INDEX].label = label;
			_attackSelections[caster.INDEX].func = func;
			
			// Requires Targets
			var reqTarget:Array = [
				"ChargeShot",
				"TargetShot",
				"StunStrike",
				"ParaDarts",
				"F.Thrower",
				"Shotgun",
				"ThrowAxe",
				"Force Edge",
				"BurstFire",
				"Tease",
				"TailSlap"
			];
			
			if (reqTarget.indexOf(label) != -1) targetSelectionMenu(caster);
			else 
			{
				delete _attackSelections[caster.INDEX].target;
				generateCombatMenu();
			}
		}
		
		override public function showCombatUI():void
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
				var pHealth:Number = target.HP() / target.HPMax();
				var pShield:Number = target.shieldsRaw / target.shieldsMax();
				
				pHealth *= 100;
				pShield *= 100;
				
				var dHealth:int = Math.round(pHealth);
				var dShield:int = Math.round(pShield);
								
				output("\n\n" + target.long + " (<b>S: " + dShield + "% / H: " + dHealth + "%</b>)");
			}
		}
		
		private function actionSelectionsRemain():Boolean
		{
			for (var i:int = 0; i < _friendlies.length; i++)
			{
				if (_friendlies[i].isDefeated() == false && !_friendlies[i].hasStatusEffect("Stunned") && !_friendlies[i].hasStatusEffect("Grappled"))
				{
					if (_attackSelections[_friendlies[i].INDEX].type == undefined) 
					{
						return true;
					}
				}
			}
			return false;
		}
		
		private function processCombat(ignoreSelections:Boolean = false):void
		{
			if (actionSelectionsRemain() && !ignoreSelections)
			{
				clearOutput();
				output("Not all of your available party members have a selected action.");
				output("\n\nSelect a full-round of actions, or ignore this warning and continue?");
				
				clearMenu();
				removeAllButtonHighlights();
				addButton(0, "Fix", returnToCombatMenu);
				addButton(1, "Confirm", processCombat, true);
				return;
			}
			
			processPlayerActions();
		}
		
		private function processPlayerActions():void
		{
			clearOutput();
			output("<b>Your party actions:</b>");
			
			applyPlayerActions();
			updateStatusEffects(_friendlies);
			updateCooldowns(_friendlies);
			
			for (var i:int = 0; i < _hostiles.length; i++)
			{
				if (_hostiles[i].isDefeated() && _hostiles[i].alreadyDefeated == false)
				{
					_hostiles[i].alreadyDefeated = true;
					output("\n\n" + _hostiles[i].capitalA + _hostiles[i].short + " falls to the ground,");
					if (_hostiles[i].HP() <= 0) output(" defeated.");
					else output(" stricken with lust.");
				}
				else if (_hostiles[i].isDefeated() && _hostiles[i].alreadyDefeated == true)
				{
					output("\n\n" + _hostiles[i].capitalA + _hostiles[i].short + " lies on the ground, defeated.");
				}
			}
			
			if (checkForVictory()) return;
			
			showCombatUI();
			
			clearMenu();
			removeAllButtonHighlights();
			addButton(0, "Next", processAIActions);
		}
		
		private function processAIActions():void
		{
			if (checkForVictory()) return;
			
			clearOutput();
			output("<b>Hostile party actions:</b>");
			
			generateAIActions();
			updateStatusEffects(_hostiles);
			
			if (checkForVictory()) return;
			
			for (var i:int = 0; i < _friendlies.length; i++)
			{
				if ((_friendlies[i] as Creature).isDefeated() && _friendlies[i].alreadyDefeated == false)
				{
					_friendlies[i].alreadyDefeated = true;
					if (_friendlies[i] is PlayerCharacter) output("\n\nYou fall to the ground,");
					else output("\n\n" + _friendlies[i].capitalA + _friendlies[i].short + " falls to the ground,");
					if (_friendlies[i].HP() <= 0) output(" defeated.");
					else output(" stricken with lust.");
				}
			}
			
			if (checkForLoss()) return;
			
			showCombatUI();
			
			// Special handler mechanics
			for (i = 0; i < _hostiles.length; i++)
			{
				if (_hostiles[i] is BlackVoidPirate)
				{
					var bvp:BlackVoidPirate = _hostiles[i];
					
					if (bvp.respawn && bvp.isDefeated())
					{
						bvp.HP(bvp.HPMax());
						bvp.shieldsRaw = bvp.shieldsMax();
						bvp.clearCombatStatuses();
						
						output("\n\nAs one of the Black Void pirates falls to the ground, defeated, another jumps through the breach to take his place!");
					}
				}
			}
			
			_roundCounter++;
			trace("Roundcount:", _roundCounter);
			
			if (checkForVictory()) return;
			
			clearMenu();
			removeAllButtonHighlights();
			addButton(0, "Next", showCombatMenu);
		}
		
		private function returnToCombatMenu():void
		{
			clearOutput();
			showCombatMenu();
		}
		
		private function applyPlayerActions():void
		{
			for (var i:int = 0; i < _friendlies.length; i++)
			{
				if (_friendlies[i].HP() >= 0)
				{
					if (_attackSelections[_friendlies[i].INDEX].func != undefined)
					{
						var func:Function = _attackSelections[_friendlies[i].INDEX].func;
						
						if (_attackSelections[_friendlies[i].INDEX].target != undefined)
						{
							var tTarget:Creature = _attackSelections[_friendlies[i].INDEX].target as Creature;
							
							if (tTarget.HP() <= 0)
							{
								tTarget = randomTarget();
							}
							
							if (tTarget != null) func(_friendlies[i], tTarget);	
						}
						else
						{
							func(_friendlies[i]);
						}
					}
					else
					{
						if (_friendlies[i].hasStatusEffect("Stunned"))
						{
							doStunRecover(_friendlies[i]);
						}
						if (_friendlies[i].hasStatusEffect("Grappled"))
						{
							doStruggleRecover(_friendlies[i]);
						}
					}
				}
			}
		}
		
		// Not actually random, bloo bloo!
		private function randomTarget():Creature
		{
			for (var i:int = 0; i < _hostiles.length; i++)
			{
				if (!(_hostiles[i] as Creature).HP() <= 0) return _hostiles[i];
			}
			return null;
		}
		
		private function generateAIActions():void
		{
			for (var i:int = 0; i < _hostiles.length; i++)
			{
				var target:Creature = _hostiles[i];
				
				if (target.isDefeated())
				{
					continue;
				}
				
				if (target.hasStatusEffect("Grappled"))
				{
					doStruggleRecover(target);
					continue;
				}
				
				if (target.hasStatusEffect("Stunned"))
				{
					doStunRecover(target);
					continue;
				}
				
				target.generateAIActions(_hostiles, _friendlies);
			}
		}
		
		private function updateCooldowns(group:Array):void
		{
			for (var i:int = 0; i < group.length; i++)
			{
				updateCooldownEffectsFor(group[i]);
			}
		}
		
		private function updateCooldownEffectsFor(target:Creature):void
		{
			var remove:Array = [];
			
			for (var i:int = 0; i < target.statusEffects.length; i++)
			{
				var se:StorageClass = target.statusEffects[i];
				
				if (se.storageName.indexOf("Cooldown") != -1)
				{
					if (se.value2 == 0) // V2 != 0 == till-end-of-combat cooldown
					{
						se.value1--; // Only decrement cooldowns we actually want here.
						
						if (se.value1 < 0)
						{
							remove.push(se.storageName);
						}
					}
				}
			}
			
			for (i = 0; i < remove.length; i++)
			{
				target.removeStatusEffect(remove[i]);
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
			if (target.isDefeated()) return;
			
			if (target.hasStatusEffect("Targeting Shot"))
			{
				target.addStatusValue("Targeting Shot", 1, -1);
				if (target.statusEffectv1("Targeting Shot") < 0)
				{
					target.removeStatusEffect("Targeting Shot");
				}
			}
			
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
				if (target.statusEffectv1("Damage Reduction") < 0)
				{
					target.removeStatusEffect("Damage Reduction");
				}
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
			if (target.hasStatusEffect("Aim Reduction"))
			{
				target.addStatusValue("Aim Reduction", 1, -1)
				if (target.statusEffectv1("Aim Reduction") < 0)
				{
					output("\n\nThe blinding flash that was disorienting ");
					if (target is PlayerCharacter) output("you");
					else output(target.a + target.short);
					output(" clears, allowing ");
					if (target is PlayerCharacter) output("you");
					else output("them");
					output(" to see clearly again.");
					target.aimMod += target.statusEffectv2("Aim Reduction");
					target.removeStatusEffect("Aim Reduction");
				}
			}
		}
		
		private function playerVictoryCondition():Boolean
		{
			if (victoryCondition == CombatManager.ENTIRE_PARTY_DEFEATED)
			{
				for (var i:int = 0; i < _hostiles.length; i++)
				{
					if (!_hostiles[i].isDefeated()) return false;
				}
				return true;
			}
			else if (victoryCondition == CombatManager.SURVIVE_WAVES)
			{
				if (victoryArgument <= 0) throw new Error("Wave survival declared as a win condition, with no target waves defined.");
				if (_roundCounter >= victoryArgument) return true;
				return false;
			}
			
			return false;
		}
		
		private function playerLossCondition():Boolean
		{
			if (lossCondition == CombatManager.ENTIRE_PARTY_DEFEATED)
			{
				for (var i:int = 0; i < _friendlies.length; i++)
				{
					if (!_friendlies[i].isDefeated()) return false;
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