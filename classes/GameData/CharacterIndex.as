package classes.GameData 
{
	import classes.Creature;
	import classes.GameData.Characters.Logan;
	import classes.GameData.Characters.PlayerCharacter;
	import classes.GameData.Characters.Pyra;
	import classes.GameData.Characters.Tarik;
	
	import classes.GameData.Characters.Connie;
	/**
	 * ...
	 * @author Gedan
	 */
	public class CharacterIndex 
	{
		public static var Chars:Object;
		
		public static var PlayerGroup:Party;
		public static var EnemyGroup:Party;
		
		{
			Chars = new Object();
			PlayerGroup = new Party(true);
			EnemyGroup = new Party(false);
			
			CharacterIndex.configure(false);
		}
		
		public static function configure(justUpdate:Boolean = false):void 
		{
			initFor("PC", PlayerCharacter, justUpdate);
			initFor("LOGAN", Logan, justUpdate);
			initFor("PYRA", Pyra, justUpdate);
			initFor("TARIK", Tarik, justUpdate);
			initFor("CONNIE", Connie, justUpdate);
		}
		
		private static function initFor(idx:String, classT:Class, justUpdate:Boolean):void
		{
			if (!justUpdate || (justUpdate && Chars[idx] == undefined))
			{
				Chars[idx] = new classT();
			}
		}
		
		// Accessors to each character type
		public static function get pc():PlayerCharacter
		{
			return CharacterIndex.Chars["PC"];
		}
		
		public static function get logan():Logan
		{
			return CharacterIndex.Chars["LOGAN"];
		}
		
		public static function get connie():Connie
		{
			return CharacterIndex.Chars["CONNIE"];
		}
		
		public static function get pyra():Pyra
		{
			return CharacterIndex.Chars["PYRA"];
		}
		
		public static function get tarik():Tarik
		{
			return CharacterIndex.Chars["TARIK"];
		}
		
		public static function progressTime(delta:int):void
		{
			for (var prop:String in Chars)
			{
				(Chars[prop] as Creature).progressTime(delta);
			}
		}
	}
}