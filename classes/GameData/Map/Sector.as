package classes.GameData.Map 
{
	/**
	 * Sectors contain Systems
	 * They're the "root" area that a game takes place in, and should setup all the things that will be explorable- planets, locations and ships.
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
		
		public function AddShip(ship:Ship):void
		{
			Ships[ship.LocationIndex] = ship;
		}
		
		public function GetShip(name:String):Ship
		{
			if (Ships[name] != undefined) return Ships[name];
			return null;
		}
	}
}