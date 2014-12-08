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
			longName = "black rose";
			description = "Some description.";
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
			]
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