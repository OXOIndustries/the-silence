package classes.GameData.Items.Melee 
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class Greataxe extends ItemSlotClass
	{
		
		public function Greataxe() 
		{
			this._latestVersion = 1;
			
			//A KNIFE
			//4
			
			//this.indexNumber = 4;
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "Greataxe";
			
			//Regular name
			this.longName = "massive greataxe";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a huge double-headed axe";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "A rather rudimentary- yet suprisingly effective- weapon.";
			this.attackVerb = "slash";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 1450;
			this.attack = 0;
			this.damage = 8;
			this.damageType = GLOBAL.SLASHING;
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			this.bonusResistances = new Array(0,0,0,0,0,0,0,0);

			this.version = _latestVersion;
		}
		
	}

}