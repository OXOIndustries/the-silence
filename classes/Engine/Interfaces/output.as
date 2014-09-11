package classes.Engine.Interfaces 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public function output(msg:String, markdown:Boolean = false):void
	{
		import classes.kGAMECLASS;
		kGAMECLASS.userInterface.outputBuffer += doParse(msg, markdown);
		kGAMECLASS.userInterface.output();
	}
}