package classes.GameData.Items.ShipModules.Offensive.Lasers 
{
	import classes.GameData.Items.ShipModules.OffensiveModule;
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	/**
	 * ...
	 * @author Gedan
	 */
	public class ReaperTwinLinkedLaserCannons extends OffensiveModule
	{
		public function ReaperTwinLinkedLaserCannons() 
		{
			moduleShortName = "TX LCannon";
			moduleFullName = "Reaper Armaments Twin-Linked Forward Firing Laser Cannon";
			moduleDescription = "";
			
			powerconsumption = 10;
			powergrid = 20;
			moduleRemovable = true;
			weaponType = OffensiveModule.WEAPON_TYPE_LASER;
			damage = new ResistanceCollection(6.5, 0.0, 0.0, 3.5);
			trackingModifier = 3.0;
			criticalChance = 5.0;
			autoFires = true;
		}
		
	}

}