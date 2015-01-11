package classes.GameData.Content 
{
	import classes.GameData.GameState;
	import classes.GameData.CombatManager;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class Creation extends BaseContent
	{
		public function Creation() { }
		
		public function StartCreation():void
		{
			GameState.newGame();
			CombatManager.abortCombat();
			
			clearOutput();
			userInterface.setLocation("MORNING AFTER", "SHIP: SILENCE", "SYSTEM: UNKNOWN");
			//setLocation("This is a testing room name");
			userInterface.showLocation();
			gameStarted = true;
			
			output("The nightmare is always the same. You’re running, desperate and terrified and hurting bad, through the winding alleys of Terra. You can hear the sirens in the distance, the sound of laser fire, a muffled voice on a bull horn, the words drowned out in the pounding rain. No matter how fast you run, you never seem to get further away; the sounds of the standoff are in your ears, the loud thumps of weapons fire reverberating in your chest. ");

			output("\n\nYou stop at a corner, letting out onto a dark street illuminated by flickering holos and fluorescent signs. China Town. Los Angeles. A block away from the spaceport. You slump against the cold brick, and peel your hand from your side. Your vision swims as you see your own blood smeared across your hand, washing away in the downpour. It’s a labor to move; your whole body feels leaden. You take one more step forward and your world goes spinning, flickering lights swirling as you go tumbling to the pavement. ");
			
			output("\n\nA hover-car barely misses you, the force of its passing rolling you onto your back. Rain stains your cheeks, each drop a sharp blow. The sirens are closer now. Coming to lock the port down. Coming for you. You look back, the one thing Rourke told you not to do. Red and blue bolts of energy light up the night sky, making the space over the bank look as bright as the rising sun. You tell yourself you can see him, the billowing shadow atop the bank’s roof, just visible over the building tops, drawing all that gunfire. Giving you a chance to escape. ");
			
			output("\n\nThat’s what you tell yourself, until a star bolt of fire tears through the shadow, and it plummets to the earth...");

			clearMenu();
			addButton(0, "Next", CreationII);
		}

		public function CreationII():void
		{
			// Add player to the player party, lel
			PlayerParty.addToParty(pc, true);
			userInterface.showPlayerParty();
						
			clearOutput();
			output("You jolt awake, breathing hard. A sheen of ice-cold sweat clings to you, soaking into your sheets. The scar on your sides is throbbing painfully, a dull and pounding ache that has you instinctively reaching for the pill bottle on your nightstand. You wash them down with a long swig from the flask in the drawer.");
			
			output("\n\n<i>“Bad dreams again?”</i> a soft voice says beside you.");
			
			output("\n\nYou roll over to face Logan. Her yellow, slitted eyes all but glow at you in the dim light of your quarters. With a slight, forced smile, you reach down to stroke the hair behind one of her frilled reptilian ears. ");
			
			output("\n\n<i>“It’s nothing, babe. Sorry.”</i>");
			
			output("\n\n<i>“Uh-huh,”</i> she murmurs, nuzzling against your hand. <i>“Come back to sleep, Kara.”</i>");
			
			output("\n\nBefore you can answer, the big holoscreen at the foot of your bed flashes to life, casting a soft blue glow over your quarters. A QuantumComms loading screen appears, followed by <i>“Incoming call: LYSANDER CHOW.”</i> ");
			
			output("\n\n<i>“Shit,”</i> you grunt, swinging your legs out of bed and grabbing your robe from the floor. <i>“Talk about timing, huh? I gotta take this. You know Chow.”</i>");
			
			output("\n\nYou stand, pulling the robe over yourself and tying the belt. You grab the sheets and pull them up over Logan’s head, hiding her under the covers in a giggling ball of half-lizard girl. <i>“Alright, scoot. And hush.”</i> ");
			
			output("\n\nShe falls silent as you reach up and press the hovering <i>“ANSWER”</i> button. The faint blue flickers out, replaced by a pitch black laced with crackles of static. A bright lamp is pointed at the camera from behind Chow’s shoulder, half hiding him in shadows and half blinding you. You blink hard, rubbing at your eyes. ");
			
			output("\n\n<i>“Mr. Chow,”</i> you say as your vision clears. Chow’s figure comes into focus on screen, a short, rail-thin asian man, dressed to the nines in old-school business formal. A short-brimmed hat hides his receding hairline, and he leans on a gold-crowned cane even while he sits. Thinking back, this is the first time you’ve seen the cane without even a hint of somebody’s blood stained into it. <i>“To what do I owe the pleasure?”</i>");
			
			output("\n\n<i>“Ah, Miss Volke,”</i> he says, a slight smile creeping onto his leathery lips. <i>“It’s-”</i>");
			
			output("\n\nYou stop him cold. <i>“That’s Captain Volke, thank you.”</i> ");
			
			output("\n\nHe doesn’t skip a beat. <i>“Of course. My apologies, Captain. It’s been far too long.”</i>");
			
			output("\n\n<i>“Sure has, but you didn’t call at three in the morning to catch up.”</i>");
			
			output("\n\nHe laughs. Short, hard, the kind of of humorless laugh you have to practice to get just right. <i>“Of course. Down to business straight away. I’ve always liked that about you.”</i> He probably says that to every runner he has, you think. <i>“The Silence is still in orbit around New Texas, is it not?”</i>");
			
			output("\n\n<i>“It might be,”</i> you grunt. Either he has a tracker on you (unlikely), or Chow and the Fat Man have been swapping secrets. Neither answer is good. <i>“What do you want, Chow?”</i>");
			
			output("\n\nHe smiles until his lips curl. <i>“I have a job for you, Captain. But you already knew that. As you say, I am not prone to social calls.”</i> He reaches down and presses a button on the armrest of his chair. Your screen splits in half, displaying Chow’s mug on the left, and a floating field of space debris on the right. The camera pans, showing what looks like a starship in the middle of the field. It’s been completely shredded, probably by heavy weapons. A cruiser or dreadnought might have done it if they’d come alongside for a full broadsiding. The camera zooms, close enough for you to see the markings on a floating bulkhead torn free of the ship.");
			
			output("\n\n<i>“That’s a Nova ship,”</i> you say, squinting at the screen. <i>“Christ, what happened to it?”</i>");
			
			output("\n\nChow nods. <i>“Less than six hours ago, a regular Nova Securities convoy entering New Texas’s space was attacked by pirates. Unfortunately for the pirates, Nova had made an unannounced addition to the convoy at the last moment: their new flagship, dreadnought class. The </i>Righteous Shield<i>. You’ve heard of it?”</i>");
			
			output("\n\n<i>“Rumors. It has the Void trembling in their britches.”</i>");
			
			output("\n\n<i>“As they should. The </i>Shield<i> is engaged at this moment with the pirate fleet in orbit around the third moon. Meaning they haven’t had time to salvage the damaged vessels left behind in the initial ambush.”</i> ");
			
			output("\n\nYou cross your arms under your chest. <i>“And we’re the closest ship.”</i> ");
			
			output("\n\n<i>“You are,”</i> Chow admits. <i>“And this particular vessel was carrying a very precious cargo. Several bricks of Platinum 190 meant for the governor of New Texas.”</i>");
			
			output("\n\nPlat190 is the new gold on the frontier. Rare, pretty, worth its weight in credit chits several times over. A little chunk the size of your fist could buy the Silence, after-market modifications and all. Just one brick could set you up for life. ");
			
			output("\n\n<b><i>(Choose one of the following dialogue options. Hover your mouse over an option for a more detailed explanation.)</i></b>");

			processTime(10);
			
			clearMenu();
			addButton(0, "Kind", CreationIII, "kind", "Respond kindly", "Kind responses are diplomatic and truthful. Tell Chow you'll take the job, no questions asked. The man's given you good business before; keep it professional.");
			addButton(1, "Mischievous", CreationIII, "misc", "Respond mischievously", "Mischievous responses are joking, cunning, and frequently involve bluffing. Tell Chow if he wants it so bad, he can come get it himself -- or give you a big, fat slice of the pie.");
			addButton(2, "Hard", CreationIII, "hard", "Respond agressively", "Hard responses are direct, forceful, and even threatening. Tell Chow to that you'll get the Platinum for yourself, unless he saves you some time and forwards the coordinates - and twice your normal take.");
		}

		public function CreationIII(choice:String):void
		{
			clearOutput();

			if (choice == "kind")
			{
				pc.kindOptions++;
				output("<i>“Alright, Chow,”</i> you say, pulling your robe a little tighter. <i>“We’re in.”</i>");
				
				output("\n\nHis dragon-smile twists up. <i>“I’m glad to hear it, Captain. This will make us both very, very rich. I’m forwarding the coordinates of the battle to you now. I’d hurry, if I were you. Nova isn’t likely to leave the ship unguarded for very long. Your window to recover the platinum is quite short.”</i>");
				
				output("\n\n<i>“Understood,”</i> you say with a nod as the coordinates pop up on your screen. You press a button, forwarding them to Logan’s console at Navigation. <i>“A pleasure doing business, Mr. Chow.”</i>");
				
				output("\n\n<i>“Likewise,”</i> the old man says, inclining his head to you. <i>“You and your crew always are so pleasant to work with. Very professional. We’ll be speaking again shortly, I’m sure.”</i>");
				
				output("\n\n<i>“Tell me that again when we have the platinum. Silence out.”</i> You press a key, and the video cuts off, leaving you in blinding darkness in the cabin.");
				flags["CHOW_RESPONSE"] = "kind";
			}
			else if (choice == "misc")
			{
				pc.miscOptions++;
				output("<i>“Well, since we’re the only ship around... and I’m guessing that Nova will be coming back in a hurry to get their lost cargo... seems like we’re the only chance of you getting your slimy mitts on that platinum, unless you want to hop in that little speeder of yours and come get it yourself.”</i>");
				
				output("\n\nChow scowls. <i>“Watch your tone, girl. I-”</i>");
				
				output("\n\n<i>“Want that platinum enough to give me a double cut? I think you do.”</i>");
				
				output("\n\nThe old man’s lips curl in distaste, but you can see the greedy glint in his eyes. <i>“Fine, Volke. Twice normal rates. Be thankful that you were in the right place at the right time.”</i>");
				
				output("\n\nYou grin as the ship’s coordinates appear on screen. With a flick of your wrist, you send them to Logan’s console at Navigation. <i>“Always am, Chow. Guess I’m just a lucky girl. Thanks for the coordinates. We’ll call when we have the platinum.”</i>");
				
				output("\n\n<i>“See that you do,”</i> Chow says, his video snapping off. ");
				flags["CHOW_RESPONSE"] = "misc";
			}
			else if (choice == "hard")
			{
				pc.hardOptions++;
				output("<i>“We’re the closest ship, huh? Well, seeing as it’s in this system, and it was a big battle, I don’t think we’ll have any problem finding the wreck on our own. But thanks for the heads up, Chow.”</i>");
				
				output("\n\n<i>“Wait just a minute!”</i> the old man snaps, his smile twisting into something more dangerous. <i>“The Nova escort group isn’t likely to leave their crew for long. If you want to get to that platinum before they do, you’ll need the exact coordinates. Searching will take far too long.”</i>");
				
				output("\n\nYou smirk. <i>“And that’s where you come in, right?”</i> ");
				
				output("\n\nHe chuckles, eyes regarding you narrowly. <i>“I happen to have the exact coordinates, yes.”</i>");
				
				output("\n\n<i>“And I’ll happen to get double my usual cut. Deal?”</i>");
				
				output("\n\n<i>“Deal,”</i> he says, a little too quickly -- enough that you know you could have pushed for more. Maybe when you get your hands on the platinum... hell, a triple cut would be enough for you to buy your retirement right now. And maybe even take a certain choice slab of reptilian meat with you...");
				
				output("\n\nThe coordinates appear on your screen, and you flick them over to Logan’s console at Navigation. <i>“Pleasure doing business, Chow.”</i>");
				
				output("\n\nHe grunts something you can’t quite hear and the video disconnects.");
				flags["CHOW_RESPONSE"] = "hard";
			}

			output("\n\n<i>“Hmm. Looks like we’re in business, then,”</i> Logan says behind you, popping up from under the covers and stretching wide, giving you quite the view.");
			
			output("\n\n<i>“Looks like,”</i> you answer, walking over to the PA next to your door and keying it.");

			processTime(10);
			doTalkTree(addressTheCrew, "Please, report to the briefing room...", "Wake up. Get to the briefing room.", "Wake the fuck up, we've got work to do.");
		}
		
		private function addressTheCrew(choice:String):void
		{
			clearOutput();
			
			output("You cough to yourself and clear your throat as you finger the activation key on the intercom panel....");
			
			if (choice == "kind")
			{
				output("\n\n<i>“Alright, everyone, we’ve got work to do. Wake up, get a drink, wake Tarik </i>back<i> up, and meet in the conference room in 10 minutes. Captain out.”</i>");
			}
			else if (choice == "misc")
			{
				output("\n\n<i>“Wakey wakey, eggs and bakey, everyone. Just got a job in, and it’s a doozy. Splash some water on your face, pour the rest on Tarik ‘till he wakes up, and meet in the conference room in 10 minutes. Captain out.”</i>");
			}
			else if (choice == "hard")
			{
				output("\n\n<i>“Wake up, everyone! Get your shit together, it’s time to earn your keep. Somebody go bang on Tarik’s door till he actually gets out. Gather in the conference room in 10 minutes. Captain out.”</i>");
			}
			
			PlayerParty.addToParty(logan);

			currentLocation = "TheSilence.CaptainsQuarters";

			processTime(10);
			clearMenu();
			addButton(0, "Next", mainGameMenu);
		}
	}

}