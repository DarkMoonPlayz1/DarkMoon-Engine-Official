package;

import flash.system.System;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
#if windows
import Discord.DiscordClient;
#end

class WarningScreen extends MusicBeatState
{
	public static var alreadyWarned:Bool = false;
	public static var leftState:Bool = false;

	// variables that titlestate needs to make this appear
	public static var needVer:String = "";
	public static var currChanges:String = "";

	private var colorRotation:Int = 1;

	override function create()
	{
		super.create();

		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In Warning Screen", null);
		#end

		var bgBlackOverlay:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bgBlackOverlay.alpha = 0.6;
		add(bgBlackOverlay);

		var txt:FlxText = new FlxText(0, 0, FlxG.width,
			"WARNING: "
			+ "\nThis game contains flashing lights\nand other things"
			+ "\nthat may trigger eplipsey, so feel free to disable them in the options menu!"
			+ "\n\nPress ENTER to continue\nor ESCAPE to close the game",
			32);

		txt.setFormat("JackInput", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
		txt.borderColor = FlxColor.BLACK;
		txt.borderSize = 3;
		txt.borderStyle = FlxTextBorderStyle.OUTLINE;
		txt.screenCenter();
		add(txt);
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			leftState = true;
			alreadyWarned = true;
			FlxG.sound.music.stop();
			FlxG.switchState(new MainMenuState());
		}

		if (controls.BACK)
		{
			System.exit(0);
		}

		super.update(elapsed);
	}
}
