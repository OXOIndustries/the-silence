package classes.GameData.Ships 
{
	import classes.GameData.Items.ShipModules.Defensive.StalwartDefenseCoLightPlating;
	import classes.GameData.Items.ShipModules.Engines.HYDIonTruster;
	import classes.GameData.Items.ShipModules.Lightdrives.KihaCorpExcelsior;
	import classes.GameData.Items.ShipModules.Navigation.RourkeBlackstarsModifiedEmissionMasker;
	import classes.GameData.Items.ShipModules.Offensive.Lasers.ReaperLightLaserTurret;
	import classes.GameData.Items.ShipModules.Offensive.Lasers.ReaperTwinLinkedLaserCannons;
	import classes.GameData.Items.ShipModules.Offensive.Missiles.SteeleTechVanguardXXVIIMissileSystem;
	import classes.GameData.Items.ShipModules.Reactor.IEFusionReactorMKIII;
	import classes.GameData.Items.ShipModules.Shields.JoyCoCrusaderShieldGenMILSPEC;
	import classes.GameData.Items.ShipModules.Capacitor.IECapbankXVI;
	/**
	 * ...
	 * @author Gedan
	 */
	public class TheSilence extends Ship
	{
		public function TheSilence() 
		{
			this.version = 1;
			this._latestVersion = 1;
			
			INDEX = "SILENCE";
			shortName = "silence";
			longName = "the Silence";
			description = "Some description";
			a = "the ";
			A = "The ";
			
			currentLocation = "SilenceSystem";
			shipInterior = "TheSilence.Airlock";
			
			maxOffensiveModules = 5;
			maxDefensiveModules = 2;
			maxNavigationModules = 2;
			
			lightDriveModule = new KihaCorpExcelsior();
			engineModule = new HYDIonTruster();
			shieldModule = new JoyCoCrusaderShieldGenMILSPEC();
			reactorModule = new IEFusionReactorMKIII();
			capacitorModule = new IECapbankXVI();
			
			equippedModules =
			[
				new ReaperLightLaserTurret(),
				new ReaperLightLaserTurret(),
				new ReaperTwinLinkedLaserCannons(),
				new ReaperTwinLinkedLaserCannons(),
				new SteeleTechVanguardXXVIIMissileSystem(),
				new StalwartDefenseCoLightPlating(),
				new RourkeBlackstarsModifiedEmissionMasker()
			];
		}	
	}
}