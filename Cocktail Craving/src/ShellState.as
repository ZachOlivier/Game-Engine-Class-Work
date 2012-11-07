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
	
	public class ShellState implements IState
	{
		private var drunkMeter			:DrunkMeter;
		private var player				:Player;
		
		
		public function ShellState()
		{
		}
		
		
		public function start():void
		{
			drunkMeter = new DrunkMeter();
			drunkMeter.x = 150;
			drunkMeter.width = 350;
			Display.ui.addChild( drunkMeter );
			
			player = new Player();
			player.width = 80;
			player.height = 96;
			player.y = Display.height / 2;
			Display.ui.addChild( player );
			
			var tfRedScore:TextField = maketf();
			tfRedScore.text = "RED " + Global.redScore + " / 10";
			tfRedScore.x = 620;
			tfRedScore.y = 0;
			Display.ui.addChild( tfRedScore );
			
			var cocktail:Bitmap = new Resources.RedCocktail;
			cocktail.x = 450;
			cocktail.y = 200;
			Display.ui.addChild ( cocktail );
			
			var tf:TextField = maketf();
			tf.text = "Are You Ready To DRINK!?!";
			tf.x = 160;
			tf.y = 80;
			Display.ui.addChild( tf );
			
			var button:Sprite = makeButton( "   Start Drinking!", clickPlay );
			button.x = 120;
			button.y = Display.height - 270;
			Display.ui.addChild( button );
		}
		
		
		public function update():void
		{
			player.update();
		}
		
		
		public function end():void
		{
			Display.clear();
		}
		
		
		public function clickPlay( button:ButtonPure ):void
		{
			State.current = new GameState();
		}
	}
}