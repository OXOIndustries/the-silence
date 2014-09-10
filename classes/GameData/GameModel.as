package classes.GameData 
{
	import classes.Creature;
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
		
		public var currentLocation:String = "";
		public var shipLocation:String = "";
		public var inSceneBlockSaving:Boolean = false;
		
		public var inCombat:Boolean = false;
		public var inSpaceCombat:Boolean = false;
		
		public var flags = new Dictionary();
		
		public function get characters():Object
		{
			return CharacterIndex.Chars;
		}
		
		public function get logan():Creature
		{
			return CharacterIndex.Chars["LOGAN"];
		}
		
		public function get enemyParty():Array
		{
			return CharacterIndex.EnemyGroup;
		}
		
		public function get playerParty():Array
		{
			return CharacterIndex.PlayerGroup;
		}
		
		public function set characters(v:Object):void
		{
			CharacterIndex.Chars = v;
			CharacterIndex.init(true);
		}
	}
}