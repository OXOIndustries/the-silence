package classes.GameData.Items.ShipModules.Offensive.Missiles 
{
	import classes.GameData.Items.ShipModules.OffensiveModule;
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	/**
	 * ...
	 * @author Gedan
	 */
	public class SteeleTechVanguardXXVIIMissileSystem extends OffensiveModule
	{
		
		public function SteeleTechVanguardXXVIIMissileSystem() 
		{
			moduleShortName = "V-XXVII FoF";
			moduleFullName = "Steele Tech Vanguard-XXVII Missile System";
			moduleDescription = "";
			
			powerconsumption = 3;
			powergrid = 40;
			moduleRemovable = true;
			weaponType = OffensiveModule.WEAPON_TYPE_MISSILE;
			damage = new ResistanceCollection(0.0, 2.0, 9.0, 1.0);
			trackingModifier = 3.0;
			criticalChance = 0.0;
			autoFires = true;
		}
		
	}

}