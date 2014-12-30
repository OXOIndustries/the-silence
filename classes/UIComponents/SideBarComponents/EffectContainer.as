package classes.UIComponents.SideBarComponents 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import classes.UIComponents.UIStyleSettings;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class EffectContainer extends Sprite
	{
		private var _body:Sprite;
		protected var _mIcon:Sprite;
		private var _isBuff:Boolean = false
		private var _isDebuff:Boolean = false;
		
		public static var overHandlerFunc:Function = null;
		
		public var headerText:String = "Header";
		public var bodyText:String = "Body";
		private var _activeEffectsText:String = null;
		
		public function get activeEffectsText():String
		{
			if (activeEffects.length > 0)
			{
				var bFirst:Boolean = true;
				var tString:String = "";
				
				for (var i:int = 0; i < activeEffects.length; i++)
				{
					if (!bFirst)
					{
						tString += "\n";
					}
					tString += activeEffects[i];
					bFirst = false;
				}
				
				return tString;
			}
			return _activeEffectsText;
		}
		public function set activeEffectsText(v:String):void
		{
			_activeEffectsText = v;
		}
		
		public var activeEffects:Array;
		
		public function EffectContainer() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(MouseEvent.ROLL_OVER, overHandler);
			addEventListener(MouseEvent.ROLL_OUT, overHandler);
			
			activeEffects = [];
			
			Build();
		}
		
		private function overHandler(e:MouseEvent):void
		{
			overHandlerFunc(this, e);
		}
		
		private function Build():void
		{
			_body = new Sprite();
			_body.graphics.beginFill(UIStyleSettings.gBackgroundColour, 1);
			_body.graphics.drawRoundRect(0, 0, 33, 33, 4, 4);
			_body.graphics.endFill();
			this.addChild(_body);
			
			BuildIcon();
		}
		
		public function BuildIcon():void
		{
			throw new Error("Override plx");
		}
		
		public function clearState():void
		{
			_isBuff = false;
			_isDebuff = false;
			
			var whtT:ColorTransform = new ColorTransform();
			whtT.color = 0xFFFFFF;
			_mIcon.transform.colorTransform = whtT;
			
			this.alpha = 0.3;
			this.mouseEnabled = false;
			
			activeEffects = [];
		}
		
		public function addBuff(tName:String, duration:Number):void
		{
			_isBuff = true;
			setIconColorState();
			activeEffects.push("<span class='good'>" + tName + " [" + duration + " rounds]</span>");
		}
		
		public function addDebuff(tName:String, duration:Number):void
		{
			_isDebuff = true;
			setIconColorState();
			activeEffects.push("<span class='bad'>" + tName + " [" + duration + " rounds]</span>");
		}
		
		private function setIconColorState():void
		{
			this.alpha = 1.0;
			this.mouseEnabled = true;
			
			var ct:ColorTransform = new ColorTransform();
			
			if (!_isBuff && !_isDebuff) ct.color = 0xFFFFFF;
			if (_isBuff && !_isDebuff) ct.color = UIStyleSettings.gStatusGoodColour;
			if (!_isBuff && _isDebuff) ct.color = UIStyleSettings.gStatusBadColour;
			if (_isBuff && _isDebuff) ct.color = UIStyleSettings.gStatusGoodBadColor;
			
			_mIcon.transform.colorTransform = ct;
		}
	}

}