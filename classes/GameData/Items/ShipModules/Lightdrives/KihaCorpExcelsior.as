package classes.GameData.Items.ShipModules.Lightdrives 
{
	import classes.GameData.Items.ShipModules.LightdriveModule;
	/**
	 * ...
	 * @author Gedan
	 */
	public class KihaCorpExcelsior extends LightdriveModule
	{
		
		public function KihaCorpExcelsior() 
		{
			moduleShortName = "KC Excel";
			moduleFullName = "KihaCorp Excelsior-class Lightdrive";
			moduleDescription = "";
			
			activationPower = 0.66;
			maximumSpeed = 0.897;
			spoolRounds = 2;
		}
		
	}

}