package classes.Engine.Utility 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public function upperCase(str:String):String 
	{
		var firstChar:String = str.substr(0,1);
		var restOfString:String = str.substr(1,str.length);
		return firstChar.toUpperCase()+restOfString.toLowerCase();
	}

}