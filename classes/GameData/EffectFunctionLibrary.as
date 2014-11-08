package classes.GameData 
{
	import classes.GameData.Ships.Ship;
	
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
	}

}