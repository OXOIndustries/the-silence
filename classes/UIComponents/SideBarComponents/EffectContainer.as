package classes.UIComponents.SideBarComponents 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import classes.UIComponents.UIStyleSettings;
	/**
	 * ...
	 * @author Gedan
	 */
	public class EffectContainer extends Sprite
	{
		private var _body:Sprite;
		protected var _mIcon:Sprite;
		private var _mPlus:Sprite;
		private var _mNeg:Sprite;
		
		public function EffectContainer() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Build();
			BuildIcon();
		}
		
		private function Build():void
		{
			_body = new Sprite();
			_body.graphics.beginFill(UIStyleSettings.gBackgroundColour, 1);
			_body.graphics.drawRoundRect(0, 0, 33, 33, 4, 4);
			_body.graphics.endFill();
			this.addChild(_body);
			
			_mPlus = new Sprite();
			_mPlus.graphics.beginFill(UIStyleSettings.gStatusGoodColour);
			_mPlus.graphics.drawRect(4, 0, 4, 12);
			_mPlus.graphics.drawRect(0, 4, 12, 4);
			_mPlus.graphics.endFill();
			_mPlus.x = 5;
			_mPlus.y = 24;
			this.addChild(_mPlus);
			
			_mNeg = new Sprite();
			_mNeg.graphics.beginFill(UIStyleSettings.gStatusBadColour);
			_mNeg.graphics.drawRect(0, 4, 12, 4);
			_mNeg.graphics.endFill();
			_mNeg.x = 20;
			_mNeg.y = 27;
			this.addChild(_mNeg);
		}
		
		public function BuildIcon():void
		{
			throw new Error("Override plx");
		}
		
		public function setInactive():void
		{
			this.alpha = 0.3;
			this._mPlus.visible = false;
			this._mNeg.visible = false;
		}
		
		public function setActive():void
		{
			this.alpha = 1.0;
		}
		
		public function setDebuff():void
		{
			this._mNeg.visible = true;
		}
		
		public function hideDebuff():void
		{
			this._mNeg.visible = false;
		}
		
		public function setBuff():void
		{
			this._mPlus.visible = true;
		}
		
		public function hideBuff():void
		{
			this._mPlus.visible = false;
		}
		
		public function setBuffDebuff():void
		{
			this._mPlus.visible = true;
			this._mNeg.visible = true;
		}
		
		public function hideBuffDebuff():void
		{
			this._mPlus.visible = false;
			this._mNeg.visible = false;
		}
		
	}

}