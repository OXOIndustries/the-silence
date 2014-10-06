package classes.Engine.Interfaces 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public function removeButton(slot:int):void
	{
		import classes.Engine.Interfaces.userInterface;
		userInterface().addDisabledButton(slot);
	}

}