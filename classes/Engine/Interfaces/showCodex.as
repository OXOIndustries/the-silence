package classes.Engine.Interfaces 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public function showCodex():void
	{
		import classes.kGAMECLASS;
		
		userInterface().showCodex();
		kGAMECLASS.codexHomeFunction();
		clearGhostMenu();
		addGhostButton(4, "Back", userInterface().showPrimaryOutput);
	}

}