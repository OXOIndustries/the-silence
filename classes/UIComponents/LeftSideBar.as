package classes.UIComponents 
{
	import classes.GameData.Ships.Ship;
	import classes.UIComponents.SideBarComponents.PartyBlock;
	import classes.UIComponents.SideBarComponents.ShipInfoDisplay;
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
		private var _playerParty:PartyBlock;
		private var _genInfoBlock:GeneralInfoBlock;
		private var _menuButtonBlock:SideBarButtonBlock;
		private var _playerShipDisplay:ShipInfoDisplay;
				
		public function get timeText():TextField { return _genInfoBlock.time; }
		
		public function get menuButton():SquareButton { return _menuButtonBlock.menuButton; }
		public function get dataButton():SquareButton { return _menuButtonBlock.dataButton; }
		public function get quickSaveButton():SquareButton { return _menuButtonBlock.quickSaveButton; }
		public function get statsButton():SquareButton { return _menuButtonBlock.statsButton; }
		public function get perksButton():SquareButton { return _menuButtonBlock.perksButton; }
		public function get levelUpButton():SquareButton { return _menuButtonBlock.levelUpButton; }
		public function get appearanceButton():SquareButton { return _menuButtonBlock.appearanceButton; }
		
		// Block level access
		public function get partyBlock():PartyBlock { return _playerParty; }
		public function get generalInfoBlock():GeneralInfoBlock { return _genInfoBlock; }
		public function get menuButtonBlock():SideBarButtonBlock { return _menuButtonBlock; }
		public function get playerShipDisplay():ShipInfoDisplay { return _playerShipDisplay; }
		
		public function LeftSideBar() 
		{			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.BuildBackground();
			
			// Player party display
			_playerParty = new PartyBlock(4, "left");
			this.addChild(_playerParty);
			_playerParty.x = 0;
			_playerParty.y = 0;
			
			// Player ship display
			_playerShipDisplay = new ShipInfoDisplay("left");
			this.addChild(_playerShipDisplay);
			_playerShipDisplay.x = 0;
			_playerShipDisplay.y = 0;
			
			// Time/day display shit
			_genInfoBlock = new GeneralInfoBlock();
			this.addChild(_genInfoBlock);
			//_genInfoBlock.y = _miniMapBlock.y + _miniMapBlock.height + 21;
			_genInfoBlock.y = 609;
			
			// Menu button block
			_menuButtonBlock = new SideBarButtonBlock();
			this.addChild(_menuButtonBlock);
			_menuButtonBlock.y = _genInfoBlock.y + _genInfoBlock.height - 46;
			_menuButtonBlock.x = 10;
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
		
		public function setShipData(ship:Ship):void
		{
			_playerShipDisplay.showShip(ship);
		}
		
		public function hideAll():void
		{
			_playerParty.visible = false;
			_playerShipDisplay.visible = false;
		}
		
		public function showParty():void
		{
			_playerParty.visible = true;
		}
		
		public function hideParty():void
		{
			_playerParty.visible = false;
		}
		
		public function showPlayerShip():void
		{
			_playerShipDisplay.visible = true;
		}
		
		public function hidePlayerShip():void
		{
			_playerShipDisplay.visible = false;
		}
	}
}