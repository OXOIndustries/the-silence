package classes.UIComponents.SideBarComponents 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Graphics;
	import flash.text.TextField;
	import classes.UIComponents.UIStyleSettings;
	import flash.text.AntiAliasType;
	
	/**
	 * I made the "big" version scalable properly.......... but it's designed to nest two bars together, which isn't
	 * what I want for this.
	 * @author Gedan
	 */
	public class MiniCircularStatBar extends Sprite
	{
		private var _radius:int;
		private var _thickness:int;
		private var _color:uint;
		
		private var _bar:Sprite;
		private var _barMask:Sprite;
		
		private var _speed:Number = 0.01;
		
		private var _valueCurrent:Number;
		private var _valueTarget:int;
		private var _valueMax:int;
		
		private var _barText:TextField;
		
		public function MiniCircularStatBar(radius:int = 35, thickness:int = 5, color:uint = 0xFF0000) 
		{
			_radius = radius;
			_thickness = thickness;
			_color = color;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, UpdateDisplay);
			
			Build();
			BuildMiddle();
		}
		
		private function Build():void
		{
			var barBack:Sprite = new Sprite();
			barBack.graphics.beginFill(UIStyleSettings.gBackgroundColour);
			barBack.graphics.drawCircle(0, 0, _radius);
			barBack.graphics.endFill();
			addChild(barBack);
			
			_bar = new Sprite();
			_bar.graphics.beginFill(_color);
			_bar.graphics.drawCircle(0, 0, _radius);
			_bar.graphics.endFill();
			addChild(_bar);
			
			_barMask = new Sprite();
			addChild(_barMask);
			_bar.mask = _barMask;
		}
		
		private function BuildMiddle():void
		{
			var bkg:Sprite = new Sprite();
			bkg.graphics.beginFill(UIStyleSettings.gForegroundColour);
			bkg.graphics.drawCircle(0, 0, _radius - (_thickness * 2));
			bkg.graphics.endFill();
			addChild(bkg);
			
			_barText = new TextField();
			_barText.width = (_radius * 2) - (_thickness * 2);
			_barText.defaultTextFormat = UIStyleSettings.gShipSystemFormatter;
			_barText.embedFonts = true;
			_barText.antiAliasType = AntiAliasType.ADVANCED;
			_barText.text = "SYS";
			_barText.mouseEnabled = false;
			_barText.mouseWheelEnabled = false;
			addChild(_barText);
			_barText.x = -(_barText.width / 2);
			_barText.y = -(_bar.height / 2 ) + (_barText.textHeight / 2);
		}
		
		public function setValue(current:int, max:int):void
		{
			if (current > max) current = max;
			
			_valueMax = max;
			_valueTarget = Math.min(Math.max(current, 0), max);
		}
		
		private function UpdateDisplay(e:Event):void
		{
			var newValueP:Number = (_valueTarget / _valueMax) * 0.75;
			
			if (newValueP != _valueCurrent)
			{
				if (newValueP < _valueCurrent)
				{
					if (newValueP < _valueCurrent - _speed)
					{
						_valueCurrent -= _speed;
					}
					else
					{
						_valueCurrent = newValueP;
					}
				}
				else
				{
					if (newValueP > _valueCurrent + _speed)
					{
						_valueCurrent += _speed;
					}
					else
					{
						_valueCurrent = newValueP;
					}
				}
				
				RenderDisplay(_valueCurrent);
			}
		}
		
		private function RenderDisplay(percentage:Number):void
		{
			_barMask.graphics.clear();
			_barMask.graphics.beginFill(0x0000FF, 0.5);
			
			drawPieMask(_barMask.graphics, percentage, 61, 0, 0, 135 * (Math.PI/180), 8);
			
			_barMask.graphics.endFill();
		}
		
		private function drawPieMask(graphics:Graphics, percentage:Number, radius:Number = 50, x:Number = 0, y:Number = 0, rotation:Number = 0, sides:int = 6):void
		{
			// graphics should have its beginFill function already called by now
			graphics.moveTo(x, y);
			if (sides < 3) sides = 3; // 3 sides minimum
			// Increase the length of the radius to cover the whole target
			radius /= Math.cos(1/sides * Math.PI);
			// Shortcut function
			var lineToRadians:Function = function(rads:Number):void {
				graphics.lineTo(Math.cos(rads) * radius + x, Math.sin(rads) * radius + y);
			};
			// Find how many sides we have to draw
			var sidesToDraw:int = Math.floor(percentage * sides);
			for (var i:int = 0; i <= sidesToDraw; i++)
			lineToRadians((i / sides) * (Math.PI * 2) + rotation);
			// Draw the last fractioned side
			if (percentage * sides != sidesToDraw)
			lineToRadians(percentage * (Math.PI * 2) + rotation);
		}
		
		public function setLabel(v:String):void
		{
			_barText.text = v;
		}
	}
}