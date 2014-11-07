package classes.GameData.Items.ShipModules 
{

	/**
	 * ...
	 * @author Gedan
	 */
	public class ResistanceCollection 
	{
		
		public function ResistanceCollection(emR:Number, kinR:Number, expR:Number, thermR:Number) 
		{
			em = new ResistancePair(ResistancePair.RESISTANCE_EM, emR);
			kin = new ResistancePair(ResistancePair.RESISTANCE_KINETIC, kinR);
			exp = new ResistancePair(ResistancePair.RESISTANCE_EXPLOSIVE, expR);
			therm = new ResistancePair(ResistancePair.RESISTANCE_THERMAL, thermR);
		}
		
		public var em:ResistancePair;
		public var kin:ResistancePair;
		public var exp:ResistancePair 
		public var therm:ResistancePair
		
	}

}