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
		
		{
			Chars = new Object();
			PlayerGroup = new Object();
			
			CharacterIndex.init(false);
		}
		
		public static function init(justUpdate:Boolean = false):void 
		{
			trace("initializeNPCs Called, just doing cleanup?", justUpdate)
			//if (!justUpdate || (justUpdate && chars["CELISE"] == undefined))
			//{
				//chars["CELISE"] = new classes.Characters.Celise();
			//}
			
			// Check all characters have version information set
			for (var prop in CharacterIndex.Chars)
			{
				if (CharacterIndex.Chars[prop].version == 0)
				{
					throw new Error("Character class '" + prop + "' has no version information set!");
				}
				else
				{
					trace("Creature '" + prop + "' Game Version " + CharacterIndex.Chars[prop].version);
				}
			}
		}
		
		// Accessors to each character type
		public static function get pc():PlayerCharacter
		{
			return CharacterIndex.Chars["PC"];
		}
	}
}