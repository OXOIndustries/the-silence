package classes.GameData.Content 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public class Chapter3 extends BaseContent
	{
		
		public function Chapter3() { }
		
		public function captainToTheBridge():void
		{
			clearOutput();
			setLocation("\nLOGAN");

			flags["CAPTAIN_TO_THE_BRIDGE"] = 1;
			PlayerParty.addToParty(logan, true);

			output("You step up behind Logan’s chair and gaze out the viewscreen. The sight of the stars and planets rushing towards you at nine-tenths the speed of light never ceases to make your breath catch. Doubly so when you can see the distant fires and detonations of a battle raging a world away, flashing lights in the moon’s rings that can only be from exploding starships and detonating warheads. The lightshow a space fight puts on never fails to impress, even if you can’t fully shake the knowledge that people are dying by the boatload. Closer still is another fire, barely visible one second, then close enough to see the shadow of the wrecked cruiser the next.");
			
			output("\n\n<i>“Spooling the LightDrive down momentarily, Captain,”</i> Logan says, not looking up from her screen. <i>“Sensors aren’t picking any hostile craft... looks like the wreck still has some power and life support.");
			
			output("\n\n<i>“There’s a pretty big gash here,”</i> she adds, keying up a holo-projection of the damaged vessel. <i>“Figuring if Nova structures their ships like the Coalition fleet does, the cargo deck won’t be far. I should be able to insert you close to the target. There’s even atmosphere nearby.”</i>");
			
			output("\n\nThat’s good news. The less time Tarik spends in that hideous suit you had to rig up for his serpentine lower half, the less complaining you’ll hear tomorrow.");

			menu();
		}

		private function lifeSigns():void
		{
			clearOutput();
			setLocation("\nLOGAN");

			output("<i>“Any life signs still aboard?”</i>");
			
			output("\n\nLogan shrugs. <i>“Hard to say. There’s a lot of interference from the debris. A lot of secondary detonations, too. I’m still trying to get a good picture on the layout.”</i> ");
			
			output("\n\n<i>“Right. No word on escape pods, then?”</i>");
			
			output("\n\n<i>“I’ve got a few on radar,”</i> she says, waving a hand dismissively toward the holomap. <i>“Should be fine until their buddies come pick ‘em up. Tell me you’re not planning on playing rescue mission, right?”</i>");

			clearMenu();
			addButton(0, "Kind", lifeSignsII, "kind");
			addButton(1, "Mischievous", lifeSignsII, "misc");
			addButton(2, "Hard", lifeSignsII, "hard");
		}

		private function menu():void
		{
			clearMenu();
			addButton(0, "Life Signs", lifeSigns);
			addButton(1, "Ship Details", shipDetails);
			addButton(2, "Nova Sec.", novaSecurities);
			addButton(3, "Next", fuckDisGoNext);
		}

		private function lifeSignsII(choice:String):void
		{
			clearOutput();

			if (choice == "kind") output("<i>“I wish we could. But the Nova battlegroup will be back any minute, and I can’t put our crew in danger by sticking around.”</i>");
			else if (choice == "misc") output("<i>“No. Sucks for them, though.”</i>");
			else if (choice == "hard") output("<i>“They’re not our mission. Leave ‘em.”</i>");

			output("\n\nLogan turns and shoots you a slight grin. <i>“My thoughts exactly, Kara. Besides, the more of them out in the pods, the less we’ll have to shoot our way through onboard.”</i>");

			if (choice == "misc")
			{
				output("\n\n<i>“We? Planning kitting up and coming with, lizard-butt?”</i>");
				
				output("\n\nShe laughs. <i>“Sorry. For the REST of you to shoot through. I’m a pilot, not a gunslinger.”</i>");
			}

			menu();
		}

		private function shipDetails():void
		{
			clearOutput();
			setLocation("\nLOGAN");

			output("<i>“So what’re we walking into, Logan?”</i>");
			
			output("\n\nShe shrugs. <i>“Don’t have a hard layout yet. Too much interference from the debris. From the vid Chow sent us, though, it looks like a light corvette. Standard Nova Security gunboat, good for light cargo running, space lane security, other low-intensity work. Lighter and faster than a frigate, not much in the way of arms or armor. Clearly. Nova’s fleet is lousy with them, and they’re used mostly for precious cargo escorts and VIP protection. Not much bigger than the Silence, really.”</i>");
			
			output("\n\n<i>“Anything I should be aware of?”</i>");
			
			output("\n\n<i>“Well, somebody fucking shot it to pieces, so be careful where you step, and what hatches you open. Make sure you keep your magboots on full power, at least. I don’t want you getting sucked out an airlock. Even </i>I<i> might not be able to catch you.”</i>");
			
			output("\n\nLogan reaches up and plants a hand on yours. <i>“Aside from that, Nova goes heavy on security bots and auto turrets. Especially near their precious cargo. The crew might have bailed after they got hit, but there’s a good chance you’ll have to blast through some drones. They’re on automatic, and most run on autistic or no-connect mode, meaning there’s not much you can do but shoot ‘em down. No real way to hack them unless you get hands on, but at that point you might as well just shoot the shits.”</i> ");
			
			output("\n\n<i>“That all?”</i> you ask, giving her hand a squeeze.");
			
			output("\n\n<i>“Well, I’d mention the locks and such, but you’ve got that handled, master thief. Just don’t underestimate the drones, Kara. They’re not much of a threat one on one, but they’ll gang up on you. A corvette like this one could have a couple dozen bots aboard, at least.”</i>");
			
			output("\n\n<i>“I’ll keep that in mind.”</i> ");

			menu();
		}

		private function novaSecurities():void
		{
			clearOutput();
			setLocation("\nLOGAN");
			
			output("<i>“We’ve never knocked over Nova before,”</i> you muse. ");
			
			output("\n\nLogan fidgets. <i>“Yeah. They’re normally a tough nut to crack. Pirates must have had one hell of a surprise shot to have knocked out the gunboat we’re after like that.”</i>");
			
			output("\n\nAfter a moment, you add, <i>“Could have been you out there, you know.”</i> ");
			
			output("\n\n<i>“Nah,”</i> she laughs, reaching down and patting the thick, reptilian tail resting in her lap -- a stark contrast to the mostly human girl sitting in the cockpit. <i>“Nova would have drummed me out for the same damn reason the Fleet did if you and Blackstar hadn’t come along. Mercenary’s wage doesn’t pay for a lot of Throbb... especially when you have to pay for your own meals, and uniform, and all that shit. Plus I was still wanting these,”</i> Logan adds, brushing her frilled, reptilian ears. ");
			
			output("\n\nYou chuckle. <i>“So what, you were already stealing from Nova?”</i>");
			
			output("\n\n<i>“Maybe a little. Well, you know, a couple rifles from the ship’s armory. Maybe some deck schematics and shield emitter designs. I did have access to their whole datavault from the pilot’s console, after all.”</i> ");
			
			output("\n\n<i>“Clever.”</i>");
			
			output("\n\nShe shrugs. <i>“Hey, I never got caught. Would have eventually, but lucky me I found some outlaws who make killer bank before that. Especially after I gave them the codes to get into that spaceport...”</i>");
			
			output("\n\n<i>“... and just so happened to know how to pilot a star shuttle after our old pilot was so hammered he couldn’t see straight,”</i> you finish for her, and you both share a laugh. <i>“If it wasn’t for you, we’d have been done for. Nova doesn’t seem like they take prisoners these days.”</i>");
			
			output("\n\n<i>“Not when you’re leading a running firefight through their space port in the middle of the big Christmas rush.”</i>");
		}

		private function fuckDisGoNext():void
		{
			clearOutput();
			setLocation("\nLOGAN");

			output("<i>“Alright. Take us in, Logan,”</i> you say, planting your hands on the back of her chair, watching as the wreckage of the Nova ship comes into focus. The whole ship trembles as Logan kicks off the LightDrive at just the right second to pull you back to normal speed kilometers off the field of debris surrounding it. A second too soon, and you’d be cruising for hours to get there; too late, and you’d have overshot by hours. ");
			
			output("\n\nThe deck lurches forward as the LightDrive snaps off, and the viewscreen suddenly flashes gold as chunks of sundered hull crash against the navigation shields, tumbling aside as the Silence cruises past. Your ship’s nose clears you a path toward the target, finally brushing aside enough of the floating, tumbling debris for you to get a good look at your objective. ");
			
			output("\n\n<i>“Christ, what </i>happened<i> to it?”</i> Logan breathes as the Nova vessel comes into proper view. You expected to see it torn to shreds by battery fire, and pock-marked by missile craters. Instead, a single wide hole has been punched through it. One shot, straight through the shields, in one side of the hull, and out the other. The crater looks nearly wide enough to fly the Silence into. Most of the debris blown off from the Nova vessel is still drifting away, spreading out in an hourglass shape with the crippled vessel in its center. ");
			
			output("\n\n<i>“What does </i>that<i>?”</i> you add, staring at the hole. <i>“Looks like it just got punched straight through.”</i> ");
			
			output("\n\n<i>“Took some serious firepower to do that. Even to a little corvette.”</i> ");
			
			output("\n\nThe rest of the Nova ships might be in more trouble than you thought... but then again, that just means more time for you and yours to do what needs doing. Logan slowly steers the Silence towards the gaping wound in the hull of the ship, decelerating and bringing up the searchlights, illuminating the hole. Sure enough, through-and-through. ");
			
			output("\n\n<i>“Better get down to the airlock, captain. I should have a... whatever passes for docking right now... set up in a minute.”</i>");
			
			output("\n\nYou pat her on the shoulder and step towards the elevator.");

			clearMenu();
			addButton(0, "Next", actuallyGoNext);
		}

		private function actuallyGoNext():void
		{
			PlayerParty.removeFromParty(logan, true);
			mainGameMenu();
		}
		
	}

}