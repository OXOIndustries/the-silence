package classes.GameData.Items.ShipModules.Shields 
{
	import classes.GameData.Items.ShipModules.ShieldModule;
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	/**
	 * ...
	 * @author Gedan
	 */
	public class VWInverseHarmonicShield extends ShieldModule
	{
		
		public function VWInverseHarmonicShield() 
		{
			moduleShortName = "VW Shield";
			moduleFullName = "VoidWorks Inverse Harmonic Shield Generator";
			moduleDescription = "";
			
			baseShield = 180;
			shieldRecharge = 0.33;
			
			shieldResistances = new ResistanceCollection(40.0, 50.0, 85.0, 40.0);
		}
		
	}

}