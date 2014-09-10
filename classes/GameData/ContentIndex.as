package classes.GameData 
{
	import classes.GameData.Content.Appearance;
	import classes.GameData.Content.Creation;
	import classes.GameData.Content.TheSilence.TheSilence;
	
	public class ContentIndex 
	{
		public static var appearance:Appearance;
		public static var creation:Creation;
		
		// Ship Interiors
		public static var theSilence:TheSilence;
		
		{
			appearance = new Appearance();
			creation = new Creation();
			theSilence = new TheSilence();
		}
	}
}