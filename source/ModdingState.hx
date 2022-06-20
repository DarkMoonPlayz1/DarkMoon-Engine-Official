package;

#if FILESYSTEM
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIGroup;
import flixel.addons.ui.FlxUIList;
import flixel.addons.ui.FlxUIRegion;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUITypedButton;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.math.FlxRect;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import haxe.Json;
import lime.app.Application;
import openfl.display.BitmapData;
import yaml.Parser.ParserOptions;
import yaml.Yaml;

using StringTools;

#if FILESYSTEM
import sys.FileSystem;
import sys.io.File;
#end

class ModLoadingState extends MusicBeatState
{
	var selector:FlxText;

	static var curSelected:Int = 0;

	var scrollBarBG:FlxSprite;
	var scrollThing:FlxSprite;

	var modGroup:FlxTypedGroup<ModWidget>;
	var camFollow:FlxObject;
	var camPos:FlxObject;

	override function create()
	{
		FlxG.mouse.visible = true;
		usesMouse = true;

		var menuBG:FlxBackdrop = new FlxBackdrop(Paths.image('menuDesat'), 1, 1, false);
		menuBG.color = 0xFFea71fd;
		menuBG.scrollFactor.set(0, 0.2);
		menuBG.antialiasing = true;
		add(menuBG);

		modGroup = new FlxTypedGroup<ModWidget>();
		add(modGroup);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		camPos = new FlxObject(0, 0, 1, 1);
		add(camPos);

		for (mod in FileSystem.readDirectory("mods"))
		{
			var modInfo = Yaml.parse(File.getContent(Paths.modInfoFile(mod)));

			var pain = new ModWidget(0, 0, mod, modInfo.get("name"), modInfo.get("description"), modInfo.get("version"),
				Helper.toBool(modInfo.get("icon-antialiasing")));
			pain.screenCenter();
			pain.scrollFactor.set(1, 1);
			pain.y += modGroup.length * 225;
			pain.ID = modGroup.length;
			modGroup.add(pain);
		}

		FlxG.camera.follow(camPos, LOCKON, 1);
		changeItem();

		super.create();
	}

	function changeItem(huh:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'));

		curSelected += huh;

		if (curSelected >= modGroup.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = modGroup.length - 1;

		modGroup.forEach(function(spr:ModWidget)
		{
			if (spr.ID == curSelected)
			{
				camFollow.setPosition(spr.x + spr.width / 2, spr.y + spr.height / 2);
			}
		});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		var lerp:Float = Helper.boundTo(elapsed * 9.2, 0, 1);
		camPos.x = FlxMath.lerp(camPos.x, camFollow.x, lerp);
		camPos.y = FlxMath.lerp(camPos.y, camFollow.y, lerp);

		if (controls.BACK)
		{
			#if FILESYSTEM
			var prevMod = Paths.currentMod;

			for (mod in FileSystem.readDirectory('mods'))
			{
				Paths.setCurrentMod(mod);
				if (Paths.checkModLoad(mod))
					CoolUtil.loadCustomDifficulties();
			}

			Paths.setCurrentMod(prevMod);
			#end

			FlxG.switchState(new MainMenuState());
			FlxG.mouse.visible = false;
		}

		if (controls.UP_P)
			changeItem(-1);

		if (controls.DOWN_P)
			changeItem(1);

		if (FlxG.mouse.wheel != 0)
			changeItem(-FlxG.mouse.wheel);
	}
}

class ModWidget extends FlxSpriteGroup
{
	public var icon:FlxSprite;
	public var iconBG:FlxSprite;

	public var modName:FlxText;
	public var modNameBG:FlxSprite;

	public var modDesc:FlxText;
	public var modDescBG:FlxSprite;

	public var daSwitch:FlxUIButton;
	public var prioritySwitch:FlxUIButton;

	public var modRepping:String;

	public var versionText:FlxText;

