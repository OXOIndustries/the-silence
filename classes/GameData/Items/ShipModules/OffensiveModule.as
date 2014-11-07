package classes.GameData.Items.ShipModules 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public class OffensiveModule extends ShipModule
	{
		public static const WEAPON_TYPE_UNDEFINED:String = "undef";
		public static const WEAPON_TYPE_LASER:String = "laser";
		public static const WEAPON_TYPE_AUTOCANNON:String = "autocannon";
		public static const WEAPON_TYPE_ACCELERATOR:String = "accelerator";
		public static const WEAPON_TYPE_MISSILE:String = "missile";
		public static const WEAPON_TYPE_SPINAL:String = "spinal";
		public static const WEAPON_TYPE_DRONES:String = "drones";
		public static const WEAPON_TYPE_ECM:String = "ecm";
		public static const WEAPON_TYPE_PULSED_SHIELD:String = "smartbomb";
		public static const WEAPON_TYPE_SPECIAL:String = "special";
		
		public function OffensiveModule() 
		{
			type = ShipModule.TYPE_WEAPON;
			weaponType = WEAPON_TYPE_UNDEFINED;
		}
		
		// Type-categorisation of the weapon system
		public var weaponType:String = WEAPON_TYPE_UNDEFINED;
		
		// Base damage of the weapon system
		public var damage:ResistanceCollection = new ResistanceCollection(4.5, 0.0, 0.0, 5.5);
		
		// This acts like the inverse of a target ships agility. Higher tracking weapons will have a greater chance to hit.
		public var trackingModifier:Number = 3.0;
		
		// Chance of a critical shot occuring.
		public var critcalChance:Number = 5.0;
		
		// System will activate when a "fire all" signal is recieved
		public var autoFires:Boolean = true;
	}

}