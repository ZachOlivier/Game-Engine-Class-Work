package 
{
	import engine.*;
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Zach Olivier
	 */
	
	public class Player extends Sprite
	{
		private const SPEED		:int 	= 25;
		
		public var face			:int	= 0;
		
		public var halfWidth	:Number = 40;
		public var halfHeight	:Number = 48;
		
		public var mouthOpen	:Boolean = true;
		
		public var thisPlayer	:Bitmap;
		
		
		// CTOR
		public function Player()
		{	
			thisPlayer = new Resources.MouthOpen;
			
			addChild( thisPlayer );
		}
		
		
		public function update():void
		{
			// Movement
			if ( Input.getKey( Keyboard.S ) || Input.getKey( Keyboard.DOWN ) )
			{
				this.y += SPEED;
			}
				
			if ( Input.getKey( Keyboard.W ) || Input.getKey( Keyboard.UP ) )
			{
				this.y -= SPEED;
			}
			
			// Mouth
			if ( Input.getKeyDown( Keyboard.SPACE ) || Input.getMouseButtonDown( 0 ) )
			{
				face++;
				
				if ( face > 1 )
				{
					face = 0;
				}
				
				switch ( face )
				{
					case 0 :
						removeChild( thisPlayer );
						thisPlayer = new Resources.MouthOpen;
						addChild( thisPlayer );
						mouthOpen = true;
						//Systems.sound.play( Resources.ChangeMouth );
						
						break;
						
					case 1 :
						removeChild( thisPlayer );
						thisPlayer = new Resources.MouthClosed;
						addChild( thisPlayer );
						mouthOpen = false;
						//Systems.sound.play( Resources.ChangeMouth );
						
						break;
				}
			}
			
			if ( this.y > Display.height - 86 )
			{
				this.y -= 25;
			}
			
			if ( this.y < 0 )
			{
				this.y += 25;
			}
		}
		
		
		public function isColliding( cocktail:Cocktail ):Boolean
		{
			var length		:Number = ( halfWidth + cocktail.halfWidth );
			var diff		:Number = Math.abs( this.x - cocktail.x );
			
			if ( diff < length )
			{
				length 	= ( halfHeight + cocktail.halfHeight );
				diff	= Math.abs( this.y - cocktail.y );
				
				if ( diff < length )
				{
					return true;
				}
			}
			
			return false;
		}
	}
}