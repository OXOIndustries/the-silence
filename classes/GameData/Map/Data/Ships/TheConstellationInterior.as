package classes.GameData.Map.Data.Ships 
{
	import classes.GameData.Map.Room;
	import classes.GameData.Map.Ship;
	import classes.GLOBAL;
	import classes.GameData.ContentIndex;
	import classes.GameData.GameState;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class TheConstellationInterior extends Ship
	{
		public function TheConstellationInterior() 
		{
			LocationIndex = "TheConstellation";
			LocationName = "CONSTELLATION";
			
			// Command Deck "Airlock"
			var breach:Room = new Room();
			breach.RoomIndex = "BreachCommand";
			breach.RoomName = "Command Deck: Breach";
			breach.ShortName = "Cmd.Dk Breach";
			breach.EntryFunction = ContentIndex.theConstellation.breachFunction;
			breach.MoveTime = 1;
			breach.AddFlag(GLOBAL.AIRLOCK);
			breach.AddFlag(GLOBAL.INDOOR);
			breach.NorthExit = "CommandDeckM24";
			breach.OutExit = "BreachEngineering";
			breach.OutName = "Down";
			breach.OutCondition = function():Boolean {
				if (GameState.flags["CONSTELLATION_INTERNAL_SHIELDS_ON"] == 1) return true;
				return false;
			}
			AddRoom(breach);

			// Engineering Deck "Airlock"
			var breachEngineering:Room = new Room();
			breachEngineering.RoomIndex = "BreachEngineering";
			breachEngineering.RoomName = "Engineering Deck: Breach";
			breachEngineering.ShortName = "Eng.Dk Breach";
			breachEngineering.EntryFunction = ContentIndex.theConstellation.breachFunction;
			breachEngineering.MoveTime = 1;
			breachEngineering.AddFlag(GLOBAL.INDOOR);
			breachEngineering.NorthExit = "EngineeringDeckM34";
			breachEngineering.InExit = "BreachCommand";
			breachEngineering.InName = "Up";
			AddRoom(breachEngineering);

			// Command Deck Corridors
			var CommandDeckM24:Room = new Room();
			CommandDeckM24.RoomIndex = "CommandDeckM24";
			CommandDeckM24.RoomName = "Command Deck: Corridor";
			CommandDeckM24.ShortName = "Cmd.Dk Crrdr"
			CommandDeckM24.EntryFunction = ContentIndex.theConstellation.commandDeckCorridorGeneralFunction;
			CommandDeckM24.MoveTime = 1;
			CommandDeckM24.AddFlag(GLOBAL.INDOOR);
			CommandDeckM24.NorthExit = "CommandDeckM23";
			CommandDeckM24.SouthExit = "BreachCommand";
			AddRoom(CommandDeckM24);

			var EngineeringDeckM34:Room = new Room();
			EngineeringDeckM34.RoomIndex = "EngineeringDeckM34";
			EngineeringDeckM34.RoomName = "Engineering Deck: Corridor";
			EngineeringDeckM34.ShortName = "Eng.Dk Crrdr";
			EngineeringDeckM34.EntryFunction = ContentIndex.theConstellation.engineeringDeckCorridorGeneralFunction;
			EngineeringDeckM34.MoveTime = 1;
			EngineeringDeckM34.AddFlag(GLOBAL.INDOOR);
			EngineeringDeckM34.NorthExit = "EngineeringDeckM33";
			EngineeringDeckM34.SouthExit = "BreachEngineering";
			AddRoom(EngineeringDeckM34);

			var CommandDeckM23:Room = new Room();
			CommandDeckM23.RoomIndex = "CommandDeckM23";
			CommandDeckM23.RoomName = "Command Deck: Corridor";
			CommandDeckM23.ShortName = "Cmd.Dk Crrdr"
			CommandDeckM23.EntryFunction = ContentIndex.theConstellation.commandDeckCorridorGeneralFunction;
			CommandDeckM23.MoveTime = 1;
			CommandDeckM23.AddFlag(GLOBAL.INDOOR);
			CommandDeckM23.NorthExit = "CommandDeckM22";
			CommandDeckM23.EastExit = "CommandDeckN23";
			CommandDeckM23.SouthExit = "CommandDeckM24";
			CommandDeckM23.WestExit = "CommandDeckL23";
			AddRoom(CommandDeckM23);

			var EngineeringDeckM33:Room = new Room();
			EngineeringDeckM33.RoomIndex = "EngineeringDeckM33";
			EngineeringDeckM33.RoomName = "Engineering Deck: Corridor";
			EngineeringDeckM33.ShortName = "Eng.Dk Crrdr";
			EngineeringDeckM33.EntryFunction = ContentIndex.theConstellation.engineeringDeckCorridorGeneralFunction;
			EngineeringDeckM33.MoveTime = 1;
			EngineeringDeckM33.AddFlag(GLOBAL.INDOOR);
			EngineeringDeckM33.NorthExit = "EngineeringDeckM32";
			EngineeringDeckM33.EastExit = "EngineeringDeckN33";
			EngineeringDeckM33.SouthExit = "EngineeringDeckM34";
			EngineeringDeckM33.WestExit = "EngineeringDeckL33";
			AddRoom(EngineeringDeckM33);

			var CommandDeckM22:Room = new Room();
			CommandDeckM22.RoomIndex = "CommandDeckM22";
			CommandDeckM22.RoomName = "Command Deck: Corridor";
			CommandDeckM22.ShortName = "Cmd.Dk Crrdr"
			CommandDeckM22.EntryFunction = ContentIndex.theConstellation.commandDeckCorridorGeneralFunction;
			CommandDeckM22.MoveTime = 1;
			CommandDeckM22.AddFlag(GLOBAL.INDOOR);
			CommandDeckM22.NorthExit = "CommandDeckM21";
			CommandDeckM22.SouthExit = "CommandDeckM23";
			AddRoom(CommandDeckM22);

			var EngineeringDeckM32:Room = new Room();
			EngineeringDeckM32.RoomIndex = "EngineeringDeckM32";
			EngineeringDeckM32.RoomName = "Engineering Deck: Corridor";
			EngineeringDeckM32.ShortName = "Eng.Dk Crrdr";
			EngineeringDeckM32.EntryFunction = ContentIndex.theConstellation.engineeringDeckCorridorGeneralFunction;
			EngineeringDeckM32.MoveTime = 1;
			EngineeringDeckM32.AddFlag(GLOBAL.INDOOR);
			EngineeringDeckM32.NorthExit = "EngineeringDeckM31";
			EngineeringDeckM32.SouthExit = "EngineeringDeckM33";
			AddRoom(EngineeringDeckM32);

			var CommandDeckM21:Room = new Room();
			CommandDeckM21.RoomIndex = "CommandDeckM21";
			CommandDeckM21.RoomName = "Command Deck: Corridor";
			CommandDeckM21.ShortName = "Cmd.Dk Crrdr"
			CommandDeckM21.EntryFunction = ContentIndex.theConstellation.commandDeckCorridorGeneralFunction;
			CommandDeckM21.MoveTime = 1;
			CommandDeckM21.AddFlag(GLOBAL.INDOOR);
			CommandDeckM21.NorthExit = "CommandDeckM20";
			CommandDeckM21.SouthExit = "CommandDeckM22";
			AddRoom(CommandDeckM21);

			var EngineeringDeckM31:Room = new Room();
			EngineeringDeckM31.RoomIndex = "EngineeringDeckM31";
			EngineeringDeckM31.RoomName = "Engineering Deck: Corridor";
			EngineeringDeckM31.ShortName = "Eng.Dk Crrdr";
			EngineeringDeckM31.EntryFunction = ContentIndex.theConstellation.engineeringDeckCorridorGeneralFunction;
			EngineeringDeckM31.MoveTime = 1;
			EngineeringDeckM31.AddFlag(GLOBAL.INDOOR);
			EngineeringDeckM31.NorthExit = "EngineeringDeckM30";
			EngineeringDeckM31.SouthExit = "EngineeringDeckM32";
			AddRoom(EngineeringDeckM31);

			var CommandDeckM20:Room = new Room();
			CommandDeckM20.RoomIndex = "CommandDeckM20";
			CommandDeckM20.RoomName = "Command Deck: Corridor";
			CommandDeckM20.ShortName = "Cmd.Dk Crrdr"
			CommandDeckM20.EntryFunction = ContentIndex.theConstellation.commandDeckCorridorGeneralFunction;
			CommandDeckM20.MoveTime = 1;
			CommandDeckM20.AddFlag(GLOBAL.INDOOR);
			CommandDeckM20.NorthExit = "CommandDeckM19";
			CommandDeckM20.EastExit = "CommandDeckN20";
			CommandDeckM20.SouthExit = "CommandDeckM21";
			CommandDeckM20.WestExit = "CommandDeckL20";
			AddRoom(CommandDeckM20);

			var EngineeringDeckM30:Room = new Room();
			EngineeringDeckM30.RoomIndex = "EngineeringDeckM30";
			EngineeringDeckM30.RoomName = "Engineering Deck: Corridor";
			EngineeringDeckM30.ShortName = "Eng.Dk Crrdr";
			EngineeringDeckM30.EntryFunction = ContentIndex.theConstellation.engineeringDeckCorridorGeneralFunction;
			EngineeringDeckM30.MoveTime = 1;
			EngineeringDeckM30.AddFlag(GLOBAL.INDOOR);
			EngineeringDeckM30.NorthExit = "EngineeringDeckM29";
			EngineeringDeckM30.EastExit = "EngineeringDeckN30";
			EngineeringDeckM30.SouthExit = "EngineeringDeckM31";
			EngineeringDeckM30.WestExit = "EngineeringDeckL30";
			AddRoom(EngineeringDeckM30);

			var CommandDeckM19:Room = new Room();
			CommandDeckM19.RoomIndex = "CommandDeckM19";
			CommandDeckM19.RoomName = "Command Deck: Corridor";
			CommandDeckM19.ShortName = "Cmd.Dk Crrdr"
			CommandDeckM19.EntryFunction = ContentIndex.theConstellation.commandDeckCorridorGeneralFunction;
			CommandDeckM19.MoveTime = 1;
			CommandDeckM19.AddFlag(GLOBAL.INDOOR);
			CommandDeckM19.NorthExit = "CommandDeckBridge";
			CommandDeckM19.SouthExit = "CommandDeckM20";
			AddRoom(CommandDeckM19);

			var EngineeringDeckM29:Room = new Room();
			EngineeringDeckM29.RoomIndex = "EngineeringDeckM29";
			EngineeringDeckM29.RoomName = "Engineering Deck: Corridor";
			EngineeringDeckM29.ShortName = "Eng.Dk Crrdr";
			EngineeringDeckM29.EntryFunction = ContentIndex.theConstellation.engineeringDeckCorridorGeneralFunction;
			EngineeringDeckM29.MoveTime = 1;
			EngineeringDeckM29.AddFlag(GLOBAL.INDOOR);
			EngineeringDeckM29.NorthExit = "EngineeringDeckForwardBattery";
			EngineeringDeckM29.SouthExit = "EngineeringDeckM30";
			AddRoom(EngineeringDeckM29);

			var CommandDeckL23:Room = new Room();
			CommandDeckL23.RoomIndex = "CommandDeckL23";
			CommandDeckL23.RoomName = "Command Deck: Corridor";
			CommandDeckL23.ShortName = "Cmd.Dk Crrdr"
			CommandDeckL23.EntryFunction = ContentIndex.theConstellation.commandDeckCorridorToOfficersQuartersFunction;
			CommandDeckL23.MoveTime = 1;
			CommandDeckL23.AddFlag(GLOBAL.INDOOR);
			CommandDeckL23.EastExit = "CommandDeckM23";
			CommandDeckL23.WestExit = "OfficersQuarters";
			CommandDeckL23.WestCondition = function():Boolean {
				if (GameState.flags["CONSTELLATION_OFFICERS_QUARTERS_UNLOCKED"] == 1) return true;
				return false;
			}
			AddRoom(CommandDeckL23);

			var EngineeringDeckL33:Room = new Room();
			EngineeringDeckL33.RoomIndex = "EngineeringDeckL33";
			EngineeringDeckL33.RoomName = "Engineering Deck: Corridor";
			EngineeringDeckL33.ShortName = "Eng.Dk Crrdr";
			EngineeringDeckL33.EntryFunction = ContentIndex.theConstellation.engineeringDeckCorridorGeneralFunction;
			EngineeringDeckL33.MoveTime = 1;
			EngineeringDeckL33.AddFlag(GLOBAL.INDOOR);
			EngineeringDeckL33.EastExit = "EngineeringDeckM33";
			EngineeringDeckL33.WestExit = "PortCargo";
			AddRoom(EngineeringDeckL33);

			var CommandDeckN23:Room = new Room();
			CommandDeckN23.RoomIndex = "CommandDeckN23";
			CommandDeckN23.RoomName = "Command Deck: Corridor";
			CommandDeckN23.ShortName = "Cmd.Dk Crrdr"
			CommandDeckN23.EntryFunction = ContentIndex.theConstellation.commandDeckCorridorN23Function;
			CommandDeckN23.MoveTime = 1;
			CommandDeckN23.AddFlag(GLOBAL.INDOOR);
			CommandDeckN23.WestExit = "CommandDeckM23";
			AddRoom(CommandDeckN23);

			var EngineeringDeckN33:Room = new Room();
			EngineeringDeckN33.RoomIndex = "EngineeringDeckN33";
			EngineeringDeckN33.RoomName = "Engineering Deck: Corridor";
			EngineeringDeckN33.ShortName = "Eng.Dk Crrdr";
			EngineeringDeckN33.EntryFunction = ContentIndex.theConstellation.engineeringDeckCorridorGeneralFunction;
			EngineeringDeckN33.MoveTime = 1;
			EngineeringDeckN33.AddFlag(GLOBAL.INDOOR);
			EngineeringDeckN33.WestExit = "EngineeringDeckM33";
			EngineeringDeckN33.EastExit = "DroneControl";
			AddRoom(EngineeringDeckN33);

			var CommandDeckL20:Room = new Room();
			CommandDeckL20.RoomIndex = "CommandDeckL20";
			CommandDeckL20.RoomName = "Command Deck: Corridor";
			CommandDeckL20.ShortName = "Cmd.Dk Crrdr"
			CommandDeckL20.EntryFunction = ContentIndex.theConstellation.commandDeckCorridorGeneralFunction;
			CommandDeckL20.MoveTime = 1;
			CommandDeckL20.AddFlag(GLOBAL.INDOOR);
			CommandDeckL20.EastExit = "CommandDeckM20";
			CommandDeckL20.WestExit = "CommandDeckShieldControl";
			AddRoom(CommandDeckL20);

			var EngineeringDeckL30:Room = new Room();
			EngineeringDeckL30.RoomIndex = "EngineeringDeckL30";
			EngineeringDeckL30.RoomName = "Engineering Deck: Corridor";
			EngineeringDeckL30.ShortName = "Eng.Dk Crrdr";
			EngineeringDeckL30.EntryFunction = ContentIndex.theConstellation.engineeringDeckCorridorGeneralFunction;
			EngineeringDeckL30.MoveTime = 1;
			EngineeringDeckL30.AddFlag(GLOBAL.INDOOR);
			EngineeringDeckL30.EastExit = "EngineeringDeckM30";
			EngineeringDeckL30.WestExit = "EngineeringDeckShieldControl"
			AddRoom(EngineeringDeckL30);

			var CommandDeckN20:Room = new Room();
			CommandDeckN20.RoomIndex = "CommandDeckN20";
			CommandDeckN20.RoomName = "Command Deck: Corridor";
			CommandDeckN20.ShortName = "Cmd.Dk Crrdr"
			CommandDeckN20.EntryFunction = ContentIndex.theConstellation.commandDeckCorridorGeneralFunction;
			CommandDeckN20.MoveTime = 1;
			CommandDeckN20.AddFlag(GLOBAL.INDOOR);
			CommandDeckN20.EastExit = "StarboardCargo";
			CommandDeckN20.WestExit = "CommandDeckM20";
			AddRoom(CommandDeckN20);

			var EngineeringDeckN30:Room = new Room();
			EngineeringDeckN30.RoomIndex = "EngineeringDeckN30";
			EngineeringDeckN30.RoomName = "Engineering Deck: Corridor";
			EngineeringDeckN30.ShortName = "Eng.Dk Crrdr";
			EngineeringDeckN30.EntryFunction = ContentIndex.theConstellation.engineeringDeckCorridorGeneralFunction;
			EngineeringDeckN30.MoveTime = 1;
			EngineeringDeckN30.AddFlag(GLOBAL.INDOOR);
			EngineeringDeckN30.EastExit = "EngineeringDeckAtmosphericControl";
			EngineeringDeckN30.WestExit = "EngineeringDeckM30";
			AddRoom(EngineeringDeckN30);

			// Command Deck Special Rooms
			var OfficersQuarters:Room = new Room();
			OfficersQuarters.RoomIndex = "OfficersQuarters";
			OfficersQuarters.RoomName = "Command Deck: OfficersQuarters";
			OfficersQuarters.ShortName = "Cmd.Dk Off.Q";
			OfficersQuarters.EntryFunction = ContentIndex.theConstellation.commandDeckOfficersQuartersFunction;
			OfficersQuarters.MoveTime = 1;
			OfficersQuarters.AddFlag(GLOBAL.INDOOR);
			OfficersQuarters.EastExit = "CommandDeckL23";
			AddRoom(OfficersQuarters);

			var CommandDeckShieldControl:Room = new Room();
			CommandDeckShieldControl.RoomIndex = "CommandDeckShieldControl";
			CommandDeckShieldControl.RoomName = "Command Deck: Shield Control";
			CommandDeckShieldControl.ShortName = "Cmd. Dk Shield";
			CommandDeckShieldControl.EntryFunction = ContentIndex.theConstellation.commandDeckShieldControlFunction;
			CommandDeckShieldControl.MoveTime = 1;
			CommandDeckShieldControl.AddFlag(GLOBAL.INDOOR);
			CommandDeckShieldControl.EastExit = "CommandDeckL20";
			AddRoom(CommandDeckShieldControl);

			var StarboardCargo:Room = new Room();
			StarboardCargo.RoomIndex = "StarboardCargo";
			StarboardCargo.RoomName = "Command Deck: Starboard Cargo";
			StarboardCargo.ShortName = "Cmd.Dk Cargo";
			StarboardCargo.EntryFunction = ContentIndex.theConstellation.commandDeckStarboardCargoFunction;
			StarboardCargo.MoveTime = 1;
			StarboardCargo.AddFlag(GLOBAL.INDOOR);
			StarboardCargo.WestExit = "CommandDeckN20";
			AddRoom(StarboardCargo);

			var Bridge:Room = new Room();
			Bridge.RoomIndex = "CommandDeckBridge";
			Bridge.RoomName = "Command Deck: Bridge";
			Bridge.ShortName = "Cmd.Dk Bridge";
			Bridge.EntryFunction = ContentIndex.theConstellation.commandDeckBridgeFunction;
			Bridge.MoveTime = 1;
			Bridge.AddFlag(GLOBAL.INDOOR);
			Bridge.SouthExit = "CommandDeckM19";
			AddRoom(Bridge);

			// Engineering Deck Special Rooms
			var PortCargo:Room = new Room();
			PortCargo.RoomIndex = "PortCargo";
			PortCargo.RoomName = "Engineering Deck: Port Cargo";
			PortCargo.ShortName = "Eng. Dk Cargo";
			PortCargo.EntryFunction = ContentIndex.theConstellation.engineeringDeckPortCargoFunction;
			PortCargo.MoveTime = 1;
			PortCargo.AddFlag(GLOBAL.INDOOR);
			PortCargo.EastExit = "EngineeringDeckL33";
			AddRoom(PortCargo);

			var DroneControl:Room = new Room();
			DroneControl.RoomIndex = "DroneControl";
			DroneControl.RoomName = "Engineering Deck: Drone Control";
			DroneControl.ShortName = "Eng.Dk Drone";
			DroneControl.EntryFunction = ContentIndex.theConstellation.engineeringDeckDroneControlFunction;
			DroneControl.MoveTime = 1;
			DroneControl.AddFlag(GLOBAL.INDOOR);
			DroneControl.WestExit = "EngineeringDeckM33";
			AddRoom(DroneControl);

			var EngineeringDeckShieldControl:Room = new Room();
			EngineeringDeckShieldControl.RoomIndex = "EngineeringDeckShieldControl";
			EngineeringDeckShieldControl.RoomName = "Engineering Deck: Shield Control";
			EngineeringDeckShieldControl.ShortName = "Eng.Dk Shield";
			EngineeringDeckShieldControl.EntryFunction = ContentIndex.theConstellation.engineeringDeckShieldControlFunction;
			EngineeringDeckShieldControl.MoveTime = 1;
			EngineeringDeckShieldControl.AddFlag(GLOBAL.INDOOR);
			EngineeringDeckShieldControl.EastExit = "EngineeringDeckL30";
			AddRoom(EngineeringDeckShieldControl);

			var EngineeringDeckAtmos:Room = new Room();
			EngineeringDeckAtmos.RoomIndex = "EngineeringDeckAtmosphericControl";
			EngineeringDeckAtmos.RoomName = "Engineering Deck: Atmospheric Control";
			EngineeringDeckAtmos.ShortName = "Eng.Dk Atmos";
			EngineeringDeckAtmos.EntryFunction = ContentIndex.theConstellation.engineeringDeckAtmosFunction;
			EngineeringDeckAtmos.MoveTime = 1;
			EngineeringDeckAtmos.AddFlag(GLOBAL.INDOOR);
			EngineeringDeckAtmos.WestExit = "EngineeringDeckN30";
			AddRoom(EngineeringDeckAtmos);

			var EngineeringDeckBattery:Room = new Room();
			EngineeringDeckBattery.RoomIndex = "EngineeringDeckForwardBattery";
			EngineeringDeckBattery.RoomName = "Engineering Deck: Forward Battery";
			EngineeringDeckBattery.ShortName = "Eng.Dk Battery";
			EngineeringDeckBattery.EntryFunction = ContentIndex.theConstellation.engineeringDeckForwardBatteryFunction;
			EngineeringDeckBattery.MoveTime = 1;
			EngineeringDeckBattery.AddFlag(GLOBAL.INDOOR);
			EngineeringDeckBattery.SouthExit = "EngineeringDeckM29";
			AddRoom(EngineeringDeckBattery);

		}
		
	}

}