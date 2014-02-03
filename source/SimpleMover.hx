package;

import flixel.FlxG;
import flixel.FlxSprite;

/**
 * ...
 * @author Tom Fang
 */
enum MoveDirection
{
	UP;
	DOWN;
	LEFT;
	RIGHT;
}

//SimpleMover is pretty much a copy of Player
//I want it to go in a single direction by itself from the start without user input
//boolean constantMove handles this, if true it will sweep back and forth
//look at the object layer (mover start) in map.tmx using Tiled

class SimpleMover extends FlxSprite 
{
	
	inline static private var TILE_SIZE:Int = 16;
	inline static private var MOVEMENT_SPEED:Int = 2;
	public var moveToNextTile:Bool;
	private var moveDirection:MoveDirection;
	
	public var constantMove:Bool;
	//Mover won't start until the "M" key is pressed
	
	public function new(X:Int, Y:Int)
	{
		// X,Y: Starting coordinates
		super(X, Y);
		
		// Make the player graphic.
		makeGraphic(TILE_SIZE, TILE_SIZE, 0xffc04040);
	}
	override public function update():Void
	{
		super.update();  
		
		// Move the player to the next block
		if (moveToNextTile)
		{
			switch(moveDirection)
			{
				case UP:
					y -= MOVEMENT_SPEED;
				case DOWN:
					y += MOVEMENT_SPEED;
				case LEFT:
					x -= MOVEMENT_SPEED;
				case RIGHT:
					x += MOVEMENT_SPEED;
			}
		}
		
		// Check if the player has now reached the next block
		if ((x % TILE_SIZE == 0) && (y % TILE_SIZE == 0))
		{
			moveToNextTile = false;
		}

	public function moveTo(Direction:MoveDirection):Void
	{
		// Only change direction if not already moving
		if (!moveToNextTile)
		{
			moveDirection = Direction;
			moveToNextTile = true;
		}
	}
}