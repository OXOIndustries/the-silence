package classes.UIComponents.SideBarComponents 
{
	import classes.Creature;
	import classes.GameData.CharacterIndex;
	import flash.display.Sprite;
	import classes.UIComponents.SideBarComponents.CharacterInfoDisplay;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class PartyBlock extends Sprite
	{
		private var _numElems:int;
		private var _alignment:String;
		private var _partyElements:Vector.<CharacterInfoDisplay>;
		
		public function PartyBlock(numElems:int = 3, alignment:String = "left") 
		{
			_numElems = numElems;
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
			this._partyElements = new Vector.<CharacterInfoDisplay>();
			
			for (var i:int = 0; i < _numElems; i++)
			{
				var pElem:CharacterInfoDisplay = new CharacterInfoDisplay(_alignment);
				this.addChild(pElem);
				
				pElem.y = (i * pElem.height) + (i * 5);
				
				_partyElements.push(pElem);
				
				pElem.visible = false;
			}
		}
		
		public function showParty(partyMembers:Array):void
		{
			for (var i:int = 0; i < _partyElements.length;  i++)
			{
				if (partyMembers[i] == undefined)
				{
					_partyElements[i].visible = false;
				}
				else
				{
					_partyElements[i].visible = true;
					_partyElements[i].showCharacter(partyMembers[i] as Creature);
				}
			}
		}
	}

}