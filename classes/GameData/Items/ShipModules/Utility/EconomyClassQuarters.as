package classes.GameData.Items.ShipModules.Utility 
{
	import classes.GameData.Items.ShipModules.UtilityModule;
	/**
	 * ...
	 * @author Gedan
	 */
	public class EconomyClassQuarters extends UtilityModule
	{
		
		public function EconomyClassQuarters() 
		{
			this.utililtyType = UtilityModule.UTIL_CREWQ;
			
			this.bonusCrewComplement = 1;
		}
		
	}

}