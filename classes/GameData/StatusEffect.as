package classes.GameData 
{
	/**
	 * ...
	 * @author Gedan
	 */
	
	public class StatusEffect 
	{
		public var name:String = "";
		public var tooltipHeader:String = "";
		public var tooltipDescription:String = "";
		
		// Note- we can probably create inherted versions of StatusEffect and use custom payloads. 
		// None of the *generic* handling code looks into payload for general operation of the system, so
		// we can effective override "payload" with new types, and get IDE-type/property checking.
		// Dynamic objects at a base level will always work though!
		public var payload:Object = { }; 
		
		// Functions defined here should have the following signature
		// onX = function(se:StatusEffect, ship:Ship):void
		// This allows for the properties of the effect to be passed into the function (se) and the ship that will 
		// recieve the changes of this effect.
		public var onRemoveFuncLookup:String = "exampleOnRemove";
		public var onCreateFuncLookup:String = "exampleOnCreate";
		
		/* OKAY
		 * Basically, because status effects need to be a serializable property, there are certain things we can't do here.
		 * The most natural means of handling this would be to let you just inline create a function ala:
		 *
		 * public var onRemove:Function;
		 * ...
		 * onRemove = function(se:StatusEffect, ship:Ship):void 
		 * { 
		 * 		// do thing 
		 * }
		 *
		 * But this can't be saved. At all. Ever. At least as far as I am aware. (WEEEEEELL it could be, but there are other issues to consider there as well; namely bugs will persist. See ByteCote ByteArray Serialization).
		 * If we had an Effect library like CoC, this would be okay, as the class definition of each individual function would also hold current runtime references to each function. But that was a pretty shit system and I don't like it.
		 * INSTEAD, what we're going to have to do is implement the functions in a location that we can look them up.
		 * All functions need to go in another library class (EffectFunctionLibrary).
		 * What we STORE and SET in each status effect that USES these functions is the NAME of the function.
		 * Then, during execution, we'll use the string representation of the function name as a lookup in that library class to find, and execute, the appropriate function.
		 * 
		 * I think given that the functions are only going to be used by a smaller percentage of the total status effects we ever create, this is a decent middle ground- we get the flexibility of just dumbshit inline created status effects as-and-when we want, but we also get to automate a bunch of the effect handling when and where it makes sense, on a case-by-case basis.
		 * 
		 * As a thought experiment: We could also build GENERIC functions that will operate based off of the DYNAMICALLY NAMED PROPERTIES contained within payload. Consider:
		 * 
		 * onRemoveDebuffEffect(se:StatusEffect, ship:Ship):void
		 * {
		 * 		// Payload contains key:value pairs of ShipPropertyName:ValueRemoved
		 * 		// ie for a Creature example:
		 * 		// payload = { intelligenceMod: 5, physiqueMod: 2 }
		 * 
		 * 		for (var prop:String in se.payload)
		 * 		{
		 * 			ship[prop] += se.payload[prop];
		 * 		}
		 * }
		 */
		
		public function get onRemove():Function
		{ 
			if (onRemoveFuncLookup != null && onRemoveFuncLookup.length > 0)
			{
				if (EffectFunctionLibrary[onRemoveFuncLookup] != undefined)
				{
					return EffectFunctionLibrary[onRemoveFuncLookup];
				}
				else
				{
					trace("Couldn't find the associated function name for the declared effect '" + onRemoveFuncLookup + "'");
				}
			}
		}
		public function get onCreate():Function 
		{
			if (onCreateFuncLookup != null && onCreateFuncLookup.length > 0)
			{
				if (EffectFunctionLibrary[onCreateFuncLookup] != undefined)
				{
					return EffectFunctionLibrary[onCreateFuncLookup];
				}
				else
				{
					trace("Couldn't find the associated function name for the declared function '" + onCreateFuncLookup + "'");
				}
			}
		}
				
		public static const DURATION_TIME:String = "time";
		public static const DURATION_ROUNDS:String = "rounds";
		public static const DURATION_PERM:String = "perm";
		public var combatOnly:Boolean = false;
		public var durationMode:String = DURATION_PERM;
		public var duration:int = -1;
		
		public var iconClass:Class = null;
		
		public function StatusEffect(seName:String, sePayload:Object, seDuration:int = -1, seDurationType:String = DURATION_PERM, seIconClass:Class = null, removeAfterCombat:Boolean = false, seOnRemove:String = "", seOnCreate:String = "") 
		{
			name = seName;
			payload = sePayload;
			duration = seDuration;
			durationMode = seDurationType;
			iconClass = seIconClass;
			combatOnly = removeAfterCombat;
			onRemoveFuncLookup = seOnRemove;
			onCreateFuncLookup = seOnCreate;
		}
	}
}