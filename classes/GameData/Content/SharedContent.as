package classes.GameData.Content 
{
	import classes.GameData.CombatManager;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class SharedContent extends BaseContent
	{
		
		public function SharedContent() 
		{
			
		}
		
		public function combatLossScene():void
		{
			if (flags["LOST_COMBAT"] == undefined)
			{
				firstCombatLoss();
				flags["LOST_COMBAT"] = 1;
			}
			else
			{
				repeatCombatLoss();
			}
		}
		
		private function firstCombatLoss():void
		{
			clearOutput();
			output("<i>“Dammit, no,”</i> you snap, striking a fist on the table. <i>“Stop putting words in my mouth, Chow, that’s <i>not</i> how it happened.”</i>");
			
			output("\n\nThe old dragon-faced bastard chuckles, hands up in a disarming gesture. <i>“Calm yourself, Captain. You and I both know how this story ends, after all.”</i>");
			
			output("\n\nYou bite back a response, rubbing the scars on your cheeks, still fresh and sore. Even with the hospital’s best tech, it’ll take days for them to heal. <i>“Yeah. Don’t remind me. But not like that... no, it didn’t end so quickly. There’s still more to tell.”</i>");
			
			output("\n\n<i>“Then please,”</i> Chow says, waving you on. As he does so, a nurse glides in, delivering a tall drink to your erstwhile employer. <i>“Continue. I want to hear the whole story. You owe me that much, </i>Captain<i>.”</i>");
			
			output("\n\nYou wince at the jab, but continue your story. <i>“As I was saying, we got farther than that...”</i>");

			// [Continue...]
			// "Reset" the combat container for another go-round.
			clearMenu();
			addButton(0, "Continue...", CombatManager.resetCombat);
		}
		
		private function repeatCombatLoss():void
		{
			clearOutput();
			output("<i>“No, no, that’s not how it happened!”</i> you groan, rubbing your head. God, it hurts to think... <i>“We did better. A lot better.”</i>");
			
			output("\n\n<i>“Then tell me,”</i> Chow growls, leaning back in his chair. <i>“I want to hear the whole story.”</i>");

			//[Continue...]
			clearMenu();
			addButton(0, "Continue...", CombatManager.resetCombat);
		}
	}
}