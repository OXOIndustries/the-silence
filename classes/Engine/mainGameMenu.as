package classes.Engine 
{
	import classes.kGAMECLASS;
	import classes.Engine.Interfaces.highlightButton;
	import classes.Engine.Interfaces.dehighlightButton;
	/**
	 * ...
	 * @author Gedan
	 */
	
	public function mainGameMenu():void 
	{
		var highlights:Array = [6, 10, 11, 12];
		var none:Array = [0, 1, 2, 3, 4, 5, 7, 8, 9, 13, 14];
		
		for (var i:int = 0; i < highlights.length; i++)
		{
			highlightButton(highlights[i]);
		}
		
		for (i = 0; i < none.length; i++)
		{
			dehighlightButton(none[i]);
		}
		
		kGAMECLASS.mainGameMenu();
	}
}