package classes.UIComponents.SideBarComponents 
{
	import classes.GameData.Ships.Ship;
	import classes.GameData.StatusEffect;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.AntiAliasType;
	
	import classes.UIComponents.UIStyleSettings;
	import classes.Resources.Busts.StaticRenders;
	import flash.display.Bitmap;
	
	import classes.Resources.StatusIcons;
	
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
		
		private var _statusEffectDisplay:StatusEffectsBlock;
		
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
			BuildStatusEffects();
			
			showDebug();
		}
		
		private function BuildBackground():void
		{
			_debugBackground = new Sprite();
			_debugBackground.graphics.beginFill(UIStyleSettings.gForegroundColour);
			//_debugBackground.graphics.beginFill(0xFF0000);
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
			_healthStatus.x = 100;
			_healthStatus.y = 85;
			
			_capacitorStatus = new MiniCircularStatBar(35, 5, UIStyleSettings.gHighlightColour);
			addChild(_capacitorStatus);
			_capacitorStatus.x = 37;
			_capacitorStatus.y = 161;
			_capacitorStatus.setLabel("CAP");
			
			_reactorStatus = new MiniCircularStatBar(35, 5, UIStyleSettings.gHighlightColour);
			addChild(_reactorStatus);
			_reactorStatus.x = 163;
			_reactorStatus.y = 161;
			_reactorStatus.setLabel("RCT");
		}
		
		private function BuildStatusEffects():void
		{
			_statusEffectDisplay = new StatusEffectsBlock(false);
			_statusEffectDisplay.y = 210;
			addChild(_statusEffectDisplay);
		}
		
		public function showShip(ship:Ship):void
		{
			_healthStatus.setShield(ship.actualShieldHP, ship.maxShieldHP());
			_healthStatus.setHP(ship.actualHullHP, ship.maxHullHP());
			
			_reactorStatus.setValue(ship.reactorModule.powerGenerated, ship.reactorModule.powerGenerated);
			_capacitorStatus.setValue(ship.actualCapacitorCharge, ship.capacitorModule.powerStorage);
			
			_statusEffectDisplay.statusDisplay.updateDisplay(ship.statusEffects);
		}
		
		private function showDebug():void
		{
			_nameHeader.text = "TEST SHIP";
			_healthStatus.setShield(75, 100);
			_healthStatus.setHP(75, 100);
			
			_reactorStatus.setValue(140, 140);
			_capacitorStatus.setValue(140, 140);
			
			ShowBust(StaticRenders.MISSING);
			
			var testEffects:Object = { }
			testEffects["TestEffect"] = new StatusEffect("TestEffect", { }, 100, StatusEffect.DURATION_TIME, StatusIcons.DefenseUp, false, false, "", "");
			_statusEffectDisplay.statusDisplay.updateDisplay(testEffects);
			
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
			_bustImage.x = 100;
			_bustImage.y = 85;
			
			bustBackground.x = _bustImage.x;
			bustBackground.y = _bustImage.y;
			
			var bustMask:Sprite = new Sprite();
			bustMask.graphics.beginFill(0xFFFFFF);
			bustMask.graphics.drawCircle(0, 0, 45);
			bustMask.graphics.endFill();
			bustMask.x = _bustImage.x;
			bustMask.y = _bustImage.y;
			
			addChild(bustMask);
			_bustImage.mask = bustMask;
		}
		
		private function ShowBust(bustT:Class):void
		{
			if (_bustImage == null) return;
			
			if (_bustImage.numChildren == 1)
			{
				if (_bustImage.getChildAt(0) is bustT)
				{
					return;
				}
				else
				{
					_bustImage.removeChildAt(0);
				}
			}
			
			var bust:Bitmap = new bustT();
			bust.smoothing = true;
			
			_bustImage.addChild(bust);
			
			bust.x -= bust.width / 2;
			bust.y -= bust.height / 2;
		}
	}
}