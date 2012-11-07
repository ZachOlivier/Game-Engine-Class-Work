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
	
	public class DrunkLoseState implements IState
	{
		public function DrunkLoseState()
		{
		}
		
		
		public function start():void
		{
			var tf		:TextField;
			
			var drunkLose:Bitmap = new Resources.DrunkLose;
			
			Display.ui.addChild( drunkLose );
			center(drunkLose);
			
			tf = maketf();
			tf.text = "You Drank Too Many Cocktails!";
			tf.x = 140;
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