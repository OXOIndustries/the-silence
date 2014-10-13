package classes.GameData.Characters 
{
	import classes.Creature;
	import classes.GameData.Items.Apparel.ProtectiveJacket;
	import classes.GameData.Items.Guns.PlasmaPistol;
	import classes.GameData.Items.Guns.Shotgun;
	import classes.GameData.Items.Melee.BigFuckingWrench;
	import classes.GameData.Items.Melee.ForceEdge;
	import classes.GameData.Items.Protection.DecentShield;
	import classes.kGAMECLASS;
	import classes.GLOBAL;
	import classes.Resources.Busts.StaticRenders;
	
	import classes.Engine.Combat.calculateDamage;
	import classes.Engine.Combat.calculateMiss;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class MirianBragga extends Creature
	{
		
		public function MirianBragga() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = false;
			
			this.short = "Mirian";
			this.long = "Captain Mirian Bragga";
			this.originalRace = "Human";
			this.description = "Miri Bragga. The Corsair. Reaver of the Ardent Rings. This bitch is seriously bad news, one of the most famous pirates in the galaxy. Worse, she's the vanguard for the Black Void, the biggest crime syndicate in Confederate space. To put it lightly: you don't want to get on her bad side. Bragga commands the Black Rose, a heavy frigate that could give an ausar cruiser a run for its money in sheer speed and firepower. It tore the Nova Security convoy to pieces all by itself, six against one. Beating her will be damn near impossible. Escape? Unlikely. But it's the best shot you've got.";
			
			this.customBlock = "";
			this.customDodge = "";
			this.plural = false;
			this.lustVuln = 1.0;
			
			this.meleeWeapon = new ForceEdge();
			this.rangedWeapon = new PlasmaPistol();
			this.armor = new ProtectiveJacket();
			this.shield = new DecentShield();
			
			this.INDEX = "MIRIAN";
			this.bustT = StaticRenders.MISSING;
			
			this.level = 5;
			this.physiqueRaw = 18;
			this.reflexesRaw = 18;
			this.aimRaw = 18;
			this.intelligenceRaw = 18;
			this.willpowerRaw = 18;
			this.libidoRaw = 60;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 0;
			this.resistances = [1, 1, 1, 1, 1, 1, 1, 1];
			this.XPRaw = 0;
			this.credits = 7875;
			this.HPMod = 15;
			this.HPRaw = this.HPMax();
			this.shieldsRaw = this.shieldsMax();
			
			this.femininity = 85;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "brown";
			this.tallness = 85;
			this.thickness = 40;
			this.tone = 35;
			this.hairColor = "brown";
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.furColor = "brown";
			this.hairLength = 6;
			
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SKIN;
			this.skinTone = "pale";
			this.skinFlags = [];
			this.faceType = GLOBAL.TYPE_HUMAN;
			this.faceFlags = [];
			
			this.tongueType = GLOBAL.TYPE_HUMAN;
			this.lipMod = 0;
			this.earType = 0;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_HUMAN;
			this.gills = false;
			this.wingType = GLOBAL.TYPE_HUMAN;
			this.legType = GLOBAL.TYPE_HUMAN;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_PLANTIGRADE];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_HUMAN;
			this.tailCount = 0;
			this.tailFlags = new Array();
			//Used to set cunt or dick type for cunt/dick tails!
			this.tailGenitalArg = 0;
			//tailGenital:
			//0 - none.
			//1 - cock
			//2 - vagina
			this.tailGenital = 0;
			//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
			this.tailVenom = 0;
			//Tail recharge determines how fast venom/webs comes back per hour.
			this.tailRecharge = 5;
			//hipRating
			//0 - boyish
			//2 - slender
			//4 - average
			//6 - noticable/ample
			//10 - curvy//flaring
			//15 - child-bearing/fertile
			//20 - inhumanly wide
			this.hipRatingRaw = 6;
			//buttRating
			//0 - buttless
			//2 - tight
			//4 - average
			//6 - noticable
			//8 - large
			//10 - jiggly
			//13 - expansive
			//16 - huge
			//20 - inconceivably large/big/huge etc
			this.buttRatingRaw = 6;
			//No dicks here!
			this.cocks = new Array();
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginalVirgin = false;
			this.vaginas[0].loosenessRaw = 2;
			this.vaginas[0].wetnessRaw = 5;
			this.vaginas[0].bonusCapacity = 55;
			//balls
			this.balls = 0;
			this.cumMultiplierRaw = 6;
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.cumType = GLOBAL.FLUID_TYPE_CUM;
			this.ballSizeRaw = 0;
			this.ballFullness = 1;
			//How many "normal" orgams worth of jizz your balls can hold.
			this.ballEfficiency = 10;
			//Scales from 0 (never produce more) to infinity.
			this.refractoryRate = 6;
			this.minutesSinceCum = 420;
			this.timesCum = 2862;

			this.elasticity = 1.6;
			//Fertility is a % out of 100. 
			this.clitLength = .5;
			//Savin wasn't around so I just threw a # in.
			this.breastRows[0].breastRatingRaw = 10;
			this.nippleColor = "dark green";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 0;
			this.ass.wetnessRaw = 0;
			this.ass.bonusCapacity += 15;
			
			this._isLoading = false;
		}
		
		override public function generateAIActions(sameTeam:Array, otherTeam:Array):void
		{
			if (HP() <= HPMax() * 0.25)
			{
				relentless();
			}
			
			var attacks:Array = [rangedAttack, rangedAttack, meleeAttack, meleeAttack, lasPistol, forcePunch];
			
			if (shieldsRaw > 0) attacks.push(forceSabre);
		}
		
		public function lasPistol(target:Creature):void
		{
			output("\n\nBragga levels her pistol at");
			if (target is PlayerCharacter) output(" you");
			else output(" " + target.a + target.short);
			output(", taking just a moment to steady her shot before squeezing the trigger. A searing beam of light lances forth,");
			
			if (calculateMiss(this, target, false, rangedWeapon.attack, 0.5))
			{
				output(" though");
				if (target is PlayerCharacter) output(" you're");
				else output(" " + target.a + target.short);
				output(" is able to dodge aside in the nick of time!");
			}
			else
			{
				output(" slamming into ");
				if (target is PlayerCharacter) output(" you");
				else output(" " + target.mf("him", "her"));
				output(" with deadly force.");
				
				calculateDamage(this, target, damage(false) + aim() + 10, rangedWeapon.damageType, "ranged", false);
			}
		}
		
		public function forceSabre(target:Creature):void
		{
			output("\n\nThe captain rushes towards ");
			if (target is PlayerCharacter) output("you");
			else output(target.a + target.short);
			output(", her shields coalescing around her hand into a long, razor-honed edge.");
			if (target is PlayerCharacter) output(" You");
			else output(" " + target.capitalA + target.short);
			output(" barely has a moment to react before she's on");
			if (target is PlayerCharacter) output(" you");
			else output(" " + target.mf("him", "her"));
			output(", slashing in a lethal arc");
		
			if (calculateMiss(this, target, true))
			{
				output(" that");
				if (target is PlayerCharacter) output(" you are");
				else output(" " + target.a + target.short + " is");
				output(" barely able to dodge!");
			}
			else
			{
				output(" that hammers into");
				if (target is PlayerCharacter) output(" you");
				else output(" " + target.mf("him", "her"));
				output(".");
				calculateDamage(this, target, (damage(true) + physique() / 2) + 10, meleeWeapon.damageType, "melee");
			}
		}
		
		public function forcePunch(target:Creature):void
		{
			output("\n\nBragga cracks her knuckles, and you see the flickering glow of hardlight shields coalescing around her hands, wrapping around her like a pair of boxing gloves. She leaps towards");
			if (target is PlayerCharacter) output(" you");
			else output(" " + target.a + target.short);
			output(", bringing her fist down in a crushing blow");
			
			if (calculateMiss(this, target, true))
			{
				output(" that");
				if (target is PlayerCharacter) output(" you are");
				else output(" " + target.a + target.short + " is");
				output(" barely able to dodge!");
			}
			else
			{
				output(" that hammers into");
				if (target is PlayerCharacter) output(" you");
				else output(" " + target.mf("him", "her"));
				output(".");
				
				target.createStatusEffect("Trip", 1, 0, 0, 0, false, "Trip", "Tripped", true, 0);
				
				calculateDamage(this, target, (damage(true) + physique() / 2) + 10, meleeWeapon.damageType, "melee");
			}
		}
		
		public function relentless():void
		{
			//Self-Healing. Activate every time she reaches 25% or less HP. Resotre 25% HP + 25% shields. 
			output("\n\n<i>“You'll not get the better of me that easily, captain,”</i> Bragga says with a slight, almost imperceptible smirk. She stands upright, dusting herself off as if she'd barely been harmed.");
			HP(HPMax() * 0.25);
			this.shieldsRaw += shieldMax() * 0.25;
		}
		
	}

}