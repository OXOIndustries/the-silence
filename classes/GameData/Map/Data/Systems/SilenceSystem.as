package classes.GameData.Map.Data.Systems {
	import classes.GameData.Map.System;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Gedan
	 */
	public class SilenceSystem extends System
	{	
		public function SilenceSystem() 
		{
			SystemIndex = "SilenceSystem";
			SystemName = "Silence System";
			
			Position = new Point(0, 0);
			
			AddLocation(TheSilence);
		}
	}
}