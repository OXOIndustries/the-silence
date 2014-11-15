package classes.Engine.Combat.SpaceCombat 
{
	import classes.GameData.Items.ShipModules.ResistanceCollection;
	/**
	 * ...
	 * @author Gedan
	 */
	public class AttackDamageResult 
	{
		public var totalDamage:Number = 0;
		public var typedTotalDamage:ResistanceCollection = new ResistanceCollection();
		
		public var shieldDamage:Number = 0;
		public var typedShieldDamage:ResistanceCollection = new ResistanceCollection();
		
		public var hullDamage:Number = 0;
		public var typedHullDamage:ResistanceCollection = new ResistanceCollection();
		
		public var wasCrit:Boolean = false;		
		
		public var remainingDamage:ResistanceCollection = new ResistanceCollection();
	}

}