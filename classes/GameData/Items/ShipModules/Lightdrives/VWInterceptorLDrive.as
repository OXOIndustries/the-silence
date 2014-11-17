package classes.GameData.Items.ShipModules.Lightdrives 
{
	import classes.GameData.Items.ShipModules.LightdriveModule;
	/**
	 * ...
	 * @author Gedan
	 */
	public class VWInterceptorLDrive extends LightdriveModule
	{
		
		public function VWInterceptorLDrive() 
		{
			moduleShortName = "V LDrive";
			moduleFullName = "Voidworks ‘Interceptor’ Lightdrive";
			moduleDescription = "";
			
			activationPower = 0.5;
			maximumSpeed = 0.75;
			spoolRounds = 1;
		}
		
	}

}