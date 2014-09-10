package classes.Engine 
{
	import classes.GameData.GameState;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public function timeText():String
	{
		var buffer:String = ""
		
		if (GameState.hours < 10)
		{
			buffer += "0";
		}
		
		buffer += GameState.hours + ":";
		
		if (minutes < 10) 
		{
			buffer += "0";
		}
		
		buffer += GameState.minutes;
		return buffer;
	}

}