package classes.Engine.Interfaces 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public function removeAllButtonHighlights():void
	{
		for (var i:int = 0; i < 15; i++)
		{
			dehighlightButton(i);
		}
	}

}