package classes.GameData.Items.ShipModules.Offensive.Lasers 
{
	import classes.GameData.Items.ShipModules.OffensiveModule;
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	/**
	 * ...
	 * @author Gedan
	 */
	public class QuadPumpedBeamArray extends OffensiveModule
	{
		
		public function QuadPumpedBeamArray() 
		{
			moduleShortName = "QP Beams";
			moduleFullName = "Voidworks modified Quad-Pumped Beam Array";
			moduleDescription = "";
			
			powerconsumption = 15;
			powergrid = 25;
			moduleRemovable = true;
			weaponType = OffensiveModule.WEAPON_TYPE_LASER;
			trackingModifier = 3;
			criticalChance = 7;
			autoFires = true;
			damage = new ResistanceCollection(11, 0, 0, 2);
		}
		
	}

}