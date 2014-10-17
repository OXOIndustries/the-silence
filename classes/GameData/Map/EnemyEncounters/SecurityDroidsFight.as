package classes.GameData.Map.EnemyEncounters 
{
	import classes.GameData.Map.EnemyEncounter;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.num2Text;
	import classes.GameData.Characters.SecurityDroid;
	import classes.GameData.CombatManager;
	import classes.GameData.GameState;
	import classes.GameData.CodexManager;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class SecurityDroidsFight extends EnemyEncounter
	{
		
		public function SecurityDroidsFight() 
		{
			EnemyType = SecurityDroid;
		}
		
		override public function IsEnabled():Boolean
		{
			if (GameState.flags["CONSTELLATION_DRONES_DEACTIVATED"] == undefined) return true;
			return false;
		}
		
		override public function EncounterFunction():Boolean
		{
			if (IsEnabled())
			{
				if (GameState.flags["SECURITY_DROIDS_STEPS"] == undefined) GameState.flags["SECURITY_DROIDS_STEPS"] = 0;
				GameState.flags["SECURITY_DROIDS_STEPS"]++;
				
				if (GameState.flags["SECURITY_DROIDS_STEPS"] < 3) return false;
	
				if (rand(8) <= GameState.flags["SECURITY_DROIDS_STEPS"])
				{
					var numDroids:int = rand(2) + 2;
					
					output("\n\nAhead, you hear heavy mechanical footfalls marching in unison, stomping towards you down the corridor. A group of " + num2Text(numDroids) + " gray, steel droids march around the corner!");
					
					if (!CodexManager.entryUnlocked("Security Droids"))
					{
						CodexManager.unlockEntry("Security Droids");
						output("\n\n(<b>Codex entry: 'Security Droids' unlocked!</b>)");
					}
					
					clearMenu();
					addButton(0, "Fight!", actualEncounterFunction, numDroids);
					
					
					return true;
				}
			}
			
			return false;
		}
		
		private function actualEncounterFunction(numDroids:int):void
		{
			var enemies:Array = [];
					
			for (var i:int = 0; i < numDroids; i++)
			{
				enemies.push(new SecurityDroid());
			}
			
			CombatManager.newGroundCombat();
			CombatManager.setPlayers(GameState.playerParty.getParty());
			CombatManager.setEnemies(enemies);
			CombatManager.victoryCondition(CombatManager.ENTIRE_PARTY_DEFEATED);
			CombatManager.victoryScene(CombatManager.GenericVictory);
			CombatManager.lossCondition(CombatManager.ENTIRE_PARTY_DEFEATED);
			CombatManager.lossScene(CombatManager.GenericLoss);

			CombatManager.beginCombat();
			
			GameState.flags["SECURITY_DROIDS_STEPS"] = 0;
		}
		
	}

}