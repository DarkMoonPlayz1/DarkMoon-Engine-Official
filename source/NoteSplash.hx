package;

import flixel.FlxG;
import flixel.FlxSprite;

class NoteSplash extends FlxSprite
{
    public function new(x:Float = 0, y:Float = 0, note:Int = 0) //Notesplash function funny (stole this code from AlexShadow *explodes*)
    {
        super(x, y);

        frames = Paths.getSparrowAtlas('noteSplashes', 'shared');

        animation.addByPrefix("splash 0 0", "note impact 1 purple", 24, false);
        animation.addByPrefix("splash 0 1", "note impact 2 purple", 24, false);
        animation.addByPrefix("splash 0 2", "note impact 1  blue", 24, false);
        animation.addByPrefix("splash 0 3", "note impact 2  blue", 24, false);
        animation.addByPrefix("splash 1 0", "note impact 1  green", 24, false);
        animation.addByPrefix("splash 1 1", "note impact 2  green", 24, false);
        animation.addByPrefix("splash 1 2", "note impact 1  red", 24, false);
        animation.addByPrefix("splash 1 3", "note impact 2  blue", 24, false);

        setupNoteSplash(x, y, note);
        antialiasing = true;
    }

    public function setupNoteSplash(x:Float, y:Float, note:Int = 0)
    {
        setPosition(x, y);

        var dir:Int = FlxG.random.int(0, 1);
        alpha = 0.6;
        animation.play('splash-' + note + '-' + dir, true);
        updateHitbox();
        offset.set(0.2 * width, 0.2 * height);
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
        
        if (animation.curAnim.finished)
            kill();
    }
}