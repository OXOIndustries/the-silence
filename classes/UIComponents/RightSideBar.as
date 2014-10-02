package classes.UIComponents 
{
	import classes.UIComponents.MiniMap.MiniMap;
	import classes.UIComponents.SideBarComponents.LocationHeader;
	import classes.UIComponents.SideBarComponents.MiniMapBlock;
	import classes.UIComponents.StatBar;
	import classes.UIComponents.SideBarComponents.StatusEffectsBlock;
	import classes.UIComponents.StatusEffectComponents.StatusEffectsDisplay;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.AntiAliasType;
	import classes.UIComponents.SideBarComponents.PartyBlock;
	
	/**
	 * Should maybe extend a base SideBar but whatevs, makes the code much neater for shared shit.
	 * The bars are designed, primarily, to make layout easier, not do much internally with what they're displaying.
	 * This is how I write most of my UI code and components; the components are designed to go into a container,
	 * and will size themselves to the container; the containers go in a parent for positioning.
	 * @author Gedan
	 */
	public class RightSideBar extends Sprite
	{
		private var _locationHeader:LocationHeader;
		private var _enemyParty:PartyBlock;
		private var _minimapBlock:MiniMapBlock;
		
		public function get minimap():MiniMap { return _minimapBlock.miniMap; }
		
		public function get roomText():TextField { return _locationHeader.roomText; }
		public function get planetText():TextField { return _locationHeader.planetText; }
		public function get systemText():TextField { return _locationHeader.systemText; }
		
		public function get locationBlock():LocationHeader { return _locationHeader; }
				
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
			
			// Location Header
			_locationHeader = new LocationHeader("right");
			addChild(_locationHeader);
			_locationHeader.x = 0;
			_locationHeader.y = 0;
			
			// Enemy party container
			_enemyParty = new PartyBlock(5, "right");
			this.addChild(_enemyParty);
			_enemyParty.x = 0;
			_enemyParty.y = _locationHeader.y + _locationHeader.height;
			
			// Minimap Container
			_minimapBlock = new MiniMapBlock("right");
			this.addChild(_minimapBlock);
			_minimapBlock.x = 0;
			_minimapBlock.y = _locationHeader.y + _locationHeader.height;
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
		
		public function setPartyData(party:Array):void
		{
			_enemyParty.showParty(party);
		}
		
		public function showParty():void
		{
			_enemyParty.visible = true;
			_minimapBlock.visible = false;
		}
		
		public function hideParty():void
		{
			_enemyParty.visible = false;
		}
		
		public function showMinimap():void
		{
			_enemyParty.visible = false;
			_minimapBlock.visible = true;
		}
		
		public function hideMinimap():void
		{
			_minimapBlock.visible = false;
		}
		
		public function hideAll():void 
		{
			_locationHeader.hideLocationText();
			_enemyParty.visible = false;
			_minimapBlock.visible = false;
		}
		
		public function hideLocation():void
		{
			_locationHeader.hideLocationText();
		}
		
		public function showLocation():void
		{
			_locationHeader.showLocationText();
		}
	}

}