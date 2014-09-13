package classes.GameData.Rendering 
{
	import flash.display3D.Context3DProgramType;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.geom.Matrix3D;
	/**
	 * ...
	 * @author Gedan
	 */
	public class TriangleBuffer 
	{
		public var vertexShaderAssembler:AGALMiniAssembler;
		public var fragShaderAssembler:AGALMiniAssembler;
		
		public var vertexBuffer:VertexBuffer3D;
		public var indexBuffer:IndexBuffer3D;
		
		public var matrix:Matrix3D;
		
		public var numTriangles:int;
		
		public function TriangleBuffer() 
		{
			
		}
		
		public function setVertexShader(vertexCode:String):void
		{
			vertexShaderAssembler = new AGALMiniAssembler();
			vertexShaderAssembler.assemble(Context3DProgramType.VERTEX, vertexCode);
		}
		
		public function setFragShader(fragCode:String):void
		{
			fragShaderAssembler = new AGALMiniAssembler();
			fragShaderAssembler.assemble(Context3DProgramType.FRAGMENT, fragCode);
		}
		
	}

}