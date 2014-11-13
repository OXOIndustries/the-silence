package classes.GameData.Items.ShipModules 
{

	/**
	 * ResistanceCollection is a dual-purpose storage class.
	 * Primarily, it contains a set of resistances used in ship combat, moving away from a floating array of values to a fixed interface.
	 * Secondly, it is actually used to define weapon damage-type splits. Rather than stating a raw damage value, weapons define damage as a ResistanceCollection- the value of each "Resistance" is actually the damage of the weapon of that damage type. Neat, right?
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