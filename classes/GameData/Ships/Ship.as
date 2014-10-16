package classes.GameData.Ships 
{
	import classes.DataManager.Serialization.VersionedSaveable;
	import classes.Resources.Busts.StaticRenders;
	import flash.geom.Point;
	import classes.GameData.Items.ShipModules.ShipModule;
	import classes.GameData.ShipIndex;
	
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
		
		public var lightDriveModule:ShipModule = null;
		public var engineModule:ShipModule = null;
		public var shieldModule:ShipModule = null;
		
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
		
		public function equippedOffensiveModules():int
		{
			return numModulesOfType(ShipModule.TYPE_WEAPON);	
		}
		public function equippedDefensiveModules():int
		{
			return numModulesOfType(ShipModule.TYPE_DEFENSIVE);
		}
		public function equippedNavigationModules():int
		{
			return numModulesOfType(ShipModule.TYPE_NAVIGATION);
		}
		public function equippedUtilityModules():int
		{
			return numModulesOfType(ShipModule.TYPE_UTILITY);
		}
		
		// Stats -- Fitting
		public var maxPowergrid:int = 1000;
		public function currentPowergrid():int
		{
			var total:int = 0;
			for (var i:int = 0; i < equippedModules.length; i++)
			{
				total += equippedModules[i].powergrid;
			}
			return total;
		}
		
		public var baseMaxCrewComplement:int = 7;
		public function maxCrewComplement():int
		{
			return baseMaxCrewComplement;
		}
		
		// Stats -- Combat
		public var baseHullHP:int = 100;
		public var actualHullHP:int = 100;
		
		public function maxHullHP():int
		{
			return baseHullHP;
		}
		public function currentHullHP():int
		{
			return actualHullHP;
		}
		
		public var baseAgility:int = 10;
		public function agility():int
		{
			return baseAgility;
		}
	}

}