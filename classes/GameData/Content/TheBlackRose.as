package classes.GameData.Content 
{
	import classes.GameData.CombatManager;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class TheBlackRose extends BaseContent
	{
		
		public function TheBlackRose() 
		{
			
		}
		
		public function airlockFunction():Boolean
		{
			clearOutput();
			output("You, Logan, and Tarik rush into the breach, weapons drawn and ready for anything. There could be dozens of pirates still aboard the ship waiting for you. ");
			
			output("\n\nInstead, as you make it inside, you find... nobody. The vast, open chamber before you is dead empty, save for the almost gothic decorations. Two sets of sweeping stairs lead up from the deck to a second tier, bristling with computer consoles. You motion to your companions, sending them to one stair as you take the other, moving up quickly but cautiously, weapons training at the shadows above, which seem to dance and move as you approach. ");
			
			output("\n\nYou make it up to the top of the stairs, and find a command deck covered with blood and corpses. Most of the bridge crew was killed in the impact, burned by exploding consoles or shredded by flying debris. Some, however, are still very much alive, clustered around a captain’s chair that’s more like a throne, bathed in shadows. Weapons are leveled at you and yours, but for the moment, they hold their fire. You spot three at first, though your keen ears pick up footfalls approaching -- more pirates on their way, converging on you from all over the ship. Every surviving Black Void soldier rushing to meet you. ");
			
			output("\n\nFrom the throne, you hear a slow clapping. Oh, fuck...");
			
			output("\n\nThe pirate captain stands, striding out from the shadows, her cape flowing behind her. The scars and tattoos on her face twist as her lips curl into a half-smile, an ugly grin that ill suits her. <i>“I have to say, I’m impressed,”</i> she says, her hands falling away to her side and to the heavy laser gun slung there. <i>“You defied the Black Void, rammed a much bigger, more powerful ship, and now you’ve </i>boarded<i> the </i>Rose<i>. Bravo, captain. Now that you’re here, however... what exactly did you hope to accomplish? To kill me and steal the ship?”</i>");

			processTime(5);
			
			doTalkTree(fugUMiri);

			return true;
		}

		private function fugUMiri(choice:String):void
		{
			clearOutput();
			if (choice == "kind")
			{
				output("<i>“Because I want to live,”</i> you answer, levelling your gun at her. <i>“You weren’t going to let us walk away, were you?”</i>");
				
				output("\n\nShe chuckles. <i>“No. Though it would have been painless, perhaps instantaneous. Unfortunately for you, damaging the Void’s precious new flagship is going to require repayment in flesh. You’re quite attractive, captain -- you’ll net a fine price on the slave markets. Not enough to repay the debt, but it’s a start. A few months of chemical torture first...”</i>");
				
				output("\n\nYou thumb the charger on your gun and take a step towards her. The rest of your crew follows suit; the pirates spread out behind their captain, crouching and shouldering their sub-machineguns. ");
				
				output("\n\n<i>“We’re not going down without a fight,”</i> you say cooly, training the sights on the captain’s face. ");
				
				output("\n\n<i>“Unfortunate, if not unexpected,”</i> she says, languidly drawing the laspistol from her waist. <i>“Try to aim for the extremities, gentlemen, I want them in as serviceable condition as possible.”</i> ");
				
				output("\n\nTime to finish this!");
			}
			else if (choice == "misc")
			{
				output("You shrug. <i>“A bad plan’s better than no plan, right? Always do the unexpected!”</i>");
				
				output("\n\n<i>“Unexpected indeed. You could have made an excellent pirate, captain.... unfortunate that you damage the Void’s new flagship, though. That’s a debt that must be paid in flesh.”</i> ");
				
				output("\n\nYou thumb the charger on your gun and take a step towards her. The rest of your crew follows suit; the pirates spread out behind their captain, crouching and shouldering their sub-machineguns. ");
				
				output("\n\n<i>“Sorry, babe, but I’ve been a slave once before. Not happening again.”</i> ");
				
				output("\n\nThe pirate languidly draws the laspistol from her hip, leveling it at you. <i>“I’m afraid you don’t have a choice, captain. <i>“Try to aim for the extremities, gentlemen, I want them in as serviceable condition as possible.”</i> ");
				
				output("\n\nAlright, time to knock this bitch down a peg.");
			}
			else if (choice == "hard")
			{
				output("<i>“I’m here to put a bullet in your brain, bitch,”</i> you spit, and pull the trigger. ");
				
				output("\n\nFuck if you’re not going down swinging!");
			}
			
			processTime(5);

			clearMenu();
			doNext(startMiriFite);
		}

		private function startMiriFite():void
		{
			//	Start Final Boss fight. Captain Bragga + max number of Pirates possible. The turn after any pirate drops, add:
			// "Another pirate rushes up the stairs behind you, firing wildly!"
			// And replace with new pirate.

			CombatManager.newGroundCombat(); // Setup for a new combat phase.
			CombatManager.setPlayers(PlayerParty.getParty()); // Set the "friendly" players that will be fighting - could be a single char, or the party reference
			//CombatManager.setEnemies(EnemyParty); // Set the "hostile" characters that will be fighting - could be a single char, or the party reference
			CombatManager.victoryCondition(CombatManager.ENTIRE_PARTY_DEFEATED); // Set the victory condition and optional argument
			CombatManager.victoryScene(fugUCheater); // The function reference that will be called when the player achieves the victory condition
			CombatManager.lossCondition(CombatManager.ENTIRE_PARTY_DEFEATED);
			CombatManager.lossScene(piratesWin); // The function reference that will be called if the player is defeated

			CombatManager.beginCombat();
		}

		private function fugUCheater():void
		{
			clearOutput();
			output("Fug u cheater");
			clearMenu();
			CombatManager.postCombat();
		}

		private function piratesWin():void
		{
			clearOutput();
			output("<i>“They keep coming,”</i> Logan grunts, squeezing the trigger of his slug gun again and again, emptying bullets into the seemingly endless onslaught of pirates. Behind her, Tarik roars in rage, grabbing a pair of pirates and cracking their heads together. Four more take their place, throwing punches and striking out with rifle-butts.");
			
			output("\n\nYour sights stay trained on the captain, shuddering as you send bolts of plasma hurtling towards her to crash against her shields. You can see your own shields flare and buckle as she returns the favor, red streaks of fire hammering against you. Every impact shoves you back, forcing you to give ground as Captain Bragga steps calmly forward. She doesn’t even blink as you bathe her in burning green plasma, but relentlessly advances.");
			
			output("\n\nYou hear a scream of pain, and a blinding flash all around your -- your shields collapsing, and your voice twisting into a cry of pain as a laser bolt tears into you. You tumble to the ground, clutching the black scorch on your leg. Looking around, you can’t even see Logan or Tarik anymore through the horde of pirates clustering around the deck. A boot slams into your chest, shoving you onto your back and making you look up into the barrel of a laspistol. ");
			
			output("\n\n<i>“Did you really expect this to work, captain?”</i> she laughs dryly, <i>“No? Of course not. I understand that driving need to push forward, the refusal to quit when you know the outcome. I’d say it’s a human quality, but...”</i> her heel slips down, putting just enough pressure on your feline tail make you yowl in redoubled pain. ");
			
			output("\n\nShe opens her mouth to speak again, but the ship shudders around you, rocking under another impact -- almost as heavy as the one you felt on ramming it, sending pirates and crewmen tumbling against the bulkheads.");
			
			output("\n\nA voice booms over the PA, faceless and shrouded with static: <i>“Attention pirate vessel, this is Admiral Cassandra Roth of the T.S.C.S. </i>Odysseus<i>. Stand down and prepare to be boarded.”</i>");
			
			output("\n\nThe Terran navy? Oh, shit... ");
			
			output("\n\nThe pirate captain staggers back, cursing. <i>“Pack it up. To the launch deck, all of you! We’re out of here.”</i> ");
			
			output("\n\n<i>“What about the prisoners, captain?”</i>");
			
			output("\n\nShe scowls, thinking for a split second. <i>“Leave them. No time, and no room. Consider yourself lucky, Captain Volke. A quick death is, I would imagine, a kinder fate than living under the leash.”</i> ");
			
			output("\n\nBefore you can respond, she raises her pistol to your face and pulls the trigger.");
			
			output("\n\nBlackness takes you.");

			processTime(20);
			
			doNext(piratesWinII);
		}

		private function piratesWinII():void
		{
			clearOutput();
			output("<i>“Kara! Kara, please, come on!”</i>");
			
			output("\n\nThe voice comes to you like through water, distorted and distant and barely intelligible. Then you feel it: the pain. Oh, gods and stars, the pain! A groan of anguish escapes your lips, and you open your eyes.");
			
			output("\n\nEverything looks... wrong. Out of focus, saturated, hazy. Logan’s leaning over you, and you can feel her fingers tight around your own. Overhead are blinding white lights, showing a sterile white room. Machines beep and buzz quietly, just on the edge of hearing. ");
			
			output("\n\n<i>“Fuck, what... what happened...”</i> you manage to groan, wincing as the light hits your eyes. You cover them instinctively, blinking hard. They feel too big, like you can barely close your lids around them. Can eyes get swollen? Oof, it hurts to think about it...");
			
			output("\n\n<i>“Thank God, you’re finally awake,”</i> Logan says, and you feel more than see her leaning in and planting a kiss on your cheek. <i>“You had me worried, Kara...”</i> ");
			
			output("\n\nYou try to flash her a grin, but end up wincing in pain. <i>“What happened? And where are we?”</i>");
			
			output("\n\nYou hear footsteps approaching, though the third person with you is shrouded in light, too hard to see clearly. You recognize the voice instantly, however:");
			
			output("\n\n<i>“A pleasure to see you again, Captain Volke,”</i> Chow says, <i>“A pity about your cargo, though.”</i>");
			
			output("\n\nThat answers that question. Not surprising that the pirates made off with the platinum. In hindsight, you probably should have thrown it in your safe, or one of the hidden cargo hatches Blackstar secreted throughout the ship, before charging headlong into the belly of the beast.");
			
			output("\n\n<i>“About your eyes, too,”</i> Chow adds.");
			
			output("\n\nYour breath catches. <i>“My...”</i>");
			
			output("\n\n<i>“I’m so sorry, Kara,”</i> Logan winces, chewing one of her lips. <i>“You took a lasbolt right to the eyes, and...”</i>");
			
			output("\n\n<i>“I get it,”</i> you snap, a little too harshly, and curl up against your pillow. You barely contain a scream of anger, pain, and hatred. As if on cue, your vision is dominated by a swirling pink JoyCo logo and a download bar as your cyberware patches itself. It finishes quickly, and your sight clears somewhat. You feel like you should cry, but all you can manage is a heave of your chest. Your fingers dig into the sheets, into Logan’s hand as she holds you. A hand settles on your shoulder, comforting and familiar. ");
			
			output("\n\n<i>“Consider your new eyes a down payment, Captain Volke,”</i> Chow says, and you can practically hear the smug grin on his leathery lips. <i>“You still owe me a product. I expect my platinum soon.”</i>");
			
			output("\n\nYou grit your teeth. <i>“Of course you do, Chow,”</i> you say, unsteadily sitting back up and slinging your legs out of the bed. Your world spins dizzily, forcing you to lean hard against Logan. <i>“I’ll get you your damn platinum... and I’ll put a bullet in that bitch of a pirate’s head.”</i>");
			
			output("\n\n<i>To Be Continued</i>");

			processTime(10);
			clearMenu();
		}
		
	}

}