	public function new(x:Float, y:Float, modFolder:String, ?name:String, ?description:String, ?version:String, ?iconAntialiasing:Bool)
	{
		super(x, y);

		modRepping = modFolder;

		name = name != null ? name : "Mod name not found.";
		description = description != null ? description : "Mod description not found.";
		version = version != null ? version : "";
		iconAntialiasing = iconAntialiasing != null ? iconAntialiasing : true;

		// mf aint \n literally wth
		name = name.replace("\\n", "\n");
		description = description.replace("\\n", "\n");
		version = version.replace("\\n", "\n");

		iconBG = new FlxSprite().makeGraphic(200, 200, FlxColor.BLACK);
		iconBG.alpha = 0.4;

		modNameBG = new FlxSprite(205, 0).makeGraphic(600, 50, FlxColor.BLACK);
		modNameBG.alpha = 0.4;

		modDescBG = new FlxSprite(205, 55).makeGraphic(600, 145, FlxColor.BLACK);
		modDescBG.alpha = 0.4;

		var loadedBitmap:BitmapData = null;

		if (FileSystem.exists('mods/$modFolder/icon.png'))
			loadedBitmap = BitmapData.fromFile('mods/$modFolder/icon.png');

		icon = new FlxSprite();

		if (loadedBitmap != null)
		{
			icon.loadGraphic(loadedBitmap, true, 150, 150);

			var totalFrames = Math.floor(loadedBitmap.width / 150) * Math.floor(loadedBitmap.height / 150);
			icon.animation.add("icon", [for (i in 0...totalFrames) i], 10);
			icon.animation.play("icon");
		}
		else
			icon.loadGraphic(Paths.image('no-icon'));

		icon.setGraphicSize(Std.int(iconBG.width - 25), Std.int(iconBG.height - 25));
		icon.updateHitbox();
		icon.setPosition(iconBG.x + 12.5, iconBG.y + 12.5);

		icon.antialiasing = iconAntialiasing;

		modName = new FlxText(0, 5, modNameBG.width - 10);
		modName.setFormat(Paths.font("vcr.ttf"), 26, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		modName.borderSize = 2;
		modName.text = name;
		modName.x = modNameBG.x + 5;
		modName.y = modNameBG.y + (modNameBG.height / 2) - (modName.height / 2);

		modDesc = new FlxText(0, modDescBG.y + 5, modDescBG.width - 10);
		modDesc.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		modDesc.borderSize = 2;
		modDesc.text = description;
		modDesc.x = modDescBG.x + 5;

		versionText = new FlxText(0, 0, modDescBG.width - 10);
		versionText.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		versionText.borderSize = 2;
		versionText.text = version;
		versionText.x = modDescBG.x + 5;
		versionText.y = modDescBG.y + modDescBG.height - versionText.height - 5;

		add(iconBG);
		add(modNameBG);
		add(modDescBG);

		add(icon);
		add(modName);
		add(modDesc);
		add(versionText);

		daSwitch = new FlxUIButton(0, 0, '');
		daSwitch.loadGraphicSlice9([Paths.image('customButton')], 20, 20, [[4, 4, 16, 16]], false, 20, 20);
		daSwitch.resize(50, 30);
		daSwitch.updateHitbox();
		daSwitch.label.resize(50, 24);
		daSwitch.label.offset.y = 5;
		daSwitch.x = modDescBG.x + modDescBG.width - daSwitch.width - 10;
		daSwitch.y = modDescBG.y + modDescBG.height - daSwitch.height - 10;
		daSwitch.label.color = 0xFF000000;
		add(daSwitch);

		prioritySwitch = new FlxUIButton(0, 0, '');
		prioritySwitch.loadGraphicSlice9([Paths.image('customButton')], 20, 20, [[4, 4, 16, 16]], false, 20, 20);
		prioritySwitch.resize(50, 30);
		prioritySwitch.updateHitbox();
		prioritySwitch.label.resize(50, 24);
		prioritySwitch.label.offset.y = 5;
		prioritySwitch.x = daSwitch.x - prioritySwitch.width - 10;
		prioritySwitch.y = modDescBG.y + modDescBG.height - prioritySwitch.height - 10;
		// add(prioritySwitch);

		buttonToggle(true);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (daSwitch.justPressed)
			buttonToggle();
	}

	function buttonToggle(init:Bool = false):Void
	{
		var loadModFile:String = Paths.loadModFile(modRepping);
		var yaml = Yaml.parse(File.getContent(loadModFile));

		if (FileSystem.exists(loadModFile))
		{
			if (!init)
			{
				if (Paths.checkModLoad(modRepping))
				{
					Yaml.write(loadModFile, {
						'mod-priority': yaml.get('mod-priority'),
						'load': false
					});
				}
				else
				{
					Yaml.write(loadModFile, {
						'mod-priority': yaml.get('mod-priority'),
						'load': true
					});
				}
			}
		}
		else
		{
			Yaml.write(loadModFile, {
				'mod-priority': yaml.get('mod-priority'),
				'load': false
			});
		}

		if (!Paths.checkModLoad(modRepping))
		{
			if (!init)
				FlxG.sound.play(Paths.sound('modToggleOff'));

			daSwitch.color = 0xFFFF0000;
			daSwitch.label.text = "OFF";
		}
		else
		{
			if (!init)
				FlxG.sound.play(Paths.sound('modToggleOn'));

			daSwitch.color = 0xFF00FF00;
			daSwitch.label.text = "ON";
		}
	}

	function priorityToggle(init:Bool = false):Void {}
}
#end
