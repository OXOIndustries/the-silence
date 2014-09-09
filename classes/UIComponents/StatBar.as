package classes.UIComponents 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.AntiAliasType;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class StatBar extends Sprite
	{
		public static const MODE_BIG:String = "BIG";
		public static const MODE_SMALL:String = "SMALL";
		
		private var _desiredMode:String;
		
		public var highBad:Boolean = false;
		
		private var _values:TextField;
		private var _cap:TextField;
		
		private var _masks:Sprite; // Masks contains at least a text field + "scan bar" to hide the main bar.
		private var _maskBar:Sprite;
		private var _mainBar:Sprite;
		
		public function set caption(v:String):void
		{
			_cap.text = v;
		}
		
		public function set value(v:String):void
		{
			_values.text = v;
		}
		
		public function disableBar():void
		{
			_maskBar.visible = false;
			_mainBar.visible = false;
		}
		
		public function StatBar(mode:String) 
		{
			_desiredMode = mode;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Build();
		}
		
		private function Build()
		{
			if (_desiredMode == "BIG")
			{
				BuildBig();
			}
			else
			{
				BuildSmall();
			}
		}
		
		private function BuildBig():void
		{
			_mainBar = new Sprite();
			_mainBar.graphics.beginFill(UIStyleSettings.gHighlightColour);
			_mainBar.graphics.drawRect(0, 0, 179, 35);
			_mainBar.graphics.endFill();
			this.addChild(_mainBar);
			
			_maskBar = new Sprite();
			_maskBar.graphics.beginFill(UIStyleSettings.gForegroundColour);
			_maskBar.graphics.drawRect(0, 0, 180, 35);
			_maskBar.graphics.endFill();
			_maskBar.graphics.beginFill(UIStyleSettings.gBackgroundColour);
			_maskBar.graphics.drawRect(180, 0, 180, 35);
			_maskBar.graphics.endFill();
			this.addChild(_maskBar);
			
			_masks = new Sprite();
			_masks.y -11.5;
			this.addChild(_masks);
			_maskBar.mask = _masks;
			
			_cap = new TextField();
			_cap.width = 102;
			_cap.height = 59;
			_cap.defaultTextFormat = UIStyleSettings.gBigStatBarTextFormat;
			_cap.embedFonts = true;
			_cap.antiAliasType = AntiAliasType.ADVANCED;
			_cap.text = "HP";
			_masks.addChild(_cap);
			
			_values = new TextField();
			_values.width = 126;
			_values.height = 40;
			_values.x = 53.25;
			_values.y = -2.75;
			_values.defaultTextFormat = UIStyleSettings.gBigStatBarValueFormat;
			_values.embedFonts = true;
			_values.antiAliasType = AntiAliasType.ADVANCED;
			_values.text = "2047";
			this.addChild(_values);
		}
		
		private function BuildSmall():void
		{
			_mainBar = new Sprite();
			_mainBar.graphics.beginFill(UIStyleSettings.gHighlightColour);
			_mainBar.graphics.drawRect(0, 0, 179, 24);
			_mainBar.graphics.endFill();
			this.addChild(_mainBar);
			
			_maskBar = new Sprite();
			_maskBar.graphics.beginFill(UIStyleSettings.gForegroundColour);
			_maskBar.graphics.drawRect(0, 0, 180, 24);
			_maskBar.graphics.endFill();
			_maskBar.graphics.beginFill(UIStyleSettings.gBackgroundColour);
			_maskBar.graphics.drawRect(180, 0, 180, 24);
			_maskBar.graphics.endFill();
			this.addChild(_maskBar);
			
			_masks = new Sprite();
			_masks.y -8.3;
			this.addChild(_masks);
			_maskBar.mask = _masks;
			
			_cap = new TextField();
			_cap.width = 137;
			_cap.height = 41.25;
			_cap.defaultTextFormat = UIStyleSettings.gSmallStatBarTextFormat;
			_cap.embedFonts = true;
			_cap.antiAliasType = AntiAliasType.ADVANCED;
			_cap.text = "HP";
			_masks.addChild(_cap);
			
			_values = new TextField();
			_values.width = 164;
			_values.height = 29.9;
			_values.x = 15.25;
			_values.y = -2.75;
			_values.defaultTextFormat = UIStyleSettings.gSmallStatBarValueFormat;
			_values.embedFonts = true;
			_values.antiAliasType = AntiAliasType.ADVANCED;
			_values.text = "2047";
			this.addChild(_values);
		}
		
		public function clearGlo():void
		{
			
		}
		
		public function resetBar():void
		{
			
		}
		
		public function setMax(arg:Number):void
		{
			
		}
		
		public function setGoal(arg:Number):void
		{
			
		}
		
		public function getGoal():Number
		{
			return 0;
		}
	}

}