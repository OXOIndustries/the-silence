package classes.UIComponents.SideBarComponents 
{
	import classes.Creature;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import classes.UIComponents.UIStyleSettings;
	import flash.text.AntiAliasType;
	import classes.Resources.Busts.StaticRenders;
	import classes.StringUtil;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class CharacterInfoDisplay extends Sprite
	{
		private var _alignment:String = "";
		
		private var _debugBackground:Sprite;
		
		private var _nameHeader:TextField;
		private var _nameHeaderUnderline:Sprite;
		
		private var _bustImage:Sprite;
		private var _circleStats:CircularStatBar;
		private var _statusEffects:Sprite;
		
		public function CharacterInfoDisplay(alignment:String = "left") 
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
			// Colorised background to check boundary
			//BuildDebugBackground();
			BuildBackground();
			
			BuildHeader();
			BuildStatBars();
			BuildBustContainer();
			
			// Default testing data for devwork.
			ShowDebugInfo();
		}
		
		private function BuildDebugBackground():void
		{
			_debugBackground = new Sprite();
			_debugBackground.graphics.beginFill(0xFF0000);
			_debugBackground.graphics.drawRect(0, 0, 190, 145);
			_debugBackground.graphics.endFill();
			this.addChild(_debugBackground);
		}
		
		private function BuildBackground():void
		{
			_debugBackground = new Sprite();
			_debugBackground.graphics.beginFill(UIStyleSettings.gForegroundColour);
			_debugBackground.graphics.drawRect(0, 0, 190, 145);
			_debugBackground.graphics.endFill();
			this.addChild(_debugBackground);
		}
		
		private function BuildHeader():void
		{
			_nameHeaderUnderline = new Sprite();
			_nameHeaderUnderline.x = (_alignment == "left") ? 0 : 10;
			_nameHeaderUnderline.y = 22;
			_nameHeaderUnderline.graphics.beginFill(UIStyleSettings.gHighlightColour, 1);
			_nameHeaderUnderline.graphics.drawRect(0, 0, 190, 1);
			_nameHeaderUnderline.graphics.endFill();
			this.addChild(_nameHeaderUnderline);
			
			_nameHeader = new TextField();
			_nameHeader.x = (_alignment == "left") ? 0 : 10;
			_nameHeader.y = 0;
			_nameHeader.width = 190;
			_nameHeader.defaultTextFormat = UIStyleSettings.gStatBlockHeaderFormatter;
			_nameHeader.embedFonts = true;
			_nameHeader.antiAliasType = AntiAliasType.ADVANCED;
			_nameHeader.text = "CHARACTER NAME";
			_nameHeader.mouseEnabled = false;
			_nameHeader.mouseWheelEnabled = false;
			this.addChild(_nameHeader);			
		}
		
		private function BuildBustContainer():void
		{
			var bustBackground:Sprite = new Sprite();
			bustBackground.graphics.beginFill(UIStyleSettings.gForegroundColour);
			bustBackground.graphics.drawCircle(0, 0, 48);
			bustBackground.graphics.endFill();
			this.addChild(bustBackground);
			
			_bustImage = new Sprite();
			this.addChild(_bustImage);
			
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
			
			this.addChild(bustMask);
			_bustImage.mask = bustMask;
		}
		
		private function BuildStatBars():void
		{
			_circleStats = new CircularStatBar();
			this.addChild(_circleStats);
			
			_circleStats.x = 100;
			_circleStats.y = 85;
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
		
		private function ShowDebugInfo():void
		{
			ShowBust(StaticRenders.CREW_LOGAN);
			_circleStats.setShield(100, 100);
			_circleStats.setHP(100, 100);
		}
		
		public function showCharacter(tar:Creature):void
		{
			ShowBust(tar.bustT);
			_nameHeader.text = tar.long.toUpperCase();
			_circleStats.setShield(tar.shields(), tar.shieldsMax());
			_circleStats.setHP(tar.HP(), tar.HPMax());
		}
	}
}