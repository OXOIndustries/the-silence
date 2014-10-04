package classes.GameData.Content 
{
	import classes.GameData.Content.BaseContent;
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
				output("\n\nThere's a door to the west beside a security panel glowing an ominious red....");
				
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

			output("<b>A security field dominates the back of the cargo bay, surrounding a large reinforced briefcase</b>, among other valuable cargo.");
			return false;
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