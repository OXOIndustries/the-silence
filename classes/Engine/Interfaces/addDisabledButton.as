package classes.Engine.Interfaces 
{
	import classes.kGAMECLASS;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public function addDisabledButton(slot:int, cap:String = "", ttHeader:String = null, ttBody:String = null):void
	{
		kGAMECLASS.userInterface.addDisabledButton(slot, cap, ttHeader, ttBody);
	}
}