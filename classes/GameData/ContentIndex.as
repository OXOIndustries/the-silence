package classes.GameData 
{
	import classes.GameData.Content.Appearance;
	import classes.GameData.Content.Chapter2;
	import classes.GameData.Content.Chapter3;
	import classes.GameData.Content.Creation;
	import classes.GameData.Content.TheSilence.TheSilence;
	
	public class ContentIndex 
	{
		public static var appearance:Appearance;
		public static var creation:Creation;
		public static var chapter2:Chapter2;
		public static var chapter3:Chapter3;
		
		// Ship Interiors
		public static var theSilence:TheSilence;
		
		{
			appearance = new Appearance();
				
			// Room content
			theSilence = new TheSilence();
			
			// Chapter Content
			creation = new Creation();
			chapter2 = new Chapter2();
			chapter3 = new Chapter3();
		}
	}
}