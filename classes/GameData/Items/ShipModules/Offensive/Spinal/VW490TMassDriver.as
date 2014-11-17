package classes.GameData.Items.ShipModules.Offensive.Spinal 
{
	import classes.GameData.Items.ShipModules.OffensiveModule;
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	/**
	 * ...
	 * @author Gedan
	 */
	public class VW490TMassDriver extends OffensiveModule
	{
		
		public function VW490TMassDriver() 
		{
			moduleShortName = "490T MDriver";
			moduleFullName = "Voidworks Modified 490T Mass Driver";
			moduleDescription = "";
			
			powerconsumption = 90;
			powergrid = 400;
			moduleRemovable = false;
			weaponType = OffensiveModule.WEAPON_TYPE_SPINAL;
			trackingModifier = -1;
			autoFires = false;
			criticalChance = 0.0;
			damage = new ResistanceCollection(0, 70, 10, 40);
		}
		
	}

}