package classes.GameData 
{
	import classes.Creature;
	import classes.Engine.Interfaces.output;
	import classes.Engine.Interfaces.userInterface;
	/**
	 * ...
	 * @author Gedan
	 */
	public class Party
	{
		private var _charactersInParty:Array;
		private var _playerParty:Boolean;
				
		public function Party(isPlayer:Boolean = false) 
		{
			_playerParty = isPlayer;
			_charactersInParty = new Array();
		}
		
		public function addToParty(char:Creature, suppressOutput:Boolean = false):void
		{
			if (_charactersInParty.indexOf(char) == -1)
			{
				_charactersInParty.push(char);
				if (_playerParty && !suppressOutput) output("\n\n<b>" + char.short + " has joined your party!</b>");
				if (_playerParty)
				{
					userInterface().setPlayerPartyData(_charactersInParty);
				}
				else
				{
					userInterface().setEnemyPartyData(_charactersInParty);
				}
			}
			else
			{
				trace("Character is already in the party!");
			}
		}
		
		public function removeFromParty(char:Creature, supressOutput:Boolean = false):void
		{
			if (_charactersInParty.indexOf(char) == -1)
			{
				trace("Character does not existin within the party!");
			}
			else
			{
				_charactersInParty.splice(_charactersInParty.indexOf(char), 1);
				if (_playerParty && !supressOutput) output("\n\n<b>" + char.short + " has left your party!</b>");
				if (_playerParty)
				{
					userInterface().setPlayerPartyData(_charactersInParty);
				}
				else
				{
					userInterface().setEnemyPartyData(_charactersInParty);
				}
			}
		}
		
		public function getParty():Array
		{
			// Really this should isolate the concept of the storage array from the output but I'm being lazy.
			return _charactersInParty;
		}
		
		public function isInParty(char:Creature):Boolean
		{
			if (_charactersInParty.indexOf(char) != -1) return true;
			return false;
		}
	}

}