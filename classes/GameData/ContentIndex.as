package classes.GameData 
{
	import classes.GameData.Content.Appearance;
	import classes.GameData.Content.Chapter2;
	import classes.GameData.Content.Chapter3;
	import classes.GameData.Content.Creation;
	import classes.GameData.Content.TheBlackRose;
	import classes.GameData.Content.TheConstellation;
	import classes.GameData.Content.TheSilence.TheSilence;
	
	public class ContentIndex 
	{
		public static var appearance:Appearance;
		public static var creation:Creation;
		public static var chapter2:Chapter2;
		public static var chapter3:Chapter3;
		
		// Ship Interiors
		// By pointing at content using these public static accessors, we can
		// consider switching out the "filler" content used for certain elements
		// allowing us to reduce complexity of things like room descriptions
		// at a cost of having to build duplicate content.
		// F.ex we could "switch" theSilence content implementation with 3
		// different versions, and have that handle ALL of the different states
		// the silence can be in during the course of the story.
		public static var theSilence:TheSilence;
		public static var theConstellation:TheConstellation;
		public static var theBlackRose:TheBlackRose;
		
		// The swapping could be achieved like such;
		/*
		public static var theSilenceBase:TheSilence;
		public static var theSilencePirates:TheSilenceP; (public class TheSilenceP extends TheSilence)
		public static var theSilencePostPirates:TheSilencePP;
		
		public static function get theSilence():TheSilence
		{
			if (GameState.flags["some indicator"] return theSilencePirates;
			if (GameState.flags["other indicator"] return theSilencePostPirates;
			return theSilenceBase;
		}
		*/
		
		{
			appearance = new Appearance();
				
			// Room content
			theSilence = new TheSilence();
			theConstellation = new TheConstellation();
			theBlackRose = new TheBlackRose();
			
			// Chapter Content
			creation = new Creation();
			chapter2 = new Chapter2();
			chapter3 = new Chapter3();
		}
	}
}