package;

import flixel.FlxG;
import flixel.FlxSprite;

/**
 * ...
 * @author .:Tom Fang:.
 */
enum MoverMoveDirection
{
	UP;
	DOWN;
	LEFT;
	RIGHT;
}

class SimpleMover extends FlxSprite
{
	/**
	 * How big the tiles of the tilemap are.
	 */
	inline static private var TILE_SIZE:Int = 16;
	/**
	 * How many pixels to move each frame. Has to be a divider of TILE_SIZE 
	 * to work as expected (move one block at a time), because we use the
	 * modulo-operator to check whether the next block has been reached.
	 */
	inline static private var MOVEMENT_SPEED:Int = 1; //half-speed of Player
	
	/**
	 * Flag used to check if char is moving.
	 */ 
	public var moveToNextTile:Bool;
	/**
	 * Var used to hold moving direction.
	 */ 
	private var moveDirection:MoverMoveDirection;
	
	public function new(X:Int, Y:Int)
	{
		// X,Y: Starting coordinates
		super(X, Y);
		
		// Make the player graphic.
		makeGraphic(TILE_SIZE, TILE_SIZE, 0xffff7f50); //for colors: https://github.com/HaxeFlixel/flixel/blob/dev/flixel/util/FlxColor.hx
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
		
		// Check for WASD or arrow key presses and move accordingly
		if (FlxG.keyboard.pressed("N"))
		{
			moveTo(MoverMoveDirection.LEFT);
		}
		
		else if (FlxG.keyboard.pressed("M"))
		{
			moveTo(MoverMoveDirection.RIGHT);
		}
	}
	
	public function moveTo(Direction:MoverMoveDirection):Void
	{
		// Only change direction if not already moving
		if (!moveToNextTile)
		{
			moveDirection = Direction;
			moveToNextTile = true;
		}
	}
}
