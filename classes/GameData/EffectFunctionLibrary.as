package classes.GameData 
{
	import classes.GameData.Ships.Ship;
	import classes.Resources.StatusIcons;
	
	/**
	 * Static function library that can be used to bind string names for functions assigned to a status effect to a goal function.
	 * @author Gedan
	 */
	
	public class EffectFunctionLibrary 
	{
		public function EffectFunctionLibrary() { }
		
		// All functions should have the following signature
		// public static function [name](se:StatusEffect, ship:Ship):void
		public static function exampleOnCreate(se:StatusEffect, ship:Ship):void
		{
			trace("exampleOnCreate called for", se.name, "on", ship.longName);
		}
		
		public static function exampleOnRemove(se:StatusEffect, ship:Ship):void
		{
			trace("exampleOnRemove called for:", se.name, "on", ship.longName);
		}
		
		public static function buff(se:StatusEffect, ship:Ship):void
		{
			for (var prop:String in se.payload)
			{
				if (se[prop])
				{
					se[prop] += se.payload[prop];
				}
			}
		}
		public static function debuff(se:StatusEffect, ship:Ship):void
		{
			for (var prop:String in se.payload)
			{
				if (se[prop])
				{
					se[prop] -= se.payload[prop];
				}
			}
		}
		
		// Basically, certain effects that we'll display to the user will nest child effects.
		// These child effects will effectively be reference-counted- ergo, we could apply 3 different immobilises
		// and have the root immobilise check only removed with the end of the final effect.
		// This is done by using the root effect handlers in the "displayed" effects onCreate/onRemove.
		// see: SingularityAnchor.attackTarget function for an example.
		public static function applyImmobilise(se:StatusEffect, ship:Ship):void
		{
			var iEffect:StatusEffect;
			
			// Add to the effect count if already present
			if (ship.hasStatusEffect("Immobilise"))
			{
				iEffect = ship.getStatusEffect("Immobilise");
				iEffect.payload.count++;
			}
			// Otherwise init to count of 1
			else
			{
				iEffect = new StatusEffect("Immobilise", { count: 1 }, 0, StatusEffect.DURATION_PERM, null, true, true, "", "");
				ship.addStatusEffect(iEffect);
			}
		}
		public static function removeImmobilise(se:StatusEffect, ship:Ship):void
		{
			var iEffect:StatusEffect;
			
			if (ship.hasStatusEffect("Immobilise"))
			{
				iEffect = ship.getStatusEffect("Immobilise");
				iEffect.payload.count--;
			}
			else
			{
				trace("Warning: The Immobilise status effect has already been removed! (Possibly removed by Effect Cleanup)");
			}
			
			if (iEffect.payload.count <= 0)
			{
				ship.removeStatusEffect("Immobilise");
			}
		}
		
	}

}