package classes.GameData 
{
	import classes.Creature;
	import classes.DataManager.Serialization.ISaveable;
	import classes.DataManager.Serialization.VersionedSaveable;
	import classes.GameData.Ships.Ship;
	
	import classes.GameData.Characters.BlackVoidPirate;
	import classes.GameData.Characters.Logan;
	import classes.GameData.Characters.MirianBragga;
	import classes.GameData.Characters.PlayerCharacter;
	import classes.GameData.Characters.Pyra;
	import classes.GameData.Characters.Tarik;
	import classes.GameData.Characters.Connie;
	
	import flash.utils.Dictionary;
	
	import classes.kGAMECLASS;
	
	import classes.Engine.Utility.clone;
	import flash.utils.getDefinitionByName;
	
	/**
	 * GameModel stores all of the current state of the game, and is accessible to all other classes at-will.
	 * It contains ALL things that must persist between game saves.
	 * Eventually I can provide the actual mechanics to de/serialise the game state HERE in this class, and just have the data manager target a fixed interface (using the IVersionedSavable interface) to save/load the info.
	 * DataManager is then totally agnostic of the data (and the structure) behind the game; all it cares about is access to a singular model that provides the interface to get/set data.
	 * @author Gedan
	 */
	public class GameModel implements ISaveable
	{
		public var days:uint = 0;
		public var hours:uint = 0;
		public var minutes:uint = 0;
		
		public var gameStarted:Boolean = false;
		
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
		
		public function set playerParty(v:Array):Party
		{
			CharacterIndex.PlayerGroup = v;
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
		
		public function getSaveObject():Object
		{
			var o:Object = new Object();
			
			o.days = this.days;
			o.hours = this.hours;
			o.minutes = this.minutes;
			
			o.gameStarted = this.gameStarted;
			
			o.gameOptions = kGAMECLASS.gameOptions.getSaveObject();
			
			o.flags = new Object();
			for (prop in this.flags)
			{
				o.flags[prop] = this.flags[prop];
			}
			
			o.characters = new Object();
			for (prop in this.characters)
			{
				if ((this.characters[prop] as Creature).neverSerialize == false)
				{
					o.characters[prop] = this.characters[prop].getSaveObject();
				}
			}
			
			o.playerparty = new Array();
			var cParty:Party = this.playerParty;
			for (var i:int = 0; i < cParty.getParty().length; i++)
			{
				o.playerparty.push(cParty.getParty()[i].INDEX);
			}
			
			o.ships = new Object();
			for (prop in this.ships)
			{
				if ((this.ships[prop] as Ship).neverSerialize == false)
				{
					o.ships[prop] = this.ships[prop].getSaveObject();
				}
			}
			
			o.unlockedCodexEntries = new Array();
			var cEntries:Array = CodexManager.unlockedEntryList;
			for (i = 0; i < cEntries.length; i++)
			{
				o.unlockedCodexEntries.push(cEntries[i]);
			}
			
			o.viewedCodexEntries = new Array();
			var cViewed:Array = CodexManager.viewedEntryList;
			for (i = 0; i < cViewed.length; i++)
			{
				o.viewedCodexEntries.push(cViewed[i]);
			}
			
			o.statTracking = clone(StatTracking.getStorageObject());
			
			return o;
		}
		
		public function loadSaveObject(o:Object):void
		{
			this.days = o.days;
			this.hours = o.hours;
			this.minutes = o.minutes;
			
			this.gameStarted = o.gameStarted;
			
			kGAMECLASS.gameOptions.loadSaveObject(o.gameOptions);
			
			var characters:Object = new Object();
			for (prop in o.characters)
			{
				characters[prop] = new (getDefinitionByName(o.characters[prop].classInstance) as Class)();
				characters[prop].loadSaveObject(o.characters[prop]);
			}
			this.characters = characters;
			
			var party:Array = new Array();
			for (var i:int = 0; i < o.playerparty.length; i++)
			{
				party.push(CharacterIndex.Chars[o.playerparty[i].INDEX]);
			}
			playerParty = party;
			
			var ships:Object = new Object();
			for (prop in o.ships)
			{
				ships[prop] = new (getDefinitionByName(o.ships[prop].classInstance) as Class)();
				ships[prop].loadSaveObject(o.ships[prop]);
			}
		}
	}
}