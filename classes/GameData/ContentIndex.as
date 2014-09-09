package classes.GameData 
{
	import classes.GameData.Content.Appearance;
	import classes.GameData.Content.Creation;
	
	public class ContentIndex 
	{
		public static var appearance:Appearance;
		public static var creation:Creation;
		
		{
			appearance = new Appearance();
			creation = new Creation();
		}
	}
}