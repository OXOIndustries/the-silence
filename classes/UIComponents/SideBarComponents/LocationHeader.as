package classes.UIComponents.SideBarComponents 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import classes.UIComponents.UIStyleSettings;
	import flash.text.AntiAliasType;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class LocationHeader extends Sprite
	{
		private var _roomBlock:Sprite;
		private var _roomText:TextField;
		
		private var _planetBlock:Sprite;
		private var _planetText:TextField;
		
		private var _systemBlock:Sprite;
		private var _systemText:TextField;
		
		public function get roomText():TextField { return _roomText; }
		public function get planetText():TextField { return _planetText; }
		public function get systemText():TextField { return _systemText; }
		
		public function LocationHeader() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.BuildBlocks();
		}
		
		private function BuildBlocks():void
		{
			// Background Elements
			_roomBlock = new Sprite();
			_roomBlock.graphics.beginFill(UIStyleSettings.gHighlightColour, 1);
			_roomBlock.graphics.drawRect(0, 0, 189, 78);
			_roomBlock.graphics.endFill();
			
			this.addChild(_roomBlock);
			
			_roomBlock.x = 0;
			_roomBlock.y = 5;
			
			_planetBlock = new Sprite();
			_planetBlock.graphics.beginFill(UIStyleSettings.gHighlightColour, 1);
			_planetBlock.graphics.drawRect(0, 0, 189, 20);
			_planetBlock.graphics.endFill();
			
			this.addChild(_planetBlock);
			
			_planetBlock.x = Math.floor(_roomBlock.x);
			_planetBlock.y = Math.floor(_roomBlock.y + _roomBlock.height + 6);
			
			_systemBlock = new Sprite();
			_systemBlock.graphics.beginFill(UIStyleSettings.gHighlightColour, 1);
			_systemBlock.graphics.drawRect(0, 0, 189, 20);
			_systemBlock.graphics.endFill();
			
			this.addChild(_systemBlock);
			
			_systemBlock.x = Math.floor(_planetBlock.x);
			_systemBlock.y = Math.floor(_planetBlock.y + _planetBlock.height + 6);
			
			// Text Elements
			_roomText = new TextField();
			_roomText.x = _roomBlock.x + 5;
			_roomText.y = _roomBlock.y + 70; // Was 60, should probably do something different though, an anchor to roomBlock.y, set height to same and textAlign from bottom?
			_roomText.width = 179;
			_roomText.height = 90;
			_roomText.defaultTextFormat = UIStyleSettings.gLocationBlockRoomFormatter;
			_roomText.embedFonts = true;
			_roomText.antiAliasType = AntiAliasType.ADVANCED;
			_roomText.text = "";
			_roomText.multiline = true;
			_roomText.wordWrap = false;
			_roomText.mouseEnabled = false;
			_roomText.mouseWheelEnabled = false;
			_roomText.filters = [UIStyleSettings.gRoomLocationTextGlow];
			
			this.addChild(_roomText);
			
			_planetText = new TextField();
			_planetText.x = _planetBlock.x + 5;
			_planetText.y = _planetBlock.y - 4;
			_planetText.width = 179;
			_planetText.height = 28;
			_planetText.defaultTextFormat = UIStyleSettings.gLocationBlockPlanetSystemFormatter;
			_planetText.embedFonts = true;
			_planetText.antiAliasType = AntiAliasType.ADVANCED;
			_planetText.text = "";
			_planetText.multiline = false;
			_planetText.wordWrap = false;
			_planetText.mouseEnabled = false;
			_planetText.mouseWheelEnabled = false;
			
			this.addChild(_planetText);
			
			_systemText = new TextField();
			_systemText.x = _systemBlock.x + 5;
			_systemText.y = _systemBlock.y - 4;
			_systemText.width = 179;
			_systemText.height = 28;
			_systemText.defaultTextFormat = UIStyleSettings.gLocationBlockPlanetSystemFormatter;
			_systemText.embedFonts = true;
			_systemText.antiAliasType = AntiAliasType.ADVANCED;
			_systemText.text = "";
			_systemText.multiline = false;
			_systemText.wordWrap = false;
			_systemText.mouseEnabled = false;
			_systemText.mouseWheelEnabled = false;
			
			this.addChild(_systemText);
		}
		
		// Actually, using this, I can do some simple asset/sprite stacking to enable
		// multiple busts to be displayed, layered on top of each other (similar to ZilPack),
		// without having to have unique assets for each one; or, say, we have random groups of things!
		
		/**
		 * Pass in the name of the character bust to display.
		 * Presently, this is using the "old" system of a capitalised string index to find a bust;
		 * it should probably be refactored to instead use the shortName variable(s) of the busts chosen
		 * for display.
		 * Any index NOT found will hide the bust, ergo "hide", "none" "somebustthatdoesntexist" will
		 * all hide the bust display.
		 * 
		 * Currently, the RIVAL images won't be displayed. I'll fix it when I've rigged everything else up.
		 * @param	args 	Multiple string args targetting bust image classes
		 */
		
		public function hideLocationText():void
		{
			_roomText.visible = false;
			_planetText.visible = false;
			_systemText.visible = false;
		}
		
		public function showLocationText():void
		{
			_roomText.visible = true;
			_planetText.visible = true;
			_systemText.visible = true;
		}
	}

}