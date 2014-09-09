package classes.GameData.Content 
{
	import classes.Creature;
	import flash.events.MouseEvent;
	import classes.GameData.CharacterIndex;
	/**
	 * ...
	 * @author Gedan
	 */
	public class Appearance extends BaseContent
	{
		// UI Router for the appearance button
		public function pcAppearance(e:MouseEvent = null):void 
		{
			if (!userInterface.appearanceButton.isActive)
			{
				return;
			}
			else if (userInterface.showingPCAppearance)
			{
				userInterface.showPrimaryOutput();
				userInterface.showingPCAppearance = false;
			}
			else
			{
				userInterface.showSecondaryOutput();
				userInterface.appearanceButton.Glow();
				appearance(CharacterIndex.pc);
				userInterface.showingPCAppearance = true;
			}
		}
		
		public function appearance(target:Creature):void
		{
			output2("Stuff");
		}	
	}
}