package classes.GameData.Content 
{
	import classes.Creature;
	import classes.Engine.Interfaces.*;
	import classes.Engine.mainGameMenu;
	import classes.GameData.Characters.PlayerCharacter;
	import classes.GameData.ContentIndex;
	import classes.GameData.GameModel;
	import classes.GameData.Party;
	import classes.GUI;
	import classes.kGAMECLASS;
	import flash.utils.Dictionary;
	import classes.GameData.GameState;
	
	public class BaseContent 
	{
		protected function output(msg:String):void
		{
			classes.Engine.Interfaces.output(msg);
		}
		
		protected function output2(msg:String):void
		{
			classes.Engine.Interfaces.output2(msg);
		}
		
		protected function clearOutput():void
		{
			classes.Engine.Interfaces.clearOutput();
		}
		
		protected function clearOutput2():void
		{
			classes.Engine.Interfaces.clearOutput2();
		}
		
		protected function clearMenu():void
		{
			classes.Engine.Interfaces.clearMenu();
		}
		
		protected function addButton(slot:int, cap:String = "", func:Function = undefined, arg:* = undefined, ttHeader:String = null, ttBody:String = null):void
		{
			classes.Engine.Interfaces.addButton(slot, cap, func, arg, ttHeader, ttBody);
		}
		
		protected function get userInterface():GUI
		{
			return classes.Engine.Interfaces.userInterface();
		}
		
		protected function get silly():Boolean
		{
			return kGAMECLASS.gameOptions.sillyMode;
		}
		
		protected function set silly(v:Boolean):void
		{
			kGAMECLASS.gameOptions.sillyMode = v;
		}
		
		protected function get easy():Boolean
		{
			return kGAMECLASS.gameOptions.easyMode;
		}
		
		protected function set easy(v:Boolean):void
		{
			kGAMECLASS.gameOptions.easyMode = v;
		}
		
		protected function get debug():Boolean
		{
			return kGAMECLASS.gameOptions.debugMode;
		}
		
		protected function set debug(v:Boolean):void
		{
			kGAMECLASS.gameOptions.debugMode = v;
		}
		
		protected function get flags():Dictionary
		{
			return GameState.flags;
		}
		
		protected function get logan():Creature
		{
			return GameState.logan;
		}
		
		protected function get inSpaceCombat():Boolean
		{
			return GameState.inSpaceCombat;
		}
		
		protected function get inCombat():Boolean
		{
			return GameState.inCombat;
		}
		
		protected function get currentLocation():String
		{
			return GameState.currentLocation;
		}
		
		protected function set currentLocation(v:String):void
		{
			GameState.currentLocation = v;
		}
		
		protected function mainGameMenu():void
		{
			classes.Engine.mainGameMenu();
		}
		
		protected function get PlayerParty():Party
		{
			return GameState.playerParty;
		}
		
		protected function get EnemyParty():Party
		{
			return GameState.enemyParty;
		}
		
		protected function get pc():PlayerCharacter
		{
			return GameState.pc;
		}
		
		protected function get gameStarted():Boolean
		{
			return GameState.gameStarted;
		}
		
		protected function set gameStarted(v:Boolean):void
		{
			GameState.gameStarted = v;
		}
		
		protected function setLocation(room:String, planet:String = null, system:String = null):void
		{
			classes.Engine.Interfaces.setLocation(room, planet, system);
		}
	}

}