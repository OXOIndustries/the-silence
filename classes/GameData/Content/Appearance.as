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
			clearOutput2();
			output2("You are Kara Volke, a kaithrit smuggler in the prime of her youth. You stand at an amazonian six-foot-six, with a toned and athletic frame. Your chest proudly sports a pair of EE-cup breasts, each capped with a nipple pierced by a horizontal bar, tucked snugly into your skin-tight top. You have a head of windswept cobalt hair, parted by a pair of cute cat ears lined with silver studs; a pair of feline tails sprout from your behind, curling and wiggling behind you with every step. A gunbelt hangs low on your hips, bearing a heavy-duty plasma caster and the hilt of a hardlight sword, both readily accessible at a moment's notice. Several extra energy cells, a set of security tools, and a long-bladed dagger are all slung on the back of your belt, mostly hidden from view by your tails.");

			//output2("\n\nYou're also wearing a half-skirt that shows plenty of leg -- and a little bit of your black boyshorts if you get careless. Your shorts conceal your hermaphroditism, if only barely. You've got a ten-inch feline cock between your legs, its crown surrounded by soft little nubs. Your balls are held close against you by a tight pouch of sensitive flesh. Beneath them sits your womanhood, its prominent clit pierced by a small golden ring. Your slit is is slick and welcoming, not what you would consider tight anymore thanks to Logan's attentions, but not necessarily loose, either.");

			//output2("\n\nYou have a tight little butthole planted between a pair of big, spankable ass cheeks, right where it belongs.");
		}	
	}
}