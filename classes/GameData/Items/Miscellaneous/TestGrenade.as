package classes.GameData.Items.Miscellaneous 
{
	import classes.Creature;
	import classes.StringUtil;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.kGAMECLASS;
	import classes.Engine.Combat.InCombat;
	import classes.Engine.Interfaces.clearOutput;
	import classes.Engine.Interfaces.output;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class TestGrenade extends ItemSlotClass
	{
		public function TestGrenade()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.EXPLOSIVECONSUMABLE;
			
			this.shortName = "T.Gren";
			
			this.longName = "test grenade consumable";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			this.description = "a test grenade consumable";
			
			this.tooltip = "This is an item designed to test combat-item utilization.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			this.basePrice = 100;
			this.attack = 0;
			this.damage = 15;
			this.damageType = GLOBAL.THERMAL;
			this.defense = 0;
			this.shieldDefense = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			this.bonusResistances = new Array(0, 0, 0, 0, 0, 0, 0, 0);
			
			this.combatUsable = true;
			this.targetsSelf = false;
			
			this.version = this._latestVersion;
		}
		
		override public function useFunction(targetCreature:Creature, usingCreature:Creature = null):Boolean
		{
			if (!inCombat())
			{
				clearOutput();
				output("Pulling the pin on a grenade without a target to throw it at would be pretty dumb now, wouldn't it?");
				this.quantity++;
				return false;
			}
			else
			{
				// Player used an item
				if (usingCreature == kGAMECLASS.pc)
				{
					clearOutput();
					playerUsed(targetCreature, usingCreature);
				}
				// Enemy used an item on the PC
				else if (targetCreature == kGAMECLASS.pc && usingCreature != kGAMECLASS.pc)
				{
					output("\n");
					npcUsed(targetCreature, usingCreature);
				}
				else
				{
					throw new Error("Don't know how we got here. Exception for debugging.");
				}
				
				return false;
			}
		}
		
		public function playerUsed(targetCreature:Creature, usingCreature:Creature):void
		{
			output("You throw the grenade at the " + targetCreature.short + "!");
			
			// Ideally, should probably rebuild this function on a per-item basis to weave item-specific text
			// into the combat, and lean on the shield/hp damage functions
			// Or possibly open up genericDamageApply to also accept override text for its output
			//kGAMECLASS.genericDamageApply(this.damage, usingCreature, targetCreature, this.damageType);
			
			output("\n");
		}
		
		public function npcUsed(targetCreature:Creature, usingCreature:Creature):void
		{
			output(usingCreature + " threw a grenade at");
			if (targetCreature == kGAMECLASS.pc) output(" you!");
			else output(" " + targetCreature.short);
			
			//kGAMECLASS.genericDamageApply(this.damage, usingCreature, targetCreature, this.damageType);
		}
		
	}

}