package classes.GameData.Map.Data 
{
	import classes.GameData.Map.Data.Ships.TheSilenceInterior;
	import classes.GameData.Map.Data.Systems.UnknownSystem;
	import classes.GameData.Map.Sector;
	import classes.GameData.Map.System;
	
	import classes.GameData.Map.Data.Systems.SilenceSystem;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class SilenceSector extends Sector
	{
		public function SilenceSector() 
		{
			SectorIndex = "Silence";
			SectorName = "Sector 17-3B";
			
			AddSystem(new SilenceSystem());
			AddSystem(new UnknownSystem());
			AddShip(new TheSilenceInterior());
			
			GetShip("TheSilence").ParentSystem = GetSystem("UnknownSystem");
		}	
	}

}