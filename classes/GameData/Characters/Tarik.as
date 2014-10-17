package classes.GameData.Characters 
{
	import classes.Creature;
	import classes.GameData.Items.Apparel.ProtectiveJacket;
	import classes.GameData.Items.Guns.Handaxes;
	import classes.GameData.Items.Guns.PlasmaPistol;
	import classes.GameData.Items.Melee.ForceEdge;
	import classes.GameData.Items.Melee.Greataxe;
	import classes.GameData.Items.Protection.DecentShield;
	import classes.kGAMECLASS;
	import classes.GLOBAL;
	import classes.Resources.Busts.StaticRenders;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class Tarik extends Creature
	{
		
		public function Tarik() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = false;
			
			this.short = "Tarik";
			this.long = "Tarik";
			this.originalRace = "Naleen";
			this.description = "Tarik's the newest addition to the crew. A few weeks ago, you knocked over a freighter convoy heading to Tavros, and lo and behold, found a cargo full of exotic xeno slaves. You freed them -- you of all people know what it's like to live in a collar, after all. You didn't come away from the job with a profit, thanks to that, but you did get Tarik: a slave meant for the gladiator rings of Thallisus. When you rescued him, the big bastard swore some kind of oath of service to you. What's the difference between that and slavery? Still, it doesn't hurt to have a huge bruiser with an axe on the crew, especially when he can rip most folk in half with his bare hands. At least, that's what he says he can do... and you don't doubt him.";
			
			this.a = "";
			this.capitalA = "";
			
			this.customBlock = "";
			this.customDodge = "";
			this.plural = false;
			this.lustVuln = 1.0;
			
			this.meleeWeapon = new Greataxe();
			this.rangedWeapon = new Handaxes();
			this.armor = new ProtectiveJacket();
			this.shield = new DecentShield();
			
			this.INDEX = "TARIK";
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
		
	}

}