package classes.GameData.Items.ShipModules.Defensive 
{
	import classes.GameData.Items.ShipModules.DefensiveModule;
	/**
	 * ...
	 * @author Gedan
	 */
	public class VoidworksRegenerativeHullAlloy extends DefensiveModule
	{
		
		public function VoidworksRegenerativeHullAlloy() 
		{
			moduleShortName = "HullRegen";
			moduleFullName = "Voidworks Regenerative Hull Alloy";
			moduleDescription = "";
			
			defensiveType = DefensiveModule.DEF_HULLREP;
			
			canRegenInCombat = true;
			canRegenOutOfCombat = false;
			
			regenRateInCombat = 0.07;
			powerconsumption = 200;
			regenRateOutOfCombat = 0.03;
			
			// TODO: Probably hack in something to handle the menu display option here-
			// probably cheat it, otherwise I have to implement the entire "Modules confer Abilities" stack.
		}
		
	}

}