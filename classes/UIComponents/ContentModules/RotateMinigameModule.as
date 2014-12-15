package classes.UIComponents.ContentModules 
{
	import classes.UIComponents.ContentModule;
	import classes.UIComponents.ContentModuleComponents.RotateGameElement;
	import flash.events.Event;
	/**
	 * ...
	 * @author Gedan
	 */
	public class RotateMinigameModule extends ContentModule
	{	
		// Keys to configure/poll the game board.
		public static const NODE_GOAL:uint 		= 1 << 0;
		public static const NODE_INTERACT:uint 	= 1 << 1;
		public static const NODE_LOCKED:uint	= 1 << 2;
		
		public static const CON_NORTH:uint 		= 1 << 3;
		public static const CON_EAST:uint 		= 1 << 4;
		public static const CON_SOUTH:uint 		= 1 << 5;
		public static const CON_WEST:uint 		= 1 << 6;
		
		public static const ROT_000:uint		= 1 << 0;
		public static const ROT_090:uint		= 1 << 1;
		public static const ROT_180:uint		= 1 << 2;
		public static const ROT_270:uint		= 1 << 3;
		
		private var _pieces:Array;
		private var _width:int;
		private var _height:int;
		
		public function RotateMinigameModule() 
		{
			leftBarEnabled = true;
			rightBarEnabled = true;
			fullButtonTrayEnabled = false;
			_moduleName = "RotateMinigame";
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			this.visible = false;
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.Build();
		}
		
		private function Build():void
		{
			
		}
	
		public function setPuzzleState(sizeX, sizeY, board:Array):void
		{
			if (sizeX * sizeY > board.length) throw new Error("Too many board settings for the defined board size!");
		}
		
		public function resetPuzzle():void
		{
			
		}
		
		public function getNearby(s:RotateGameElement, dir:uint):RotateGameElement
		{
			var i:int = _pieces.indexOf(s);
			
			if (i >= 0)
			{
				var iX:int;
				var iY:int;
				
				iX = i % width;
				iY = int(i / width);
				
				if (dir & CON_NORTH && iY > 0)
				{
					iY--;
				}
				else
				{
					return null;
				}
				
				if (dir & CON_SOUTH && iY < height)
				{
					iY++;
				}
				else
				{
					return null;
				}
				
				if (dir & CON_EAST && iX < width)
				{
					iX++;
				}
				else
				{
					return null;
				}
				
				if (dir & CON_WEST && iX > 0)
				{
					iX--;
				}
				else
				{
					return null;
				}
				
				return _pieces[iX + iY];
			}
			else
			{
				return null;
			}
		}
		
		public function tryConnect(source:RotateGameElement, dir:uint):void
		{
			var t:RotateGameElement = getNearby(source, dir);
			
			if (t)
			{
				if (dir & CON_NORTH && t.South)
				{
					source.conNorth = true;
					t.powerFrom(CON_SOUTH);
				}
				if (dir & CON_EAST && t.West)
				{
					source.conEast = true;
					t.powerFrom(CON_WEST);
				}
				else if (dir & CON_SOUTH && t.North)
				{
					source.conSouth = true;
					t.powerFrom(CON_NORTH);
				}
				else if (dir & CON_WEST && t.East)
				{
					source.conWest = true;
					t.powerFrom(CON_WEST);
				}
			}
		}
		
		public function clrConnections(source:RotateGameElement):void
		{
			source.conNorth = false;
			source.conEast = false;
			source.conSouth = false;
			source.conWest = false;
			source.isPowered = false;
		}
	}

}