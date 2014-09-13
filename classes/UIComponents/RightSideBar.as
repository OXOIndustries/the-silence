package classes.UIComponents 
{
	import classes.UIComponents.StatBar;
	import classes.UIComponents.SideBarComponents.AdvancementBlock;
	import classes.UIComponents.SideBarComponents.BigStatBlock;
	import classes.UIComponents.SideBarComponents.CoreStatsBlock;
	import classes.UIComponents.SideBarComponents.StatusEffectsBlock;
	import classes.UIComponents.StatusEffectComponents.StatusEffectsDisplay;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.AntiAliasType;
	
	/**
	 * Should maybe extend a base SideBar but whatevs, makes the code much neater for shared shit.
	 * The bars are designed, primarily, to make layout easier, not do much internally with what they're displaying.
	 * This is how I write most of my UI code and components; the components are designed to go into a container,
	 * and will size themselves to the container; the containers go in a parent for positioning.
	 * @author Gedan
	 */
	public class RightSideBar extends Sprite
	{
		// All of the individual bars are broken out here, because *this* class is where I'd likely configure
		// bindUtils.bindProperty things back out into the game data classes. On load, the load code
		// just sends the PC char to the UI, which passes it into RightSideBar, which configures the DataBinds
		// And then there's no longer a need to manually update all the bars!
		// The idea is UI gets seperated from game logic entirely. All UI cares about is values in Creatures.
		
		/**
		 * Config for lazy init.
		 * @param	doTween	Set the bar to tween in from offscreen during startup
		 */
		public function RightSideBar() 
		{			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * Lazyinit once we've been added to the stage. Means we can get stage references and shit, and everything
		 * will be sized according to the content it contains properly. FUCK DISPLAYLIST FOREVER.
		 * @param	e
		 */
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.BuildBackground();
		}
		
		/**
		 * Build the bar background element
		 */
		private function BuildBackground():void
		{
			this.graphics.beginFill(UIStyleSettings.gForegroundColour, 1);
			this.graphics.drawRect(0, 0, 200, 740);
			this.graphics.endFill();
			
			this.name = "";
			this.x = 1000;
			this.y = 0;
		}
		
		/**
		 * Build the character name header stuff
		 */
		private function BuildCharacterHeader():void
		{

		}
		
		public function hideItems():void
		{

		}
		
		public function showItems():void
		{

		}
		
		public function removeGlows():void
		{

		}
		
		public function resetItems():void
		{

		}
	}

}