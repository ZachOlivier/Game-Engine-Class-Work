package 
{
	import engine.*;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	

	public class Main extends Sprite 
	{
		private const MAX_LINES	:int = 24;
		private var outLines	:Vector.<TextField>;
		
		public var mouseAndKey:Bitmap = new Resources.MouseAndKey();

		/// CTOR
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			Time.init( stage );
			Input.init( stage );
			Display.init( stage );
			
			/// Make screen output lines
			outLines = new Vector.<TextField>();
			var tf:TextField;
			for (var i:int = 0; i < MAX_LINES; i++)
			{
				tf = maketf( 16 );
				Display.ui.addChild( tf );
				tf.y = i * 20;
				outLines.push( tf );
				//tf.text = "Default!";
			}
			
			Display.main.addChild( mouseAndKey );
			
			mouseAndKey.width = stage.width;
			mouseAndKey.height = stage.height;
			
			addEventListener( Event.ENTER_FRAME, update );
		}
		
		/// Main update loop
		private function update( e:Event ):void
		{
			// Update sub-systems
			Time.update();
			Input.update();

			// Generate a string based on the input state of T
			var out:String =
				String( Time.frameCount ) 	+ ": " 								+
				"	tDown: " 				+ Input.getKeyDown( Keyboard.T )	+ " M: " + Input.getMouseDown( Input.mouse ) 	+ 
				"   tHeld: " 				+ Input.getKey( Keyboard.T ) 		+ " M: " + Input.getMouse( Input.mouse )		+
				"   tRelease: " 			+ Input.getKeyRelease( Keyboard.T ) + " M: " + Input.getMouseRelease( Input.mouse )	+
				"   tDouble: " 				+ Input.getKeyDouble( Keyboard.T )	+ " M: " + Input.getMouseDouble( Input.mouse )	+
				"   tTap: " 				+ Input.getKeyTap( Keyboard.T ) 	+ " M: " + Input.getMouseTap( Input.mouse );
				
			/* Populate a textfield on the screen based on the frame
			var tf:TextField = outLines[ Time.frameCount % MAX_LINES ];
			tf.text = out;*/
			
			// Change the color of the key based on the T's state
			if ( Input.getKeyDown( Keyboard.T ) )
			{
				Display.ui.graphics.beginFill(0x000000);
				Display.ui.graphics.drawRect(309, 40, 104, 85);
				Display.ui.graphics.endFill();
			}
				
			else if ( Input.getKey( Keyboard.T ) )
				{
					Display.ui.graphics.beginFill(0x0000FF);
					Display.ui.graphics.drawRect(309, 40, 104, 85);
					Display.ui.graphics.endFill();
				}
			
			// Change the left mouse button based on its state
			else if ( Input.getMouseDown( Input.mouse ) )
			{
				Display.ui.graphics.beginFill(0x000000);
				Display.ui.graphics.drawCircle(320, 200, 32);
				Display.ui.graphics.endFill();
			}
				
			else if ( Input.getMouse( Input.mouse ) )
				{
					Display.ui.graphics.beginFill(0x0000FF);
					Display.ui.graphics.drawCircle(320, 200, 32);
					Display.ui.graphics.endFill();
				}
				
			else
				{
					Display.ui.graphics.clear();
				}
			
			trace( out );
		}
		
		
	}
}
