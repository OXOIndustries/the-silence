package classes.GameData.Items.ShipModules.Utility 
{
	import classes.GameData.Items.ShipModules.UtilityModule;
	/**
	 * ...
	 * @author Gedan
	 */
	public class AGENMedbayCivilianClass extends UtilityModule
	{
		
		public function AGENMedbayCivilianClass() 
		{
			moduleShortName = "Medbay";
			moduleFullName = "AGEN Civilian-class Medbay";
			moduleDescription = "";
			utililtyType = UtilityModule.UTIL_MEDICAL;
			powergrid = 15;
		}
		
	}

}