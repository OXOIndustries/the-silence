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
		
		private var _defState:Array;
		
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
			_pieces = [];
			
			for (var yy:int = 0; yy < 9; yy++)
			{
				for (var xx:int = 0; xx < 9; xx++)
				{
					var elem:RotateGameElement = new RotateGameElement();
					
					this.addChild(elem);
					_pieces.push(elem);
					
					elem.x = (xx * elem.width) + (elem.width / 2);
					elem.y = (yy * elem.height) + (elem.height / 2);
					
					elem.visible = false;
				}
			}
		}
	
		public function setPuzzleState(sizeX:int, sizeY:int, board:Array):void
		{
			if (sizeX * sizeY > board.length) throw new Error("Too many board settings for the defined board size!");
			
			if (sizeX % 2 != 1 || sizeY % 2 != 1) throw new Error("Boards should always feature odd-sized dimensions (3x3, 3x5 etc)");
			if (sizeX < 3 || sizeY < 3) throw new Error("Boards should always feature at least 3 rows or columns.");
			
			_defState = board;
			_width = sizeX;
			_height = sizeY;
			
			var sX:int;
			var sY:int;
			
			sX = (sizeX - 1) / 2;
			sY = (sizeY - 1) / 2;
			
			sX = 4 - sX;
			sY = 4 - sY;
			
			var iX:int = 0;
			var iY:int = 0;
			
			for (var i:int = 0; i < board.length; i++)
			{
				var elem:uint = board[i];
				
				var dElem:RotateGameElement;
				
				dElem = _pieces[(sX + iX) + (sY + iY)];
				dElem.setState(board[i]);
				
				iX++;
				
				if (iX == sizeX - 1)
				{
					iY++;
					iX = 0;
				}
			}
		}
		
		public function resetPuzzle():void
		{
			setPuzzleState(_width, _height, _defState);
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