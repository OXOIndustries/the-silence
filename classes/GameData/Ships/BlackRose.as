package classes.GameData.Ships 
{
	import classes.GameData.Items.ShipModules.Capacitor.IECapbankXX;
	import classes.GameData.Items.ShipModules.Defensive.StalwartDefenseCoAblativePlating;
	import classes.GameData.Items.ShipModules.Defensive.StalwartDefenseCoReactivePlating;
	import classes.GameData.Items.ShipModules.Defensive.VoidworksRegenerativeHullAlloy;
	import classes.GameData.Items.ShipModules.Engines.IonRXEngines;
	import classes.GameData.Items.ShipModules.Lightdrives.VWInterceptorLDrive;
	import classes.GameData.Items.ShipModules.Offensive.Lasers.QuadPumpedBeamArray;
	import classes.GameData.Items.ShipModules.Offensive.Special.SingularityAnchor;
	import classes.GameData.Items.ShipModules.Offensive.Spinal.VW490TMassDriver;
	import classes.GameData.Items.ShipModules.Reactor.VWFNIR90Reactor;
	import classes.GameData.Items.ShipModules.Shields.VWInverseHarmonicShield;
	import classes.GameData.Items.ShipModules.Offensive.Projectile.GoblinAutocannon;
	/**
	 * ...
	 * @author Gedan
	 */
	public class BlackRose extends Ship
	{
		
		public function BlackRose() 
		{
			this.version = 1;
			this._latestVersion = 1;
			
			INDEX = "BLACKROSE";
			shortName = "black rose";
			longName = "the Black Rose";
			description = "You're locked in battle with the <i>Black Rose</i>, a sleek pirate ship armed to the teeth, proudly flying the skull and crossbones emblazoned upon its curvaceous hull. The Rose bristles with weapons, as you'd expect from a pirate frigate: cannons and point-defense guns poking up from hardened turrets across the bow and back, leading back to a large launch bay on its starboard flank. Missile launches dot the prow, leveled menacingly at you.\n\nThe most distinctive feature of your enemy's ship, however, is the single huge cannon barrel that seems to run the full length of the Black Rose, wide enough to look like it'd be throwing shells the size of hover trucks. You do not want to get hit by whatever that shoots.";
			
			a = "the ";
			A = "The ";
			
			currentLocation = "SilenceSystem";
			shipInterior = "TheBlackRose.Airlock";
			
			maxOffensiveModules = 10;
			maxDefensiveModules = 10;
			maxNavigationModules = 10;
			
			lightDriveModule = new VWInterceptorLDrive();
			engineModule = new IonRXEngines();
			shieldModule = new VWInverseHarmonicShield();
			reactorModule = new VWFNIR90Reactor();
			capacitorModule = new IECapbankXX();
			
			equippedModules = 
			[
				 new VW490TMassDriver(),
				 new QuadPumpedBeamArray(),
				 new QuadPumpedBeamArray(),
				 new GoblinAutocannon(),
				 new GoblinAutocannon(),
				 new SingularityAnchor(),
				 new StalwartDefenseCoReactivePlating(),
				 new StalwartDefenseCoAblativePlating(),
				 new VoidworksRegenerativeHullAlloy()
			];
		}
		
		override public function generateAIAction(target:Ship):void
		{
			var powerUsed:Number = 0;
			
			if (target.isImmobilised)
			{
				// DOOOOOMSDAAAAAAAAY
				var dgun:VW490TMassDriver = getModuleByClass(VW490TMassDriver) as VW490TMassDriver;
				powerUsed += attackTarget(target, [dgun]);
			}
			else if (this.shieldPercent() < 0.75)
			{
				// "You fuggen scratched muh paint. Ima fuckin punch you now.
				var sMissile:SingularityAnchor = getModuleByClass(SingularityAnchor) as SingularityAnchor;
				powerUsed += attackTarget(target, [sMissile]);
			}
			else
			{
				// Broadside motherfucker.
				var weapons:Array = autofireOffensiveModulesEquipped();
				powerUsed += attackTarget(target, weapons);
			}
			
			applyRecharge(powerUsed);
		}
		
	}

}