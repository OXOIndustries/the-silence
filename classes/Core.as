package classes
{
	import classes.GameData.ContentIndex;
	import classes.TiTS_Settings;
	import classes.UIComponents.MainButton;
	import fl.transitions.Tween;
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.net.FileReference;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.display.MovieClip;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.AntiAliasType;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import fl.transitions.easing.None;
	
	// Game content managers
	import classes.GameData.TooltipManager;
	import classes.GameData.CodexManager;
	import classes.GameData.GameOptions;
	import classes.GameData.GameState;
	import classes.GameData.MapIndex;
	
	import classes.InputManager;
	import classes.DataManager.DataManager;
	import classes.Parser.ParseEngine;
	import classes.GameData.StatTracking;
	import classes.GUI;
	import classes.Mapper;
	
	// Game classes
	import classes.GameData.Items.Miscellaneous.NoItem;
	
	// Game interface functions
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.StringUtil;

	// Manager child classes for ease of use
	import classes.UIComponents.StatBar;
	
	//Build the bottom drawer
	public class Core extends MovieClip
	{
		// Smoosh all the included stuff into the TiTS class
		// this is a HORRIBLE way of architecting the system, but it's better then not
		// using classes at all
		
		include "../includes/CodexEntries.as";
		include "../includes/ControlBindings.as";
		
		/*
		include "../includes/combat.as";
		include "../includes/items.as";
		include "../includes/creation.as";
		include "../includes/engine.as";
		include "../includes/game.as";
		include "../includes/masturbation.as";
		
		include "../includes/appearance.as";
		
		include "../includes/debug.as";

		
		include "../includes/travelEvents.as";		
		include "../includes/lightsOut.as";
		*/

		// Queued event system
		public var eventBuffer:String;
		public var eventQueue:Array;
		public var gameOptions:GameOptions;

		// Version string/value
		public var version:String;
		
		public var inputManager:InputManager;
		public var parser:ParseEngine;
		public var dataManager:DataManager;
		public var userInterface:GUI;
		public var mapper:Mapper;

		// Hacky fix for some UI updating problems under Chrome
		public var whatTheFuck:Sprite;
		public var whatTheFuckToggleState:Boolean;

		public function Core()
		{
			kGAMECLASS = this;
			dataManager = new DataManager();
			gameOptions = new GameOptions();

			version = "0.00.01";

			eventQueue = new Array();
			eventBuffer = "";

			parser = new ParseEngine(this, TiTS_Settings);
			//mapper = new Mapper(this.rooms);
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			this.inputManager = new InputManager(stage, false);
			this.setupInputControls();
			
			// set up the user interface: ------------------------------------------------------------
			this.userInterface = new GUI(this, stage);
			clearMenu();

			this.addEventListener(Event.FRAME_CONSTRUCTED, finishInit);
		}
		
		private function finishInit(e:Event):void
		{
			this.removeEventListener(Event.FRAME_CONSTRUCTED, finishInit);
			this.configureCodex();
			this.userInterface.showMainMenu();
			buildWTF();
		}
		
		private function buildWTF():void
		{
			whatTheFuck = new Sprite();
			whatTheFuck.name = "wtf";
			whatTheFuck.graphics.beginFill(0x333E52, 1);
			whatTheFuck.graphics.drawRect(0, 0, 2, 2);
			whatTheFuck.graphics.endFill();
			
			stage.addChild(whatTheFuck);
			whatTheFuck.x = 1199;
			whatTheFuck.y = 799;
		}
		
		public function toggleWTF():void
		{
			whatTheFuckToggleState != whatTheFuckToggleState;
			
			var start:int;
			var end:int;
			
			if (whatTheFuckToggleState == false)
			{
				start = 1199;
				end = 0;
			}
			else
			{
				start = 0;
				end = 1199;
			}
			
			var tw:Tween = new Tween(whatTheFuck, "x", None.easeNone, start, end, 12, false); 
		}
		
		public function mainGameMenu():void 
		{
			GameState.flags["COMBAT MENU SEEN"] = undefined;
			
			//Display shit that happened during time passage.
			if (processEventBuffer()) return;
			
			//Queued events can fire off too!
			if (eventQueue.length > 0) 
			{
				//Do the most recent:
				this.eventQueue[0]();
				//Strip out the most recent:
				this.eventQueue.splice(0,1);
				return;
			}
			
			//Set up all appropriate flags
			//Display the room description
			clearOutput();
			
			MapIndex.displayRoom(GameState.currentLocation);
		}
		
		public function processEventBuffer():Boolean
		{
			if (eventBuffer.length > 0)
			{
				clearOutput();
				output("<b>" + possessive(pc.short) + " log:</b>" + eventBuffer);
				eventBuffer = "";
				clearMenu();
				addButton(0, "Next", mainGameMenu);
				return true;
			}
			return false;
		}

		public function buttonClick(evt:MouseEvent):void 
		{
			toggleWTF();
			
			if (evt.currentTarget is MainButton)
			{
				trace("Button " + (evt.currentTarget as MainButton).buttonName + " clicked");
			}
			else
			{
				trace("Button " + evt.currentTarget.caption.text + " clicked.");
			}
			
			if (evt.currentTarget.arg == undefined)
			{
				if (evt.currentTarget.func != null) evt.currentTarget.func();
			}
			else
			{
				if (evt.currentTarget.func != null) evt.currentTarget.func(evt.currentTarget.arg);
			}
			
			if (GameState.characters["PC"] != undefined)
			{
				updateUI();
			}
			
			userInterface.updateTooltip((evt.currentTarget as DisplayObject));
		}
		
		public function updateUI():void
		{
			
		}
		
		public function get pc():*
		{
			
		}
		
		public function showName(name:String):void
		{
			userInterface.showName(name);
		}
		
		public function addItemButton(slot:int, item:ItemSlotClass, func:Function = undefined, arg:* = undefined, ttHeader:String = null, ttBody:String = null, seller:Creature = null, buyer:Creature = null):void
		{
			var comparisonString:String = null;
			var compareItem:ItemSlotClass = null;
			
			if (item.type == GLOBAL.RANGED_WEAPON)
			{
				compareItem = (GameState.characters["PC"] as Creature).rangedWeapon;
			}
			else if (item.type == GLOBAL.MELEE_WEAPON)
			{
				compareItem = (GameState.characters["PC"] as Creature).meleeWeapon;
			}
			else if (item.type == GLOBAL.ARMOR || item.type == GLOBAL.CLOTHING)
			{
				compareItem = (GameState.characters["PC"] as Creature).armor;
			}
			else if (item.type == GLOBAL.SHIELD)
			{
				compareItem = (GameState.characters["PC"] as Creature).shield;
			}
			else if (item.type == GLOBAL.LOWER_UNDERGARMENT)
			{
				compareItem = (GameState.characters["PC"] as Creature).lowerUndergarment;
			}
			else if (item.type == GLOBAL.UPPER_UNDERGARMENT)
			{
				compareItem = (GameState.characters["PC"] as Creature).upperUndergarment;
			}
			else if (item.type == GLOBAL.ACCESSORY)
			{
				compareItem = (GameState.characters["PC"] as Creature).accessory;
			}
			
			if (compareItem == null)
			{
				compareItem = new NoItem();
			}
			
			comparisonString = item.compareTo(compareItem, seller, buyer);
			
			// Do GUI stuff with the compareItem string -- can probably mangle a call together a call to addButton() to do the needful
			// if we have any null arguments at this point rather than throwing an error and shit.
			userInterface.addItemButton(slot, item.shortName, item.quantity, func, arg, ttHeader, ttBody, comparisonString);
		}
		
		public function addOverrideItemButton(slot:int, item:ItemSlotClass, buttonName:String, func:Function = undefined, arg:* = undefined, ttHeader:String = null, ttBody:String = null):void
		{
			var comparisonString:String = null;
			var compareItem:ItemSlotClass = null;
			
			if (item.type == GLOBAL.RANGED_WEAPON)
			{
				compareItem = (GameState.characters["PC"] as Creature).rangedWeapon;
			}
			else if (item.type == GLOBAL.MELEE_WEAPON)
			{
				compareItem = (GameState.characters["PC"] as Creature).meleeWeapon;
			}
			else if (item.type == GLOBAL.ARMOR || item.type == GLOBAL.CLOTHING)
			{
				compareItem = (GameState.characters["PC"] as Creature).armor;
			}
			else if (item.type == GLOBAL.SHIELD)
			{
				compareItem = (GameState.characters["PC"] as Creature).shield;
			}
			else if (item.type == GLOBAL.LOWER_UNDERGARMENT)
			{
				compareItem = (GameState.characters["PC"] as Creature).lowerUndergarment;
			}
			else if (item.type == GLOBAL.UPPER_UNDERGARMENT)
			{
				compareItem = (GameState.characters["PC"] as Creature).upperUndergarment;
			}
			else if (item.type == GLOBAL.ACCESSORY)
			{
				compareItem = (GameState.characters["PC"] as Creature).accessory;
			}
			
			if (compareItem == null)
			{
				compareItem = new NoItem();
			}
			
			comparisonString = item.compareTo(compareItem);
			
			var itemHeader:String = null;
			var itemBody:String = null;
			
			if (ttHeader != null && ttHeader.length > 0) itemHeader = ttHeader;
			if (ttBody != null && ttBody.length > 0) itemBody = ttBody;
			
			if (itemHeader == null || itemHeader.length == 0) itemHeader = TooltipManager.getFullName(item.shortName);
			if (itemBody == null || itemBody.length == 0) itemBody = TooltipManager.getTooltip(item.shortName);
			
			// Do GUI stuff with the compareItem string -- can probably mangle a call together a call to addButton() to do the needful
			// if we have any null arguments at this point rather than throwing an error and shit.
			userInterface.addItemButton(slot, buttonName, 1, func, arg, itemHeader, itemBody, comparisonString);
		}
		
		public function removeButton(slot:int):void
		{
			userInterface.addDisabledButton(slot);
		}
		
		public function refreshFontSize():void
		{
			userInterface.refreshFontSize(gameOptions.fontSize);
		}
		
		public function showCodex():void
		{
			this.userInterface.showCodex();
			this.codexHomeFunction();
			clearGhostMenu();
			addGhostButton(4, "Back", this.userInterface.showPrimaryOutput);
		}
		
		public function spacebarKeyEvt():void
		{
			this.userInterface.SpacebarEvent();
		}

		// Proxy through and tweak the input manager along the way
		public function displayInput():void
		{
			this.inputManager.ignoreInputKeys(true);
			this.userInterface.displayInput();
		}
		
		public function removeInput():void
		{
			this.inputManager.ignoreInputKeys(false);
			this.userInterface.removeInput();
		}
		
		public function pressButton(arg:int = 0):void 
		{
			this.userInterface.PressButton(arg);
			updateUI();
		}

		// New passthroughs to GUI to handle scroll event controls
		public function upScrollText():void
		{
			this.userInterface.upScrollText();
		}
		
		public function downScrollText():void
		{
			this.userInterface.downScrollText();
		}
		
		public function pageUpScrollText():void
		{
			this.userInterface.pageUpScrollText();
		}
		
		public function pageDownScrollText():void
		{
			this.userInterface.pageDownScrollText();
		}
		
		public function homeScrollText():void
		{
			this.userInterface.homeScrollText();
		}
		
		public function endScrollText():void
		{
			this.userInterface.endScrollText();
		}
		
		public function nextOutputPage():void
		{
			this.userInterface.BufferPageNextHandler();
		}
		
		public function prevOutputPage():void
		{
			this.userInterface.BufferPagePrevHandler();
		}
	
		/*
		MOST of this should be broken up into simple shim-functions that call the real, relevant function in userInterface:GUI
		I'm breaking it out into a separate class, and just manipulating those class variables for the moment
		once that's working, I can start piecemeal moving things to functions in GUI.

		*/

		//1: TEXT FUNCTIONS
		public function outputCodex(words:String, markdown:Boolean = false):void
		{
			this.userInterface.outputCodexBuffer += doParse(words, markdown);
		}

		public function clearOutputCodex():void
		{
			this.userInterface.clearOutputCodex();
		}

		// HTML tag formatting wrappers, because lazy as fuck
		public function header(words:String):String
		{
			return String("<span class='header'>" + words + "</span>\n");
		}

		public function blockHeader(words:String):String
		{
			return String("<span class='blockHeader'>" + words + "</span>\n");
		}

		public function num2Text(number:Number):String {
			var returnVar:String = null;
			var numWords = new Array("zero","one","two","three","four","five","six","seven","eight","nine","ten");
			if (number > 10 || int(number) != number) {
				returnVar = "" + number;
			} 
			else {
				returnVar = numWords[number];
			}
			return(returnVar);
		}
		public function num2Text2(number:int):String {
			var returnVar:String = null;
			var numWords = new Array("zero","first","second","third","fourth","fifth","sixth","seventh","eighth","ninth","tenth");
			if (number > 10) {
				returnVar = "" + number + "th";
			} 
			else {
				returnVar = numWords[number];
			}
			return(returnVar);
		}

		function leftBarClear():void {
			this.userInterface.leftBarClear();
		}

		function deglow():void 
		{
			this.userInterface.deglow()
		}			

		public function updateNPCStats():void 
		{

		}
		
		public function updateStatBar(arg:StatBar , value = undefined, max = undefined):void 
		{

		}
		
		public function rootMenu():void
		{
			
		}
		
		public function CharacterCreation():void
		{
			if (GameState.characters["PC"].short.length >= 1) 
			{
				this.userInterface.warningText.htmlText = "<b>Are you sure you want to create a new character?</b>";
				this.userInterface.confirmNewCharacter();
			}
			else 
			{
				ContentIndex.creation.StartCreation();
			}
		}
	}
}