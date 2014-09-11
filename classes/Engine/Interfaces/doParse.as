package classes.Engine.Interfaces 
{
	import classes.kGAMECLASS;
	/**
	 * ...
	 * @author Gedan
	 */
	public function doParse(script:String, markdown:Boolean = false):String
	{
		return kGAMECLASS.parser.recursiveParser(script, markdown);
	}

}