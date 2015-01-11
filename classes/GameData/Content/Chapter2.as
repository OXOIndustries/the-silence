package classes.GameData.Content 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public class Chapter2 extends BaseContent
	{
		public function Chapter2() { }
		
		public function missionBrief():void
		{
			clearOutput();
			setLocation("MISSION BRIEFING");

			flags["CREW_BRIEFED"] = 1;
			flags["CONFROOM_SHOW_NPC_FLAG"] = 0;

			output("<i>“Alright, everyone,”</i> you say, clapping your hands to get the crew’s attention. Your three subordinates lay their gaze on you, and fall silent. Expectant. <i>“I just finished talking to Chow. He’s got an urgent job, and we’re the only ship in range to do it. And believe me, the payout is going to be worth it.”</i>");
			
			output("\n\n<i>“Chow again?”</i> Pyra huffs. You turn your attention to the short, red-scaled chief engineer, barely visible over the lip of the table save for her plumage of bright purple feathers. She pulls herself a little straighter so that you can see her eyes. <i>“Chow fucking screwed us on that last run. I almost got my ears pinched off!”</i> she adds, manhandling one of the nearly body-length ears dangling from her head. Several metallic studs and rings jingle around a large scar running along its length.");

			processTime(5);
			
			clearMenu();
			doTalkTree(missionBriefII);
		}

		private function missionBriefII(response:String):void
		{
			clearOutput();
			setLocation("MISSION BRIEFING");

			// Kind
			// We need the money. Especially after that last job...
			if (response == "kind")
			{
				output("<i>“It’s not Chow’s fault the pilot got too drunk to fly. Could he have vetted the sonofabitch better? Yeah, maybe. But you can’t hold it against Chow. Especially when we need this job. We didn’t make a penny off the last job, and we’ll be running on fumes before you know it.”</i> ");
				
				output("\n\nPyra grunts. <i>“More like already.”</i>");
				
				output("\n\n<i>“Yeah,”</i> Logan adds, <i>“and Throbb doesn’t just magically appear in my cabin, either. We need to make bank.”</i>");
				
				output("\n\n<i>“And we will,”</i> you say, placing a hand on her shoulder.");
			}
			// Mischievous
			// So maybe Chow isn't the easiest to work for. A job's a job.
			else if (response == "misc")
			{
				output("<i>“Alright, maybe he fucked us last time, maybe he didn’t. You can’t expect every pilot you hire to be as good as Logan here.”</i>");
				
				output("\n\nLogan flashes you a grin when you look her way.");
				
				output("\n\n<i>“Either way, a job’s a job. We’ve got the coordinates, we’ve got eyes on the place, everything’s set. And the haul is going to be fucking incredible. Easily worth a little boo-boo on your ear, shortstack.”</i>");
			}
			// Hard
			// Stop whining. We're going to make bank off this. 
			else if (response == "hard")
			{
				output("<i>“Stop whining. It’s a cut,”</i> you say, rolling your eyes. ");
				
				output("\n\nPyra scowls, about to retort when Logan cuts her off: <i>“I think the payout is going to be worth a little scratch, Pyra.”</i>");
				
				output("\n\n<i>“It fuckin’ </i>hurt<i>,”</i> the raskvel mechanic pouts, rubbing her ear. <i>“You try driving with half your fucking head pinched in the speeder door.”</i> ");
				
				output("\n\n<i>“Quiet,”</i> you snap. <i>“The pay here’s going to be worth a little pain. Trust me.”</i>");
			}

			// Combine
			output("\n\nTarik slithers up, looming two feet over you, easy. The massive creature yawns lazily, rolling his shoulders and rubbing at the mane of fur rung around his neck. <i>“So what exactly is the job, Captain Volke?”</i>");

			if (response == "hard")
			{
				output("\n\n<i>“I’m getting to that, Tarik,”</i>");
			}
			else
			{
				output("\n\n<i>“I’m glad you asked, Tarik,”</i>");
			}

			output(" you say, stepping over and tapping the holoscreen on the wall. Chow's data moves seamlessly over, showing the drifting hulk of the destroyed Nova Securities ship while you reiterate the information Chow gave you to your crew. When you mention a container full of platinum, their eyes go wide. Even Logan puts on a good show of being amazed, though that might just be her Throbb addiction talking.");

			output("\n\n<i>“That’s a lot of money,”</i> Pyra admits, scratching at her ear. ");
			
			output("\n\nYou nod. <i>“Moreover, the isotope being carried by the caravan was 190. One of the rarest -- and most valuable -- isotopes. Easily worth ten times over the norm. Still don’t like working for Chow now?”</i>");
			
			output("\n\n<i>“Shit, I’ll suck his dick for that,”</i> Pyra laughs, hopping out of her seat and adjusting her black skin-hugging suit around her hips. <i>“Where do I sign up?”</i>");

			output("\n\n");
			if (response == "misc")
			{
				output("<i>“To suck his dick?”</i> you laugh. ");
			}
			output("<i>“Down in Engineering, giving Logan full power. We’ve got a narrow window to get it, crack the metal skulls of whatever security bots are still standing in the hulk, and salvage the cargo.”</i>");

			output("\n\nPyra’s answer is to giggle madly and scamper over to the elevator and vanish down to Engineering.");
			
			output("\n\n<i>“We’re pretty close already,”</i> Logan says, eyeing the coordinates. <i>“If Pyra doesn’t blow the engines, we could be there in... ten minutes? Fifteen, tops.”</i>");
			
			output("\n\nYou nod. <i>“Right. Logan, Get up to the bridge and get us underway. Tarik, go grab everyone’s kit and get down to the airlock. We’ll need to hit the ground running as soon as Logan docks with the wreck.”</i>");
			
			output("\n\n<i>“Assuming there’s anyplace </i>to<i> dock,”</i> Logan says, standing and heading toward the elevator. <i>“Might want to suit up for E.V.A., cuz I don’t see anything like an airlock left.”</i>");

			logan.currentLocation = "TheSilence.Bridge";
			
			output("\n\nTarik grunts and starts slithering toward the fore of the ship. <i>“Must we go into the Blackness again? The suit you gave me is very... discomforting.”</i>");

			if (response == "kind")
			{
				output("\n\n<i>“Sorry, big guy. Not a lot of space suits out there made for gigantic naga-dudes.”</i>");
			}
			else if (response == "misc")
			{
				output("\n\n<i>“It’s called the Black, big guy. Don’t worry, we pull this off and we’ll be able to get a suit that fits you worth a shit.”</i>");
			}
			else if (response == "hard")
			{
				output("\n\n<i>“Suck it up, big guy. You don’t exactly fit into any normal space suits.”</i>");
			}

			output("\n\nTarik sighs. <i>“Aye, Captain. As you say,”</i> before slithering down toward the airlock, his enormous shoulders slumped. With him gone, you’re left alone in the conference room as your crew prepares for action.");

			processTime(10);
			
			clearMenu();
			addButton(0, "Next", missionBriefIII);
		}

		private function missionBriefIII():void
		{
			clearOutput();
			setLocation("MISSION BRIEFING");

			output("A few moments later, the P.A. chimes, and Logan’s voice comes through. <i>“Captain to the bridge. Captain to the bridge.”</i>");

			processTime(2);
			
			clearMenu();
			addButton(0, "Next", mainGameMenu);
		}
	}
}