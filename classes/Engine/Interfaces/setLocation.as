package classes.Engine.Interfaces 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public function setLocation(title:String, planet:String = "Error Planet", system:String = "Error System"):void 
	{
		import classes.kGAMECLASS;
		kGAMECLASS.userInterface.setLocation(title, planet, system);
	}

}