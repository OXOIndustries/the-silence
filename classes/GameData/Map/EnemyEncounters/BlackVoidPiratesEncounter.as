package classes.GameData.Map.EnemyEncounters 
{
	import classes.GameData.Characters.BlackVoidPirate;
	import classes.GameData.Items.ShipModules.Navigation.RourkeBlackstarsModifiedEmissionMasker;
	import classes.GameData.Map.EnemyEncounter;
	import flash.utils.Dictionary;
	import classes.GameData.GameState;
	import classes.GameData.CombatManager;
	import classes.GameData.ContentIndex;
	import classes.Engine.Interfaces.*;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class BlackVoidPiratesEncounter extends EnemyEncounter
	{
		
		public function BlackVoidPiratesEncounter() 
		{
			EnemyType = BlackVoidPirate;
		}
		
		override public function IsEnabled():Boolean
		{
			if (GameState.flags["DEFEATED_MIRI_SPESSCOMBAT"] == 1) return true;
			return false;
		}
		
		override public function EncounterFunction():Boolean
		{
			if (IsEnabled())
			{
				var f:Dictionary = GameState.flags;
				
				if (f["PIRATES_STEPS"] == undefined) f["PIRATES_STEPS"] = 0;
				f["PIRATES_STEPS"]++;
				
				if (f["PIRATES_STEPS"] < 3) return false;
				
				var num:int = rand(5);
				if (num <= f["PIRATES_STEPS"])
				{
					initEncounterFunction();
					return true;
				}
			}
			
			return false;
		}
		
		private function initEncounterFunction():void 
		{
			var numPirates:int = 3 + rand(2);
			
			output("\n\nCommand chatter cuts through the awkward, ominious groaning of the <i>Silence's</i> hull creaking and twisting after the collision. Whilst the <i>Black Rose</i> itself may no longer pose a danger, it sounds like her crew has come looking to finish the job.");
			
			clearMenu();
			addButton(0, "Fight!", actualEncounterFunction, numPirates);
		}
		
		private function actualEncounterFunction(numPirates:int):void
		{
			var enemies:Array = [];
			
			for (var i:int = 0; i < numPirates; i++)
			{
				enemies.push(new BlackVoidPirate());
			}
			
			CombatManager.newGroundCombat();
			CombatManager.setPlayers(GameState.playerParty.getCombatParty());
			CombatManager.setEnemies(enemies);
			CombatManager.victoryCondition(CombatManager.ENTIRE_PARTY_DEFEATED);
			CombatManager.victoryScene(piratesVictory);
			CombatManager.lossCondition(CombatManager.ENTIRE_PARTY_DEFEATED);
			CombatManager.lossScene(ContentIndex.shared.combatLossScene);
			CombatManager.entryScene(initEncounterFunction);
			GameState.flags["PIRATES_STEPS"] = 0;
			
			CombatManager.beginCombat();
		}
		
		private function piratesVictory():void
		{
			clearOutput();
			setLocation("VICTORY: BLACK VOID PIRATES");
			
			output("The last of <i>this</i> Black Void boarding crew falls to the floor, scorched armor and damaged weaponry skittering along the deck plating.");
			output("\n\nYou're going to have to stem the tide of invaders quickly, before too many of them make it aboard the <i>Silence</i> for you and your crew to deal with.");
			
			clearMenu();
			CombatManager.GenericVictory();
			CombatManager.postCombat();
		}
	}

}