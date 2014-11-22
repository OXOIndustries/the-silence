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
			return new ResistanceCollection(em.ResistAmount, kin.ResistAmount, exp.ResistAmount, therm.ResistAmount);
		}
		
		public function multiply(m:Number = 2.0):void 
		{
			if (em.ResistAmount > 0) em.ResistAmount *= m;
			if (kin.ResistAmount > 0) kin.ResistAmount *= m;
			if (exp.ResistAmount > 0) exp.ResistAmount *= m;
			if (therm.ResistAmount > 0) therm.ResistAmount *= m;
		}
		
		public function add(rc:ResistanceCollection):void
		{
			em.ResistAmount += rc.em.ResistAmount;
			kin.ResistAmount += rc.kin.ResistAmount;
			exp.ResistAmount += rc.exp.ResistAmount;
			therm.ResistAmount += rc.therm.ResistAmount;
		}
		
		public function applyResistances(resistance:ResistanceCollection):void
		{
			if (em.ResistAmount > 0) em.ResistAmount *= ((100.0 - resistance.em.ResistAmount) / 100.0);
			if (kin.ResistAmount > 0) kin.ResistAmount *= ((100 - resistance.kin.ResistAmount) / 100.0);
			if (exp.ResistAmount > 0) exp.ResistAmount *= ((100 - resistance.exp.ResistAmount) / 100.0);
			if (therm.ResistAmount > 0) therm.ResistAmount *= ((100 - resistance.therm.ResistAmount) / 100.0);
		}
		
		public function getTotal():Number
		{
			return (em.ResistAmount + kin.ResistAmount + exp.ResistAmount + therm.ResistAmount);
		}
		
	}

}