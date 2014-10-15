package classes.Engine.Utility 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Gedan
	 */
	public function clone(o:Object):Object
	{
		var copier:ByteArray = new ByteArray();
		var ret:Object = new Object();
		copier.writeObject(o);
		copier.position = 0;
		ret = copier.readObject();
		
		return ret;
	}

}