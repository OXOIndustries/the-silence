package classes.GameData.Items.ShipModules.Defensive 
{
	import classes.GameData.Items.ShipModules.DefensiveModule;
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	/**
	 * ...
	 * @author Gedan
	 */
	public class StalwartDefenseCoLightPlating extends DefensiveModule
	{
		public function StalwartDefenseCoLightPlating() 
		{
			moduleShortName = "LPlating";
			moduleFullName = "Stalwart Defense Co Light Plating";
			moduleDescription = "";
			
			defensiveType = DefensiveModule.DEF_PLATING;
			
			bonusHullResistances = new ResistanceCollection(0.0, 0.0, 30.0, 0.0);
			bonusHull = 25;
		}	
	}
}