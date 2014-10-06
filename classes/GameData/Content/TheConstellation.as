package classes.GameData.Content 
{
	import classes.GameData.Content.BaseContent;
	import classes.GameData.Items.Melee.GravityAxe;
	/**
	 * ...
	 * @author Gedan
	 */
	public class TheConstellation extends BaseContent
	{
		
		public function TheConstellation() 
		{
			
		}
		
		public function breachFunction():Boolean
		{
			clearOutput();
			output("Some kind of ungodly powerful weapon blew a hole straight through the <i>Constellation</i>. Debris floats listlessly through open space, drifting in the gaping wound blasted through the hull. Lucky for you, that gives you easy access between the main decks.");
			return false;
		}
		
		public function commandDeckCorridorGeneralFunction():Boolean
		{
			clearOutput();
			output("The corridors through the <i>Constellation</i> are littered with debris sucked out in the moments of decompression that followed the massive hull breach. Emergency lights are still on, though main lighting is non-functional, bathing the corridors in a dark, flickering red. Occasional plates on the wall tell you that you're on the Command deck.");
			return false;
		}
		
		public function commandDeckCorridorN23Function():Boolean
		{
			var ret:Boolean = commandDeckCorridorGeneralFunction();
			
			output("\n\nThe corridor ahead has collapsed. Pyra notes that it looks like an explosion hit here. Maybe an ammunition detonation?");
			
			return ret;
		}
		
		public function commandDeckCorridorL23Function():Boolean
		{
			var ret:Boolean = commandDeckCorridorGeneralFunction();
			
			output("\n\nThe plate here reads <i>“Officers’ Quarters.”</i> However, the path ahead is sealed by a security bulkhead. ");
			
			return ret;
		}
		
		public function engineeringDeckCorridorGeneralFunction():Boolean
		{
			clearOutput();
			output("The corridors through the <i>Constellation</i> are littered with debris sucked out in the moments of decompression that followed the massive hull breach. Emergency lights are still on, though main lighting is non-functional, bathing the corridors in a dark, flickering red. Occasional plates on the wall tell you that you're on the Engineering deck.");
			return false;
		}
		
		public function commandDeckCorridorToOfficersQuartersFunction():Boolean
		{
			clearOutput();
			output("The corridors through the <i>Constellation</i> are littered with debris sucked out in the moments of decompression that followed the massive hull breach. Emergency lights are still on, though main lighting is non-functional, bathing the corridors in a dark, flickering red. Occasional plates on the wall tell you that you're on the Command deck.");
			
			if (flags["CONSTELLATION_OFFICERS_QUARTERS_UNLOCKED"] == undefined)
			{
				output("\n\nThe plate here reads ‘Officers’ Quarters’. However, the path ahead is sealed by a security bulkhead. ");
				
				addButton(0, "Security Override", overrideOfficersQuartersSecurity);
			}
			
			return false;
		}
		
		public function overrideOfficersQuartersSecurity():void
		{
			clearOutput();
			output("TODO");
			clearMenu();
			addButton(0, "Next", mainGameMenu);
		}
		
		public function commandDeckOfficersQuartersFunction():Boolean
		{
			clearOutput();
			output("Several officers’ quarters line this hall, though most of the doors are sealed save for what was clearly the captain's quarters. Richly decorated with hunting trophies and antique guns, and furnished with real Terran wood dressers and desks, this room looks more like something out of a hunting lodge than a warship.");

			if (flags["CONSTELLATION_TAKEN_PISTOL"] == undefined)
			{
				output("\n\n<b>There's an old plasma pistol on the captain's desk</b> of the same make and model of your own. It's been heavily modified, though. Might be useful.");
				
				addButton(0, "Take Pistol", takeTheShooter);
			}
			
			return false;
		}
		
		public function takeTheShooter():void
		{
			clearOutput();
			
			flags["CONSTELLATION_TAKEN_PISTOL"] = 1;
			
			output("You pick up the plasma gun lying out on the captain’s desk. It looks to be in good condition, and it’s loaded. Look like the <i>Constellation</i>’s captain was working on it when shit hit the fan. It’s ID-locked, of course, but you're able to quickly yank the bolt focus off the captain’s gun and apply it to your own.");

			output("\n\n<b>Your ranged damage has increased!</b>");
			
			pc.createStatusEffect("Constellation Captains Weapon Modification", 0, 0, 0, 0, true, "", "", false, 0);
			
			clearMenu();
			addButton(0, "Next", mainGameMenu);
		}
		
		public function commandDeckShieldControlFunction():Boolean
		{
			clearOutput();
			if (flags["COMMAND_DECK_SHIELD_ENTERED"] == undefined)
			{
				flags["COMMAND_DECK_SHIELD_ENTERED"] = 1;
				
				output("<i>“Interior shield control,”</i> Pyra says as the hatch hisses shut behind you. <i>“I should be able to lock in the atmosphere from here. Keep us from getting sucked out the hatch if we bump into a hull breach, anyway.”</i>");
				output("\n\n");
			}
			
			output("A plate on the door identifies this room as ‘Interior Shield Control’. Common sense says this is where atmospheric and emergency shields are operated from; main combat shields are likely down in Engineering.");
			
			if (flags["CONSTELLATION_INTERNAL_SHIELDS_ON"] == undefined) addButton(0, "Shield Repair", commandDeckShieldRepair);
			
			return false;
		}
		
		private function commandDeckShieldRepair():void
		{
			clearOutput();
			
			flags["CONSTELLATION_INTERNAL_SHIELDS_ON"] = 1;
			
			output("<i>“Bring the emergency shields up, Pyra.”</i>");

			output("\n\nThe little raskvel nods and scrambles up onto the console to work. <i>“Roger, boss. Should juuuust take a second.”</i>");

			output("\n\nShe goes to work, fiddling with buttons, sticks, and displays. After a minute, Pyra grunts with frustration, mumbling about the control console's fat motherboards and inability to breed and whatever other insults she can come up with. Finally, Pyra grabs the wrench off of her belt and gives the whole console a great big WHACK.");

			output("\n\nIt beeps and shudders to life.");

			output("\n\n<i>“Ha! Suck it, piece of shit!”</i> she giggles, patting her wrench. <i>“Alright, nav and interior shields are up. Should be safe now.”</i>");

			output("\n\n<b>With the navigation shields online, you can now use the Breach to travel between decks.</b>");
			
			clearMenu();
			addButton(0, "Next", mainGameMenu);
		}
		
		public function commandDeckStarboardCargoFunction():Boolean
		{
			clearOutput();
			output("A cargo hold of some kind. Equipment is stocked up here chest-high, in boxes or loose. If you weren't on a timetable, you'd love to tear through here for loot, but the Platinum comes first.");
			return false;
		}
		
		public function commandDeckBridgeFunction():Boolean
		{
			clearOutput();
			output("The <i>Constellation</i>'s bridge is sleek and modern, with several consoles aimed toward a 180 degree viewscreen wrapping around the front, though it’s been cracked pretty badly in the attack. Several bunches of electronic cords have broken loose from the ceiling or bulkheads, and some of the support consoles have exploded in a power overload. The lights are flickering thanks to the damage.");

			output("\n\nA few of the <i>Constellation</i>’s crewmen are on the deck. A quick check shows they’re quite dead, burned by console overloads or torn apart by shrapnel.");
			return false;
		}
		
		public function engineeringDeckPortCargoFunction():Boolean
		{
			clearOutput();
			output("The main cargo bay on the <i>Constellation</i>, Port Cargo is laden with heavy supply crates ranging from food to uniforms to spare engine parts. Generally, everything the ship needs to make it through a prolonged mission.");

			if (flags["GOT_THE_BRIEFCASE"] == undefined)
			{
				output("\n\n<b>A security field dominates the back of the cargo bay, surrounding a large reinforced briefcase</b>, among other valuable cargo.");
				addButton(0, "Briefcase", initialBriefcaseHo);
			}
			else if (flags["GOT_THE_BRIEFCASE"] == 1)
			{
				addButton(0, "Briefcase", takeBriefcase, "Take Briefcase", "Take the briefcase full of platinum 190.");
			}
			else addDisabledButton(0, "Briefcase");

			if (flags["GOT_GRAVITY_AXE"] == undefined)
			{
				addButton(1, "Gravity Axe", takeGravityAxe, "Take Gravity Axe", "Offer up the huge Gravity Axe to your equally enormous companion Tarik.");
			}
			else addDisabledButton(1, "Gravity Axe");

			addButton(2, "Take Silicone", takeSilicone);
			if (flags["INSPECTED_DROID"] == undefined) addButton(3, "Take Droid", takeCompanionDroid);
			else addDisabledButton(3, "Droid");

			if (flags["CONNIE_VI_HACKED"] == 1)
			{
				addButton(4, "Connie", reapproachConnie);
			}
			
			return false;
		}
		
		private function takeBriefcase():void
		{
			clearOutput();

			output("You reach down and pick up the reinforced briefcase. It’s actually pretty light -- lighter than it ought to be, you think, until you pop it open with your lockpicks and check the goods. Almost reverently, you open up the case. You’re instantly rewarded with the heart-stopping sight of six long, thick bars of pure platinum 190, stamped with proof of the Confederate Central Bank. You have a fortune in your hands.");
			
			output("\n\n<i>“Pretty,”</i> Tarik says, looking over your shoulder. ");
			
			output("\n\n<i>“I wanna see!”</i> Pyra adds, jumping up around your legs, trying to get a glimpse of the platinum.");
			
			output("\n\nYou grin down at her, but click the case closed. <i>“You’ll get your chance, Pyra. Come on, we’ve got what we came for!”</i>");
			
			output("\n\nYou swing the briefcase back around and hook it securely onto your belt. Time to go!");

			flags["GOT_THE_BRIEFCASE"] = 2;
			pc.createKeyItem("Breifcase of Platinum 190", 0, 0, 0, 0, "A briefcase containing 6 bars of Platinum 190.");
			doNext(mainGameMenu);
		}

		private function takeGravityAxe():void
		{
			clearOutput();

			output("<i>“Hey, Tarik. Found a new toy for you,”</i> you say, indicating the massive anti-grav axe locked in the weapon rack. ");
			
			output("\n\nThe towering naleen licks his lips. <i>“A fine weapon.”</i> ");
			
			output("\n\nYou raise your plasma pistol and fire a bolt into the lock, melting it in a green inferno. The axe drops into your hand, and from yours to Tarik’s. He smiles from ear to ear, hefting the weapon up and getting a feel for it. <i>“So light... like swinging a mere branch through the air.”</i>");
			
			output("\n\n<i>“Don’t cream yourself, catnip,”</i> Pyra chuckles. ");
			
			output("\n\nTarik grunts and slings the axe over his back. <i>“I will put this to good use, captain.”</i>");
			
			output("\n\nYou grin. <i>“I’m sure you will.”</i>");

			flags["GOT_GRAVITY_AXE"] = 1;
			tarik.meleeWeapon = new GravityAxe();
			doNext(mainGameMenu);
		}

		private function takeSilicone():void
		{
			clearOutput();

			output("What the hell would you do with all this silicone? It's not even worth that much. Get real, Kara!");

			doNext(mainGameMenu);
		}

		private function takeCompanionDroid():void
		{
			clearOutput();

			output("You look over to the roughly human-sized cargo crate sitting on the deck, clearly marked <i>“JoyCo Companionship Chassis Mk.II.”</i> ");
			
			output("\n\n<i>“Just a chassis,”</i> Pyra says, squinting at the box. <i>“No A.I. onboard. Unless you want to drag a people-sized chunk of scrap metal with you, it’s not much good to us.”</i> ");
			
			output("\n\nDamn shame! A high-class chassis is worth a small fortune in its own right... could be fifty or sixty grand to the right buyer. One of whom, clearly, is on New Texas.");

			flags["INSPECTED_DROID"] = 1;

			clearMenu();
			doNext(mainGameMenu);
		}

		private function initialBriefcaseHo():void
		{
			clearOutput();
			setLocation("The Briefcase");

			output("<i>“This must be it,”</i> you say, stepping towards the security field -- a wall of laser beams running less than an inch apart and stacked eight feet high, forming a complete cage around the briefcase. A small display is rooted on the floor, including a holo-interface which pops up as you approach. The holo coalesces into the figure of an attractive, if blatantly artificial, woman. Cybernetic patterns run across her glowing blue flesh and streams of code form her eyes and short-cropped hair. ");
			
			output("\n\n<i>“Welcome b-b-back, <GUEST>,”</i> she intones, her voice skipping randomly. <i>“How can I h-h-help you to-to-todaaaayyyyyy?”</i>");
			
			output("\n\n<i>“GHOST!”</i> Tarik shrieks, grabbing the axe from over his shoulder and swinging it at the hologram. The projection shivers and flickers as the axe tears through it, but reforms a moment later. It merely blinks in response. <i>“What manner of sorcery is this!?”</i>");
			
			output("\n\n<i>“It’s a hologram, catnip,”</i> Pyra says, poking at the shimmering projection’s leg with her wrench. <i>“Surprised she’s even still working.”</i> ");
			
			output("\n\nYou push your crewmen away from the hologram and step right up to it, gaining its full attention. Her dead, code-filled eyes shift slightly to regard you. ");
			
			output("\n\n<i>“Identify yourself.”</i>");
			
			output("\n\nThe hologram fizzles for a moment, eyes crossing, before it answers unsteadily. <i>“I am Nova Securities A-A-AEEEEYYYYYYY EEEEYYYYEEEE-”</i> its voice twists into a horrible, ear-piercing shriek until Pyra lunges forward and cracks the projector with her wrench. The hologram flickers, and resumes its normal form.");
			
			output("\n\n<i>“Nova Securities A.I. System Delta-Three-Golf-Sierra-One, operating name <i>Constellation</i>.”</i> It pauses, looking at you strangely before adding. <i>“Many of the crew choose to call me Connie.”</i>");
			
			output("\n\nPyra takes a knee under the hologram’s legs, poking around at the projector. <i>“She’s pretty banged up. Some metal frags lodged in here,”</i> the raskvel notes, yanking the front panel off. <i>“Lemme see if I can fix ‘er up a little... there we go! How ‘bout a little rewiring, holo-bitch?”</i> ");
			
			output("\n\nConnie flickers out of existence as Pyra yanks some wires. A moment later, she reappears, looking considerably more solid. Her code-filled eyes look more alert as she adopts a military at-ease stance before you. Under her, Pyra wrenches the display closed and jacks a roll-out keypad into it. <i>“Should get rid of the stutter, anyway. All yours, cap.”</i> ");
			
			output("\n\nYou give Pyra an approving nod and return your attention to Connie and tell her: <i>“I need something inside the security field.”</i>");
			
			output("\n\n<i>“My apologies, Guest, but in red alert conditions, only a registered officer of the <i>Constellation</i> may access my advanced commands.");
			
			output("\n\nCrap. Well, it was worth a try. Time to do your hacker thing.");

			// {Security Bypass Minigame here}
			output("\n\nTODO: Security Minigame");

			clearMenu();
			addButton(0, "Ignore", mainGameMenu);
			addButton(1, "Hack", completeAIHack);
		}

		private function completeAIHack():void
		{
			clearOutput();

			flags["CONNIE_VI_HACKED"] = 1;

			output("The A.I. recoils as if shocked when you finish the bypass. Her color palette shifts slightly, turning her to the same bluish color of your hair. That’s better.");
			
			output("\n\n<i>“Greetings, Captain Volke,”</i> Connie says, rewarding your efforts with a slight smile. <i>“How may I assist you?”</i>");

			connieMenu();
		}

		private function reapproachConnie():void
		{
			clearOutput();
			output("You step back up to Connie’s flickering holo-presence. She regards you with a slight smile. <i>“Welcome back, Captain Volke. How may I assist you?”</i>");
			connieMenu();
		}

		private function connieMenu():void
		{
			clearMenu();
			addButton(0, "Ship Status", connieShipStatus, "Ship System Status", "What's the <i>Constellation</i>'s current status?");
			if (flags["GOT_THE_BRIEFCASE"] == undefined) addButton(1, "Security Field", connieSecurityField, "Cargo Security Field", "Ask about the security field.");
			else addDisabledButton(1, "Security Field", "Cargo Security Field", "With the security field disabled, there's no need to talk to Connie about it.");
			if (flags["GOT_THE_BRIEFCASE"] != 2) addButton(2, "Cargo", connieCargo, "Briefcase", "Ask what's behind the security field.");
			else addDisabledButton(2, "Cargo", "Briefcase", "Having already pilfered the briefcase, there's no need to talk to Connie about it.");
			addButton(3, "Crew Status", connieCrewStatus, "Crew Status", "Ask the V.I. what the status of the <i>Constellation</i>'s crew is");
			if (flags["INSPECTED_DROID"] == 1) addButton(4, "V.I. Status", connieVIStatus, "V.I. Status", "Talk to Connie about her own status, and what she is able to do.");
			else addDisabledButton(4, "V.I. Status", "V.I. Status", "Maybe you should take a look around the secured cargo first.");
			if (flags["CONNIE_ASKED_STATUS"] == 1) addButton(5, "Download", connieDownload, "Download Connie", "Save Connie from the ships failing systems.");
			else addDisabledButton(5, "Download", "Download Connie", "You should get a clear picture of the V.I's current status first.");
		}

		private function connieShipStatus():void
		{
			clearOutput();
			output("<i>“What’s the ship’s status, Connie?”</i>");
			
			output("\n\nThe A.I. cocks her head to the side, the code streams on her accelerating considerably as she pulls in data. <i>“I am detecting critical battle damage across all decks. The <i>Constellation</i> is suffering from massive power loss and loss of atmosphere. Main guns are currently " + ((flags["CONSTELLATION_GUNS_ACTIVE"] == 1) ?"active" : "inactive") + ". Combat shields are " + ((flags["CONSTELLATION_MAIN_SHIELDS_ACTIVE"] == 1) ? "up" : "down") + ". Internal shielding is up. Internal security is " ((flags["CONSTELLATION_DRONES_DEACTIVATED"] == undefined) ? "active": "inactive") + ". Hull integrity is critical across multiple decks.”</i>");
			
			output("\n\n<i>“Do we still have engines? Any flight ability?”</i>");
			
			output("\n\nShe shakes her head. <i>“Negative, captain. I have control of minimal thrusters; however, any attempt at acceleration is likely to cause further damage. The chance of splitting the ship in half is roughly seventy three percent.”</i>");
			
			if (pc.isMisc) output("\n\n<i>“Oh, goody.”</i>");
			else output("\n\n<i>“Shit.”</i>"); 
			output(" Wouldn't have hurt to steal a Nova ship while you're at it.");
			
			connieMenu();
			addDisabledButton(0, "Ship Status");
		}
		
		private function connieSecurityField():void
		{
			clearOutput();
			output("<i>“Talk to me about the security field here.”</i>");
			
			output("\n\nConnie looks over her shoulder to regard the field, then back to you. “<i>Constellation</i>’s cargo security field is made of light lasers to prevent theft, at risk of bodily damage. A high-intensity gravity field inside prevents cargo from shifting or being damaged during flight.”</i>");
			
			output("\n\n<i>“Can you disable it?”</i>");
			
			output("\n\n<i>“Of course, Captain,”</i> she says, and the field flickers away. <i>“Please let me know when you would like me to reactivate it.”</i> ");
			
			output("\n\nYou snicker. <i>“Sure will.”</i>");

			flags["GOT_THE_BRIEFCASE"] = 1;

			connieMenu();
		}
		
		private function connieCargo():void
		{
			clearOutput();
			output("<i>“So, what’re we carrying here?”</i> you ask, nodding toward the secure cargo bay{, now noticeably missing its security field}.");
			
			output("\n\n<i>“Accessing cargo manifest... vital cargo currently includes a KihaCorp Mk.VII Gravity Axe, several high-capacity canisters of silicone, one JoyCo companion droid chassis, and one sealed case of platinum bars. All cargo is slated as maximum priority, to be delivered to New Texas care of Governor Tee.”</i>");
			
			output("\n\n<i>“What’s a bull dude gonna do with all that silicone? Grow tits?”</i> Pyra asks, looking at the big steel canisters behind the hologram. ");
			
			output("\n\nTarik’s attention, however, is clearly on the hefty double-bladed axe sitting on a weapon rack. Several small electronic devices cling to the blade, covering it in a small, persistent anti-gravity field. One good hit with that’ll send you flying! You reach up and scratch Tarik’s ears, telling him that he’ll get to play with that soon enough.");

			connieMenu();
			addDisabledButton(2, "Cargo");
		}

		private function connieCrewStatus():void
		{
			clearOutput();

			output("<i>“What’s the crew’s status, Connie?”</i>");
			
			output("\n\n<i>“Heavy casualties have been sustained, captain. Several crewmen were injured in combat. Six deaths were sustained.”</i>");
			
			output("\n\nSurprisingly light, given the damage the <i>Constellation</i> sustained. <i>“Where is everyone, then?”</i>");
			
			output("\n\n<i>“You ordered a full evacuation one hour ago, captain,”</i> the V.I. ‘reminds’ you. <i>“All surviving crewmen have evacuated via life pods. " + ((flags["CONSTELLATION_PIRATES_ARRIVED"] == undefined) ? "Only three life signs remain aboard" : "Several unidentified life signs remain aboard") + " the </i>Constellation<i>, captain.”</i> ");
			
			output("\n\n");
			if (flags["CONSTELLATION_PIRATES_ARRIVED"] == undefined) output("Good, good.");
			else output("Uh-oh.");

			connieMenu();
			addDisabledButton(3, "Crew Status");
		}

		private function connieVIStatus():void
		{
			clearOutput();

			flags["CONNIE_ASKED_STATUS"] = 1;

			output("<i>“Connie, what’s your status?”</i>");
			
			output("\n\nShe blinks. <i>“My status, captain?”</i> ");
			
			output("\n\n<i>“Your status, yeah. The ship’s badly damaged. Power’s low. How long are you going to last?”</i>");
			
			output("\n\nThe V.I. hesitates at the question, a fraction of a second longer than it would take to compile that data. <i>“I am in imminent danger of shutting down, Captain Volke. Several core databanks are registering as critically damaged, and power reserves are at minimal operating capacity.”</i>");
			
			output("\n\nAfter a moment of silence, she adds, <i>“Due to damaged computers, captain, I beleieve that were I to shut down, my data would be irreparably corrupted or lost. I am currently hosting across several networks to sustain minimal operating presence.”</i>");
			
			output("\n\n<i>“The spirit is dying?”</i> Tarik says, slithering closer to Connie. ");
			
			output("\n\nPyra rolls her eyes and pokes her wrench into the hologram’s spectral leg. <i>“It’s a fuckin’ computer program, catnip, not some freaky tribal spirit shit. Who gives a shit?”</i>");
			
			output("\n\nThe A.I. blinks, but otherwise fails to react to Pyra.");

			connieMenu();
			addDisabledButton(4, "V.I. Status");
		}

		private function connieDownload():void
		{
			clearOutput();
			output("<i>“Connie, what do you say about getting out of here?”</i>");
			
			output("\n\n<i>“Captain? Please clarify,”</i> she asks, cocking her head to the side. ");
			
			output("\n\nYou grin. <i>“Can’t let a good A.I. go to waste, can we? Prep yourself for download into a new shell.”</i>");
			
			output("\n\nWithout hesitation, she answers, <i>“Aye, captain,”</i> and vanishes.");
			
			output("\n\nYou take a knee next to her display and yank out some of the wires Pyra had laid, causing the little raskvel to curse at you until you shout over her, <i>“Tarik! Crack open that box over there,”</i> pointing toward the droid chassis. He does so with gusto, tearing it apart with his bare hands until the blue-fleshed droid chassis tumbles out and into his arms. At your word, he drags the hefty robot over and deposits it beside you. The chassis flops onto the deck like a ragdoll, gloriously nude and strikingly lifeless. It could easily pass for a human, were it not for the slightly blue shift of her skin and the ultrapornstar-like proportions of hips, breasts, and legs.");
			
			output("\n\nCompanion droid indeed. You pull the wires toward a small port on the droid chassis’s back and hook them in, giving the <i>Constellation</i>’s V.I. a direct path into the empty husk of a robot. Power flows into the machine, illuminating its milky white eyes and the bits of holographics surrounding the ports in the small of its back. The droid’s chassis shudders slowly to life, powering up for what’s probably the first time. ");
			
			output("\n\n<i>“Download complete, Captain Volke,”</i> the chassis says, its lips unmoving, projecting from the speakers buried somewhere deep in its throat. ");
			
			output("\n\n<i>“Connie, access the Extranet and download the...”</i> you look at the remnants of the crate, <i>“JoyCo mark-two companion droid control software. Add it to your main programming.”</i>");
			
			output("\n\nIn the blink of an eye, Connie masters the droid body you’ve slotted her into and brings it to its feet. Her robotic frame is tall and voluptuous, six feet of perfectly sculpted silicone under sky-blue synthflesh. She curls her fingers, looking down on them like they were alien tentacles. From that, her hands slip down, running across her bare artificial flesh, exploring herself. ");
			
			output("\n\n<i>“Not to cut this short, but we need to go,”</i> you say, placing a hand on the newly-minted ConnieBot’s shoulder and giving her a slight pull toward the hatch. Unsteadily, the android follows you as you prepare to leave.");

			flags["CONNIE_GOT_A_BODY"] = 1;

			doNext(mainGameMenu);
		}

		public function engineeringDeckDroneControlFunction():Boolean
		{
			clearOutput();
			output("This area is marked as ‘Drone Control’,  for obvious reasons. The internal security drones and the unmanned interceptors in the launch bay are all directed from here over several holo consoles. Most of the drones are listed as damaged or inactive, and the launch bay has suffered critical damage.");
			
			if (flags["CONSTELLATION_DRONES_DEACTIVATED"] == undefined)
			{
				addButton(0, "Deactivate", deactivateDrones);
			}
			return false;
		}
		
		private function deactivateDrones():void
		{
			clearOutput();
			
			flags["CONSTELLATION_DRONES_DEACTIVATED"] = 1;
			
			output("<i>“Pyra, can you disable security from here?”</i>");

			output("\n\n<i>“You know it, captain!”</i> the raskvel answers, scrambling up onto one of the holo-consoles and mashing some of the buttons, seemingly at random. <i>“Oooh, they’re running some serious security here. They’ve got </i>tanks<i> down in the hold! Like, actual fuckin’ hover tanks!”</i>");
			
			doTalkTree(deactivateDronesII);
		}
		
		private function deactivateDronesII(choice:String):void
		{
			clearOutput();
			if (choice == "kind")
			{
				output("<i>“We don't have time for that, Pyra.”</i>");
			}
			else
			{
				output("<i>“Eye on the prize, Pyra.”</i>");
			}
			
			output("\n\n<i>“But TAAAAANNNNKKKKS,”</i> she whines, still working. You just scowl at her. As awesome as having your own personal hover tank would be, you doubt you could even fit it in the Silence’s launch bay, much less devote the time to do it right now.");

			output("\n\nAfter a few moments, the console blinks and the display flickers to a gigantic picture of a dick. <i>“Drones are down. Shouldn't be hitting any more security, captain.”</i>");
			
			doNext();
		}
		
		public function engineeringDeckShieldControlFunction():Boolean
		{
			clearOutput();
			output("Marked ‘Main Shield Control’, this room is home to a variety of energy readouts and important displays critical for maintaining combat shields aboard the <i>Constellation</i>. Main shields are currently");
			if (flags["CONSTELLATION_MAIN_SHIELDS_ACTIVE"] == 1)
			{
				output(" up");
			}
			else
			{
				output(" down");
			}
			output(", according to the readout in the center of the room.");

			if (flags["CONSTELLATION_MAIN_SHIELDS_ACTIVE"] == undefined && flags["CONSTELLATION_PIRATES_ARRIVED"] != undefined)
			{
				addButton(0, "Shields Up!", shieldsUp);
			}
			
			return false;
		}
		
		private function shieldsUp():void
		{
			clearOutput();
			
			flags["CONSTELLATION_MAIN_SHIELDS_ACTIVE"] = 1;
			
			output("You hop over to the shield control and punch the activator. Combat shields come up shakily, and the deck settles down under your feet as the shields start absorbing some of the fire coming your way.");
			
			doNext();
		}
		
		public function engineeringDeckAtmosFunction():Boolean
		{
			clearOutput();
			output("Atmospheric control is, of course, full of computer arrays maintaining internal atmosphere, gravity, and temperature. Of all the rooms you’ve passed through aboard the <i>Constellation</i>, this is probably the least damaged: were it not for the distinct lack of crewmen and the blinking evacuation alerts on screen, you'd barely know there was anything amiss.");
			return false;
		}
		
		public function engineeringDeckForwardBatteryFunction():Boolean
		{
			clearOutput();
			output("The forward battery is, as you expected, the gun control for the <i>Constellation</i>'s main cannons. It’s a simple one-man operation, with fire control, energy output displays, and targeting data all feeding to a single console. A permanent link has been set up connecting the point defenses controlled from the bridge to the gunner's seat, allowing them to share information quickly. Surprisingly, given the damage the <i>Constellation</i> has sustained, the main guns seem to still be powered and operational.");
			
			if (flags["CONSTELLATION_PIRATES_ARRIVED"] == undefined)
			{
				output("\n\n<b>There's no need to mess with the big guns right now</b>.");
			}
			else
			{
				if (flags["CONSTELLATION_GUNS_ACTIVE"] == undefined)
				{
					addButton(0, "Activate Guns", activateGuns);
				}
			}
			
			return false;
		}
		
		private function activateGuns():void
		{
			clearOutput();
			
			flags["CONSTELLATION_GUNS_ACTIVE"] = 1;
			
			output("You step up to the heavy battery and start punching buttons, trying to get the <i>Constellation</i>’s guns online. It's not much, after all the damage the ship has taken, but it's something to keep the pirates at bay!");

			output("\n\nHowever, the console doesn't respond.");

			output("\n\n<i>“Shit. No time to run a hack,”</i> you growl, turning to leave.");

			if (PlayerParty.isInParty(connie))
			{
				output("\n\n<i>“Allow me, Captain Volke,”</i> Connie says, stepping forward. A probe snakes out of her wrist and into the command console under the gun. The console flickers, then releases. You quickly slip into the controls, punching in the ID on the Silence and telling the gun to blast anything that isn't your ship. The deck rumbles as the guns light up, hurling laser bolts into the void around the <i>Constellation</i>.");

				output("\n\n<i>“That'll buy us some time. Now come on!”</i>");	
			}

			doNext();
		}
		
	}

}