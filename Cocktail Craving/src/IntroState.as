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
	
	public class IntroState implements IState
	{
		private var drunkMeter			:DrunkMeter;
		private var player				:Player;
		
		
		public function IntroState()
		{
		}
		
		
		public function start():void
		{
			Display.console.visible = false;
			
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
			
			var tf:TextField = maketf();
			tf.text = "Drunk Meter ^^^^^, Don't Drink Too Much!";
			tf.x = 95;
			tf.y = 80;
			Display.ui.addChild( tf );
			
			tf = maketf();
			tf.text = "Hold 'W' or ARROW UP to move up";
			tf.x = 95;
			tf.y = 170;
			Display.ui.addChild( tf );
			
			tf = maketf();
			tf.text = "Hold 'S' or ARROW DOWN to move down";
			tf.x = 95;
			tf.y = 220;
			Display.ui.addChild( tf );
			
			tf = maketf();
			tf.text = "SPACE or LEFT MOUSE to change mouth";
			tf.x = 95;
			tf.y = 270;
			Display.ui.addChild( tf );
			
			tf = maketf();
			tf.text = "Objective : Drink ONLY 10 Red Cocktails!";
			tf.x = 95;
			tf.y = 370;
			Display.ui.addChild( tf );
			
			tf = maketf();
			tf.text = "Dont Forget You Can Close Your Mouth!";
			tf.x = 95;
			tf.y = 470;
			Display.ui.addChild( tf );
			
			var button:Sprite = makeButton( "    I've Got This!", initiateGame );
			button.x = 250;
			button.y = Display.height - 70;
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
		
		
		public function initiateGame( button:ButtonPure ):void
		{
			State.current = new ShellState();
		}
	}
}