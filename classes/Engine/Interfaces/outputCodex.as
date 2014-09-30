package classes.Engine.Interfaces 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public function outputCodex(words:String, markdown:Boolean = false):void
	{
		import classes.kGAMECLASS;
		kGAMECLASS.userInterface.outputCodexBuffer += doParse(words, markdown);
		kGAMECLASS.userInterface.output2();
	}
}