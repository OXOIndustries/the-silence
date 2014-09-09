package classes.GameData.Content 
{
	import classes.Engine.Interfaces.*;
	import classes.GameData.ContentIndex;
	import classes.GUI;
	
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
	}

}