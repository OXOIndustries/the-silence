package classes.GameData.Items.ShipModules 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public class ResistancePair 
	{
		public static const RESISTANCE_EM:String = "em";
		public static const RESISTANCE_KINETIC:String = "kin";
		public static const RESISTANCE_EXPLOSIVE:String = "exp";
		public static const RESISTANCE_THERMAL:String = "therm";
		
		public function ResistancePair(type:String, resistance:Number) 
		{
			ResistsType = type;
			ResistAmount = resistance;
		}
		
		public var ResistsType:String;
		public var ResistAmount:Number;
	}

}