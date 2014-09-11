package classes.GameData.Map 
{
	import flash.geom.Point;
	/**
	 * Systems contain BaseLocations - Places & Ships (for now)
	 * @author Gedan
	 */
	public class System 
	{
		public var SystemIndex:String;
		public var SystemName:String;
		
		public var Position:Point;
		
		public var ParentSector:Sector;
		
		public var ChildLocations:Object = { };
		
		public var IsNavigable:Boolean = true; // Can actually travel to it on the map
		
		
		public function System() 
		{
			
		}
		
		public function AddLocation(location:BaseLocation):void
		{
			if (location is Ship || location is Place)
			{
				if (location.ParentSystem == null)
				{
					ChildLocations[location.LocationIndex] = location;
					location.ParentSystem = this;
				}
				else
				{
					trace("Location is already assigned to a System!");
				}
			}
			else
			{
				trace("Location is not a Ship or a Place thus cannot be added to a System.");
			}
		}
		
		public function GetLocation(name:String):BaseLocation
		{
			return ChildLocations[name];
		}
	}
}