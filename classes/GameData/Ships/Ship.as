package classes.GameData.Ships 
{
	import classes.DataManager.Serialization.VersionedSaveable;
	import classes.GameData.Items.ShipModules.Capacitor.IECapbankXVI;
	import classes.GameData.Items.ShipModules.CapacitorModule;
	import classes.GameData.Items.ShipModules.DefensiveModule;
	import classes.GameData.Items.ShipModules.EngineModule;
	import classes.GameData.Items.ShipModules.LightdriveModule;
	import classes.GameData.Items.ShipModules.Offensive.Lasers.ReaperLightLaserTurret;
	import classes.GameData.Items.ShipModules.OffensiveModule;
	import classes.GameData.Items.ShipModules.ReactorModule;
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	import classes.GameData.Items.ShipModules.ShieldModule;
	import classes.GameData.Items.ShipModules.UtilityModule;
	import classes.GameData.StatusEffect;
	import classes.Resources.Busts.StaticRenders;
	import flash.geom.Point;
	import classes.GameData.Items.ShipModules.ShipModule;
	import classes.GameData.ShipIndex;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class Ship extends VersionedSaveable
	{
		protected var _neverSerialize:Boolean = false;
		public function get neverSerialize():Boolean { return _neverSerialize; }
		
		
		public function Ship() 
		{
			this.addIgnoredField("neverSerialize");
			this.addIgnoredField("hasConnection");
			this.addIgnoredField("connectedShipObject");
			this.addIgnoredField("airlockConnectsTo");
			this.addIgnoredField("equippedDefensiveModules");
			this.addIgnoredField("equippedNavigationModules");
			this.addIgnoredField("equippedOffensiveModules");
			this.addIgnoredField("equippedUtilityModules");
			this.addIgnoredField("currentPowergrid");
			this.addIgnoredField("maxCrewComplement");
			this.addIgnoredField("maxHullHP");
			this.addIgnoredField("currentHullHP");
			this.addIgnoredField("agility");
			this.addIgnoredField("bustT");
		}
		
		// Identification/display
		public var bustT:Class = StaticRenders.MISSING;
		public var INDEX:String = "";
		public var shortName:String = "";
		public var longName:String = "";
		public var description:String = "";
		public var a:String = "a ";
		public var A:String = "A ";
		public var plural:Boolean = false;
		
		// Location
		public var currentLocation:String = ""; // System the ship is located in
		public var posX:Number = 0;
		public var posY:Number = 0;
		
		public var shipInterior:String = ""; // The FQN of the ship interior airlock
		public var connectedShip:String = "";
		
		/**
		 * Connect the two ships together.
		 * @param	ship
		 */
		public function moveToShip(ship:Ship):void
		{
			connectedShip = ship.INDEX;
			connectedShipObject().connectedShip = this.INDEX;
		}
		
		public function disconnectShips():void
		{
			connectedShipObject().connectedShip = "";
			connectedShip = "";
		}
		
		public function hasConnection():Boolean
		{
			if (airlockConnectsTo() != null && airlockConnectsTo().length > 0) return true;
			return false;
		}
		
		public function connectedShipObject():Ship
		{
			if (connectedShip.length > 0)
				return ShipIndex.Ships[connectedShip];
			else
				return null;
		}
		
		public function airlockConnectsTo():String
		{
			if (connectedShipObject() != null) return connectedShipObject().shipInterior;
			else return "";
		}
		
		// Equipment
		public var maxOffensiveModules:int = 1;
		public var maxDefensiveModules:int = 1;
		public var maxNavigationModules:int = 1;
		public var maxUtilityModules:int = 1;
		
		public var maxEquipmentSlots:int = 3;
		
		public var lightDriveModule:LightdriveModule = null;
		public var engineModule:EngineModule = null;
		public var shieldModule:ShieldModule = null;
		public var reactorModule:ReactorModule = null;
		public var capacitorModule:CapacitorModule = null;
		
		public var equippedModules:Array = [];
		
		private function numModulesOfType(t:String):int
		{
			var total:int = 0;
			for (var i:int = 0; i < equippedModules.length; i++)
			{
				if (equippedModules[i].type == t) total++;
			}
			return total;		
		}
		private function getModulesOfType(t:String):Array
		{
			var mods:Array = [];
			for (var i:int = 0; i < equippedModules.length; i++)
			{
				if (equippedModules[i].type == t) mods.push(equippedModules[i]);
			}
			return mods;
		}
		
		public function offensiveModulesTotal():int
		{
			return numModulesOfType(ShipModule.TYPE_WEAPON);	
		}
		public function defensiveModulesTotal():int
		{
			return numModulesOfType(ShipModule.TYPE_DEFENSIVE);
		}
		public function navigationModulesTotal():int
		{
			return numModulesOfType(ShipModule.TYPE_NAVIGATION);
		}
		public function utilityModulesTotal():int
		{
			return numModulesOfType(ShipModule.TYPE_UTILITY);
		}
		
		public function offensiveModulesEquipped():Array
		{
			return getModulesOfType(ShipModule.TYPE_WEAPON);
		}
		public function defensiveModulesEquipped():Array
		{
			return getModulesOfType(ShipModule.TYPE_DEFENSIVE);
		}
		public function navigationModulesEquipped():Array
		{
			return getModulesOfType(ShipModule.TYPE_NAVIGATION);
		}
		public function utilityModulesEquipped():Array
		{
			return getModulesOfType(ShipModule.TYPE_UTILITY);
		}
		
		// Stats -- Fitting
		public var maxPowergrid:Number = 1000;
		public function currentPowergrid():int
		{
			var total:int = 0;
			for (var i:int = 0; i < equippedModules.length; i++)
			{
				total += equippedModules[i].powergrid;
			}
			
			total += lightDriveModule.powergrid;
			total += engineModule.powergrid;
			total += shieldModule.powergrid;
			total += reactorModule.powergrid;
			total += capacitorModule.powergrid;
			
			return total;
		}
		
		public var baseMaxCrewComplement:int = 7;
		public function maxCrewComplement():int
		{
			var total:int = 0;
			for (var i:int = 0; i < equippedModules.length; i++)
			{
				if (equippedModules[i] is UtilityModule)
				{
					var um:UtilityModule = equippedModules[i] as UtilityModule;
					total += um.bonusCrewComplement;
				}
			}
			
			return total + baseMaxCrewComplement;
		}
		
		// Stats -- Health/Operation
		public var baseHullHP:Number = 100;
		public var actualHullHP:Number = 100;
		public function maxHullHP():int
		{
			var total:int = 0;
			var multi:int = 1.0;
			
			for (var i:int = 0; i < equippedModules.length; i++)
			{
				if (equippedModules[i] is DefensiveModule)
				{
					var dm:DefensiveModule = equippedModules[i] as DefensiveModule;
					total += dm.bonusHull;
					multi += dm.bonusHullMultiplier;
				}
			}
			
			return (total + baseHullHP) * multi;
		}
		public function currentHullHP():int
		{
			return actualHullHP;
		}
		
		public function isDefeated():Boolean
		{
			return currentHullHP() <= 0;
		}
			
		public var actualShieldHP:Number = 0;
		public function maxShieldHP():Number
		{
			return shieldModule.baseShield;
		}
		public function currentShieldHP():Number
		{
			return actualShieldHP;
		}
		public function shieldPercent():Number
		{
			return actualShieldHP / maxShieldHP();
		}
		
		public var actualCapacitorCharge:Number = 0;
		public function maxCapacitorCharge():Number
		{
			return capacitorModule.powerStorage;
		}
		public function currentCapacitorCharge():Number
		{
			return actualCapacitorCharge;
		}
		
		// Stats -- Resistances
		public var hullResistances:ResistanceCollection = new ResistanceCollection(40.0, 15.0, 0.0, 25.0);
		public function actualHullResistances():ResistanceCollection
		{
			// TODO: Hook in defensive modules to increase returned ResistanceCollection.
			// Resistances should be added in the form of:
			// (100 - currentResistance) * addedResistance, ergo reducing the effectiveness of stacking.
			
			var defModules:Array = defensiveModulesEquipped();
			
			var resistances:ResistanceCollection = hullResistances.getCopy();
			
			for (var i:int = 0; i < defModules.length; i++)
			{
				var defModule:DefensiveModule = defModules[i];
				resistances.combineResistances(defModule.bonusHullResistances);
			}
			
			if (hasStatusEffect("Hull Resistance Bonus"))
			{
				var se:StatusEffect = statusEffects["Hull Resistance Bonus"];
				var bonusR:ResistanceCollection = new ResistanceCollection();
				
				if (se.payload.value != undefined)
				{
					bonusR.em.ResistAmount = se.payload.value;
					bonusR.exp.ResistAmount = se.payload.value;
					bonusR.kin.ResistAmount = se.payload.value;
					bonusR.therm.ResistAmount = se.payload.value;
				}
				
				if (se.payload.em != undefined) bonusR.em.ResistAmount += se.payload.em;
				if (se.payload.exp != undefined) bonusR.exp.ResistAmount += se.payload.exp;
				if (se.payload.kin != undefined) bonusR.kin.ResistAmount += se.payload.kin;
				if (se.payload.therm != undefined) bonusR.therm.ResistAmount += se.payload.therm;
				
				resistances.combineResistances(bonusR);
			}
			
			return resistances;
		}
		
		public function actualShieldResistances():ResistanceCollection
		{
			// TODO: Hook in defensive modules to increase returned ResistanceCollection.
			// Resistances should be added in the form of:
			// (100 - currentResistance) * addedResistance, ergo reducing the effectiveness of stacking.
			
			var defModules:Array = defensiveModulesEquipped();
			
			var resistances:ResistanceCollection = shieldModule.shieldResistances.getCopy();
			
			for (var i:int = 0; i < defModules.length; i++)
			{
				var defModule:DefensiveModule = defModules[i];
				resistances.combineResistances(defModule.bonusShieldResistances);
			}
			
			if (hasStatusEffect("Shield Resistance Bonus"))
			{
				var se:StatusEffect = statusEffects["Hull Resistance Bonus"];
				var bonusR:ResistanceCollection = new ResistanceCollection();
				
				if (se.payload.value != undefined)
				{
					bonusR.em.ResistAmount = se.payload.value;
					bonusR.exp.ResistAmount = se.payload.value;
					bonusR.kin.ResistAmount = se.payload.value;
					bonusR.therm.ResistAmount = se.payload.value;
				}
				
				if (se.payload.em != undefined) bonusR.em.ResistAmount += se.payload.em;
				if (se.payload.exp != undefined) bonusR.exp.ResistAmount += se.payload.exp;
				if (se.payload.kin != undefined) bonusR.kin.ResistAmount += se.payload.kin;
				if (se.payload.therm != undefined) bonusR.therm.ResistAmount += se.payload.therm;
				
				resistances.combineResistances(bonusR);
			}
			
			return resistances;
		}
		
		// Stats -- Modifiers etc.
		public var baseAgility:Number = 5;
		public function agility():int
		{
			return baseAgility * engineModule.agilityMultiplier;
		}
		
		public function maneuveringSpeed():Number
		{
			return engineModule.maneuveringSpeed;
		}
		
		// Stats - Subsystem Health
		
		/**
		 * Returns the average max health of all modules of a given type.
		 * The average will be used to keep this as simple as possible.
		 * if (currentDamage > targetModule.maxHealth) module is unavailable effectively.
		 * @param	t
		 * @return
		 */
		private function getMaxHealthForType(t:String):Number
		{
			var mods:Array = getModulesOfType(t);
			var hp:Number = 0;
			
			for (var i:int = 0; i < mods.length; i++)
			{
				hp += mods[i].moduleBaseHealth;
			}
			
			hp /= mods.length;
			
			return hp;
		}
		
		public function offensiveModuleMaxHealth():Number
		{
			return getMaxHealthForType(ShipModule.TYPE_WEAPON);
		}
		public function defensiveModuleMaxHealth():Number
		{
			return getMaxHealthForType(ShipModule.TYPE_DEFENSIVE);
		}
		public function navigationModuleMaxHealth():Number
		{
			return getMaxHealthForType(ShipModule.TYPE_NAVIGATION);
		}
		public function utilityModuleMaxHealth():Number
		{
			return getMaxHealthForType(ShipModule.TYPE_UTILITY);
		}
		
		public var offensiveModuleCurrentHealth:Number;
		public var defensivemoduleCurrentHealth:Number;
		public var navigationModuleCurrentHealth:Number;
		public var utilityModuleCurrentHealth:Number;
		
		// Combat Status
		public var statusEffects:Object = { };
		
		/**
		 * Create or merge values into an existing status effect.
		 * This is designed for single-round modifiers to the player ship, declared via order functions.
		 * Orders are implemented by stacking many simple status effects to change properties on the ship, that can be immediately cleared in the round after.
		 * This way, many effects can share implementation details, and numerous mods can be applied in a single check.
		 * @param	mName
		 * @param	payload
		 */
		public function addTemporaryModifier(mName:String, payload:Object):void
		{
			if (statusEffects[mName] == undefined)
			{
				addStatusEffect(new StatusEffect(mName, payload, -1, StatusEffect.DURATION_ROUNDS, null, true, true));
			}
			else
			{
				var se:StatusEffect = statusEffects[mName];
				
				for (var prop:String in payload)
				{
					if (se.payload[prop] == undefined)
					{
						se.payload[prop] = payload[prop];
					}
					else
					{
						se.payload[prop] += payload[prop];
					}
				}
			}
		}
		public function addStatusEffect(se:StatusEffect):void
		{
			if (statusEffects[se.name] == undefined)
			{
				statusEffects[se.name] = se;
				if (se.onCreate != null)
					se.onCreate(se, this);
			}
			else
				throw new Error("Status effect with this name already exists!");
		}
		public function hasStatusEffect(n:String):Boolean
		{
			return (statusEffects[n] != undefined);
		}
		public function getStatusEffect(n:String):StatusEffect
		{
			return statusEffects[n];
		}
		public function updateStatusEffects(delta:int):void
		{
			var remove:Array = [];
			
			for (var prop:String in statusEffects)
			{
				var se:StatusEffect = statusEffects[prop];
				
				if (se.durationMode != StatusEffect.DURATION_PERM)
				{
					se.duration -= delta;
					if (se.duration < 0)  remove.push(prop);
				}
			}
			
			removeStatusEffects(remove);
		}
		public function removeStatusEffect(n:String):void
		{
			if (statusEffects[n] != undefined)
			{
				if (statusEffects[n].onRemove != null)
					statusEffects[n].onRemove(statusEffects[n], this);
					
				delete statusEffects[n];
			}
		}
		public function removeStatusEffects(a:Array):void
		{
			for (var i:int = 0; i < a.length; i++)
			{
				removeStatusEffect(a[i]);
			}
		}
		
		// Weapons -- Type availability
		private function hasWeaponType(t:String):Boolean
		{
			for (var i:int = 0; i < equippedModules.length; i++)
			{
				if (equippedModules[i] is OffensiveModule)
				{
					if (equippedModules[i].weaponType == t) return true;
				}
			}
			return false;
		}
		
		public function hasLasers():Boolean
		{
			return hasWeaponType(OffensiveModule.WEAPON_TYPE_LASER);
		}
		
		public function hasMissiles():Boolean
		{
			return hasWeaponType(OffensiveModule.WEAPON_TYPE_MISSILE);
		}
		
		// Weapons -- Bonuses
		public function trackingModifierMultiplier():Number
		{
			return 1.0;
		}
		
		public function trackingModifierBonus():Number
		{
			return 0.0;
		}
		
		/**
		 * This is an /additional/ multiplier applied to the existing weapon crit damage multiplier.
		 * ie they are additive, so no bonus here is 0, not 1.
		 * @return
		 */
		public function criticalDamageMultiplier():Number
		{
			var multi:Number = 0.0;
			
			if (hasStatusEffect("Critical Damage Mod"))
			{
				multi += statusEffects["Critical Damage Mod"].payload.value;
			}
			
			return multi;
		}
		
		public function emDamageBonus():Number
		{
			var bonus:Number = 0.0;
			
			if (hasStatusEffect("EM Damage Bonus"))
			{
				bonus += statusEffects["EM Damage Bonus"].payload.value;
			}
			
			return bonus;
		}
		public function kinDamageBonus():Number
		{
			var bonus:Number = 0.0;
			
			if (hasStatusEffect("Kin Damage Bonus"))
			{
				bonus += statusEffects["Kin Damage Bonus"].payload.value;
			}
			
			return bonus;
		}
		public function expDamageBonus():Number
		{
			var bonus:Number = 0.0;
			
			if (hasStatusEffect("Exp Damage Bonus"))
			{
				bonus += statusEffects["Exp Damage Bonus"].payload.value;
			}
			
			return bonus;
		}
		public function thermDamageBonus():Number
		{
			var bonus:Number = 0.0;
			
			if (hasStatusEffect("Therm Damage Bonus"))
			{
				bonus += statusEffects["Therm Damage Bonus"].payload.value;
			}
			
			return bonus;
		}
		
		public function emDamageMultiplier():Number
		{
			var multi:Number = 1.0;
			
			if (hasStatusEffect("EM Damage Multi"))
			{
				multi += statusEffects["EM Damage Multi"].payload.value;
			}
			
			return multi;
		}
		public function kinDamageMultiplier():Number
		{
			var multi:Number = 1.0;
			
			if (hasStatusEffect("Kin Damage Multi"))
			{
				multi += statusEffects["Kin Damage Multi"].payload.value;
			}
			
			return multi;
		}
		public function expDamageMultiplier():Number
		{
			var multi:Number = 1.0;
			
			if (hasStatusEffect("Exp Damage Multi"))
			{
				multi += statusEffects["Exp Damage Multi"].payload.value;
			}
			
			return multi;
		}
		public function thermDamageMultiplier():Number
		{
			var multi:Number = 1.0;
			
			if (hasStatusEffect("Therm Damage Multi"))
			{
				multi += statusEffects["Therm Damage Multi"].payload.value;
			}
			
			return multi;
		}
		
		public function getModifiedDamageForWeapon(w:OffensiveModule):ResistanceCollection
		{
			var multi:Number = 1.0;
			
			if (hasStatusEffect("Weapon Damage Mod"))
			{
				multi += statusEffects["Weapon Damage Mod"].payload.value;
			}
			
			if (w.weaponType == OffensiveModule.WEAPON_TYPE_LASER)
			{
				if (hasStatusEffect("Laser Damage Mod"))
				{
					multi += statusEffects["Laser Damage Mod"].payload.value;
				}
			}
			
			var newDamage:ResistanceCollection = w.damage.getCopy();
			
			newDamage.em.ResistAmount += emDamageBonus();
			newDamage.kin.ResistAmount += kinDamageBonus();
			newDamage.exp.ResistAmount += expDamageBonus();
			newDamage.therm.ResistAmount += thermDamageBonus();
			
			newDamage.em.ResistAmount *= emDamageMultiplier();
			newDamage.kin.ResistAmount *= kinDamageMultiplier();
			newDamage.exp.ResistAmount *= expDamageMultiplier();
			newDamage.therm.ResistAmount *= thermDamageMultiplier();
			
			newDamage.multiply(multi);
			
			return newDamage;
		}
		
		public function getModifiedPowerCostForWeapon(w:OffensiveModule):Number
		{
			var multi:Number = 1.0;
			
			if (hasStatusEffect("Weapon Cost Mod"))
			{
				multi += statusEffects["Weapon Cost Mod"].payload.value;
			}
			
			if (w.weaponType == OffensiveModule.WEAPON_TYPE_LASER)
			{
				if (hasStatusEffect("Laser Cost Mod"))
				{
					multi += statusEffects["Laser Cost Mod"].payload.value;
				}
			}
			
			return multi;
		}
		
		public function getModifiedCriticalChanceForWeapon(w:OffensiveModule):Number
		{
			var multi:Number = 1.0;
			
			if (hasStatusEffect("Critical Chance Mod"))
			{
				multi += statusEffects["Critical Chance Mod"].payload.value;
			}
			
			return multi;
		}
		
		// Operational Functions
		
		/**
		 * Calculate and return how much power the reactor can generate this turn.
		 * @return
		 */
		public function getPowerGenerated():Number
		{
			return reactorModule.powerGenerated;
		}
		public function getShieldRechargeMultiplier():Number
		{
			var base:Number = shieldModule.shieldRecharge;
			
			if (hasStatusEffect("Shield Recharge Multiplier"))
			{
				base *= statusEffects["Shield Recharge Multiplier"].payload.value;
			}
			
			return base;
		}
		/**
		 * Execute Reactor Recharge- take the generated power, remove the used power, apply charge
		 * to shields + capacitor.
		 * @param	powerUsed
		 */
		public function applyRecharge(powerUsed:Number = 0):void
		{
			var gen:Number = getPowerGenerated();
			gen -= powerUsed;
			
			if (gen > 0) handleRemainingPower(gen);
		}
		private function handleRemainingPower(remains:Number):void
		{
			var shieldRegen:Number = remains * getShieldRechargeMultiplier();
			var capGen:Number = remains - shieldRegen;
			
			actualShieldHP += shieldRegen;
			
			if (actualShieldHP >= maxShieldHP())
			{
				capGen += (actualShieldHP - maxShieldHP()) * (1 / getShieldRechargeMultiplier()); // Should invert the value so we get "cap gen scale" spillover
				actualShieldHP = maxShieldHP();
			}
			
			actualCapacitorCharge += capGen;
			if (actualCapacitorCharge >= maxCapacitorCharge())
			{
				var leftover:Number = actualCapacitorCharge - maxCapacitorCharge();
				actualCapacitorCharge = maxCapacitorCharge();
				
				if (actualShieldHP < maxShieldHP())
				{
					actualShieldHP += leftover * getShieldRechargeMultiplier();
					if (actualShieldHP > maxShieldHP()) actualShieldHP = maxShieldHP();
				}
			}
		}
		
		// Combat Engagement Functions
		/**
		 * Execute an attack against a target ship.
		 * This is a grouped attack handler- the combat system selects the weapons to use, and passes module references
		 * to this function as an array.
		 * @param	targetShip
		 * @param	weaponSelection
		 * @return	powerConsumed
		 */
		public function attackTarget(targetShip:Ship, weaponSelection:Array):Number
		{
			var calledTypes:Array = [];
			var powerConsumed:Number = 0;
			
			// For all weapons indicated...
			for (var i:int = 0; i < weaponSelection.length; i++)
			{
				// Determine if we've already actively fired this type of weapon
				if (calledTypes.indexOf(getQualifiedClassName(weaponSelection[i])) == -1)
				{
					// If we havent, determine how many instances of this weapon are actively being fired in this turn
					var numOfType:int = 0;
					
					for (var ii:int = 0; ii < weaponSelection.length; ii++)
					{
						if (getQualifiedClassName(weaponSelection[i]) == getQualifiedClassName(weaponSelection[ii])) numOfType++; // I would store the typeof() but typeof() in AS3 is retarded, and only returns base type info (ie string, object, number etc)
					}
					
					// And fire them "once" with all the output enabled, indicating the number of weapons involved.
					(weaponSelection[i] as OffensiveModule).attackTarget(targetShip, this, numOfType);
					powerConsumed += (getModifiedPowerCostForWeapon((weaponSelection[i] as OffensiveModule)) * numOfType)
					
					// Then mark this type as having been fired
					calledTypes.push(getQualifiedClassName(weaponSelection[i]));
				}
			}
			
			return powerConsumed;
		}
	}

}