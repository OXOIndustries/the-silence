package classes.GameData.Items.ShipModules.Engines 
{
	import classes.GameData.Items.ShipModules.EngineModule;
	/**
	 * ...
	 * @author Gedan
	 */
	public class HYDIonTruster extends EngineModule
	{
		
		public function HYDIonTruster() 
		{
			moduleShortName = "IonThrust.";
			moduleFullName = "Hayden Drive Yards Ion Thrusters";
			moduleDescription = "";
			
			agilityModifier = 1.25;
			maneuveringSpeed = 7.5;
		}
		
	}

}