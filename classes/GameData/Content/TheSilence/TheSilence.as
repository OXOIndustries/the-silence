package classes.GameData.Content.TheSilence 
{
	import classes.GameData.Content.BaseContent;
	import classes.GameData.ContentIndex;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class TheSilence extends BaseContent
	{
		
		public function TheSilence() 
		{
			
		}
		
		//{ region Room Functions
		
		//{ region Crew Deck
		public function airlockRoomFunction():Boolean
		{
			clearOutput();
			output("This is the <i>Silence’s</i> airlock. Several E.V.A. suits are hooked up onto the bulkhead, as well as a few of the heavier weapons your crew possesses, including Pyra's flamethrower. Everything is, of course, locked down with DNA identification.");
			return false;
		}
		
		public function crewDeckK21RoomFunction():Boolean
		{
			sharedCrewCorridor();
			return false;
		}
		
		public function crewDeckL21RoomFunction():Boolean
		{
			sharedCrewCorridor();
			output("\n\nTo the north is Tarik’s quarters. He never leaves his door closed, giving you an easy view into the feline serpent's bunk. His room is spartan, decorated only by several strange, wavy lines he’s painted on the bulkheads. You assume they have some spiritual significance. There are more empty crew quarters to the south.");
			return false;
		}
		
		public function crewL20RoomFunction():Boolean
		{
			clearOutput();
			output("Tarkis's quarters yo.");
			return false;
		}
		
		public function crewL22RoomFunction():Boolean
		{
			clearOutput();
			output("A spartan bunk-room, outfitted with the very barest of essentials - just enough to qualify the space as something technically inhabitable by an actual living, breathing person. <i>Technically</i> being the operative word.");

			output("\n\nTo one side of the room, there's a bed that you can attest is possibly one of the single most uncomfortable things to actually sleep on that exists in the universe. Directly opposite on the other side of the room, there's a painfully sterile workdesk-come-dresser; cupboards to store clothes and possesions within, but it's all just so... clinical.");
			return false;
		}
		
		public function crewDeckM21RoomFunction():Boolean
		{
			sharedCrewCorridor();
			output("\n\nTo the north is Pyra’s quarters. Even through the hatch, you can smell the musky gunk she loves to cover herself and her quarters with. It doesn’t seem to bother the rest of the crew, but... it makes your nose twitch every time you pass by. There are more empty crew quarters to the south.");
			return false;
		}
		
		public function crewM22RoomFunction():Boolean
		{
			clearOutput();
			output("A spartan bunk-room, outfitted with the very barest of essentials - just enough to qualify the space as something technically inhabitable by an actual living, breathing person. <i>Technically</i> being the operative word.");

			output("\n\nTo one side of the room, there’s a bed that you can attest is possibly one of the single most uncomfortable things to actually sleep on that exists in the universe. Directly opposite on the other side of the room, there’s a painfully sterile workdesk-come-dresser; cupboards to store clothes and possesions within, but it's all just so... clinical.");
			return false;
		}
		
		public function crewM20RoomFunction():Boolean
		{
			clearOutput();
			output("Pyra's room yo.");
			return false;
		}
		
		public function crewDeckN21RoomFunction():Boolean
		{
			sharedCrewCorridor();
			return false;
		}
		
		public function crewDeckN22RoomFunction():Boolean
		{
			clearOutput();
			output("The corridor between your quarters and the conference room and galley is long, well-cleaned (thanks to your maidbots), and fairly generic. A few readouts are mounted on the wall, which let you see the ship's status at a glance.");
			return false;
		}
		
		public function captainsQuartersRoomFunction():Boolean
		{
			clearOutput();
			output("Your room aboard the Silence. Her previous captain outfitted his quarters like a penthouse, complete with a huge bed, tacky fish tanks, and ugly but expensive art pieces from famous Terran and Ausaril masters. You've customized it somewhat since then, though you hate to change too much. A few kaithrit spirit-tokens, a handful of heavy metal and gaming posters, and your old collar all decorate the walls. Your nightstands are covered with needles, pill bottles, and half-empty bottles of vodka. So it's a rockstar's penthouse, basically.");
			return false;
		}
		
		public function conferenceRoomFunction():Boolean
		{
			clearOutput();
			output("The ‘conference room’ is what you and the crew call the combination mess/galley/rec room at the fore of the ship, just behind the elevator. It's the largest room on this deck, dominated by a long dining table that runs its length. A couch, holoscreen TV, and several entertainment devices are set up along the southern wall, opposite the tiny kitchen setup.");
			
			if (flags["CREW_BRIEFED"] == undefined)
			{
				output("\n\nThe crew’s gathered here as ordered. Pyra, the tiny red ball of energy that is your chief engineer, is making herself a bowl of cereal. A huge, furred creature with the lower body of a snake - Tarik - is yawning and rubbing his eyes.");
				
				addButton(0, "Mission Brief", ContentIndex.chapter2.missionBrief, undefined, "Mission Briefing", "Brief the crew on the upcoming mission");
			}
			
			if (flags["CONFROOM_FIRST_ENTRY"] == undefined)
			{
				flags["CONFROOM_FIRST_ENTRY"] = 1;
				output("\n\n<i>“Looks like everyone’s here, Captain,”</i> Logan says, flopping down on the couch.");
				PlayerParty.removeFromParty(logan);
				logan.currentLocation = "TheSilence.ConferenceRoom";
			}
			
			return false;
		}
		
		public function crewDeckElevatorRoomFunction():Boolean
		{
			clearOutput();
			output("This elevator connects the Silence's three decks: the Bridge, the Crew Deck, and Engineering. You're currently on the Crew Deck.");
			return false;
		}
		//} end region
		
		//{ region Bridge Deck
		public function bridgeElevatorRoomFunction():Boolean
		{
			clearOutput();
			output("This elevator connects the Silence's three decks: the Bridge, the Crew Deck, and Engineering. You're currently on the Bridge.");
			return false;
		}
		
		public function bridgeRoomFunction():Boolean
		{
			clearOutput();
			output("The Silence’s bridge isn’t too far removed from a warship’s: pristine, white, glowing with readouts, V.I. holograms, and several projected star maps and status displays. A forward view screen sits over the pilot's console, which has been pulled adjacent to the Navigation station, allowing for (assisted) one-man flight. Weapons consoles flank the bridge, and a tactical map dominates the center, completely with active sensor projections and positioning data for the surrounding several thousand kilometers of space.");
			
			if (logan.currentLocation == "TheSilence.Bridge" && inSpaceCombat == false)
			{
				output("\n\nLogan's sitting at the pilot's console, feeding nav data from the console into the auto-pilot programs. Her job will come later, when Nova gets on your tail. <i>“Everything’s solid up here, Captain,”</i> she says, tone formal now that she’s on duty.");
			}
			
			if (logan.currentLocation == "TheSilence.Bridge" && inSpaceCombat == true)
			{
				output("\n\nLogan’s furiously typing with one hand, steering with the other, desperately trying to wrangle an advantage for the crew against the overwhelming assault of the <i>Black Rose</i>.");
			}
			return false;
		}
		//} end region
		
		//{ region Engineering Deck
		public function engineeringElevatorRoomFunction():Boolean
		{
			clearOutput();
			output("This elevator connects the Silence's three decks: the Bridge, the Crew Deck, and Engineering. You're currently on the Engineering Deck.");
			return false;
		}
		
		public function engineeringDeck1RoomFunction():Boolean
		{
			clearOutput();
			output("The Silence's Engineering deck runs most of the length of the ship -- for good reason. When Blackstar designed her, he insisted on several extra power generators, converters, and secondary engine controls. Thanks to this, the Silence is incredibly fast, and she's shielded harder than just about any ship in her size category.");
			return false;
		}
		
		public function engineeringDeck2RoomFunction():Boolean
		{
			clearOutput();
			output("The Silence's Engineering deck runs most of the length of the ship - for good reason. When Blackstar designed her, he insisted on several extra power generators, converters, and secondary engine controls. Thanks to this, the Silence is incredibly fast, and she's shielded harder than just about any ship in her size category. ");
			output("\n\nThe main engine is here, thrumming powerfully. Several holo-readouts display its status, and show detailed power maps for shields, weapons, life support, and other vital systems.");
			return false;
		}
		//} end region
		
		//{ region Shared Room Functions
		public function sharedCrewCorridor():void
		{
			clearOutput();
			output("The main corridor running through the Silence, connecting it from the rear airlock to the conference room and the elevator at the fore. The corridor's wide enough that two people can walk abreast, and is definitely the cleanest part of the ship: the steel bulkheads shine in the light thanks to the tireless efforts of the maidbots.");
		}
		//} end region
		
		//} end region
	}

}