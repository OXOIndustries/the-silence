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
		public function actualHullResistances():Array
		{
			// TODO: Hook in defensive modules to increase returned ResistanceCollection.
			// Resistances should be added in the form of:
			// (100 - currentResistance) * addedResistance, ergo reducing the effectiveness of stacking.
			return hullResistances;
		}
		
		public function actualShieldResistances():Array
		{
			// TODO: Hook in defensive modules to increase returned ResistanceCollection.
			// Resistances should be added in the form of:
			// (100 - currentResistance) * addedResistance, ergo reducing the effectiveness of stacking.
			return shieldModule.shieldResistances;
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
			return 0.0;
		}
		
		public function emDamageBonus():Number
		{
			return 0.0;
		}
		public function kinDamageBonus():Number
		{
			return 0.0;
		}
		public function expDamageBonus():Number
		{
			return 0.0;
		}
		public function thermDamageBonus():Number
		{
			return 0.0;
		}
		
		public function emDamageMultiplier():Number
		{
			return 1.0;
		}
		public function kinDamageMultiplier():Number
		{
			return 1.0;
		}
		public function expDamageMultiplier():Number
		{
			return 1.0;
		}
		public function thermDamageMultiplier():Number
		{
			return 1.0;
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
			var shieldRegen:Number = remains * shieldModule.shieldRecharge;
			var capGen:Number = remains - shieldRegen;
			
			actualShieldHP += shieldRegen;
			
			if (actualShieldHP >= maxShieldHP())
			{
				capGen += (actualShieldHP - maxShieldHP()) * (1 / shieldModule.shieldRecharge); // Should invert the value so we get "cap gen scale" spillover
				actualShieldHP = maxShieldHP();
			}
			
			actualCapacitorCharge += capGen;
			if (actualCapacitorCharge >= maxCapacitorCharge())
			{
				var leftover:Number = actualCapacitorCharge - maxCapacitorCharge();
				actualCapacitorCharge = maxCapacitorCharge();
				
				if (actualShieldHP < maxShieldHP())
				{
					actualShieldHP += leftover * shieldModule.shieldRecharge;
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
		 */
		public function attackTarget(targetShip:Ship, weaponSelection:Array):void
		{
			var calledTypes:Array = [];
			
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
						if (getQualifiedClassName(weaponSelection[i]) == getQualifiedClassName(weaponSelection[ii])) numOfType++;
					}
					
					// And fire them "once" with all the output enabled, indicating the number of weapons involved.
					(weaponSelection[i] as OffensiveModule).attackTarget(targetShip, this, numOfType);
					
					// Then mark this type as having been fired
					calledTypes.push(getQualifiedClassName(weaponSelection[i]));
				}
			}
		}
	}

}