package classes.UIComponents 
{
	import classes.UIComponents.SideBarComponents.PartyBlock;
	import classes.UIComponents.StatBar;
	import classes.UIComponents.MiniMap.MiniMap;
	import classes.UIComponents.SideBarComponents.LocationHeader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import classes.UIComponents.SideBarComponents.MiniMapBlock;
	import classes.UIComponents.SideBarComponents.GeneralInfoBlock;
	import classes.UIComponents.SideBarComponents.SideBarButtonBlock;
	import classes.UIComponents.StatusEffectComponents.StatusEffectsDisplay;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class LeftSideBar extends Sprite
	{
		private var _doTween:Boolean;
		
		private var _locationHeader:LocationHeader;
		private var _playerParty:PartyBlock;
		private var _genInfoBlock:GeneralInfoBlock;
		private var _menuButtonBlock:SideBarButtonBlock;
		
		public function get roomText():TextField { return _locationHeader.roomText; }
		public function get planetText():TextField { return _locationHeader.planetText; }
		public function get systemText():TextField { return _locationHeader.systemText; }
		
		public function get timeText():TextField { return _genInfoBlock.time; }
		public function get daysText():TextField { return _genInfoBlock.days; }
		
		public function get menuButton():SquareButton { return _menuButtonBlock.menuButton; }
		public function get dataButton():SquareButton { return _menuButtonBlock.dataButton; }
		public function get quickSaveButton():SquareButton { return _menuButtonBlock.quickSaveButton; }
		public function get statsButton():SquareButton { return _menuButtonBlock.statsButton; }
		public function get perksButton():SquareButton { return _menuButtonBlock.perksButton; }
		public function get levelUpButton():SquareButton { return _menuButtonBlock.levelUpButton; }
		public function get appearanceButton():SquareButton { return _menuButtonBlock.appearanceButton; }
		
		// Block level access
		public function get locationBlock():LocationHeader { return _locationHeader; }
		public function get partyBlock():PartyBlock { return _playerParty; }
		public function get generalInfoBlock():GeneralInfoBlock { return _genInfoBlock; }
		public function get menuButtonBlock():SideBarButtonBlock { return _menuButtonBlock; }
		
		public function LeftSideBar(doTween:Boolean = true) 
		{
			_doTween = doTween;
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.BuildBackground();
			
			// The location
			_locationHeader = new LocationHeader();
			this.addChild(_locationHeader);
			_locationHeader.x = 0;
			_locationHeader.y = 0;
			
			// Player party display
			_playerParty = new PartyBlock(3, "left");
			this.addChild(_playerParty);
			_playerParty.x = 0;
			_playerParty.y = _locationHeader.y + _locationHeader.height - 20;
			
			// Time/day display shit
			_genInfoBlock = new GeneralInfoBlock();
			this.addChild(_genInfoBlock);
			//_genInfoBlock.y = _miniMapBlock.y + _miniMapBlock.height + 21;
			_genInfoBlock.y = 581;
			
			// Menu button block
			_menuButtonBlock = new SideBarButtonBlock();
			this.addChild(_menuButtonBlock);
			_menuButtonBlock.y = _genInfoBlock.y + _genInfoBlock.height - 17;
			_menuButtonBlock.x = 10;
		}
		
		private function moveToFinalPosition(e:Event):void
		{
			this.x = 0;
		}
		
		private function BuildBackground():void
		{
			this.graphics.beginFill(UIStyleSettings.gForegroundColour, 1);
			this.graphics.drawRect(0, 0, 200, 740);
			this.graphics.endFill();
			
			this.name = "";
			this.x = 0;
			this.y = 0;
		}
		
		public function setPartyData(party:Array):void
		{
			_playerParty.showParty(party);
		}
		
		public function hideLocation():void
		{
			this._locationHeader.hideLocationText();
		}
		
		public function showLocation():void
		{
			this._locationHeader.showLocationText();
		}
		
		public function hideAll():void
		{
			this._locationHeader.hideLocationText();
			_playerParty.visible = false;
		}
		
		public function showParty():void
		{
			_playerParty.visible = true;
		}
	}
}