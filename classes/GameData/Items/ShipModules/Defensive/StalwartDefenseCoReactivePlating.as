package classes.GameData.Items.ShipModules.Defensive 
{
	import classes.GameData.Items.ShipModules.DefensiveModule;
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	/**
	 * ...
	 * @author Gedan
	 */
	public class StalwartDefenseCoReactivePlating extends DefensiveModule
	{
		
		public function StalwartDefenseCoReactivePlating() 
		{
			moduleShortName = "RPlating";
			moduleFullName = "Stalwart DefenseCo Reactive Plating";
			moduleDescription = "";
			
			defensiveType = DefensiveModule.DEF_PLATING;
			
			bonusHull = 0;
			bonusHullResistances = new ResistanceCollection(0, 40, 0, 0);
		}
		
	}

}