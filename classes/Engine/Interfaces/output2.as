package classes.Engine.Interfaces 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public function output2(msg:String, markdown:Boolean = false):void
	{
		import classes.kGAMECLASS;
		kGAMECLASS.userInterface.outputBuffer2 += doParse(msg, markdown);
		kGAMECLASS.userInterface.output2();
	}

}