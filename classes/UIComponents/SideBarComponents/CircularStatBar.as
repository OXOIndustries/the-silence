package classes.UIComponents.SideBarComponents 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Graphics;
	import classes.UIComponents.UIStyleSettings;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class CircularStatBar extends Sprite
	{
		private var _radius:int;
		private var _thickness:int;
		
		private var _shieldsHalf:Sprite;
		private var _hpHalf:Sprite;
		
		private var _shieldMask:Sprite;
		private var _hpMask:Sprite;
		
		private var _speed:Number = 0.01;
		
		private var _shieldCurrent:Number;
		private var _shieldTarget:int;
		private var _shieldMax:int;
		
		private var _hpCurrent:Number;
		private var _hpTarget:int;
		private var _hpMax:int;
		
		public function CircularStatBar(radius:int = 59) 
		{
			_radius = radius;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, UpdateDisplay);
			
			Build();
		}
		
		private function Build():void
		{
			var barBack:Sprite = new Sprite();
			barBack.graphics.beginFill(UIStyleSettings.gBackgroundColour);
			barBack.graphics.drawCircle(0, 0, _radius);
			barBack.graphics.endFill();
			addChild(barBack);
			
			_shieldsHalf = new Sprite();
			_shieldsHalf.graphics.beginFill(0x3FA9F5);
			_shieldsHalf.graphics.drawCircle(0, 0, _radius);
			_shieldsHalf.graphics.endFill();
			addChild(_shieldsHalf);
			
			_hpHalf = new Sprite();
			_hpHalf.graphics.beginFill(0x7AC943);
			_hpHalf.graphics.drawCircle(0, 0, _radius);
			_hpHalf.graphics.endFill();			
			addChild(_hpHalf);
			
			_shieldMask = new Sprite();
			addChild(_shieldMask);
			_shieldsHalf.mask = _shieldMask;
			
			_hpMask = new Sprite();
			addChild(_hpMask);
			_hpHalf.mask = _hpMask;
		}
		
		public function setShield(current:int, max:int):void 
		{
			if (current > max) current = max;
			
			_shieldMax = max;
			_shieldTarget = Math.min(Math.max(current, 0), max);
		}
		
		public function setHP(current:int, max:int):void
		{
			if (current > max) current = max;
			
			_hpMax = max;
			_hpTarget = Math.min(Math.max(current, 0), max);
		}
		
		private function UpdateDisplay(e:Event):void
		{
			var tSpeed:Number = _speed;
			
			if (_skipAnimation)
			{
				tSpeed = 100;
				_skipAnimation = false;
			}
			
			// The update functions don't cap at 1 -- we're using semicircles, so 100% == 0.5;
			var newShieldP:Number = (_shieldTarget / _shieldMax) / 2;
			
			if (newShieldP != _shieldCurrent)
			{
				if (newShieldP < _shieldCurrent) 
				{
					if (newShieldP < _shieldCurrent - tSpeed)
					{
						_shieldCurrent -= tSpeed;
					}
					else
					{
						_shieldCurrent = newShieldP;
					}
				}
				else 
				{
					if (newShieldP > _shieldCurrent + tSpeed)
					{
						_shieldCurrent += tSpeed;
					}
					else
					{
						_shieldCurrent = newShieldP;
					}
				}
				
				UpdateShield(_shieldCurrent);
			}
			
			var newHPP:Number = (_hpTarget / _hpMax) / 2;
			
			// If the number is different
			if (newHPP != _hpCurrent)
			{
				// If we're going lower
				if (newHPP < _hpCurrent)
				{
					// If the new number doesn't pass the target
					if (newHPP < _hpCurrent - tSpeed)
					{
						_hpCurrent -= tSpeed;
					}
					// otherwise set to the target
					else
					{
						_hpCurrent = newHPP;
					}
				}
				// otherwise if we're going higher
				else
				{
					// If the new number doesn't pass the target
					if (newHPP > _hpCurrent + tSpeed)
					{
						_hpCurrent += tSpeed;
					}
					// otherwise set to the target
					else
					{
						_hpCurrent = newHPP;
					}
				}
			}
			
			UpdateHP(_hpCurrent);
		}
		
		private function UpdateShield(percentage:Number):void
		{
			_shieldMask.graphics.clear();
			_shieldMask.graphics.beginFill(0x0000FF, 0.5);
			_shieldMask.graphics.moveTo(0, 0);
			
			var drawPieMask:Function = function(graphics:Graphics, percentage:Number, radius:Number = 50, x:Number = 0, y:Number = 0, rotation:Number = 0, sides:int = 6):void
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
			
			drawPieMask(_shieldMask.graphics, percentage, 61, 0, 0, 90 * (Math.PI/180), 8);
			
			_shieldMask.graphics.endFill();
		}
		
		private function UpdateHP(percentage:Number):void
		{
			_hpMask.graphics.clear();
			_hpMask.graphics.beginFill(0x00FF00, 0.5);
			_hpMask.graphics.moveTo(0, 0);
			
			var drawPieMask:Function = function(graphics:Graphics, percentage:Number, radius:Number = 50, x:Number = 0, y:Number = 0, rotation:Number = 0, sides:int = 6):void
			{
				// graphics should have its beginFill function already called by now
				graphics.moveTo(x, y);
				
				if (sides < 3) sides = 3;
				
				// Increase the length of the radius to cover the whole target
				radius /= Math.cos(1 / sides * Math.PI);
				
				// Shortcut function
				var lineToRadians:Function = function(rads:Number):void 
				{
					graphics.lineTo(Math.cos(rads) * radius + x, Math.sin(rads) * radius + y);
				};
				
				// Find how many sides we have to draw
				var sidesToDraw:int = Math.floor(percentage * sides);
				
				for (var i:int = 0; i <= sidesToDraw; i++)
				{
					lineToRadians((i / sides) * -(Math.PI * 2) + rotation);
				}
				
				// Draw the last fractioned side
				if (percentage * sides != sidesToDraw)
				lineToRadians(percentage * -(Math.PI * 2) + rotation);
			}
			
			drawPieMask(_hpMask.graphics, percentage, 61, 0, 0, 90 * (Math.PI/180), 8);
			
			_hpMask.graphics.endFill();
		}
		
		private var _skipAnimation:Boolean = false;
		public function skipAnimation():void
		{
			_skipAnimation = true;
		}
	}

}