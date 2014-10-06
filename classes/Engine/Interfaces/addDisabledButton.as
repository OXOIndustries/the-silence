package classes.Engine.Interfaces 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public function addDisabledButton(slot:int, cap:String = "", ttHeader:String = null, ttBody:String = null):void
	{
		import classes.Engine.Interfaces.userInterface;
		userInterface().addDisabledButton(slot, cap, ttHeader, ttBody);
	}
}