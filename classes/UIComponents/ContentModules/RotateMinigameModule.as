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
		
		private var _basePower:RotateGameElement;
		private var _goalNodes:Array;
		
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
					
					elem.x = (xx * elem.width) + (elem.width / 2) + 40;
					elem.y = (yy * elem.height) + (elem.height / 2) + 10;
					
					elem.name = "Element " + String(xx) + "-" + String(yy);
					
					elem.visible = false;
				}
			}
		}
	
		public function setPuzzleState(sizeX:int, sizeY:int, board:Array):void
		{
			if (sizeX * sizeY > board.length) throw new Error("Too many board settings for the defined board size!");
			if (sizeX % 2 != 1 || sizeY % 2 != 1) throw new Error("Boards should always feature odd-sized dimensions (3x3, 3x5 etc)");
			if (sizeX < 3 || sizeY < 3) throw new Error("Boards should always feature at least 3 rows or columns.");
			if (board.length > _pieces.length) throw new Error("Boards can only contain at most 81 elements.");
			
			var paddedArray:Array
			_basePower = null;
			_goalNodes = [];
			
			if (board.length < 9 * 9)
			{
				paddedArray = [];
				var xPad:int = (9 - sizeX) / 2;
				var yPad:int = (9 - sizeY) / 2;
				
				var baseI:int = 0;
				
				for (var yy:int = 0; yy < 9; yy++)
				{
					for (var xx:int = 0; xx < 9; xx++)
					{
						//trace("Working for (" + yy + "," + xx + ")");
						if (yy < yPad || yy >= 9 - yPad)
						{
							//trace(" -> element falls outside of defined board (Y)");
							paddedArray.push(0);
						}
						else if (xx < xPad || xx >= 9 - xPad)
						{
							//trace(" -> element falls outside of defined board (X)");
							paddedArray.push(0);
						}
						else
						{
							//trace(" -> setting element to board value " + board[baseI]);
							paddedArray.push(board[baseI]);
							baseI++;
						}					
					}
				}
			}
			else
			{
				paddedArray = board;
			}
			
			_defState = paddedArray;
			_width = sizeX;
			_height = sizeY;
			
			for (var i:int = 0; i < paddedArray.length; i++)
			{
				var dElem:RotateGameElement = _pieces[i];
				dElem.setState(paddedArray[i]);
				
				if (paddedArray[i] & RGMK.NODE_GOAL)
				{
					_goalNodes.push(dElem);
					dElem.basePowerNode = false;
					
					if (_basePower == null)
					{
						_basePower = dElem;
						_basePower.basePowerNode = true;
					}
				}
			}
			
			initForPlay();
		}
		
		private function initForPlay():void
		{
			_basePower.isPowered = true;
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
				
				iX = i % 9;
				iY = int(i / 9);
				
				if (dir & RGMK.CON_NORTH)
				{
					if (iY > 0) iY--;
					else return null;
				}
				
				if (dir & RGMK.CON_SOUTH)
				{
					if (iY < 9) iY++;
					else return null;
				}
				
				if (dir & RGMK.CON_EAST)
				{
					if (iX < 9) iX++;
					else return null;
				}
				
				if (dir & RGMK.CON_WEST)
				{
					if (iX > 0) iX--;
					else return null;
				}
				
				var tElem:RotateGameElement = _pieces[iX + (iY * 9)];
				if (tElem.Type == 0) return null;
				return tElem;
			}
			else
			{
				return null;
			}
		}
		
		private var visitedElems:Array;
		
		public function resolveConnections():void
		{
			visitedElems = [];
			
			for (var i:int = 0; i < _pieces.length; i++)
			{
				var tElem:RotateGameElement = _pieces[i] as RotateGameElement;			
				clrConnections(tElem);
				if (tElem == _basePower) tElem.isPowered = true;	
			}
			
			tryConnect(_basePower);
		}
		
		public function tryConnect(source:RotateGameElement):void
		{
			if (source.isPowered == false) return;
			
			if (visitedElems.indexOf(source) != -1)
			{
				return;
			}
			else
			{
				visitedElems.push(source);
			}
			
			var nNorth:RotateGameElement = getNearby(source, RGMK.CON_NORTH);
			var nEast:RotateGameElement = getNearby(source, RGMK.CON_EAST);
			var nSouth:RotateGameElement = getNearby(source, RGMK.CON_SOUTH);
			var nWest:RotateGameElement = getNearby(source, RGMK.CON_WEST);
			
			if (nEast && nEast.name == "Element 5-5")
			{
				trace("BP");
			}
			
			if (nNorth)
			{
				if (source.North && nNorth.South)
				{
					nNorth.powerFrom(RGMK.CON_SOUTH);
					source.conNorth = true;
					nNorth.conSouth = true;
					tryConnect(nNorth);
				}
			}
			
			if (nEast)
			{
				if (source.East && nEast.West)
				{
					nEast.powerFrom(RGMK.CON_WEST);
					source.conEast = true;
					nEast.conWest = true;
					tryConnect(nEast);
				}
			}
			
			if (nSouth)
			{
				if (source.South && nSouth.North)
				{
					nSouth.powerFrom(RGMK.CON_NORTH);
					source.conSouth = true;
					nSouth.conNorth = true;
					tryConnect(nSouth);
				}
			}
			
			if (nWest)
			{
				if (source.West && nWest.East)
				{
					nWest.powerFrom(RGMK.CON_EAST);
					source.conWest = true;
					nWest.conEast = true;
					tryConnect(nWest);
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