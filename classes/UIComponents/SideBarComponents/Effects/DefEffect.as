package classes.UIComponents.SideBarComponents.Effects 
{
	import classes.UIComponents.SideBarComponents.EffectContainer;
	import flash.display.Sprite;
	import classes.Resources.StatusIcons;
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author Gedan
	 */
	public class DefEffect extends EffectContainer
	{
		
		public function DefEffect() 
		{
			
		}
		
		override public function BuildIcon():void
		{
			_mIcon = new StatusIcons.DefenseDown();
			this.addChild(_mIcon);
			
			if (_mIcon.width != (29) || _mIcon.height != (29))
			{
				var ratio:Number;
				if (_mIcon.width > _mIcon.height)
				{
					ratio = _mIcon.height / _mIcon.width;
					_mIcon.width = 29
					_mIcon.height = Math.floor((29) * ratio);
				}
				else
				{
					ratio = _mIcon.width / _mIcon.height;
					_mIcon.height = 29;
					_mIcon.width = Math.floor((29) * ratio);
				}
			}
			
			_mIcon.x = Math.floor((33 - 29) / 2);
			_mIcon.y = Math.floor((33 - 29) / 2);
			var whtT:ColorTransform = new ColorTransform();
			whtT.color = 0xFFFFFF;
			_mIcon.transform.colorTransform = whtT;
		}
		
	}

}