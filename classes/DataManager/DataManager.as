package classes.DataManager 
{
	import classes.kGAMECLASS;
	import classes.ShipClass;
	import flash.display.Shader;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	import classes.StringUtil;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import classes.DataManager.Errors.VersionUpgraderError;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	import classes.GameData.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.GameData.CodexManager;
	import classes.GameData.StatTracking;
	
	import classes.Engine.Interfaces.*;
	import classes.Engine.canSaveAtCurrentLocation;
	
	import classes.GameData.CharacterIndex;
	import classes.GameData.GameState;
	
	/**
	 * Data Manager to handle the processing of player data files.
	 * @author Gedan
	 */
	public class DataManager 
	{
		// Define the current version of save games.
		private static const LATEST_SAVE_VERSION:int = 1;
		private static const MINIMUM_SAVE_VERSION:int = 1;
		
		private var _autoSaveEnabled:Boolean = false;
		private var _lastManualDataSlot:int = -1;
		
		private var _debug:Boolean = true;
		
		public function DataManager() 
		{
			// This is some bullshit workaround to ensure classes are compiled into the packages so they'll be available later -- This is stupid and bullshit, but there needs to be an *explict* reference to a class somewhere in the code
			// For it to actually be compiled.
		}
		
		/**
		 * Data router to do a bunch of stuff. I suspect most of this should be refactored into GUI.as as it almost
		 * entirely pertains to display state vis-a-vis the display state of the data manager.
		 * @param	d	MouseEvent
		 */
		public function dataRouter(d:MouseEvent = undefined):void
		{
			if (!kGAMECLASS.userInterface.dataButton.isActive)
			{
				return;
			}
			else if (kGAMECLASS.userInterface.dataButton.isHighlighted)
			{
				kGAMECLASS.userInterface.dataButton.DeGlow();
				kGAMECLASS.userInterface.showPrimaryOutput();
				
				if (GameState.gameStarted)
				{
					kGAMECLASS.userInterface.showPrimaryOutput();
				}
				
				if (!GameState.gameStarted)
				{
					kGAMECLASS.userInterface.showMainMenu();
				}
			}
			else
			{
				kGAMECLASS.userInterface.showSecondaryOutput();
				this.showDataMenu();
				kGAMECLASS.userInterface.dataButton.Glow();
			}
		}
		
		private function getSO(slotNumber:int):SharedObject
		{
			return SharedObject.getLocal("silence_" + slotNumber, "/");
		}
		
		private function replaceDataWithBlob(so:SharedObject, blob:Object):void
		{
			so.clear();
			
			for (var prop:String in blob)
			{
				so.data[prop] = blob[prop];
			}
		}
		
		private function getFileData(so:SharedObject):Object
		{
			var ret:Object = new Object();
			
			// I'm not too concerned about run-time clones for data-processing purposes. What I DONT want to do is clone data OUT into the shared objects.
			// Clone will give us typed-classes dumped into data. We're trying to avoid that, and use basic containers that we can convert into our actual types later.
			var copier:ByteArray = new ByteArray();
			copier.writeObject(so.data);
			copier.position = 0;
			ret = copier.readObject();
			
			return ret;
		}
		
		// Again, this is intended for PURE BASIC objects, nothing complex with complex types. Basically, complex object trees used as a heirarchy.
		private function cloneObject(o:Object):Object
		{
			var copier:ByteArray = new ByteArray();
			var ret:Object = new Object();
			copier.writeObject(o);
			copier.position = 0;
			ret = copier.readObject();
			
			return ret;
		}
		
		/**
		 * Display the Save/Load menu
		 */
		public function showDataMenu():void
		{
			var displayMessage:String = "";
			
			clearOutput2();
			kGAMECLASS.userInterface.dataButton.Glow();
			
			displayMessage += "You can ";
			
			if (canSaveAtCurrentLocation()) displayMessage += "<b>save</b> or ";
			displayMessage += "<b>load</b> your data here.";
			
			if (!canSaveAtCurrentLocation()) displayMessage += "\n\nYou must be at a safe place to save your game.</b>";
			
			output2(displayMessage);
			
			output2("\n\nTrials in Tainted Space uses a system to track the game version used to create a save file. Saves that require modifications to be compatible with the version of the game you are currently running will state “<b>REQUIRES UPGRADE</b>.”");
			output2("\n\n<b>YOUR SAVE DATA STILL EXISTS.</b> Trying to load a slot that “<b>REQUIRES UPGRADE</b>” will perform an automatic upgrade of the save data whilst it is being loaded. Once done, you are free to continue playing the game as normal.");
			
			kGAMECLASS.userInterface.clearGhostMenu();
			addGhostButton(0, "Load", this.loadGameMenu);
			if (canSaveAtCurrentLocation()) addGhostButton(1, "Save", this.saveGameMenu);
			
			addGhostButton(14, "Back", dataRouter);
		}
		

		/**
		 * Display the loading interface
		 */
		private function loadGameMenu():void
		{
			clearOutput2();
			kGAMECLASS.userInterface.dataButton.Glow();
			
			var displayMessage:String = "";
			displayMessage += "<b>Which slot would you like to load?</b>\n";
			
			kGAMECLASS.userInterface.clearGhostMenu();
			
			for (var slotNum:int = 1; slotNum <= 14; slotNum++)
			{
				var dataFile:SharedObject = this.getSO(slotNum);
				displayMessage += this.generateSavePreview(dataFile, slotNum);
				if (this.slotCompatible(dataFile) == true)
				{
					addGhostButton(slotNum - 1, "Slot " + slotNum, this.loadGameData, slotNum);
				}
				else
				{
					addDisabledGhostButton(slotNum - 1, "Slot " + slotNum);
				}
			}
			
			output2(displayMessage);
			output2("\n");
			addGhostButton(14, "Back", this.showDataMenu);
		}
		
		/**
		 * Display the saving interface
		 */
		private function saveGameMenu():void
		{
			clearOutput2();
			kGAMECLASS.userInterface.dataButton.Glow();
			
			var displayMessage:String = "";
			displayMessage += "<b>Which slot would you like to save in?</b>\n";
			
			kGAMECLASS.userInterface.clearGhostMenu();
			
			for (var slotNum:int = 1; slotNum <= 14; slotNum++)
			{
				var dataFile:SharedObject = this.getSO(slotNum);
				displayMessage += this.generateSavePreview(dataFile, slotNum);
				addGhostButton(slotNum - 1, "Slot " + slotNum, this.saveGameData, slotNum);
			}
			
			output2(displayMessage);
			addGhostButton(14, "Back", this.showDataMenu);
		}
		
		/**
		 * Generate a preview of a given slotNumber for use by the display methods
		 * @param	slotNumber Number to preview
		 * @return	String describing the contents of the slot
		 */
		private function generateSavePreview(dataFile:SharedObject, slotNumber:int):String
		{
			var returnString:String = "";
			
			// Various early-outs
			if (dataFile.data.version == undefined)
			{
				return (String(slotNumber) + ": <b>EMPTY</b>\n\n");
			}
			
			if (dataFile.data.minVersion > DataManager.LATEST_SAVE_VERSION)
			{
				return (String(slotNumber) + ": <b>INCOMPATIBLE</b>\n\n");
			}
			
			// Valid file to preview!
			returnString += slotNumber;
			returnString += " - Kara Volke - (";
			
			if (dataFile.data.gameState.hours < 10) returnString += "0";
			returnString += dataFile.data.gameState.hours;
			returnString += ":";
			
			if (dataFile.data.gameState.minutes < 10) returnString += "0";
			returnString += dataFile.data.gameState.minutes;
			returnString += " Days: " + dataFile.data.gameState.days + ")";
			
			returnString += "\n\t<b>Location:</b> " + StringUtil.toTitleCase(dataFile.data.gameState.roomName) + " / " + StringUtil.toTitleCase(dataFile.data.gameState.planetName) + " / " + StringUtil.toTitleCase(dataFile.data.gameState.systemName);
			
			returnString += "\n";
			return returnString;
		}
		
		/**
		 * Grab data from around the game and stuff it into a shared object for serialization
		 * @param	slotNumber
		 */
		private function saveGameData(slotNumber:int):void
		{
			// Save the "last active slot" for autosave purposes within the DataManager properties
			_lastManualDataSlot = slotNumber;
			
			var dataFile:SharedObject = this.getSO(slotNumber);
			var dataBlob:Object = new Object();
			
			// Call helper method(s) to do the actual saving of datas
			this.saveBaseData(dataBlob);
			
			// VERIFY SAVE DATA BEFORE DOING FUCK ALL ELSE
			if (this.verifyBlob(dataBlob))
			{
				// Verification successful, do things
				this.replaceDataWithBlob(dataFile, dataBlob);
				dataFile.flush();
				clearOutput2();
				kGAMECLASS.userInterface.dataButton.Glow();
				output2("Game saved to slot " + slotNumber + "!");
				clearGhostMenu();
				addGhostButton(14, "Back", this.showDataMenu);
			}
			else
			{
				// Verification failed, ERROR ERROR ABORT
				var brokenFile:SharedObject = SharedObject.getLocal("broken_save", "/");
				this.replaceDataWithBlob(brokenFile, dataBlob);
				brokenFile.flush();
				
				clearOutput2();
				kGAMECLASS.userInterface.dataButton.Glow();
				output2("Save data verification failed. Please send the files 'broken_save.sol' and 'TiTs_" + slotNumber + ".sol' to Fenoxo or file a bug report!");
				clearGhostMenu();
				addGhostButton(14, "Back", this.showDataMenu);
			}
		}
		
		/**
		 * Method to append the "minimum" version we expect into the save file -- aka version 1
		 * @param	obj
		 */
		private function saveBaseData(dataFile:Object):void
		{
			// Versioning Information
			dataFile.version 		= DataManager.LATEST_SAVE_VERSION;
			dataFile.minVersion 	= DataManager.MINIMUM_SAVE_VERSION;
			dataFile.gameState 		= GameState.getSaveObject();
		}
		
		/**
		 * Load the given slot numbers save data
		 * @param	slotNumber
		 */
		private function loadGameData(slotNumber:int):void
		{
			clearOutput2();
			kGAMECLASS.userInterface.dataButton.Glow();
			
			// Save the "last active slot" for autosave purposes within the DataManager properties
			_lastManualDataSlot = slotNumber;
			
			var dataFile:SharedObject = this.getSO(slotNumber);
			var dataObject:Object;
			var dataErrors:Boolean = false;
			
			// Check we can get version information out of the file
			if (dataFile.data.version == undefined)
			{
				this.printDataErrorMessage("version");
				dataErrors = true;
			}
			
			if (dataFile.data.minVersion == undefined && dataFile.data.version > 2) // Special second conditional for v1 saves
			{
				this.printDataErrorMessage("minVersion");
				dataErrors = true;
			}
			
			// Check that the minVersion isn't above our latest version
			if (dataFile.data.minVersion > DataManager.LATEST_SAVE_VERSION)
			{
				output2("This save file requires a minimum save format version of " + DataManager.LATEST_SAVE_VERSION + " for correct support. Please use a newer version of the game!\n\n");
				dataErrors = true;
			}
			
			// If we're good so far, check if we need to upgrade the data
			if (!dataErrors)
			{
				dataObject = this.getFileData(dataFile);
				
				if (dataFile.data.version < DataManager.LATEST_SAVE_VERSION)
				{
					// Loop over each version to grab the correct implementations for upgrading
					while (dataObject.version < DataManager.LATEST_SAVE_VERSION)
					{
						try
						{
							(new (getDefinitionByName("classes.DataManager.SaveVersionUpgrader" + dataObject.version) as Class) as ISaveVersionUpgrader).upgrade(dataObject);
						}
						catch (error:VersionUpgraderError)
						{
							trace("Error thrown in data loader!", error);
							trace("Traceback = \n", error.getStackTrace());
							dataErrors = true;
						}
					}
				}
			}
			
			var gamePtr:* = kGAMECLASS;
			
			// We should now have the latest version of a game save structure -- Final verify
			if (!dataErrors)
			{
				dataErrors = !this.verifyBlob(dataObject);
			}
			
			// Now we can shuffle data into disparate game systems 
			var saveBackup:Object = new Object();
			
			dataErrors = this.loadBaseData(dataObject, saveBackup);
			
			// Do some output shit
			if (!dataErrors)
			{
				kGAMECLASS.updateUI();
				output2("Game loaded from 'TiTs_" + slotNumber + "'!");
				kGAMECLASS.userInterface.clearGhostMenu();
				addGhostButton(0, "Next", this.executeGame);
			}
			else
			{
				if (GameState.gameStarted)
				{
					var ph:Object = new Object();
					this.loadBaseData(saveBackup, ph);
				}
				
				output2("Error: Could not load game data.");
				clearGhostMenu();
				addGhostButton(14, "Back", this.showDataMenu);
			}
		}
		
		/**
		 * Method to extract the base data from the save object and shuffle it into various game systems.
		 * Need to add some error handling in here
		 * @param	obj
		 */
		private function loadBaseData(obj:Object, curGameObj:Object):Object
		{
			trace("loadBaseData");
			// Base/Primary information
			var prop:String;
			var i:int;
			
			// Watch this magic
			if (GameState.gameStarted)
			{
				this.saveBaseData(curGameObj); // Current game state backed up! Shocking!
			}
			
			// Game state
			GameState.loadSaveObject(obj.gameState);
			
			// Returns the backup
			return false;
		}
		
		private function printDataErrorMessage(property:String):void
		{
			output2("Data property " + property + " was expected, but unset. This save is possibly corrupt!\n\n");
			return;
		}
		
		private function printThrownError(error:Error):void
		{
			output2("<b>Processing failed: </b>" + error.message + "\n\n");
			return;
		}
			
		/**
		 * Verify that ALL of the properties we expect to be present on a save data element, for this version of a save, are present and sane.
		 * This works during both save AND load for the "simple" data. Probably extend it into complex types later
		 * @param	data Data blob to verify
		 * @return	Boolean true/false of verification
		 */
		private function verifyBlob(data:Object):Boolean
		{
			// The idea is to check for many, basic properties on the data file to make sure we have EVERYTHING defined as a final-verify step before actually saving or loading a file
			// During save, we're going to operate under the assumption that our complex-type save method (ie creature.getSaveObject() has done its own verification)
			// We COULD pass the blob back and run another verify, but this is a quick, cheap-ish way 
			if (data.version == undefined) throw new Error("Version failed");	
			if (data.minVersion == undefined) throw new Error("minVersion failed");
			return true;
		}
		
		/**
		 * "Resume" game post load. There are a handful of references to this method around the game...
		 */
		public function executeGame():void
		{
			//Purge out the event buffer so people can't buy something, load, and then get it.
			kGAMECLASS.eventQueue = new Array();
			kGAMECLASS.eventBuffer = "";
			
			// If the text input was being displayed, hide it
			kGAMECLASS.removeInput();
			
			kGAMECLASS.userInterface.dataButton.Deactivate();
			kGAMECLASS.userInterface.showPrimaryOutput();
			
			// Trigger an attempt to update display font size
			kGAMECLASS.refreshFontSize();
			kGAMECLASS.mainGameMenu();
		}
		
		private function doAutoSave():void
		{
			if (_autoSaveEnabled)
			{
				if (_lastManualDataSlot != -1)
				{
					this.saveGameData(_lastManualDataSlot);
				}
			}
		}
		
		private function slotCompatible(dataFile:SharedObject):Boolean
		{
			if (dataFile.data.version == undefined)
			{
				return false;
			}
			else if (dataFile.data.minVersion == undefined) // Special case for V1 saves
			{
				return true;
			}
			else if (dataFile.data.minVersion > DataManager.LATEST_SAVE_VERSION)
			{
				return false;
			}
			else
			{
				return true;
			}
		}
	}

}