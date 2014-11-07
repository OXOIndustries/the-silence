package classes.GameData.Items.ShipModules 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public class ShieldModule extends ShipModule
	{
		
		public function ShieldModule() 
		{
			type = ShipModule.TYPE_SHIELD;
		}
		
		// Base Shield HP provided by the generator
		public var baseShield:Number = 100;
		
		// Modifier for the amount of shield generated against incoming power.
		// Acts as either a cost penalty (shield requires more power to recharge) or a bonus.
		public var shieldRecharge:Number = 0.33;
		
		// Resistances provided by the generator.
		public var shieldResistances:ResistanceCollection = new ResistanceCollection(0.0, 0.0, 0.0, 0.0);
	}

}