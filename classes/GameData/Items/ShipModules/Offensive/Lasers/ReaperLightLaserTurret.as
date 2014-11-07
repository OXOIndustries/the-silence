package classes.GameData.Items.ShipModules.Offensive.Lasers 
{
	import classes.GameData.Items.ShipModules.OffensiveModule;
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	/**
	 * ...
	 * @author Gedan
	 */
	public class ReaperLightLaserTurret extends OffensiveModule
	{
		
		public function ReaperLightLaserTurret() 
		{
			moduleShortName = "LL Turret";
			moduleFullName = "Reaper Armaments Light Laser Turret";
			moduleDescription = "";
			
			powerconsumption = 3;
			powergrid = 3;
			moduleRemovable = true;
			weaponType = OffensiveModule.WEAPON_TYPE_LASER;
			trackingModifier = 3.5;
			critcalChance = 5.0;
			autoFires = true;
			damage = new ResistanceCollection(3.0, 0.0, 0.0, 1.0);
		}
		
	}

}