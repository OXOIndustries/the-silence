package classes.UIComponents.SideBarComponents 
{
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
		private var _reactorStatus:MiniCirularStatBar;
		
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
		}
		
		private function BuildBackground():void
		{
			_debugBackground = new Sprite();
			_debugBackground.graphics.beginFill(UIStyleSettings.gForegroundColour);
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
			_nameHader.text = "SHIP NAME";
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
			
		}
	}

}