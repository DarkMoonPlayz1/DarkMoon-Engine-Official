package;

import flixel.FlxSprite;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

class HealthIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;

	private var isOldIcon:Bool = false;
	private var isPlayer:Bool = false;
	private var char:String = '';

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		isOldIcon = (char == 'bf-old');
		this.isPlayer = isPlayer;
		changeIcon(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}

	private var iconOffsets:Array<Float> = [0, 0];

	public function changeIcon(char:String)
	{
		if (this.char != char)
		{
			var name:String = 'icons/' + char;
			if (!Paths.fileExists('images/' + name + '.png', IMAGE)) // finds the characters icon png
				name = 'icons/icon-' + char;
			if (!Paths.fileExists('images/' + name + '.png',
				IMAGE)) // else if it doesn't find the icon for the character, then instead of crashing, it will make the icon to the placeholder icon
				name = 'icons/icon-face';
			var file:Dynamic = Paths.image(name);

			loadGraphic(file);
			loadGraphic(file, true, Math.floor(width / 3), Math.floor(height));
			iconOffsets[0] = (width - 150) / 3;
			iconOffsets[1] = (width - 150) / 3;
			iconOffsets[2] = (width - 150) / 3;
			updateHitbox();

			animation.add(char, [0, 1, 2], 0, false, isPlayer);
			animation.play(char);
			this.char = char;

			antialiasing = ClientPrefs.globalAntialiasing;
			if (char.endsWith('-pixel'))
			{
				antialiasing = false;
			}
		}
	}

	override function updateHitbox()
	{
		super.updateHitbox();
		offset.x = iconOffsets[0];
		offset.y = iconOffsets[1];
	}

	public function getCharacter():String
	{
		return char;
	}
}
