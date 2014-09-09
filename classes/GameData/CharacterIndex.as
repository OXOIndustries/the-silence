package classes.GameData 
{
	import classes.GameData.Characters.PlayerCharacter;
	/**
	 * ...
	 * @author Gedan
	 */
	public class CharacterIndex 
	{
		public static var Chars:Object;
		
		public static var PlayerGroup:Object;
		public static var EnemyGroup:Object;
		
		{
			Chars = new Object();
			PlayerGroup = new Object();
			
			CharacterIndex.init(false);
		}
		
		public static function init(justUpdate:Boolean = false):void 
		{
			trace("initializeNPCs Called, just doing cleanup?", justUpdate);
			
			if (!justUpdate || (justUpdate && Chars["PC"] == undefined))
			{
				Chars["PC"] = new PlayerCharacter();
			}
		}
		
		// Accessors to each character type
		public static function get pc():PlayerCharacter
		{
			return CharacterIndex.Chars["PC"];
		}
	}
}