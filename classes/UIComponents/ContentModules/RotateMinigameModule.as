package classes.UIComponents.ContentModules 
{
	import classes.UIComponents.ContentModule;
	import classes.UIComponents.ContentModuleComponents.RotateGameElement;
	import flash.events.Event;
	import classes.UIComponents.ContentModuleComponents.RGMK;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class RotateMinigameModule extends ContentModule
	{	
		// Keys to configure/poll the game board.
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
	
		public function setPuzzleState(sizeX:int, sizeY:int, board:Array):void
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
				
				if (dir & RGMK.CON_NORTH && iY > 0)
				{
					iY--;
				}
				else
				{
					return null;
				}
				
				if (dir & RGMK.CON_SOUTH && iY < height)
				{
					iY++;
				}
				else
				{
					return null;
				}
				
				if (dir & RGMK.CON_EAST && iX < width)
				{
					iX++;
				}
				else
				{
					return null;
				}
				
				if (dir & RGMK.CON_WEST && iX > 0)
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
				if (dir & RGMK.CON_NORTH && t.South)
				{
					source.conNorth = true;
					t.powerFrom(RGMK.CON_SOUTH);
				}
				if (dir & RGMK.CON_EAST && t.West)
				{
					source.conEast = true;
					t.powerFrom(RGMK.CON_WEST);
				}
				else if (dir & RGMK.CON_SOUTH && t.North)
				{
					source.conSouth = true;
					t.powerFrom(RGMK.CON_NORTH);
				}
				else if (dir & RGMK.CON_WEST && t.East)
				{
					source.conWest = true;
					t.powerFrom(RGMK.CON_WEST);
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