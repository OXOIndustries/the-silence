package classes.GameData.Map.Data.Ships 
{
	import classes.GameData.Map.Room;
	import classes.GameData.Map.Ship;
	import classes.GameData.ContentIndex;
	import classes.GLOBAL;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class TheSilenceInterior extends Ship
	{
		public function TheSilenceInterior() 
		{
			LocationIndex = "TheSilence";
			LocationName = "SILENCE";
			
			// CREW DECK
			var airlock:Room = new Room();
			airlock.RoomIndex = "Airlock";
			airlock.RoomName = "AIRLOCK";
			airlock.ShortName = "Silence A.Lk";
			airlock.EntryFunction = ContentIndex.theSilence.airlockRoomFunction;
			airlock.MoveTime = 1;
			airlock.AddFlag(GLOBAL.AIRLOCK);
			airlock.AddFlag(GLOBAL.INDOOR);
			airlock.NorthExit = "CrewDeckK21";
			AddRoom(airlock);
			
			var crewDeckK21:Room = new Room();
			crewDeckK21.RoomIndex = "CrewDeckK21";
			crewDeckK21.RoomName = "CREW DECK CORRIDOR";
			crewDeckK21.EntryFunction = ContentIndex.theSilence.crewDeckK21RoomFunction;
			crewDeckK21.MoveTime = 1;
			crewDeckK21.AddFlag(GLOBAL.INDOOR);
			crewDeckK21.SouthExit = "Airlock";
			crewDeckK21.EastExit = "CrewDeckL21";
			AddRoom(crewDeckK21);
			
			var crewDeckL21:Room = new Room();
			crewDeckL21.RoomIndex = "CrewDeckL21";
			crewDeckL21.RoomName = "CREW DECK CORRIDOR";
			crewDeckL21.EntryFunction = ContentIndex.theSilence.crewDeckL21RoomFunction;
			crewDeckL21.MoveTime = 1;
			crewDeckL21.NorthExit = "CrewL20";
			crewDeckL21.NorthCondition = function():Boolean { return false; }
			crewDeckL21.EastExit = "CrewDeckM21";
			crewDeckL21.SouthExit = "CrewL22";
			crewDeckL21.SouthCondition = function():Boolean { return false; }
			crewDeckL21.WestExit = "CrewDeckK21";
			crewDeckL21.AddFlag(GLOBAL.INDOOR);
			AddRoom(crewDeckL21);

			var crewL20:Room = new Room();
			crewL20.RoomIndex = "CrewL20";
			crewL20.RoomName = "CREW QUARTERS ???";
			crewL20.EntryFunction = ContentIndex.theSilence.crewL20RoomFunction;
			crewL20.SouthExit = "CrewDeckL21";
			crewL20.AddFlag(GLOBAL.INDOOR);
			AddRoom(crewL20);

			var crewL22:Room = new Room();
			crewL22.RoomIndex = "CrewL22";
			crewL22.RoomName = "CREW QUARTERS ???";
			crewL22.EntryFunction = ContentIndex.theSilence.crewL22RoomFunction;
			crewL22.NorthExit = "CrewDeckL21";
			crewL22.AddFlag(GLOBAL.INDOOR);
			AddRoom(crewL22);

			var crewDeckM21:Room = new Room();
			crewDeckM21.RoomIndex = "CrewDeckM21";
			crewDeckM21.RoomName = "CREW DECK CORRIDOR";
			crewDeckM21.EntryFunction = ContentIndex.theSilence.crewDeckM21RoomFunction;
			crewDeckM21.MoveTime = 1;
			crewDeckM21.NorthExit = "CrewM20";
			crewDeckM21.NorthCondition = function():Boolean { return false; }
			crewDeckM21.EastExit = "CrewDeckN21";
			crewDeckM21.SouthExit = "CrewM22";
			crewDeckM21.SouthCondition = function():Boolean { return false; }
			crewDeckM21.WestExit = "CrewDeckL21";
			crewDeckM21.AddFlag(GLOBAL.INDOOR);
			AddRoom(crewDeckM21);

			var crewM22:Room = new Room();
			crewM22.RoomIndex = "CrewM22";
			crewM22.RoomName = "CREW QUARTERS ???";
			crewM22.EntryFunction = ContentIndex.theSilence.crewM22RoomFunction;
			crewM22.NorthExit = "CrewDeckM21";
			crewM22.AddFlag(GLOBAL.INDOOR);
			AddRoom(crewM22);

			var crewM20:Room = new Room();
			crewM20.RoomIndex = "CrewM20";
			crewM20.RoomName = "CREW QUARTERS ???";
			crewM20.EntryFunction = ContentIndex.theSilence.crewM20RoomFunction;
			crewM20.SouthExit = "CrewDeckM21";
			crewM20.AddFlag(GLOBAL.INDOOR);
			AddRoom(crewM20);

			var crewDeckN21:Room = new Room();
			crewDeckN21.RoomIndex = "CrewDeckN21";
			crewDeckN21.RoomName = "CREW DECK CORRIDOR";
			crewDeckN21.EntryFunction = ContentIndex.theSilence.crewDeckN21RoomFunction;
			crewDeckN21.MoveTime = 1;
			crewDeckN21.EastExit = "ConferenceRoom";
			crewDeckN21.SouthExit = "CrewDeckN22";
			crewDeckN21.WestExit = "CrewDeckM21";
			crewDeckN21.AddFlag(GLOBAL.INDOOR);
			AddRoom(crewDeckN21);

			var crewDeckN22:Room = new Room();
			crewDeckN22.RoomIndex = "CrewDeckN22";
			crewDeckN22.RoomName = "CREW DECK CORRIDOR";
			crewDeckN22.EntryFunction = ContentIndex.theSilence.crewDeckN22RoomFunction;
			crewDeckN22.MoveTime = 1;
			crewDeckN22.NorthExit = "CrewDeckN21";
			crewDeckN22.SouthExit = "CaptainsQuarters";
			crewDeckN22.AddFlag(GLOBAL.INDOOR);
			AddRoom(crewDeckN22);

			var captainsQuarters:Room = new Room();
			captainsQuarters.RoomIndex = "CaptainsQuarters";
			captainsQuarters.RoomName = "CAPTAINS QUARTERS";
			captainsQuarters.EntryFunction = ContentIndex.theSilence.captainsQuartersRoomFunction;
			captainsQuarters.NorthExit = "CrewDeckN22";
			captainsQuarters.AddFlag(GLOBAL.INDOOR);
			AddRoom(captainsQuarters);

			var conferenceRoom:Room = new Room();
			conferenceRoom.RoomIndex = "ConferenceRoom";
			conferenceRoom.RoomName = "CONFERENCE ROOM";
			conferenceRoom.EntryFunction = ContentIndex.theSilence.conferenceRoomFunction;
			conferenceRoom.WestExit = "CrewDeckN21";
			conferenceRoom.EastExit = "CrewDeckElevator";
			conferenceRoom.AddFlag(GLOBAL.INDOOR);
			AddRoom(conferenceRoom);

			var crewDeckElevator:Room = new Room();
			crewDeckElevator.RoomIndex = "CrewDeckElevator";
			crewDeckElevator.RoomName = "ELEVATOR: CREW DECK";
			crewDeckElevator.ShortName = "Crew Deck";
			crewDeckElevator.ElevatorRooms = ["BridgeElevator", "CrewDeckElevator", "EngineeringElevator"];
			crewDeckElevator.EntryFunction = ContentIndex.theSilence.crewDeckElevatorRoomFunction;
			crewDeckElevator.WestExit = "ConferenceRoom";
			crewDeckElevator.AddFlag(GLOBAL.ELEVATOR);
			crewDeckElevator.AddFlag(GLOBAL.INDOOR);
			AddRoom(crewDeckElevator);

			// BRDIGE DECK
			var bridgeElevator:Room = new Room();
			bridgeElevator.RoomIndex = "BridgeElevator";
			bridgeElevator.RoomName = "ELEVATOR: BRIDGE";
			bridgeElevator.ShortName = "Bridge Deck";
			bridgeElevator.ElevatorRooms = ["BridgeElevator", "CrewDeckElevator", "EngineeringElevator"];
			bridgeElevator.WestExit = "Bridge";
			bridgeElevator.EntryFunction = ContentIndex.theSilence.bridgeElevatorRoomFunction;
			bridgeElevator.AddFlag(GLOBAL.ELEVATOR);
			bridgeElevator.AddFlag(GLOBAL.INDOOR);
			AddRoom(bridgeElevator);

			var bridge:Room = new Room();
			bridge.RoomIndex = "Bridge";
			bridge.RoomName = "BRIDGE";
			bridge.EastExit = "BridgeElevator";
			bridge.EntryFunction = ContentIndex.theSilence.bridgeRoomFunction;
			bridge.AddFlag(GLOBAL.INDOOR);
			AddRoom(bridge);

			// Engineering Deck
			var engineeringElevator:Room = new Room();
			engineeringElevator.RoomIndex = "EngineeringElevator";
			engineeringElevator.RoomName = "ELEVATOR: ENGINEERING";
			engineeringElevator.ShortName = "Eng. Deck";
			engineeringElevator.ElevatorRooms = ["BridgeElevator", "CrewDeckElevator", "EngineeringElevator"];
			engineeringElevator.WestExit = "EngineeringDeck1";
			engineeringElevator.EntryFunction = ContentIndex.theSilence.engineeringElevatorRoomFunction;
			engineeringElevator.AddFlag(GLOBAL.INDOOR);
			engineeringElevator.AddFlag(GLOBAL.ELEVATOR);
			AddRoom(engineeringElevator);

			var engineeringDeck1:Room = new Room();
			engineeringDeck1.RoomIndex = "EngineeringDeck1";
			engineeringDeck1.RoomName = "ENGINEERING DECK";
			engineeringDeck1.WestExit = "EngineeringDeck2";
			engineeringDeck1.EastExit = "EngineeringElevator";
			engineeringDeck1.EntryFunction = ContentIndex.theSilence.engineeringDeck1RoomFunction;
			engineeringDeck1.AddFlag(GLOBAL.INDOOR);
			AddRoom(engineeringDeck1);

			var engineeringDeck2:Room = new Room();
			engineeringDeck2.RoomIndex = "EngineeringDeck2";
			engineeringDeck2.RoomName = "ENGINEERING DECK";
			engineeringDeck2.EastExit = "EngineeringDeck1";
			engineeringDeck2.EntryFunction = ContentIndex.theSilence.engineeringDeck2RoomFunction;
			engineeringDeck2.AddFlag(GLOBAL.INDOOR);
			AddRoom(engineeringDeck2);
			
			trace("Created Silence Instance");
		}	
	}
}