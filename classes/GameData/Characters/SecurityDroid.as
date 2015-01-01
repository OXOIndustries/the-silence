package classes.GameData.Characters 
{
	import classes.Creature;
	import classes.Engine.Combat.calculateMiss;
	import classes.Engine.Combat.calculateDamage;
	import classes.GameData.Items.Apparel.ProtectiveJacket;
	import classes.GameData.Items.Guns.Handaxes;
	import classes.GameData.Items.Guns.LaserRifle;
	import classes.GameData.Items.Guns.PlasmaPistol;
	import classes.GameData.Items.Melee.ForceEdge;
	import classes.GameData.Items.Melee.Greataxe;
	import classes.GameData.Items.Miscellaneous.EmptySlot;
	import classes.GameData.Items.Protection.BasicShield;
	import classes.GameData.Items.Apparel.DroidPlating;
	import classes.kGAMECLASS;
	import classes.GLOBAL;
	import classes.Resources.Busts.StaticRenders;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.possessive;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class SecurityDroid extends Creature
	{
		
		public function SecurityDroid() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = false;
			
			this.short = "Security Droid";
			this.long = "Security Droid";
			this.originalRace = "Machine";
			this.description = "Basic security droids are ubiquitous across Confederate space. Loaded with the most rudimentary Friend/Foe ID system, small arms controls, and basic tactical movement routines money can buy in bulk, security droids provide area defense and can repel boarders on ships without having to pay living, breathing security personnel. Most security droids are cheap, effective enough at stopping open attackers, and are completely expendable. You've dealt with dozens of them over the course of your career, and they're pretty damn easy to bypass if you're stealthy, or one-shot takedown if you're in a pinch. Overall, only a threat in bulk. Lucky for you, Nova's got the budget to buy them by the container-full.";
			this.a = "";
			this.capitalA = "";
			
			this.customBlock = "";
			this.customDodge = "";
			this.plural = false;
			this.lustVuln = 1.0;
			
			this.meleeWeapon = new EmptySlot();
			this.rangedWeapon = new LaserRifle();
			this.armor = new DroidPlating();
			this.shield = new BasicShield();
			
			this.INDEX = "SECURITYDROID";
			this.bustT = StaticRenders.MOB_BOT;
			this.isUniqueInFight = false;
			this.btnTargetText = "SecDroid";
			
			this.level = 3;
			this.physiqueRaw = 10;
			this.reflexesRaw = 8;
			this.aimRaw = 11;
			this.intelligenceRaw = 11;
			this.willpowerRaw = 11;
			this.libidoRaw = 60;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 0;
			this.resistances = [1, 1, 1, 1, 1, 1, 1, 1];
			this.XPRaw = 0;
			this.credits = 7875;
			this.HPMod = 0;
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
			
			this.createStatusEffect("Force It Gender");
			
			this._isLoading = false;
		}
		
		override public function generateAIActions(sameTeam:Array, otherTeam:Array):void
		{
			if (this.HP() <= this.HPMax() * 0.75 && !hasStatusEffect("Shieldwall Cooldown"))
			{
				this.shieldWall();
				return;
			}
			
			var target:Creature = selectTarget(otherTeam);
			
			if (target != null)
			{
				var attacks:Array = [rangedAttack, rangedAttack, rangedAttack, shock, laserBarrage];
				attacks[rand(attacks.length)](target);
			}
		}
		
		public function laserBarrage(target:Creature):void
		{
			output("\n\n" + this.short + " stomps forward, firing rapidly from the hip. Bolts of red-hot energy streak towards ");
			if (target is PlayerCharacter) output("you");
			else output(target.a + target.short);
			output(", guided by the droid's onboard targeting computers.");
			
			
			var numHits:int = 0;
			if (calculateMiss(this, target, false)) numHits++;
			if (calculateMiss(this, target, false)) numHits++;
			
			if (numHits == 0)
			{
				output(" Both shots go wide!");
			}
			else
			{
				if (numHits == 1) output(" One hits.");
				if (numHits == 2) output(" Both hit.");
				
				var dmg:Number = calculateDamage(this, target, (this.damage(false) + (aim()/2)) * numHits, this.rangedWeapon.damageType, "ranged", false);
			}
		}
		
		public function shock(target:Creature):void
		{
			//Deals light electricity damage, chance to stun.
			output("\n\n" + this.short + " takes its left wrist off its rifle, levels it at ");
			if (target is PlayerCharacter) output("you");
			else output(target.a + target.short);
			output(", and fires a small dart from a hidden launcher. The dart");
			
			if (calculateMiss(this, target, false))
			{
				output(" goes wide, plinking against a bulkhead.");
			}
			else 
			{
				output(" strikes home, releasing an electrical charge that zaps ");
				if (target is PlayerCharacter) output("you");
				else output(target.a + target.short);
				output(", ripping a scream from");
				if (target is PlayerCharacter) output(" your");
				else output(target.mfn(" his", " her", " its"));
				output(" throat.");
				
				calculateDamage(this, target, 5, GLOBAL.ELECTRIC, "special", false);
				
				if (rand(3) == 0)
				{
					if (target is PlayerCharacter) output("\nYou're");
					else output("\n" + target.a + target.short);
					output(" is stunned!")
					target.createStatusEffect("Stunned", 2, this.arrayIdx, 0, 0, false, "Stun", "Stunned", true, 0);
				}
				else
				{
					if (target is PlayerCharacter) output("\nYou");
					else output("\n" + target.a + target.short);
					output(" quickly shake");
					if (!(target is PlayerCharacter)) output("s");
					output(" off the dart.");
				}
			}
		}
		
		public function shieldWall():void
		{
			//Recharge 25% shields. 1/encounter.
			output("\n\n" + this.short + " reaches down and taps on its shield generator, activating an emergency generator to harden its defenses.");
			
			createStatusEffect("Shieldwall Cooldown", 0, 0, 0, 0, true, "", "", true, 0);
			
			var sGain:int = shieldsMax() * 0.25;
			shieldsRaw += sGain;
			
			output(" " + sGain + " shields restored!");
		}
		
		override public function doStunRecoverFor(target:Creature):void
		{
			output("\n\nThe electrical dart embedded in " + target.a + possessive(target.short) + " armor falls out, allowing them to quickly recover from the stunning effect of the electricity.");
		}
		
	}

}