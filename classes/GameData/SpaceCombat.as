package classes.GameData 
{
	import classes.Engine.Interfaces.*;
	import classes.Engine.Combat.SpaceCombat.*;
	import classes.Engine.mainGameMenu;
	import classes.GameData.Ships.Ship;
	
	import classes.GameData.Items.ShipModules.ShipModule;
	import classes.GameData.Items.ShipModules.OffensiveModule;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class SpaceCombat extends CombatContainer
	{
		private var _initForRound:int = -1;
		public function doneRoundActions():Boolean
		{
			if (_initForRound == _roundCounter) return true;
			return false;
		}
		
		private var _attackSelections:Object = { };
		private var _lastAttackSelections:Object;
		
		public function get playerShip():Ship { return _friendlies[0]; }
		public function get hostileShip():Ship { return _hostiles[0]; }
		
		public function SpaceCombat() 
		{
			_combatMode = CombatContainer.COMBAT_SPACE;
			_roundCounter = 0;
			
			genericVictory = function():void {
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
			var aArgs:*;
			
			if (args[0] is Array)
			{
				aArgs = args[0];
			}
			else
			{
				aArgs = args;
			}
			
			_friendlies = aArgs;
		}
		
		override public function setEnemies(... args):void
		{
						var aArgs:*;
			
			if (args[0] is Array)
			{
				aArgs = args[0];
			}
			else
			{
				aArgs = args;
			}
			
			_hostiles = aArgs;
		}
		
		override public function beginCombat():void
		{
			validateContainer();
			showCombatMenu();
		}
		
		private function validateContainer():void
		{
			if (_victoryFunction == null) throw new Error("No victory function has been specified");
			if (_lossFunction == null) throw new Error("No loss function has been specified");
		}
		
		private function showCombatMenu():void
		{
			clearOutput();
			clearMenu();
			
			removeAllButtonHighlights();
			
			if (!doneRoundActions())
			{
				_roundCounter++;
				_lastAttackSelections = _attackSelections;
				_attackSelections = new Object();
				_attackSelections.weapons = [];
				showCombatUI(true);
			}
			else
			{
				showCombatUI(false);
			}
			
			if (checkForVictory()) return;
			if (checkForLoss()) return;
			
			generateCombatMenu();
			showCombatDescriptions();
			
			_initForRound = _roundCounter;
		}
		
		private function generateCombatMenu():void
		{
			removeAllButtonHighlights();
			
			addButton(0, "Fire", processCombat);
						
			addButton(1, "Offense", selectOffensiveOrder);
			if (_attackSelections.offensiveOrder != undefined) highlightButton(1);
			addDisabledButton(6, getOffensiveOrderText());
						
			addButton(2, "Navigation", selectNavigationOrder);
			if (_attackSelections.navigationOrder != undefined) highlightButton(2);
			addDisabledButton(7, getNavigationOrderText());
			
			addButton(3, "Defense", selectDefensiveOrder);
			if (_attackSelections.defensiveOrder != undefined) highlightButton(3);
			addDisabledButton(8, getDefensiveOrderText());
			
			/*
			if (!playerShip.hasStatusEffect("LDrive Disabled"))
			{
				if (playerShip.hasStatusEffect("LDrive Spooling"))
				{
					var lDrive:StatusEffect = playerShip.getStatusEffect("LDrive Spooling");
					if (lDrive.payload.attemptInRound >= _roundCounter)
					{
						addButton(14, "Escape", escapeAttempt, undefined, "Engage Lightdrive", "Make an escape attempt using your ships lightdrive!");
					}
					else
					{
						addDisabledButton(14, "Escape", "Lightdrive Charging", "Your lightdrive is currently spooling up!");
					}
				}
				else
				{
					addButton(14, "Escape", chargeLightDrive, undefined, "Charge Lightdrive", "Spool up your lightdrive as quickly as possible to make an attempt at escape!");
				}
			}
			else
			{
				addDisabledButton(14, "Escape", "Engage Lightdrive", "You can't use your lightdrive to escape this fight!");
			}
			*/
			addDisabledButton(14, "Escape", "Escape", "With as much debris as there is floating around the wreck of the constellation, making an attempt to activate your ships Light Drive would probably not be advisable.");
		}
		
		/**
		 * Make an actual escape chance calculation to end combat.
		 */
		private function escapeAttempt():void
		{
			throw new Error("Not Implemented Yet.");
		}
		
		/**
		 * Start the charging (spoolup) process that the ships equipped lightdrive requires before it can be activated.
		 */
		private function chargeLightDrive():void
		{
			throw new Error("Not Implemented Yet.");
		}
		
		private function getOrderPowerUsage():Number
		{
			var usage:Number = 0;
			usage += getOffensivePowerCost();
			usage += getDefensivePowerCost();
			usage += getNavigationOrderPowerCost();
			return usage;
		}
		
		private function selectOffensiveOrder():void
		{
			clearMenu();
			removeAllButtonHighlights();
			
			addButton(0, "None", selOffensiveOrder, "none", "Clear Order", "Clear any selected orders.");
			
			if (getOrderPowerUsage() - getOffensivePowerCost() + 80 <= playerShip.actualCapacitorCharge) addButton(1, "Overcharge", selOffensiveOrder, "overcharge", "Overcharged Emitters", "Overcharge your laser emitters, increasing damage by 25% but increasing powercost by 100%.\n\nActivation Cost: 80 Power");
			else addDisabledButton(1, "Overcharge", "Overcharged Emitters", "Overcharge your laser emitters, increasing damage by 25% but increasing powercost by 100%.\n\nActivation Cost: 80 Power\n\nYou do not have enough power!");
			
			if (getOrderPowerUsage() - getOffensivePowerCost() + 60 <= playerShip.actualCapacitorCharge)
			addButton(2, "S.Strikes", selOffensiveOrder, "surgicalstrike", "Surgical Strikes", "Engage manual fire control of your ships weapons systems, and make each shot count. Increases critical shot chance by 10%, but increases power cost by 100%.\n\nActivation Cost: 60 Power");
			else addDisabledButton(2, "S.Strikes", "Surgical Strikes", "Engage manual fire control of your ships weapons systems, and make each shot count. Increases critical shot chance by 10%, but increases power cost by 100%.\n\nActivation Cost: 60 Power\n\nYou do not have enough power!");
			
			addButton(3, "C.Bursts", selOffensiveOrder, "controlledbursts", "Aim for peak optimisation of your ships weapons systems, reducing power cost by 25% but decreasing damage by 10%.\n\nActivation Cost: 0 Power");
			
			if (_attackSelections.offensiveOrder != undefined)
			{
				var btn:int = -1;
				switch (_attackSelections.offensiveOrder)
				{
					case "overcharge":
						btn = 1;
						break;
						
					case "surgicalstrike":
						btn = 2;
						break;
						
					case "controlledbursts":
						btn = 3;
						break;
						
					default:
						btn = -1;
						break;
				}
				
				if (btn != -1) highlightButton(btn);
			}
		}
		
		private function getOffensiveOrderText():String
		{
			if (_attackSelections.offensiveOrder == undefined)
			{
				return "None";
			}
			else
			{
				switch (_attackSelections.offensiveOrder)
				{
					case "overcharge":
						return "Overcharge";
						break;
						
					case "surgicalstrike":
						return "S.Strike";
						break;
						
					case "controlledbursts":
						return "C.Bursts";
						break;
						
					default:
						return "None";
						break;
				}
			}
			return "None";
		}
		
		private function getOffensivePowerCost():Number
		{
			switch (getOffensiveOrderText())
			{
				case "Overcharge":
					return 80;
					break;
					
				case "S.Strike":
					return 60;
					break;
					
				case "C.Bursts":
					return 0;
					break;
				
				default:
					return 0;
					break;
			}
		}
		
		private function getWeaponCostMultiForType(t:String):Number
		{
			var multi:Number = 1.0;
			
			if (t == OffensiveModule.WEAPON_TYPE_LASER)
			{
				if (_attackSelections.offensiveOrder == "overcharge") multi += 1.0;
			}
			
			if (_attackSelections.offensiveOrder == "surgicalstrike") multi += 1.0;
			if (_attackSelections.offensiveOrder == "controlledbursts") multi -= 0.25;
			
			return multi;
		}
		
		private function getWeaponCost():Number
		{
			var cost:Number = 0;
			
			for (var i:int = 0; i < playerShip.equippedModules.length; i++)
			{
				if (playerShip.equippedModules[i].type == ShipModule.TYPE_WEAPON && playerShip.equippedModules[i].autoFires == true)
				{
					var mod:OffensiveModule = playerShip.equippedModules[i] as OffensiveModule;
					
					cost += mod.powerconsumption * getWeaponCostMultiForType(mod.weaponType);
				}
			}
			
			return cost;
		}
		
		private function selOffensiveOrder(arg:String):void
		{
			if (arg == "none") 
			{
				delete _attackSelections.offensiveOrder;
			}
			else
			{
				_attackSelections.offensiveOrder = arg;
			}
			
			generateCombatMenu();
		}
		
		private function selectDefensiveOrder():void
		{
			clearMenu();
			removeAllButtonHighlights();
			
			addButton(0, "None", selDefensiveOrder, "none", "Clear Order", "Clear any selected orders.");
			if (getOrderPowerUsage() - getDefensivePowerCost() + 55 <= playerShip.actualCapacitorCharge) addButton(1, "Freq.Mod", selDefensiveOrder, "frequencymodulation", "Frequency Modulation", "Initiate a rotating shield harmonic frequency. Increases shield resistances by 10% but reduces shield recharge rate by 25%.\n\nActivation Cost: 55 Power");
			else addDisabledButton(1, "Freq.Mod", "Frequency Modulation", "Initiate a rotating shield harmonic frequency. Increases shield resistances by 10% but reduces shield recharge rate by 25%.\n\nActivation Cost: 55 Power\n\nYou do not have enough power!");
			
			if (getOrderPowerUsage() - getDefensivePowerCost() - 61 <= playerShip.actualCapacitorCharge) addButton(2, "CapDump", selDefensiveOrder, "capacitordump", "Capacitor Dump", "Initiate an emergency recharge of the ships shield emitters, dumping all available power from the capacitor into the shield emitters at 40% of the normal recharge rate.\n\nActivation Cost: 60 Power");
			else addDisabledButton(2, "CapDump", "Capacitor Dump", "Initiate an emergency recharge of the ships shield emitters, dumping all available power from the capacitor into the shield emitters at 40% of the normal recharge rate.\n\nActivation Cost: 60 Power\n\nYou do not have enough power!");
			
			if (_attackSelections.defensiveOrder != undefined)
			{
				var btn:int = -1;
				switch (_attackSelections.defensiveOrder)
				{
					case "frequencymodulation":
						btn = 0;
						break;
					
					case "capacitordump":
						btn = 1;
						break;
						
					default:
						btn = -1;
						break;
				}
				
				if (btn != -1) highlightButton(btn);
			}
		}
		
		private function getDefensiveOrderText():String
		{
			if (_attackSelections.defensiveOrder == undefined)
			{
				return "None";
			}
			else
			{
				switch (_attackSelections.defensiveOrder)
				{
					case "frequencymodulation":
						return "Freq.Mod";
						break;
						
					case "capacitordump":
						return "CapDump";
						break;
						
					default:
						return "None";
						break;
				}
			}
			return "None";
		}
		
		private function getDefensivePowerCost():Number
		{
			switch (getDefensiveOrderText())
			{
				case "Freq.Mod":
					return 55;
					break;
					
				case "CapDump":
					return 60;
					break;
					
				default:
					return 0;
					break;
			}
			return 0;
		}
		
		private function selDefensiveOrder(arg:String):void
		{
			if (arg == "none")
			{
				delete _attackSelections.defensiveOrder;
			}
			else
			{
				_attackSelections.defensiveOrder = arg;
			}
			
			generateCombatMenu();
		}
		
		private function selectNavigationOrder():void
		{
			clearMenu();
			removeAllButtonHighlights();
			
			addButton(0, "None", selNavigationOrder, "none", "Clear Order", "Clear any selected orders.");
			
			if (getOrderPowerUsage() - getNavigationOrderPowerCost() + 60 <= playerShip.actualCapacitorCharge) addButton(1, "E.Maneuvers", selNavigationOrder, "evasive", "Evasive Maneuvers", "Maximise your ships chances to avoid incoming hostile fire. Reduces chance to be hit by 10% but increases weapon power usage by 25% to compensate.\n\nActivation Cost: 60 Power");
			else addDisabledButton(1, "E.Maneuvers", "Evasive Maneuvers", "Maximise your ships chances to avoid incoming hostile fire. Reduces chance to be hit by 10% but increases weapon power usage by 25% to compensate.\n\nActivation Cost: 60 Power\n\nYou do not have enough power!");
			
			if (getOrderPowerUsage() - getNavigationOrderPowerCost() + 80 <= playerShip.actualCapacitorCharge) addButton(2, "UnderGuns", selNavigationOrder, "undertheirguns", "Under Their Guns", "Close in on the hostile ship in an attempt to avoid their weapon systems firing arcs.\n\nReduces chance to be hit by 25% but increases all damage taken by 50%.\n\nActivation Cost: 80 Power");
			else addDisabledButton(2, "UnderGuns", "Under Their Guns", "Close in on the hostile ship in an attempt to avoid their weapon systems firing arcs.\n\nReduces chance to be hit by 25% but increases all damage taken by 50%.\n\nActivation Cost: 80 Power\n\nYou do not have enough power!");
			
			if (_attackSelections.navigationOrder != undefined)
			{
				var btn:int = -1;
				switch (_attackSelections.navigationOrder)
				{
					case "evasive":
						btn = 1;
						break;
					
					case "undertheirguns":
						btn = 2;
						break;
						
					default:
						btn = -1;
						break;
				}
				
				if (btn != -1) highlightButton(btn);
			}
		}
		
		private function getNavigationOrderText():String
		{
			if (_attackSelections.navigationOrder == undefined)
			{
				return "None";
			}
			else
			{
				switch (_attackSelections.navigationOrder)
				{
					case "evasive":
						return "E.Maneuvers";
						break;
						
					case "undertheirguns":
						return "UnderGuns";
						break;
						
					default:
						return "None";
						break;
				}
			}
			return "None";
		}
		
		private function selNavigationOrder(arg:String):void
		{
			if (arg == "none")
			{
				delete _attackSelections.navigationOrder;
			}
			else
			{
				_attackSelections.navigationOrder = arg;
			}
			
			generateCombatMenu();
		}
		
		private function getNavigationOrderPowerCost():Number
		{
			switch (getNavigationOrderText())
			{
				case "E.Maneuvers":
					return 60;
					break;
					
				case "UnderGuns":
					return 80;
					break;
					
				default:
					return 0;
					break;
			}
		}
		
		private function cheatKillEverything():void
		{
			_hostiles[0].actualHullHP = 0;
		}
		
		private function showCombatUI(roundInit:Boolean = false):void
		{
			if (roundInit)
			{
				userInterface().showPlayerShip();
				userInterface().hidePlayerParty();
				userInterface().setPlayerShipData(playerShip);
				
				userInterface().hideMinimap();
				userInterface().showHostileShip();
				userInterface().setHostileShipData(hostileShip);
			}
			else
			{
				var modShield:Number = 0;
				var modHull:Number = 0;
				var modReactor:Number = 0;
				var modCap:Number = 0;
				
				modReactor -= getWeaponCost();
				modReactor -= getOffensivePowerCost();
				modReactor -= getDefensivePowerCost();
				modReactor -= getNavigationOrderPowerCost();
				
				userInterface().updatePlayerShipData(playerShip, modShield, modHull, modReactor, modCap);
				userInterface().updateHostileShipData(hostileShip);
			}
		}
		
		private function showCombatDescriptions():void
		{
			output("You're engaged in space combat with a hostile ship!\n\n");
			output(hostileShip.description);
		}
		
		private function checkForVictory():Boolean
		{
			if (playerVictoryCondition())
			{
				clearMenu();
				addButton(0, "Victory", _victoryFunction);
				return true;
			}
			return false;
		}
		
		private function playerVictoryCondition():Boolean
		{
			if (victoryCondition == CombatManager.ENTIRE_PARTY_DEFEATED)
			{
				if (hostileShip.isDefeated()) return true;
				return false;
			}
			else if (victoryCondition == CombatManager.SURVIVE_WAVES)
			{
				if (victoryArgument <= 0) throw new Error("Wave survival declared as victory condition, with no target wave count defined.");
				if (_roundCounter >= victoryArgument) return true;
				return false;
			}
			
			return false;
		}
		
		private function checkForLoss():Boolean
		{
			if (playerLossCondition())
			{
				clearMenu();
				addButton(0, "Defeat", _lossFunction);
				return true;
			}
			return false;
		}
		
		private function playerLossCondition():Boolean
		{
			if (lossCondition == CombatManager.ENTIRE_PARTY_DEFEATED)
			{
				if (playerShip.isDefeated()) return true;
				return false;
			}
			else if (lossCondition == CombatManager.SURVIVE_WAVES)
			{
				if (lossArgument <= 0) throw new Error("Wave survival declared as loss condition, with no target wave count defined.");
				if (_roundCounter >= lossArgument) return true;
				return false;
			}
			
			return false;
		}
		
		private function processCombat():void
		{
			// Hook any pre-action shit here
			clearOutput();
			output("Systems across the ship hum and whirr in unison, hardware and crew alike coming together in your shared time of need.");
			
			processPlayerActions();
		}
		
		private function processPlayerActions():void
		{
			applyPlayerActions();
			updateStatusEffects(playerShip);
			
			if (checkForVictory()) return;
			
			showCombatUI();
			
			clearMenu();
			removeAllButtonHighlights();
			addButton(0, "Next", processAIActions);
		}
		
		private function applyPlayerActions():void
		{
			var powerUsed:Number = 0;
			
			if (_attackSelections.offensiveOrder != undefined)
			{
				if (_attackSelections.offensiveOrder == "overcharge")
				{
					playerShip.addTemporaryModifier("Laser Damage Mod", { value: 0.25 } );
					playerShip.addTemporaryModifier("Laser Cost Mod", { value: 1.0 } );
					powerUsed += getOffensivePowerCost();
				}
				else if (_attackSelections.offensiveOrder == "surgicalstrike")
				{
					playerShip.addTemporaryModifier("Critical Chance Mod", { value: 0.1 } );
					playerShip.addTemporaryModifier("Weapon Cost Mod", { value: 1.0 } );
					powerUsed += getOffensivePowerCost();
				}
				else if (_attackSelections.offensiveOrder == "controlledbursts")
				{
					playerShip.addTemporaryModifier("Weapon Cost Mod", { value: -0.25 } );
					playerShip.addTemporaryModifier("Weapon Damage Mod", { value: -0.1 } );
				}
			}
			
			if (_attackSelections.defensiveOrder != undefined)
			{
				if (_attackSelections.defensiveOrder == "frequencymodulation")
				{
					playerShip.addTemporaryModifier("Shield Resistance Bonus", { value: 0.1 } );
					playerShip.addTemporaryModifier("Shield Recharge Multiplier", { value: -0.25 } );
					powerUsed += getDefensivePowerCost();
				}
				else if (_attackSelections.defensiveOrder == "capacitordump")
				{
					playerShip.addTemporaryModifier("CapDump", { } );
					powerUsed += getDefensivePowerCost();
				}
			}
			
			if (_attackSelections.navigationOrder != undefined)
			{
				if (_attackSelections.navigationOrder == "evasive")
				{
					playerShip.addTemporaryModifier("Evasion Multiplier", { value: 0.1 } );
					playerShip.addTemporaryModifier("Weapon Cost Mod", { value: 0.25 } );
					powerUsed += getNavigationOrderPowerCost();
				}
				else if (_attackSelections.navigationOrder == "undertheirguns")
				{
					playerShip.addTemporaryModifier("Evasion Multiplier", { value: 0.25 } );
					playerShip.addTemporaryModifier("Damage Taken Multiplier", { value: 0.5 } );
					powerUsed += getNavigationOrderPowerCost();
				}
			}
			
			playerShip.actualCapacitorCharge -= powerUsed;
			
			// Do shooty shoot
			powerUsed = playerShip.attackTarget(hostileShip, playerShip.autofireOffensiveModulesEquipped());
			playerShip.applyRecharge(powerUsed);
		}
		
		private function processAIActions():void
		{
			clearOutput();
			removeAllButtonHighlights();
			
			output("Your tactical display focuses on " + hostileShip.longName + " as it gracefully sweeps around to bring its guns to bear."); 
			
			updateStatusEffects(hostileShip);
			generateAIActions();
		}
		
		private function generateAIActions():void
		{
			hostileShip.generateAIAction(playerShip);
			
			showCombatUI();
			
			if (checkForVictory()) return;
			if (checkForLoss()) return;
			
			clearMenu();
			addButton(0, "Next", returnToCombatMenu);
		}
		
		private function returnToCombatMenu():void
		{
			_roundCounter++;
			showCombatMenu();
		}
		
		private function updateStatusEffects(target:Ship):void
		{
			target.updateStatusEffects(1, StatusEffect.DURATION_ROUNDS);
		}		
	}
}