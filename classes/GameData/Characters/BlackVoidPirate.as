package classes.GameData.Characters 
{
	import classes.Creature;
	import classes.GameData.Items.Apparel.BlackVoidArmor;
	import classes.GameData.Items.Apparel.ProtectiveJacket;
	import classes.GameData.Items.Guns.HeavyAR;
	import classes.GameData.Items.Guns.PlasmaPistol;
	import classes.GameData.Items.Guns.Shotgun;
	import classes.GameData.Items.Melee.BigFuckingWrench;
	import classes.GameData.Items.Melee.ForceEdge;
	import classes.GameData.Items.Miscellaneous.EmptySlot;
	import classes.GameData.Items.Protection.DecentShield;
	import classes.kGAMECLASS;
	import classes.GLOBAL;
	import classes.Resources.Busts.StaticRenders;
	
	import classes.Engine.Combat.calculateMiss;
	import classes.Engine.Combat.calculateDamage;
	
	import classes.Engine.Interfaces.*;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class BlackVoidPirate extends Creature
	{
		public var respawn:Boolean = false;
		
		public function BlackVoidPirate() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = false;
			
			this.short = "Black Void Pirate";
			this.long = "Black Void Priate";
			this.originalRace = "Human";
			this.description = "The Black Void pirates are the nastiest, biggest group of rogues on the frontier -- and the core, for that matter. They've sunk their talons into damn near everything, from gambling and prostitution on high-wealth Confederate worlds to outright space lane piracy out on the rush worlds. You've dealt with them before -- smugglers and pirates have a natural sort of codependance -- though you'd never work for them again if you could help it. The Void is ruthless, and they hold a grudge across all the stars. They usually hunt in wolf packs of small ships, corvettes and re-purposed heavy freighters, to take down cargo craft. Lone ships attacking an armed convoy? What the hell is going on?";
			
			this.customBlock = "";
			this.customDodge = "";
			this.plural = false;
			this.lustVuln = 1.0;
			
			this.meleeWeapon = new EmptySlot();
			this.rangedWeapon = new HeavyAR();
			this.armor = new BlackVoidArmor();
			this.shield = new DecentShield();
			
			this.INDEX = "VOIDPIRATE";
			this.bustT = StaticRenders.MISSING;
			
			this.level = 3;
			this.physiqueRaw = 12;
			this.reflexesRaw = 10;
			this.aimRaw = 15;
			this.intelligenceRaw = 8;
			this.willpowerRaw = 8;
			this.libidoRaw = 60;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 0;
			this.resistances = [1, 1, 1, 1, 1, 1, 1, 1];
			this.XPRaw = 0;
			this.credits = 7875;
			this.HPMod = 10;
			this.HPRaw = this.HPMax();
			this.shieldsRaw = this.shieldsMax();
			
			this.femininity = 10;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "brown";
			this.tallness = 85;
			this.thickness = 40;
			this.tone = 75;
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
			this.createCock(8, 1);
			
			//balls
			this.balls = 2;
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
			var target:Creature = selectTarget(otherTeam);
			
			var attacks:Array = [rangedAttack, rangedAttack, rangedAttack, threeRoundBurst];
			
			if (!hasStatusEffect("Flashbang Used"))
			{
				attacks.push("flashbang");
			}
			
			if (!hasStatusEffect("Net Used"))
			{
				attacks.push(lightNet);
			}
			
			var sel:Function = attacks[rand(attacks.length)];
			if (sel is String) sel(otherTeam);
			else sel(target);
		}
		
		public function threeRoundBurst(target:Creature):void
		{
			output("\n\nThe pirate lets loose, spraying lead at");
			if (target is PlayerCharacter) output(" you.");
			else output(" " + target.a + target.short +".");
			
			var numHits:int = 0;
			
			for (var i:int = 0; i < 3; i++)
			{
				if (!calculateMiss(this, target, false, -1, 2.0)) numHits++;
			}
			
			if (numHits == 0)
			{
				output(" His barrage of fire goes completely wide!");
			}
			else
			{
				if (numHits == 1) output(" One bullet hits home.");
				else output(" Several bullets hit home.");
				
				var dmg:Number = (damage(false) + (aim() / 2)) * numHits;
				
				calculateDamage(this, target, dmg, rangedWeapon.damageType, "ranged");
			}
		}
		
		public function flashbang(otherTeam:Array):void
		{
			output("\n\nThe pirate grabs a grenade from his belt and tosses at your crew! You all cover your eyes as best you can, but the flash still leaves you slightly disoriented. AIM lowered for a turn!");
			createStatusEffect("Flashbang Used");
			
			for (var i:int = 0; i < otherTeam.length; i++)
			{
				(otherTeam[i] as Creature).createStatusEffect("Aim Reduction", 1, 2, 0, 0, false, "AimDown", "Aim Penalty", true, 0);
				(otherTeam[i] as Creature).aimMod -= 2;
			}
		}
		
		public function lightNet(target:Creature):void
		{
			output("\n\nThe pirate grabs what looks like a fishing net from a pouch on his belt. The net starts glowing as the pirate pulls his arm back and hucks it at");
			if (target is PlayerCharacter) output(" you.");
			else output(" " + target.a + target.short + ".");
			
			createStatusEffect("Net Used");
			
			if (calculateMiss(this, target, false, 1, 3.0))
			{
				if (target is PlayerCharacter) output(" You dodge");
				else output(" " + target.capitalA + target.short + " dodges");
				output(" the light net.");
			}
			else
			{
				output(" The net entangles");
				if (target is PlayerCharacter) output(" you");
				else output(" " + target.a + target.short);
				output(", barelling");
				if (target is PlayerCharacter) output(" you");
				else output(" " + target.mf("him", "her"));
				output(" to the ground with incredible weight, preventing all but the slightest movements.");
				if (target is PlayerCharacter) output(" You");
				else output(" " + target.capitalA + target.short);
				output(" is grappled!");
				
				target.createStatusEffect("Grappled", 3, 0, 0, 0, false, "Grapple", "Grappled", true, 0);
			}
		}
		
	}

}