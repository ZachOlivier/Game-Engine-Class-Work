package  
{
	import engine.*;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Zach Olivier
	 */
	
	public class GameState implements IState
	{
		private const COCKTAIL_BASE		:int = 4;
		
		public var speed				:int = 6;
		
		public var canMiss				:Boolean;
		
		public var tfRedScore			:TextField = maketf();
		
		private var drunkMeter			:DrunkMeter;
		private var player				:Player;
		private var cocktails			:Vector.<Cocktail>;
		
		
		public function GameState()
		{
		}
		
		
		public function start():void
		{
			// Place the text fields and drunk meter
			tfRedScore.x = 620;
			tfRedScore.y = 0;
			Display.ui.addChild( tfRedScore );
			
			// Create and place the tables
			var table:Bitmap = new Resources.Table;
			table.width = Display.width - 92;
			table.x = 92;
			table.y = 50;
			Display.background.addChild( table );
			
			table = new Resources.Table;
			table.width = Display.width - 92;
			table.x = 92;
			table.y = 190;
			Display.background.addChild( table );
			
			table = new Resources.Table;
			table.width = Display.width - 92;
			table.x = 92;
			table.y = 330;
			Display.background.addChild( table );
			
			table = new Resources.Table;
			table.width = Display.width - 92;
			table.x = 92;
			table.y = 470;
			Display.background.addChild( table );
			
			// Send the first 4 cocktails
			newRound();
			Systems.console.add( "Four New Cocktails!" );
			
			// Get the player and the drunk meter
			player = new Player();
			player.width = 80;
			player.height = 96;
			player.y = ( Display.height / 2 );
			Display.main.addChild( player );
			
			drunkMeter = new DrunkMeter();
			drunkMeter.x = 150;
			drunkMeter.width = 350;
			Display.ui.addChild( drunkMeter );
		}
		
		
		public function update():void
		{
			tfRedScore.text = "RED " + Global.redScore + " / 10";
			
			var cocktail:Cocktail;
			
			var len:int = cocktails.length;
			for ( var i:int = 0; i < len; i++ )
			{
				cocktail = cocktails[i];
				
				cocktail.x -= speed;
			}
			
			player.update();
			drunkMeter.update();
			
			for ( i = len - 1; i >= 0; i-- )
			{
				cocktail = cocktails[i];
				
				if ( player.isColliding( cocktail ) && player.mouthOpen == true && cocktail.color == 3 )
				{
					Display.main.removeChild( cocktail );
					cocktails.splice( i, 1 );
					
					//Systems.sound.play( Resources.GoodCocktail );
					
					Systems.console.add( "You Drank A Red Cocktail!" );
					
					speed += 3;
					canMiss = false;
					
					Global.drunk += 1;
					Global.redScore += 1;
				}
				else if ( player.isColliding( cocktail ) && player.mouthOpen == true && cocktail.color != 3 )
				{
					Display.main.removeChild( cocktail );
					cocktails.splice ( i, 1 );
					
					//Systems.sound.play( Resources.BadCocktail );
					
					Systems.console.add( "You Drank A Cocktail That Wasn't Red!" );
					
					speed += 5;
					
					Global.drunk += 2;
				}
				else if ( cocktail.x < -60 && cocktail.color == 3 && canMiss == true )
				{
					//Systems.sound.play( Resources.LoseMiss );
					
					youLoseMiss();
					
					Systems.console.add( "You Must Have Missed A Red Cocktail!" );
				}
				else if ( cocktail.x < -120 )
				{
					Display.main.removeChild( cocktail );
					cocktails.splice( i, 1 );
				}
			}
			
			// As soon as the cocktails are all off screen, send 4 more faster cocktails
			if ( cocktails.length == 0 )
			{
				newRound();
				
				Systems.console.add( "Four New Cocktails!" );
			}
			
			// If the player got all of the correct cocktails, show win screen after end
			if ( Global.redScore == 10 && Global.drunk == 10 )
			{
				//Systems.sound.play( Resources.YouWin );
				
				youWin();
				
				Systems.console.add( "Congratulations, You Win!" );
			}
			
			// If the player got any of the wrong cocktails, show lose screen after drunk
			else if ( Global.redScore == 10 && Global.drunk > 10 )
			{
				//Systems.sound.play( Resources.LoseDrunk );
				
				youLoseDrunk();
				
				Systems.console.add( "You Drank Too Much!" );
			}
		}
		
		
		public function end():void
		{
			Display.clear();
		}
		
		
		public function newRound():void
		{
			canMiss = true;
			
			var cocktail:Cocktail;
			cocktails = new Vector.<Cocktail>();
			
			for ( var i:int = 0; i < COCKTAIL_BASE; i++ )
			{
				cocktail = new Cocktail();
				cocktails.push( cocktail );
				
				Display.main.addChild( cocktail );
				
				cocktail.x = 800 + ( Math.random() * 100 );
				
				if ( i == 0 )
				{
					cocktail.y = 60;
				}
				else if ( i == 1 )
				{
					cocktail.y = 200;
				}
				else if ( i == 2 )
				{
					cocktail.y = 340;
				}
				else if ( i == 3 )
				{
					cocktail.y = 480;
				}
			}
		}
		
		
		public function youWin():void
		{
			State.current = new WinState();
		}
		
		
		public function youLoseDrunk():void
		{
			State.current = new DrunkLoseState();
		}
		
		
		public function youLoseMiss():void
		{
			State.current = new MissLoseState();
		}
	}
}