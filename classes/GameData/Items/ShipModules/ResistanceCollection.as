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
		
		public function ResistanceCollection(emR:Number = 0, kinR:Number = 0, expR:Number = 0, thermR:Number = 0) 
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
		
		public function getCopy():ResistanceCollection
		{
			var ret:ResistanceCollection = new ResistanceCollection(em, kin, exp, therm);
		}
		
		public function multiply(m:Number = 2.0):void 
		{
			if (em > 0) em *= m;
			if (kin > 0) kin *= m;
			if (exp > 0) exp *= m;
			if (therm > 0) therm *= m;
		}
		
		public function add(rc:ResistanceCollection):void
		{
			em += rc.em;
			kin += rc.kin;
			exp += rc.exp;
			therm += rc.therm;
		}
		
		public function applyResistances(resistance:ResistanceCollection):void
		{
			if (em > 0) em *= ((100.0 - resistance.em) / 100.0);
			if (kin > 0) kin *= ((100 - resistance.kin) / 100.0);
			if (exp > 0) exp *= ((100 - resistance.exp) / 100.0);
			if (therm > 0) therm *= ((100 - resistance.therm) / 100.0);
		}
		
		public function getTotal():Number
		{
			return em + kin + exp + therm;
		}
		
	}

}