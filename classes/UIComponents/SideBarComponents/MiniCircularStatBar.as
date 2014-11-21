package classes.UIComponents.SideBarComponents 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * I made the "big" version scalable properly.......... but it's designed to nest two bars together, which isn't
	 * what I want for this.
	 * @author Gedan
	 */
	public class MiniCircularStatBar extends Sprite
	{
		private var _radius:int;
		private var _thickness:int;
		
		private var _bar:Sprite;
		private var _barMask:Sprite;
		
		private var _speed:Number = 0.01;
		
		private var _valueCurrent:Number;
		private var _valueTarget:int;
		private var _valueMax:int;		
		
		public function MiniCircularStatBar(radius:int = 59) 
		{
			_radius = radius;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, UpdateDisplay);
			
			Build();
		}
		
		private function Build():void
		{
			
		}
		
	}

}