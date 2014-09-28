package classes.GameData.Map 
{
	/**
	 * Sectors contain Systems
	 * @author Gedan
	 */
	public class Sector 
	{
		public var SectorIndex:String;
		public var SectorName:String;
		
		public var Systems:Object = { };
		public var Ships:Object = { };
		
		public function Sector() 
		{
			
		}
		
		public function AddSystem(system:System):void
		{
			if (system.ParentSector == null)
			{
				Systems[system.SystemIndex] = system;
				system.ParentSector = this;
			}
			else
			{
				trace("System already exists within a Sector!");
			}
		}
		
		public function GetSystem(name:String):System
		{
			if (Systems[name] != undefined) return Systems[name];
			return null;
		}
		
		public function GetShip(name:String):Ship
		{
			if (Ships[name] != undefined) return Ships[name];
			return null;
		}
	}
}