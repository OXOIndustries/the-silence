package classes.Engine.Interfaces 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public function highlightButton(idx:int):void
	{
		import classes.GUI;
		userInterface().setButtonHighlighted(idx);
	}

}