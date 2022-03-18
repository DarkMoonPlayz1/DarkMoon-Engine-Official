import flixel.FlxG;

class Ratings
{
    public static function GenerateLetterRank(accuracy:Float)
    {
        var ranking:String = "N/A";
		if(FlxG.save.data.botplay)
			ranking = "N/A";

        if (PlayState.misses == 0 && PlayState.bads == 0 && PlayState.shits == 0 && PlayState.goods == 0)
            ranking = "S";
        else if (PlayState.misses == 0 && PlayState.bads == 0 && PlayState.shits == 0 && PlayState.goods >= 1)
            ranking = "A+";
        else if (PlayState.misses == 0)
            ranking = "A";
        else if (PlayState.misses < 10)
            ranking = "COMBO BROKEN";
        else
            ranking = "F";

        var wifeConditions:Array<Bool> = [
            accuracy >= 99.9935,
            accuracy >= 99.980,
            accuracy >= 99.970,
            accuracy >= 99.955,
            accuracy >= 99.90,
            accuracy >= 99.80,
            accuracy >= 99.70,
            accuracy >= 99,
            accuracy >= 96.50,
            accuracy >= 93,
            accuracy >= 90,
            accuracy >= 85,
            accuracy >= 80,
            accuracy >= 70,
            accuracy >= 60,
            accuracy < 60
        ];

        for(i in 0...wifeConditions.length)
        {
            var b = wifeConditions[i];
            if (b)
            {
                switch(i)
                {
                    case 0:
                        ranking += "";
                    case 1:
                        ranking += "";
                    case 2:
                        ranking += "";
                    case 3:
                        ranking += "";
                    case 4:
                        ranking += "";
                    case 5:
                        ranking += "";
                    case 6:
                        ranking += "";
                    case 7:
                        ranking += "";
                    case 8:
                        ranking += " ";
                    case 9:
                        ranking += "";
                    case 10:
                        ranking += "";
                    case 11:
                        ranking += "";
                    case 12:
                        ranking += "";
                    case 13:
                        ranking += "";
                    case 14:
                        ranking += "";
                    case 15:
                        ranking += "";
                }
                break;
            }
        }

        if (accuracy == 0)
            ranking = "N/A";
		else if(FlxG.save.data.botplay)
			ranking = "N/A";

        return ranking;
    }
    
    public static function CalculateRating(noteDiff:Float, ?customSafeZone:Float):String // Generate a judgement through some timing shit
    {

        var customTimeScale = Conductor.timeScale;

        if (customSafeZone != null)
            customTimeScale = customSafeZone / 166;

        // trace(customTimeScale + ' vs ' + Conductor.timeScale);

	if (FlxG.save.data.botplay)
	    return "sick";
	    
        if (noteDiff > 166 * customTimeScale)
            return "miss";
        if (noteDiff > 135 * customTimeScale)
            return "shit";
        else if (noteDiff > 90 * customTimeScale)
            return "bad";
        else if (noteDiff > 45 * customTimeScale)
            return "good";
        else if (noteDiff < -45 * customTimeScale)
            return "good";
        else if (noteDiff < -90 * customTimeScale)
            return "bad";
        else if (noteDiff < -135 * customTimeScale)
            return "shit";
        else if (noteDiff < -166 * customTimeScale)
            return "miss";
        return "sick";
    }


}