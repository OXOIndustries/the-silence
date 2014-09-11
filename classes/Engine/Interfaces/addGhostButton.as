package classes.Engine.Interfaces 
{
	import classes.kGAMECLASS;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public function addGhostButton(slot:int, cap:String = "", func:Function = undefined, arg:* = undefined, ttHeader:String = null, ttBody:String = null):void
	{
		kGAMECLASS.userInterface.addGhostButton(slot, cap, func, arg, ttHeader, ttBody);
	}

}