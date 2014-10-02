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

			version = "0.00.03";

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

		public function leftBarClear():void 
		{
			this.userInterface.leftBarClear();
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
			if (GameState.gameStarted == true) 
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