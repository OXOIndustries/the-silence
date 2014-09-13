package classes.UIComponents.SideBarComponents 
{
	import classes.GameData.Rendering.TriangleBuffer;
	import fl.motion.MatrixTransformer;
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Program3D;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Matrix3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DVertexBufferFormat;
	/**
	 * ...
	 * @author Gedan
	 */
	public class CharacterBustRender extends Sprite
	{
		private var context3D:Context3D;
		private var stage3D:Stage3D;
		
		private var triangleBuffers:Vector.<TriangleBuffer>;
		
		public function CharacterBustRender() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Build();
		}
		
		private function Build():void
		{
			stage3D = stage.stage3Ds[0];
			stage3D.addEventListener(Event.CONTEXT3D_CREATE, contextCreated);
			stage3D.requestContext3D();
		}
		
		private function contextCreated(e:Event):void
		{
			context3D = (e.target as Stage3D).context3D;
			var aa:int = 0;
			var enableDepthBuffer:Boolean = true;
			context3D.configureBackBuffer(stage.width, stage.height, aa, enableDepthBuffer);
			addEventListener(Event.ENTER_FRAME, perFrame);
		}
		
		private function perFrame(e:Event):void
		{
			doRender();
		}
		
		private function doRender():void
		{
			context3D.clear(0, 0, 1);
			
			var cam:Matrix3D = new Matrix3D();
			var matViewProj:Matrix3D = new Matrix3D();
			matViewProj.append(cam);
			matViewProj.append(createOrthographicProjectionMatrix(stage.width, stage.height, 0, 1));
			context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, matViewProj, true);
			
			for each (var buffer:TriangleBuffer in triangleBuffers)
			{
				var shader:Program3D = context3D.createProgram();
				shader.upload(buffer.vertexShaderAssembler.agalcode, buffer.fragShaderAssembler.agalcode);
				context3D.setProgram(shader);
				
				context3D.setVertexBufferAt(0, buffer.vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
				context3D.drawTriangles(buffer.indexBuffer, 0, buffer.numTriangles);
			}
			
			context3D.present();
		}
		
		private function createOrthographicProjectionMatrix(viewWidth:Number, viewHeight:Number, near:Number, far:Number):Matrix3D
		{
			return new Matrix3D(Vector.<Number>
			([
				2/viewWidth,	0, 				0, 				0,
				0, 				-2/viewHeight, 	0, 				0,
				0, 				0, 				1/(far-near), 	-near/(far-near),
				0, 				0, 				0, 				1
			]));
	  }
		
	}

}