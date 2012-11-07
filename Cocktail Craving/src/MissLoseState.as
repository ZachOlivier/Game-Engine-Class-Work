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
	
	public class MissLoseState implements IState
	{
		public function MissLoseState()
		{
		}
		
		
		public function start():void
		{
			var cocktail:Bitmap = new Resources.RedCocktail;
			cocktail.x = 310;
			cocktail.y = 150;
			Display.ui.addChild ( cocktail );
			
			var tf:TextField = maketf();
			tf.text = "  You Missed A Red Cocktail!";
			tf.x = 150;
			tf.y = 10;
			Display.ui.addChild( tf );
			
			var button:Sprite = makeButton( "     Try Again?", playAgain );
			button.x = 30;
			button.y = Display.height - 70;
			Display.ui.addChild( button );
			
			button = makeButton( "         Credits", viewCredits );
			button.x = 470;
			button.y = Display.height - 70;
			Display.ui.addChild( button );
		}
		
		
		public function update():void
		{
		}
		
		
		public function end():void
		{
			Display.clear();
			
			Global.drunk = 0;
			Global.redScore = 0;
		}
		
		
		public function playAgain( button:ButtonPure ):void
		{
			State.current = new ShellState();
		}
		
		
		public function viewCredits( button:ButtonPure ):void
		{
			State.current = new CreditsState();
		}
	}
}