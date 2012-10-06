package engine 
{
	import adobe.utils.CustomActions;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	
	/**
	 *	Input Manager
	 */
	public class Input 
	{
		static private const UP			: uint = 0;
		static private const PRESS		: uint = 1;
		static private const HELD		: uint = 2;
		static private const RELEASE    : uint = 3;
		static private const DOUBLE     : uint = 4;
		static private const TAP     	: uint = 5;

		static private const START_PRESS:uint = 9999;
		
		static private const END_PRESS:uint = 9999;
		
		static private var keys		: Vector.<uint>;
		static private var active	: Vector.<KeyState>;
		static private var press	: Vector.<KeyState>;
		
		static public var mouse	: uint;
		
		static public function init( stage:Stage ):void
		{
			stage.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.removeEventListener( KeyboardEvent.KEY_UP,   onKeyUp );
			stage.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );

			keys 	= new Vector.<uint>(256);	// state of all keys
			active 	= new Vector.<KeyState>();	// only keys in a state other than up
			press 	= new Vector.<KeyState>();	// hold all the pressed times
			
			mouse	= keys[ 255 ];
			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, 	onKeyUp );
			stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
		}
		
		/// Flash Event: A key was just pressed
		static public function onKeyDown( e:KeyboardEvent ):void
		{
			// If the system is sending another key down event, but the key is marked
			// as being in some other state than down; ignore it.
			if ( keys[ e.keyCode ] != UP )
				return;
			
			keys[ e.keyCode ] = START_PRESS;
			
			var keyState:KeyState = new KeyState( e.keyCode, Time.frameCount );
			active.push( keyState );
			press.push( keyState );
		}
		
		/// Flash Event: The mouse was just pressed
		static public function onMouseDown( e:MouseEvent ):void
		{
			// If the system is sending another key down event, but the key is marked
			// as being in some other state than down; ignore it.
			if ( keys[ mouse ] != UP )
				return;
			
			keys[ mouse ] = START_PRESS;
			
			var keyState:KeyState = new KeyState( mouse, Time.frameCount );
			active.push( keyState );
			press.push( keyState );
		}
		
		/// Flash Event: A key was raised
		static public function onKeyUp( e:KeyboardEvent ):void
		{
			keys[ e.keyCode ] = UP;
			
			// Loop through all active keys; there is a slight chance that
			// more than one entry for a key being "down" snuck in due to
			// how Flash / OS handles input.
			var keyState:KeyState;
			for ( var i:int = active.length - 1; i > -1; i-- )
			{
				keyState = active[i];				// get next keystate in active list
				if ( keyState.code == e.keyCode )	// if the code matches
					active.splice( i, 1 );			// remove
			}
			
			for ( var p:int = press.length - 1; p > -1; p-- )
			{
				keyState = press[p];				// get next keystate in active list
				if ( keyState.code == e.keyCode )	// if the code matches
					press.splice( p, 1 );			// remove
			}
		}
		
		/// Flash Event: The mouse was raised
		static public function onMouseUp( e:MouseEvent ):void
		{
			keys[ mouse ] = UP;
			
			// Loop through all active keys; there is a slight chance that
			// more than one entry for a key being "down" snuck in due to
			// how Flash / OS handles input.
			var keyState:KeyState;
			for ( var i:int = active.length - 1; i > -1; i-- )
			{
				keyState = active[i];				// get next keystate in active list
				if ( keyState.code == mouse )		// if the code matches
					active.splice( i, 1 );			// remove
			}
			
			for ( var p:int = press.length - 1; p > -1; p-- )
			{
				keyState = press[p];				// get next keystate in active list
				if ( keyState.code == mouse )		// if the code matches
					press.splice( p, 1 );			// remove
			}
		}
		
		/// Call this once per frame
		static public function update():void
		{
			var code	:uint;
			var keyState:KeyState;
			
			// Go through all the inputs currently mark as being active...
			for ( var i:int = active.length - 1; i > -1; i-- )
			{
				keyState = active[i];
				code = keyState.code;
				
				// If a press is just starting, mark it as started and update
				// the frame for the press to be this frame.
				if ( keys[code] == START_PRESS )
				{
					keys[code] = PRESS;
					keyState.frame = Time.frameCount;
				}
				
				// If a key is pressed and it's the frame after it was pressed,
				// change the state.
				if ( keys[code] == PRESS && keyState.frame < Time.frameCount )
				{
					keys[code] = HELD;
					continue;
				}

				// If a key that was pressed is now not, release
				if ( keys[code] == END_PRESS )
				{
					keys[code] = RELEASE;
				}
				
				// If a key was pressed then released, and pressed then released again
				// in a short time, double press
				if ( press.length > 1 && press[0].frame - press[1].frame < .5 && press[0].code == press[1].code )
				{
					keys[code] = DOUBLE;
				}
				
				// If a key was pressed then released in a short time, tap
			}
		}
		
		/// Has a key just been pressed in this frame?
		static public function getKeyDown( code:uint ):Boolean
		{
			return keys[ code ] == PRESS;
		}

		/// Is a key in state other than being "up"?
		static public function getKey( code:uint ):Boolean
		{
			return keys[ code ] == HELD;
		}
		
		/// Was the key being HELD back to "up"?
		static public function getKeyRelease( code:uint ):Boolean
		{
			return keys[ code ] == RELEASE;
		}
		
		/// Was the key that was PRESS-RELEASE, PRESS-RELEASE again without HELD?
		static public function getKeyDouble( code:uint ):Boolean
		{
			return keys[ code ] == DOUBLE;
		}
		
		/// Was a key that was PRESS, RELEASE before HELD?
		static public function getKeyTap( code:uint ):Boolean
		{
			return keys[ code ] == TAP;
		}
		
		/// Has the mouse just been pressed in this frame?
		static public function getMouseDown( code:uint ):Boolean
		{
			return keys[ code ] == PRESS;
		}

		/// Is the mouse in a state other than being "up"?
		static public function getMouse( code:uint ):Boolean
		{
			return keys[ code ] == HELD;
		}
		
		/// Was the mouse being HELD back to "up"?
		static public function getMouseRelease( code:uint ):Boolean
		{
			return keys[ code ] == RELEASE;
		}
		
		/// Was the mouse PRESS-RELEASE, PRESS-RELEASE again without HELD?
		static public function getMouseDouble( code:uint ):Boolean
		{
			return keys[ code ] == DOUBLE;
		}
		
		/// Was the mouse PRESS, RELEASE before HELD?
		static public function getMouseTap( code:uint ):Boolean
		{
			return keys[ code ] == TAP;
		}
	}
}

internal class KeyState
{
	public var code	:uint;
	public var frame:uint;
	
	/// CTOR
	function KeyState( code:uint, frame:uint ) :void
	{
		this.code 	= code;
		this.frame 	= frame;
	}
}