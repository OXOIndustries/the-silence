package classes.GameData.Items.Guns 
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class Handaxes extends ItemSlotClass
	{
		
		public function Handaxes() 
		{
			this._latestVersion = 1;

			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.RANGED_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "Hand Axes";
			
			//Regular name
			this.longName = "hand axes";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a bandolier of handaxes";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "A collection of small throwing axes worn as a bandolier across the chest.";
			this.attackVerb = "throw";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 2000;
			this.attack = 2;
			this.damage = 15;
			this.damageType = GLOBAL.KINETIC;
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