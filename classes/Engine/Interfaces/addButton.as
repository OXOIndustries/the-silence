package classes.Engine.Interfaces 
{
	import classes.kGAMECLASS;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public function addButton(slot:int, cap:String = "", func:Function = undefined, arg:* = undefined, ttHeader:String = null, ttBody:String = null):void
	{
		kGAMECLASS.userInterface.addButton(slot, cap, func, arg, ttHeader, ttBody);
	}
}