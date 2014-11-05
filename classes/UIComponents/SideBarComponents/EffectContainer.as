package classes.UIComponents.SideBarComponents 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import classes.UIComponents.UIStyleSettings;
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
		
		public function EffectContainer() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Build();
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
		}
		
		public function addBuff():void
		{
			_isBuff = true;
			setIconColorState();
		}
		
		public function addDebuff():void
		{
			_isDebuff = true;
			setIconColorState();
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