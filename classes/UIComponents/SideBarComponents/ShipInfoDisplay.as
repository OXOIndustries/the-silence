package classes.UIComponents.SideBarComponents 
{
	import classes.GameData.Ships.Ship;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.AntiAliasType;
	
	import classes.UIComponents.UIStyleSettings;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class ShipInfoDisplay extends Sprite
	{
		private var _alignment:String = ""
		
		private var _debugBackground:Sprite;
		
		private var _nameHeader:TextField;
		private var _nameUnderline:Sprite;
		
		private var _bustImage:Sprite;
		private var _healthStatus:CircularStatBar;
		private var _capacitorStatus:MiniCircularStatBar;
		private var _reactorStatus:MiniCircularStatBar;
		
		private var _statusEffectContainer:Sprite;	
		
		public function ShipInfoDisplay(alignment:String = "left") 
		{
			_alignment = alignment;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Build();
		}
		
		private function Build():void
		{
			BuildBackground();
			BuildHeader();
			BuildStatBars();
			BuildBustContainer();
			
			showDebug();
		}
		
		private function BuildBackground():void
		{
			_debugBackground = new Sprite();
			//_debugBackground.graphics.beginFill(UIStyleSettings.gForegroundColour);
			_debugBackground.graphics.beginFill(0xFF0000);
			_debugBackground.graphics.drawRect(0, 0, 190, 300);
			_debugBackground.graphics.endFill();
			this.addChild(_debugBackground);
		}
		
		private function BuildHeader():void
		{
			_nameUnderline = new Sprite();
			_nameUnderline.x = (_alignment == "left") ? 0 : 10;
			_nameUnderline.y = 22;
			_nameUnderline.graphics.beginFill(UIStyleSettings.gHighlightColour, 1);
			_nameUnderline.graphics.drawRect(0, 0, 190, 1);
			_nameUnderline.graphics.endFill();
			this.addChild(_nameUnderline);
			
			_nameHeader = new TextField();
			_nameHeader.x = (_alignment == "left") ? 0 : 10;
			_nameHeader.y = 0;
			_nameHeader.width = 190;
			_nameHeader.defaultTextFormat = UIStyleSettings.gStatBlockHeaderFormatter;
			_nameHeader.embedFonts = true;
			_nameHeader.antiAliasType = AntiAliasType.ADVANCED;
			_nameHeader.text = "SHIP NAME";
			_nameHeader.mouseEnabled = false;
			_nameHeader.mouseWheelEnabled = false;
			this.addChild(_nameHeader);
		}
		
		private function BuildStatBars():void
		{
			_healthStatus = new CircularStatBar();
			this.addChild(_healthStatus);
			_healthStatus.x = 90;
			_healthStatus.y = 85;
			
			_capacitorStatus = new MiniCircularStatBar();
			addChild(_capacitorStatus);
			_capacitorStatus.x = 40;
			_capacitorStatus.y = 180;
			
			_reactorStatus = new MiniCircularStatBar();
			addChild(_reactorStatus);
			_reactorStatus.x = 120;
			_reactorStatus.y = 180;
		}
		
		public function showShip(ship:Ship):void
		{
			// HANDLE ME PLS
		}
		
		private function showDebug():void
		{
			_nameHeader.text = "TEST SHIP";
			_healthStatus.setShield(75, 100);
			_healthStatus.setHP(75, 100);
			
			_reactorStatus.setValue(70, 140);
			_capacitorStatus.setValue(70, 140);
		}
		
		private function BuildBustContainer():void
		{
			var bustBackground:Sprite = new Sprite();
			bustBackground.graphics.beginFill(UIStyleSettings.gForegroundColour);
			bustBackground.graphics.drawCircle(0, 0, 48);
			bustBackground.graphics.endFill();
			addChild(bustBackground);
			
			_bustImage = new Sprite();
			addChild(_bustImage);
			_bustImage.x = 136;
			_bustImage.y = 85;
		}
	}

}