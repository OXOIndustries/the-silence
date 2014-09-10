package classes.GameData.Content 
{
	import classes.Engine.Interfaces.*;
	import classes.GameData.ContentIndex;
	import classes.GUI;
	import classes.kGAMECLASS;
	
	public class BaseContent 
	{
		protected function output(msg:String):void
		{
			classes.Engine.Interfaces.output(msg);
		}
		
		protected function output2(msg:String):void
		{
			classes.Engine.Interfaces.output2(msg);
		}
		
		protected function clearOutput():void
		{
			classes.Engine.Interfaces.clearOutput();
		}
		
		protected function clearOutput2():void
		{
			classes.Engine.Interfaces.clearOutput2();
		}
		
		protected function get userInterface():GUI
		{
			return classes.Engine.Interfaces.userInterface();
		}
		
		protected function get silly():Boolean
		{
			return kGAMECLASS.gameOptions.sillyMode;
		}
		
		protected function set silly(v:Boolean):void
		{
			kGAMECLASS.gameOptions.sillyMode = v;
		}
		
		protected function get easy():Boolean
		{
			return kGAMECLASS.gameOptions.easyMode;
		}
		
		protected function set easy(v:Boolean):void
		{
			kGAMECLASS.gameOptions.easyMode = v;
		}
		
		protected function get debug():Boolean
		{
			return kGAMECLASS.gameOptions.debugMode;
		}
		
		protected function set debug(v:Boolean):void
		{
			kGAMECLASS.gameOptions.debugMode = v;
		}
	}

}