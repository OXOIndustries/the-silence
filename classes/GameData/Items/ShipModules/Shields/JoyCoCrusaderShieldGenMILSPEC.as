package classes.GameData.Items.ShipModules.Shields 
{
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	import classes.GameData.Items.ShipModules.ShieldModule;
	/**
	 * ...
	 * @author Gedan
	 */
	public class JoyCoCrusaderShieldGenMILSPEC extends ShieldModule
	{
		public function JoyCoCrusaderShieldGenMILSPEC() 
		{
			moduleShortName = "CShield";
			moduleFullName = "JoyCo Crusader Shield MILSPEC";
			moduleDescription = "";
			
			baseShield = 140;
			shieldRecharge = 0.45;
			
			shieldResistances = new ResistanceCollection(10.0, 40.0, 80.0, 30.0);
		}	
	}
}