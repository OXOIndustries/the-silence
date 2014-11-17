package classes.GameData.Items.ShipModules.Engines 
{
	import classes.GameData.Items.ShipModules.EngineModule;
	/**
	 * ...
	 * @author Gedan
	 */
	public class IonRXEngines extends EngineModule
	{
		
		public function IonRXEngines() 
		{
			moduleShortName = "IRX Engine";
			moduleFullName = "Synchrotech Ion-RX Engines";
			moduleDescription = "";
			
			agilityMultiplier = 1.1;
			maneuveringSpeed = 5;
		}
		
	}

}