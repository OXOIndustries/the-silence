package classes.Engine.Party 
{
	import classes.Engine.Interfaces.output;
	import classes.GameData.GameState;
	/**
	 * ...
	 * @author Gedan
	 */
	public function removeFromParty(arg:String):void
	{
		var idx:uint = -1;
		
		for (var i:int = 0; i < GameState.playerParty.length; i++)
		{
			if (GameState.playerParty[i].CharacterIndex == arg)
			{
				idx = i;
			}
		}
		
		if (idx != -1)
		{
			output("\n\n<b>" + GameState.playerParty[idx].shortName + " has left the party.</b>");
			GameState.playerParty.splice(idx, 1);
		}
	}

}