package classes.Engine 
{
	import classes.GameData.GameState;
	/**
	 * ...
	 * @author Gedan
	 */
	public function canSaveAtCurrentLocation():Boolean
	{
		if (GameState.gameStarted == false) return false;
		if (GameState.inSceneBlockSaving == true) return false;
		if (GameState.inCombat) return false;
		
		return true;
	}

}