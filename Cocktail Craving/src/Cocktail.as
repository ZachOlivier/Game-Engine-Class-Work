package 
{
	import engine.*;
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Zach Olivier
	 */
	
	public class Cocktail extends Sprite
	{	
		public var halfWidth	:Number = 20;
		public var halfHeight	:Number = 28;
		
		public var color		:int 	= 0;
		
		public var isDisposed	:Boolean = false;
		
		public var thisCocktail	:Bitmap;
		
		
		// CTOR
		public function Cocktail()
		{	
			color = ( Math.random() * 4 );
			
			if ( color == 0 )
			{
				thisCocktail = new Resources.BlueCocktail();
			}
			else if ( color == 1 )
			{
				thisCocktail = new Resources.GreenCocktail();
			}
			else if ( color == 2 )
			{
				thisCocktail = new Resources.PurpleCocktail();
			}
			else if ( color == 3 )
			{
				thisCocktail = new Resources.RedCocktail();
			}
			else if ( color == 4 )
			{
				thisCocktail = new Resources.YellowCocktail();
			}
			
			addChild( thisCocktail );
			
			thisCocktail.width = halfWidth * 2;
			thisCocktail.height = halfHeight * 2;
		}
		
		
		public function dispose():void
		{
			isDisposed = true;
		}
		
		
		public function update():void
		{
		}
	}
}