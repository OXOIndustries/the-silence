package classes.GameData.Content.TheSilence 
{
	import classes.GameData.Content.BaseContent;
	import classes.GameData.ContentIndex;
	import classes.GameData.CombatManager;
	import classes.GameData.MapIndex;
	
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
			
			if (theSilence.connectedShipObject() == theBlackRose)
			{
				output("There’s not much of your airlock hatch left. It’s been torn to shreds in the impact, riddled with holes and floating debris in the low-grav gap between the ships. Where the hatch should be, there’s now a great big slab of black that’s been lasered open, creating a passage into the enemy ship. You steel yourself before preparing to step over the threshold...");

				clearMenu();
				addButton(0, "Enter Breach", MapIndex.Move, theSilence.airlockConnectsTo);
				return true;
			}
			
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

			output("\n\n<i>“Agreed.”</i> You grab your space suit from the rack and pull it on over your clothes. Tarik hands you your gunbelt and force sword once you're squared away, and you're good to go.");

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
			
			if (logan.currentLocation == "TheSilence.Bridge" && flags["DEFEATED_PIRATES_AT_BREACH"] == undefined)
			{
				output("\n\nLogan's sitting at the pilot's console, feeding nav data from the console into the auto-pilot programs. Her job will come later, when Nova gets on your tail. <i>“Everything’s solid up here, Captain,”</i> she says, tone formal now that she’s on duty.");
			}
			
			if (logan.currentLocation == "TheSilence.Bridge" && flags["DEFEATED_PIRATES_AT_BREACH"] == 1 && flags["DEFEATED_MIRI_SPESSCOMBAT"] == undefined)
			{
				if (flags["INITIAL_RETURN_DURING_SPESS_COMBAT"] == undefined)
				{
					ohShitMiriGonnaFuckYouUp();
					return true;
				}
				else
				{
					output("\n\nLogan’s furiously typing with one hand, steering with the other, desperately trying to wrangle an advantage for the crew against the overwhelming assault of the <i>Black Rose</i>.");

					addButton(0, "Fight!", startSpessFightAgainstMiri);
				}
			}
			return false;
		}

		private function startSpessFightAgainstMiri():void
		{
			CombatManager.newSpaceCombat(); // Setup for a new combat phase.
			theSilence.initCombat();
			CombatManager.setPlayers(theSilence); // Set the "friendly" players that will be fighting - could be a single char, or the party reference
			theBlackRose.initCombat();
			// TODO: Hook the bonuses into state from the Constellation into Black Rose here.
			CombatManager.setEnemies(theBlackRose); // Set the "hostile" characters that will be fighting - could be a single char, or the party reference
			CombatManager.victoryCondition(CombatManager.ENTIRE_PARTY_DEFEATED); // Set the victory condition and optional argument
			CombatManager.victoryScene(waitWhatHowFuckYouCheater); // The function reference that will be called when the player achieves the victory condition
			CombatManager.lossCondition(CombatManager.ENTIRE_PARTY_DEFEATED);
			CombatManager.lossScene(rammingSpeedLogan); // The function reference that will be called if the player is defeated
			CombatManager.entryScene(startSpessFightAgainstMiri);
			CombatManager.beginCombat();
		}

		private function waitWhatHowFuckYouCheater():void
		{
			clearOutput();
			output("Kay, I guess you done cheated gud n stuff. Black Rose is intended to be undefeatable...");
		}

		private function rammingSpeedLogan():void
		{			
			clearOutput();
			output("<i>“She can’t take much more, captain!”</i> Logan shouts over the din of emergency klaxons and overloading equipment. Even the emergency shields are buckling, straining to keep the Silence from tearing itself apart. ");
			
			output("\n\n<i>“Tell me we’re ready to jump, Logan,”</i> you shout back. Her answer is drowned out as a rocket slams into the Silence, throwing you out of the captain’s chair. You tumble across the deck, slamming into a bulkhead. Your head cracks hard against steel. Pain shoots through you and your world spins, hazing your vision. You can still see the flashes of light through the forward screen, laser fire coming in and going out. The ship shudders and lurches under you under the hail of fire, rattling you to your bones. ");
			
			output("\n\nIs this it? The end? You groan in pain, trying to stand. <i>“Logan, talk to me!”</i>");
			
			output("\n\n<i>“They fucked our engines, Kara,”</i> she grunts, grabbing your hand and pulling you up. You lean hard against the nav console, staring at the red readouts, showing just about every system in critical condition. <i>“There’s no way we’re jumping, babe. We’re dead in the water.”</i> ");
			
			output("\n\nShit. You look between Logan, the rest of the crew, and the massive frigate bearing down on you.");

			doTalkTree(rammingSpeedLoganII);
		}

		private function rammingSpeedLoganII(choice:String):void
		{
			clearOutput();
			if (choice == "kind")
			{
				output("<i>“Keep it... keep it together, Logan,”</i> you say through gritted teeth. <i>“We’re going to get out of here.”</i>");
			}
			else if (choice == "misc")
			{
				output("<i>“Don’t worry, Logan, I’ve got this,”</i> you tell her. Only half lying.");
			}
			else if (choice == "hard")
			{
				output("<i>“Just keep to your post, Logan,”</i> you growl. <i>“I’ll get us through this.”</i>");
			}

			output("\n\nYou say that, but... shit, not a lot of options left. You’ve got nothing firing left but the point lasers, barely enough to knock a torpedo down, much less punch through a frigate’s shields. No possibility for escape... no way to take the bitch down.... There goes the classic fight or flight instinct. What else can you do but just sit down and die? ");
			
			output("\n\nMight as well go down with one great big <i>“fuck you.”</i>");

			clearMenu();
			addButton(0, "Ramming Speed", rammingSpeedLoganIII);
		}

		private function rammingSpeedLoganIII():void
		{
			clearOutput();
			output("<i>“Logan, we still have sublight engines?”</i>");
			
			output("\n\n<i>“Barely.”</i>");
			
			output("\n\n<i>“Enough for ramming speed?”</i>");
			
			output("\n\nShe looks at you with wide eyes, then smiles, her forked tongue flicking out across her lips. <i>“I think we can manage that.”</i> ");
			
			output("\n\nYou limp back to the captain’s seat and buckle up. The rest of your crew follows suit. Still, you shout out <i>“Brace for impact!”</i> as Logan turns the Silence around, angling the bow of your little freighter towards the Black Void frigate. Your fingers dig into the armrests as the Silence accelerates, closing towards the bridge of the pirate ship. Pyra screams as the viewscreen is overwhelmed by black steel, followed soon by Logan and Tarik... and you. ");
			
			output("\n\nAt the last moment, you could have sworn you could see the pirate bridge crew screaming in terror.");
			
			output("\n\nThe impact hits you like a brick wall, slamming you forward in your seat, just about breaking your ribs against the restraint harness. The lights explode, raining sparks and glass down on the deck. The ship lurches and groans, a horrible cry of shearing metal that rattles your teeth and makes you clutch at your ears. The structural integrity fields give up the ghost, and the Silence crumples against the enemy’s armor, hitting it like a six thousand ton bullet. Their shields buckle, completely unprepared to stop a ship-sized projectile, and you’re greeted by another wrenching tear as your bow batters into theirs. ");
			
			output("\n\nYou must have blacked out after that. The next thing you see is Logan’s face over yours, her mouth moving, but no sound coming out. All you can hear is ringing...");
			
			output("\n\n<i>“Fuck. Ow,”</i> you groan, rubbing your feline ears. There’s a little blood staining your fingers when you look back at them. ");
			
			output("\n\n<i>“YOU OKAY!?”</i> she shouts into your face, barely audible.");
			
			output("\n\nYou shake your head and, with a little help, struggle up to your feet. Your bridge is a wreck, and seriously on fire. Tarik and Pyra and flopped out on the deck, groaning and cradling their heads after the crash. Every alarm on the ship seems to be going off at once, from atmosphere breach to intruder alerts.");
			
			output("\n\nWait, intruder alerts!?");
			
			output("\n\n<i>“ON YOUR FEET,”</i> you shout, rushing over and hauling them up. <i>“They’re boarding us!”</i>");
			
			output("\n\n<i>“You crashed us,”</i> Pyra groans, <i>“I work so hard on those cock-sucking engines and you FUCKING CRASHED US.”</i>");
			
			output("\n\nHey, it’s <i>your</i> ship. You’ll crash if you damn well please.");
			
			output("\n\n<i>“Shut up and get your gun, Pyra,”</i> you snap. <i>“Tarik. Axes. We’re about to have company.”</i> ");
			
			output("\n\n<i>“Good,”</i> the naleen grins, picking up his greataxe. <i>“Let them come to break upon my AXES!”</i>");
			
			output("\n\nPyra slaps her palm against her face, but you can’t help but grin. With any luck the pirates think you’re all already dead -- and they’re not far from wrong. The bastards will be in for a surprise, though. ");
			
			output("\n\n<i>“What’s the plan, Kara?”</i>");
			
			output("\n\nYou draw your plasma caster and rack the charging handle. <i>“We’re taking the fight to the bitch. C’mon, down to the airlock.”</i>");
			
			output("\n\nPyra groans. <i>“You all go. I’ve gotta go make sure the fucking engines don’t explode. Or worse, turn back on. Shoot us out of here like a rocket. And THEN we explode.”</i>");
			
			output("\n\nCan’t argue with that. <i>“Right. Logan, grab your gun. You’re with me.”</i> ");

			//Pirate gangs can now be fought on the Silence's deck. 
			//Logan joins the party, Pyra leaves
			flags["DEFEATED_MIRI_SPESSCOMBAT"] = 1;
			PlayerParty.removeFromParty(pyra);
			PlayerParty.addToParty(logan);

			logan.currentLocation = "";
			pyra.currentLocation = "";

			doNext(mainGameMenu);
		}

		private function ohShitMiriGonnaFuckYouUp():void
		{
			clearOutput();
			output("<i>“Captain!”</i> Logan calls, shooting you a relieved look over her shoulder. <i>“Thank God you’re back.”</i>");
			
			output("\n\n<i>“Good to see you too,”</i> you smile, planting a kiss on the top of her head. <i>“What’s our status?”</i>");
			
			output("\n\nShe shakes her head. <i>“Not good. That pirate ship scares the hell out of me, Kara. I’ve never seen anything like it.”</i> ");
			
			output("\n\n<i>“Me neither. Let’s-”</i>");
			
			output("\n\nThe forward viewscreen flickers, and goes dark. It comes back showing you a holographic image of a black rose, barely visible against a field of stars. Then a woman’s face appears. She might have been beautiful once, though now her face is marred with scars and a rosevine tattoo that covers half of her face. A high-collared black cape shrouds her body, along with a blood-red full-body suit. ");
			
			output("\n\nShe stares dead at you with a cold, soulless look in her eyes. <i>“This is Captain Mirian Bragga of the <i>Black Rose</i>. Lysander Chow should have known better than to interfere in the Void’s affairs. You saw what happened to the <i>Constellation</i>. That was a disabling shot. Worse happened to the rest of the Nova fleet. Surrender the platinum, and you’ll be allowed to live.”</i> ");
			
			output("\n\nYou’ve heard that offer a thousand times before, and you know better than to even think about it. ");

			doTalkTree(ohShitMiriGonnaFuckYouUpII);
		}

		private function ohShitMiriGonnaFuckYouUpII(choice:String):void
		{
			clearOutput();
			if (choice == "kind")
			{
				output("<i>“That’s a mighty kind offer, but I’m afraid we’ll have to decline,”</i> you say, shutting down the screen. <i>“Logan, what are our options?”</i>");
				
				output("\n\n<i>“Die or run, captain,”</i> she answers, fingers dancing across her control panel. <i>“I’m spooling up the LightDrive now, can try and get us out. But it’ll take a minute. Gotta hold out until we can make the jump... it isn’t going to be easy.”</i>");
				
				output("\n\n<i>“I trust you,”</i> you say, squeezing her shoulder. <i>“Just keep us flying, Logan. We’ll cover you.”</i> ");
			}
			else if (choice == "misc")
			{
				output("<i>“What do you think we are, toddlers? Who the fuck falls for that?”</i>");
				
				output("\n\n<i>“It’s always worth a try,”</i> Bragga says, making a throat-cutting gesture. The video feed clicks off. ");
				
				output("\n\n<i>“Creepy. Logan, get us out of here, babe.”</i> ");
				
				output("\n\nShe nods. <i>“Already spooling up the LightDrive, captain. It’s going to take a couple of minutes, though. Need you on the guns until we’re ready to make the jump.”</i>");
				
				output("\n\nYou wave Pyra and Tarik to their stations and ruffle Logan’s hair. <i>“We’ll get through this. Just keep us flying.”</i>");
			}
			else if (choice == "hard")
			{
				output("<i>“Go fuck yourself,”</i> you sneer, flipping the bird at the pirate captain. Logan gives you a second before cutting the video feed. ");
				
				output("\n\n<i>“Nice, Kara,”</i> she laughs, reaching up to give you a high-five. <i>“Definitely going to murder us now, but still. It’s the thought that counts.”</i> ");
				
				output("\n\nYou chuckle. <i>“Alright. Get us out of here, babe.”</i> ");
				
				output("\n\nShe nods. <i>“Already spooling up the LightDrive, captain. It’s going to take a couple of minutes, though. Need you on the guns until we’re ready to make the jump.”</i>");
				
				output("\n\nYou wave Pyra and Tarik to their stations and ruffle Logan’s hair. <i>“Keep us alive, Logan.”</i>");
			}
			
			doNext(mainGameMenu);
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