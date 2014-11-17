package classes.GameData.Items.ShipModules.Defensive 
{
	import classes.GameData.Items.ShipModules.DefensiveModule;
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	/**
	 * ...
	 * @author Gedan
	 */
	public class StalwartDefenseCoAblativePlating extends DefensiveModule
	{
		
		public function StalwartDefenseCoAblativePlating() 
		{
			moduleShortName = "APlating";
			moduleFullName = "Stalwart DefenseCo Ablative Plating";
			moduleDescription = "";
			
			defensiveType = DefensiveModule.DEF_PLATING;
			
			bonusHull = 0;
			bonusHullResistances = new ResistanceCollection(0, 0, 40, 0);
			
		}
		
	}

}