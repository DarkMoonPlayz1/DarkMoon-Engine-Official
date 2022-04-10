package openfl.display;

import flixel.FlxG;
import haxe.Timer;
import openfl.Lib;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.DisplayObject;
import openfl.display.FPS;
import openfl.events.Event;
import openfl.events.EventType;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;

class MemoryCounter extends TextField
{
	public var times:Array<Float>;

	private var memPeak:Float = 0;

	public function new(inX:Float = 10.0, inY:Float = 10.0, inCol:Int = 0x000000, bold:Bool = false)
	{
		super();
		x = inX;
		y = inY;
		selectable = false;
		defaultTextFormat = new TextFormat("_sans", 12, inCol, false);
		text = "FPS: ";
		times = [];
		addEventListener(Event.ENTER_FRAME, onEnter);
		width = 170;
		height = 70;
	}

	private function onEnter(_)
	{
		var now = Timer.stamp();

		times.push(now);

		while (times[0] < now - 1)
			times.shift();

		var mem:Float = Math.round(System.totalMemory / 1024 / 1024 * 100) / 100;

		if (mem > memPeak)
			memPeak = mem;

		if (visible)
		{
			#if debug
			text = "FPS: "
				+ times.length
				+ "\nMEM: "
				+ mem
				+ " MB\nMEM Peak: "
				+ memPeak
				+ " MB"
				+ "\nDarkMoonEngine v1.6"
				+ '\n[DEBUG MODE]';
			#else
			text = "FPS: " + times.length + "\nMEM: " + mem + " MB\nMEM Peak: " + memPeak + " MB" + "\nDarkMoonEngine v1.6";
			#end
		}
	}
}
