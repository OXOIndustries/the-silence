package classes.GameData.Items.ShipModules.Offensive.Special 
{
	import classes.GameData.Items.ShipModules.OffensiveModule;
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	/**
	 * ...
	 * @author Gedan
	 */
	public class SingularityAnchor extends OffensiveModule
	{
		
		public function SingularityAnchor() 
		{
			moduleShortName = "GravAnchor";
			moduleFullName = "KihaCorp Singularity Anchor";
			moduleDescription = "";
			
			powerconsumption = 10;
			powergrid = 150;
			moduleRemovable = true;
			weaponType = OffensiveModule.WEAPON_TYPE_IMMOBILISE;
			trackingModifier = 3.0;
			criticalChance = 0;
			damage = new ResistanceCollection(0, 0, 0, 0);
			autoFires = false;
		}
		
	}

}