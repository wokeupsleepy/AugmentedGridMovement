package;
 
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
 
/**
 * ...
 * @author .:BuzzJeux:.
 */
class PlayState extends FlxState //a FlxState for every menu and level, think of it as a one continuous "screen"
//does this allows Mario-type scrolling?
{
	public var player:CustomTiledMover;
	public var mover:SimpleMover;
	private var _level:TiledLevel;
	private var bottomText:FlxText;
	private var inProximity:Bool;
	
	override public function create():Void
	{
		// Set the background color
		bgColor = 0xff000000;
		
		// Load the level's tilemaps
		_level = new TiledLevel("assets/data/map.tmx");
		
		// Add tilemaps
		add(_level.backgroundTiles);
		
		// Add tilemaps
		add(_level.foregroundTiles);
		
		// Load player and objects of the Tiled map
		_level.loadObjects(this);
		
		// Set and create Txt Howto
		bottomText = new FlxText(0, 225, FlxG.width);
		bottomText.alignment = "center";
		bottomText.text = "default text";
		bottomText.scrollFactor.set(0, 0);
		add(bottomText);
		inProximity = false;
	}
	
	override public function update():Void
	{
		super.update();
			
		if (player.getXPosition() % 16 == 0 && player.getYPosition() % 16 == 0) {
			bottomText.text = Std.string(player.getXPosition() / 16) + ":" + Std.string(player.getYPosition() / 16) +
			":" + player.getMoveDirection() + "  Moving?:" + player.moveToNextTile + "  Proximity?:" + inProximity;
		}
		
		/*
		alright, so the below change prevents them from clipping into each other, but now they stay stuck in the position
		the solution is to make another check afterward to see if they move apart, i.e. if Math.abs(player.x - mover.x) > 16 --> allows movement
		*/
		
		if ((Math.abs(player.getXPosition() - mover.getXPosition())) <= 16 && ((Math.abs(player.getYPosition() - mover.getYPosition())) <= 16)) {
			inProximity = true;
		}
		
		if (inProximity == true) {
			player.moveToNextTile = false;
			mover.moveToNextTile = false;
		}
		
		
		// Collide with foreground tile layer
		if (_level.collideWithLevel(player))
		{
			// Resetting the movement flag if the player hits the wall 
			// is crucial, otherwise you can get stuck in the wall
			player.moveToNextTile = false;
		}
		
		if (_level.collideWithLevel(mover))
		{
			mover.moveToNextTile = false;
		}
		
	}

	/*
	private function checkProximity():Bool
	{
		var proximityBool:Bool = false;
		
		if (((player.getXPosition() - mover.getXPosition()) < 2) || (player.getYPosition() - mover.getYPosition()) < 2))
		{
			proximityBool = true;
		}
		else
		{
			proximityBool = false;
		}
		
		return proximityBool;
	}
	*/
	
	override public function destroy():Void
	{
		super.destroy();
		
		player = null;
		_level = null;
		bottomText = null;
	}
}
