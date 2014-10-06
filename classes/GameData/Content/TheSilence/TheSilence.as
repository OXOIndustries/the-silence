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
			
			if (flags["DOCKED_WITH_CONSTELLATION"] == 1)
			{
				clearOutput();
				flags["DOCKED_WITH_CONSTELLATION"] = 2;
				
				output("As you approach the airlock, you feel the deck rumble slightly under your feet. Logan's voice comes over the P.A., <i>“We're as docked as we're getting. Grappling lines are down. Should be just a short hop through zero-G and into the belly of the beast.”</i>");

				output("\n\nThe inner door <i>whooshes</i> open as Logan speaks, and you step into where your two fellow boarders have gathered. Both are wearing space suits: Pyra's is much too big for her diminutive raskvel frame; Tarik's is monstrously deformed by his serpent lower body and bulging, muscular upper half, straining to accommodate the massive naleen. ");

				output("\n\n<i>“We go to fight a beast, now?”</i> Tarik says, the excitement evident in his voice. He hefts his greataxe, grinning.");

				doTalkTree(initialDockingWithConstellation);

				return true;
			}
			
			return false;
		}

		private function initialDockingWithConstellation(choice:String):void
		{
			clearOutput();
			if (choice == "kind")
			{
				output("<i>“No, Tarik,”</i> you say, reaching up to pat his tremendous shoulder. <i>“Calm down.”</i>");
			}
			else if (choice == "misc")
			{
				output("<i>“It’s a figure of speech, nip-for-brains,”</i> you say, rolling your eyes.");
			}
			else if (choice == "hard")
			{
				output("<i>“No, dumbass. It's an expression.”");
			}

			output("\n\n<i>“Ah,”</i> he grunts, coiling down on his tail. <i>“Very well, then.”</i>");

			output("\n\nPyra saunters up, having to waddle thanks to her awkward space suit and the massive tank of flammable... whatever it is she's got slung on her back. <i>“Just lemme go first, captain. I bet I can get atmosphere back, maybe bring the shields online again. Then we can get out of these stupid suits.”</i>");

			output("<i>“Agreed.”</i> You grab your space suit from the rack and pull it on over your clothes. Tarik hands you your gunbelt and force sword once you're squared away, and you're good to go.");

				PlayerParty.addToParty(pyra);
				PlayerParty.addToParty(tarik)

			// {Next} Add [Cycle Airlock] button.
			clearMenu();
			doNext(cycleAirlock);
		}

		private function cycleAirlock():void
		{
			clearOutput();
			output("Once you’re certain everyone’s helmets are secure, you punch the airlock and cycle through. A second of hard vacuum greets you, straining the magnets on your boots, trying to suck you into the black from whence you’ll never come back. The suction stops after a moment, leaving you standing in an utter void of... anything. No air, no sound, nothing. Just the drifting debris outside the airlock separating you from the Nova hulk, a straight shot down by less than a kilometer. Three grappling lines connect the deck below you to the tremendous hole punched through the other ship, acting as your safest way in.");
			
			output("\n\nYou take a deep breath and step forward, latching onto the wire and launching off. The thrusters on your suit go to work at the twitch of a finger, lighting your suit’s HUD up with trajectories and danger warnings as you slip into the debris field. Behind you, Tarik and Pyra follow you in, deviating only to avoid bits of deadly junk floating by -- each piece fast enough to slice you clear in half, or crush you into a mangle of broken limbs of blood. You zip up, tumbling over a chunk of hull plating bearing the ship’s name, shredded by shrapnel: <i>Constellation</i>, in huge red letters. The thrusters correct your course, back onto the grappling line. You grip on and hurtle the rest of the way into the hole. ");
			
			output("\n\nYour thrusters bring you to a stop a few feet from the top deck of the ship, letting you drag along the grappling line to decelerate. Still, you all but slam into the ruined deck, tumbling into the cavernous impact hole and onto your feet next to a shredded emergency bulkhead. You draw your plasma caster and wait the few seconds for your crew to arrive, not much more gracefully than you did. Tarik crashes into the bulkhead at nearly full force;, ten feet of kitty-naga spread eagle out across the deck as he peels himself off and staggers back.");
			
			output("\n\n<i>“These thrusters-”</i> he starts, cut off by Pyra.");
			
			output("\n\n<i>“You need twice as many for twice as much fat cat. Gotta get you a new space suit, catnip.”</i>");
			
			output("\n\nHe nods, rubbing at his head through the glass of his helmet.");
			
			output("\n\n<i>“Alright. Tarik, get the door open for us.”</i>");
			
			output("\n\nThe naleen nods and slithers over to the bulkhead, hefts his axe from over his shoulder, and gets chopping. Three good hews tear a chunk out of it, a triangle on the deck large enough for any of you to slip through. You give the hulking cat a wink and slip through after his last strike, somersaulting through the gap and onto the deck of the <i>Constellation</i>.");

			pc.currentLocation = "TheConstellation.BreachCommand";
			clearMenu();
			doNext(mainGameMenu);
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
			
			if (flags["CAPTAIN_TO_THE_BRIDGE"] == undefined && logan.currentLocation == "TheSilence.Bridge")
			{
				addButton(0, "Logan", ContentIndex.chapter3.captainToTheBridge, undefined, "Approach Logan", "Find out what Logan wants.");
			}
			
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