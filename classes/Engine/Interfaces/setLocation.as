package classes.Engine.Interfaces 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public function setLocation(title:String, planet:String = null, system:String = null):void 
	{
		import classes.kGAMECLASS;
		kGAMECLASS.userInterface.setLocation(title, planet, system);
	}

}