package classes.Engine.Interfaces 
{
	import classes.kGAMECLASS;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public function addDisabledGhostButton(slot:int, cap:String = "", ttHeader:String = null, ttBody:String = null):void
	{
		kGAMECLASS.userInterface.addDisabledGhostButton(slot, cap, ttHeader, ttBody);
	}

}