package classes.Engine.Utility 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public function plural(str:String):String 
	{
		var lastChar:String = str.substr(str.length-1,str.length);
		if(lastChar == "s") str += "es";
		else str += "s";
		return str;
	}

}