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
		
		public var totalAttacks:int = 0;
		public var numMisses:int = 0;
		public var numHits:int = 0;
		public var numCrits:int = 0;
		
		public var remainingDamage:ResistanceCollection = new ResistanceCollection();
		
		public function addResult(o:AttackDamageResult):void
		{
			totalDamage += o.totalDamage;
			typedTotalDamage.add(o.typedTotalDamage);
			
			shieldDamage += o.shieldDamage;
			typedShieldDamage.add(o.typedShieldDamage);
			
			hullDamage += o.hullDamage;
			typedHullDamage.add(o.typedHullDamage);
			
			remainingDamage.add(o.remainingDamage);
			
			if (o.wasCrit) numCrits++;
			else numHits++;
		}
	}

}