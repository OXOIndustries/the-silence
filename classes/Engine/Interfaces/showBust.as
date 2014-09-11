package classes.Engine.Interfaces 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public function showBust(... args):void
	{
		import classes.kGAMECLASS;
		kGAMECLASS.userInterface.showBust.apply(null, args);
	}

}