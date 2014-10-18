package classes.UIComponents.SideBarComponents 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import classes.UIComponents.UIStyleSettings;
	/**
	 * ...
	 * @author Gedan
	 */
	public class EffetContainer extends Sprite
	{
		private var _body:Sprite;
		private var _mIcon:Sprite;
		private var _mPlus:Sprite;
		private var _mNeg:Sprite;
		
		public function EffetContainer() 
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