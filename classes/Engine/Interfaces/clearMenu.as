package classes.Engine.Interfaces 
{
	import classes.kGAMECLASS;
	import classes.GameData.GameState;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public function clearMenu(saveDisable:Boolean = true):void 
	{
		GameState.inSceneBlockSaving = saveDisable;
		kGAMECLASS.userInterface.clearMenu();
	}

}