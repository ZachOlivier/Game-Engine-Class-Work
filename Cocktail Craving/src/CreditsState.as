package  
{
	import engine.*;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Zach Olivier
	 */
	
	public class CreditsState implements IState
	{
		public var tf:TextField;
		
		public var cocktailParty:Bitmap = new Resources.CocktailParty;
		
		
		public function CreditsState()
		{
		}
		
		
		public function start():void
		{
			Display.ui.addChild( cocktailParty );
			center( cocktailParty );
			
			cocktailParty.visible = false;
			
			tf = maketf();
			tf.text = "Thank You For Playing Cocktail Craving!";
			tf.x = 65;
			tf.y = 10;
			Display.ui.addChild( tf );
			
			tf = maketf();
			tf.text = "  This Was Created By Zach Olivier";
			tf.x = 100;
			tf.y = 70;
			Display.ui.addChild( tf );
			
			var button:Sprite = makeButton( "    Restart Game", clickPlay );
			button.x = 250;
			button.y = Display.height - 65;
			Display.ui.addChild( button );
		}
		
		
		public function update():void
		{
			tf.y += 5;
			
			if ( tf.y > 480 )
			{
				tf.y -= 5;
				
				cocktailParty.visible = true;
			}
		}
		
		
		public function end():void
		{
			Display.clear();
		}
		
		
		public function clickPlay( button:ButtonPure ):void
		{
			State.current = new IntroState();
		}
	}
}