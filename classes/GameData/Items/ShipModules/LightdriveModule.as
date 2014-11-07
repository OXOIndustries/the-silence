package classes.GameData.Items.ShipModules 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public class LightdriveModule extends ShipModule
	{
		
		public function LightdriveModule() 
		{
			type = ShipModule.TYPE_LIGHTDRIVE;
		}
		
		// Power required to activate the light drive whilst in combat
		// Expressed as a percentage of maximum reactor/capacitor power
		public var activationPower:Number = 0.75;
		
		// Maximum speed of the light drive.
		// Expressed as a precentage of C.
		public var maximumSpeed:Number = 0.9;
		
		// Number of rounds required to spool the engine for an escape attempt
		public var spoolRounds:int = 3;
	}

}