package classes.UIComponents.SideBarComponents 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Gedan
	 */
	public class CharacterInfoDisplay extends Sprite
	{
		private var _debugBackground:Sprite;
		
		private var _nameHeader:TextField;
		private var _nameHeaderUnderline:Sprite;
		
		public function CharacterInfoDisplay() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Build();
		}
		
		private function Build():void
		{
			BuildDebugBackground();
		}
		
		private function BuildDebugBackground():void
		{
			_debugBackground = new Sprite();
			_debugBackground.graphics.beginFill(0xFF0000);
			_debugBackground.graphics.drawRect(0, 0, 189, 150);
			_debugBackground.graphics.endFill();
			this.addChild(_debugBackground);
		}
		
	}

}