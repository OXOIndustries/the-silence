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
	
	import classes.StringUtil;
	
	/**
	 * GameModel stores all of the current state of the game, and is accessible to all other classes at-will.
	 * It contains ALL things that must persist between game saves.
	 * Eventually I can provide the actual mechanics to de/serialise the game state HERE in this class, and just have the data manager target a fixed interface (using the IVersionedSavable interface) to save/load the info.
	 * DataManager is then totally agnostic of the data (and the structure) behind the game; all it cares about is access to a singular model that provides the interface to get/set data.
	 * @author Gedan
	 */
	public class GameModel implements ISaveable
	{
		function GameModel()
		{
			newGame();
		}
		
		public function newGame():void
		{
			days = 1;
			hours = 8;
			minutes = 37;
			
			gameStarted = false;
			inSceneBlockSaving = false;
			encountersDisabled = false;
			
			flags = new Dictionary();
			
			CharacterIndex.configure();
			ShipIndex.init();
			
			CharacterIndex.PlayerGroup = new Party();
			CodexManager.viewedEntryList = new Array();
			CodexManager.unlockedEntryList = new Array();
			
			StatTracking.reset();
		}
		
		public var days:uint = 0;
		public var hours:uint = 0;
		public var minutes:uint = 0;
		
		public function get debug():Boolean
		{
			return kGAMECLASS.gameOptions.debugMode;
		}
		
		public var gameStarted:Boolean = false;
		public var inSceneBlockSaving:Boolean = false;
		public var encountersDisabled:Boolean = false;
		
		public function get inCombat():Boolean
		{
			return (CombatManager.inGroundCombat || CombatManager.inSpaceCombat);
		}
		
		public function get inGroundCombat():Boolean
		{
			return CombatManager.inGroundCombat;
		}
		
		public function get inSpaceCombat():Boolean
		{
			return CombatManager.inSpaceCombat;
		}
		
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
		
		public function setPlayerParty(v:Array):void
		{
			CharacterIndex.PlayerGroup.setParty(v);
		}
		
		public function set characters(v:Object):void
		{
			CharacterIndex.Chars = v;
			CharacterIndex.configure(true);
		}
		
		public function set ships(v:Object):void
		{
			ShipIndex.Ships = v;
			ShipIndex.init(true);
		}
		
		public function getSaveObject():Object
		{
			var o:Object = new Object();
			
			o.saveName = pc.short;
			o.roomName = StringUtil.toTitleCase(MapIndex.FindRoom(pc.currentLocation).RoomName);
			o.planetName = StringUtil.toTitleCase(MapIndex.FindRoom(pc.currentLocation).ParentLocation.LocationName);
			o.systemName = StringUtil.toTitleCase(MapIndex.FindRoom(pc.currentLocation).ParentLocation.ParentSystem.SystemName);
			o.currentPCNotes = "";
			o.playerGender = pc.mfn("M", "F", "A");
			
			o.days = this.days;
			o.hours = this.hours;
			o.minutes = this.minutes;
			
			o.gameStarted = this.gameStarted;
			
			o.gameOptions = kGAMECLASS.gameOptions.getSaveObject();
			
			o.flags = new Object();
			for (var prop:String in this.flags)
			{
				if (this.flags[prop] != undefined) o.flags[prop] = this.flags[prop];
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
			
			this.flags = new Dictionary();
			for (var prop:String in o.flags)
			{
				this.flags[prop] = o.flags[prop];
			}
			
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
				party.push(CharacterIndex.Chars[o.playerparty[i]]);
			}
			setPlayerParty(party);
			
			var ships:Object = new Object();
			for (prop in o.ships)
			{
				ships[prop] = new (getDefinitionByName(o.ships[prop].classInstance) as Class)();
				ships[prop].loadSaveObject(o.ships[prop]);
			}
			this.ships = ships;
			
			var unlockedCodexEntries:Array = new Array();
			for (i = 0; i < o.unlockedCodexEntries.length; i++)
			{
				unlockedCodexEntries.push(o.unlockedCodexEntries[i]);
			}
			CodexManager.unlockedEntryList = unlockedCodexEntries;
			
			var viewedCodexEntries:Array = new Array();
			for (i = 0; i < o.viewedCodexEntries.length; i++)
			{
				viewedCodexEntries.push(o.viewedCodexEntries[i]);
			}
			CodexManager.viewedEntryList = viewedCodexEntries;
			
			StatTracking.loadStorageObject(clone(o.statTracking));
		}
		
		public function makeCopy():*
		{
			
		}
	}
}