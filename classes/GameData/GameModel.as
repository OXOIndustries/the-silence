package classes.GameData 
{
	import classes.Creature;
	
	import classes.GameData.Characters.BlackVoidPirate;
	import classes.GameData.Characters.Logan;
	import classes.GameData.Characters.MirianBragga;
	import classes.GameData.Characters.PlayerCharacter;
	import classes.GameData.Characters.Pyra;
	import classes.GameData.Characters.RourkeBlackstar;
	import classes.GameData.Characters.Tarik;
	import classes.GameData.Characters.Connie;
	
	import flash.utils.Dictionary;
	/**
	 * GameModel stores all of the current state of the game, and is accessible to all other classes at-will.
	 * It contains ALL things that must persist between game saves.
	 * Eventually I can provide the actual mechanics to de/serialise the game state HERE in this class, and just have the data manager target a fixed interface (using the IVersionedSavable interface) to save/load the info.
	 * DataManager is then totally agnostic of the data (and the structure) behind the game; all it cares about is access to a singular model that provides the interface to get/set data.
	 * @author Gedan
	 */
	public class GameModel 
	{
		public var days:uint = 0;
		public var hours:uint = 0;
		public var minutes:uint = 0;
		
		public var inSceneBlockSaving:Boolean = false;
		public var encountersDisabled:Boolean = false;
		
		public var gameStarted:Boolean = false;
		public var inCombat:Boolean = false;
		public var inSpaceCombat:Boolean = false;
		
		public var flags = new Dictionary();
		
		public function get characters():Object
		{
			return CharacterIndex.Chars;
		}
		
		public function get ships():Object
		{
			return ShipIndex.Ships;
		}
		
		public function get pc():PlayerCharacter
		{
			return CharacterIndex.Chars["PC"];
		}
		
		public function get logan():Logan
		{
			return CharacterIndex.Chars["LOGAN"];
		}
		
		public function get pyra():Pyra
		{
			return CharacterIndex.Chars["PYRA"];
		}
		
		public function get tarik():Tarik
		{
			return CharacterIndex.Chars["TARIK"];
		}
		
		public function get mirian():MirianBragga
		{
			return CharacterIndex.Chars["MIRIAN"];
		}
		
		public function get rourke():RourkeBlackstar
		{
			return CharacterIndex.Chars["ROURKE"];
		}
		
		public function get connie():Connie
		{
			return CharacterIndex.Chars["CONNIE"];
		}
		
		public function get enemyParty():Party
		{
			return CharacterIndex.EnemyGroup;
		}
		
		public function get playerParty():Party
		{
			return CharacterIndex.PlayerGroup;
		}
		
		public function set characters(v:Object):void
		{
			CharacterIndex.Chars = v;
			CharacterIndex.init(true);
		}
		
		public function set ships(v:Object):void
		{
			ShipIndex.Ships = v;
			ShipIndex.init(true);
		}
	}
}