package classes.GameData.Items.ShipModules 
{
	import classes.DataManager.Serialization.UnversionedSaveable;
	/**
	 * ...
	 * @author Gedan
	 */
	public class ResistancePair extends UnversionedSaveable
	{
		public static const UNSET:String = "unset";
		public static const RESISTANCE_EM:String = "em";
		public static const RESISTANCE_KINETIC:String = "kin";
		public static const RESISTANCE_EXPLOSIVE:String = "exp";
		public static const RESISTANCE_THERMAL:String = "therm";
		
		public function ResistancePair(type:String = UNSET, resistance:Number = 0) 
		{
			ResistsType = type;
			ResistAmount = resistance;
		}
		
		public var ResistsType:String;
		public var ResistAmount:Number;
	}

}