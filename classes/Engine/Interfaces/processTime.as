package classes.Engine.Interfaces 
{
	import classes.GameData.GameState;
	import classes.GameData.CharacterIndex;
	/**
	 * ...
	 * @author Gedan
	 */
	public function processTime(delta:int):void
	{
		// Update time
		GameState.minutes += delta;
		
		while (GameState.minutes >= 60)
		{
			GameState.hours += 1;
			GameState.minutes -= 60;
		}
		
		while (GameState.hours >= 24)
		{
			GameState.days += 1;
			GameState.hours -= 24;
		}
		
		CharacterIndex.progressTime(delta);
	}

}