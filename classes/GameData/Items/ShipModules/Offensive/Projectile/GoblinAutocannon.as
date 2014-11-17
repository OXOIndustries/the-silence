package classes.GameData.Items.ShipModules.Offensive.Projectile 
{
	import classes.GameData.Items.ShipModules.OffensiveModule;
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	/**
	 * ...
	 * @author Gedan
	 */
	public class GoblinAutocannon extends OffensiveModule
	{
		
		public function GoblinAutocannon() 
		{
			moduleShortName = "Goblin AC";
			moduleFullName = "Synchrotech ‘Goblin’ Autocannon";
			moduleDescription = "";
			
			powerconsumption = 2;
			powergrid = 40;
			moduleRemovable = true;
			weaponType = OffensiveModule.WEAPON_TYPE_AUTOCANNON;
			trackingModifier = 3.0;
			criticalChance = 8.0;
			autoFires = true;
			damage = new ResistanceCollection(0, 2, 7, 2);
		}
		
	}

}