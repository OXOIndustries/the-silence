package classes.GameData.Items.ShipModules.Navigation 
{
	import classes.GameData.Items.ShipModules.NavigationModule;
	/**
	 * ...
	 * @author Gedan
	 */
	public class RourkeBlackstarsModifiedEmissionMasker extends NavigationModule
	{	
		public function RourkeBlackstarsModifiedEmissionMasker() 
		{
			moduleShortName = "RBMasker";
			moduleFullName = "Rourke Blackstar's Modified Engine Emission Diffuser";
			moduleDescription = "";
			
			navType = NavigationModule.NAV_MASKER;
			escapeChanceMultiplier = 0.5;
		}
	}
}