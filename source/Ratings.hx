import flixel.FlxG;

class Ratings
{
    public static function GenerateLetterRank(accuracy:Float)
    {
        var ranking:String = "";
		if(FlxG.save.data.botplay)
			ranking = "BotPlay";

        if (PlayState.misses == 0 && PlayState.bads == 0 && PlayState.shits == 0 && PlayState.goods == 0)
            ranking = "FC";
        else if (PlayState.misses == 0 && PlayState.bads == 0 && PlayState.shits == 0 && PlayState.goods >= 1)
            ranking = "FC";
        else if (PlayState.misses == 0)
            ranking = "FC";

        // WIFE TIME :)))) (based on Wife3)

        var wifeConditions:Array<Bool> = [
            accuracy >= 99.9935, // AAAAA
            accuracy >= 99.980, // AAAA:
            accuracy >= 99.970, // AAAA.
            accuracy >= 99.955, // AAAA
            accuracy >= 99.90, // AAA:
            accuracy >= 99.80, // AAA.
            accuracy >= 99.70, // AAA
            accuracy >= 99, // AA:
            accuracy >= 96.50, // AA.
            accuracy >= 93, // AA
            accuracy >= 90, // A:
            accuracy >= 85, // A.
            accuracy >= 80, // A
            accuracy >= 70, // B
            accuracy >= 60, // C
            accuracy < 60 // D
        ];

        for(i in 0...wifeConditions.length)
        {
            var b = wifeConditions[i];
            if (b)
            {
                switch(i)
                {
                    case 0:
                        ranking += " ";
                    case 1:
                        ranking += " ";
                    case 2:
                        ranking += " ";
                    case 3:
                        ranking += " ";
                    case 4:
                        ranking += " ";
                    case 5:
                        ranking += " ";
                    case 6:
                        ranking += " ";
                    case 7:
                        ranking += " ";
                    case 8:
                        ranking += " ";
                    case 9:
                        ranking += " ";
                    case 10:
                        ranking += " ";
                    case 11:
                        ranking += " ";
                    case 12:
                        ranking += " ";
                    case 13:
                        ranking += " ";
                    case 14:
                        ranking += " ";
                    case 15:
                        ranking += " ";
                }
                break;
            }
        }

        if (PlayState.misses == 0 && accuracy == 0)
            ranking = "FC";
        if (PlayState.misses >= 1 && accuracy <= 75)
            ranking = "BAD";
        if (PlayState.misses == 0 && accuracy <= 96)    
            ranking = "A";
		else if(FlxG.save.data.botplay)
			ranking = "BotPlay";

        return ranking;
    }
    
    public static function CalculateRating(noteDiff:Float, ?customSafeZone:Float):String
    {

        var customTimeScale = Conductor.timeScale;

        if (customSafeZone != null)
            customTimeScale = customSafeZone / 166;

        // trace(customTimeScale + ' vs ' + Conductor.timeScale);

        // trace('Hit Info\nDifference: ' + noteDiff + '\nZone: ' + Conductor.safeZoneOffset * 1.5 + "\nTS: " + customTimeScale + "\nLate: " + 155 * customTimeScale);

	if (FlxG.save.data.botplay)
	    return "sick";
	    
        if (noteDiff > 166 * customTimeScale) // so god damn early its a miss
            return "miss";
        if (noteDiff > 135 * customTimeScale) // way early
            return "shit";
        else if (noteDiff > 90 * customTimeScale) // early
            return "bad";
        else if (noteDiff > 45 * customTimeScale) // your kinda there
            return "good";
        else if (noteDiff < -45 * customTimeScale) // little late
            return "good";
        else if (noteDiff < -90 * customTimeScale) // late
            return "bad";
        else if (noteDiff < -135 * customTimeScale) // late as fuck
            return "shit";
        else if (noteDiff < -166 * customTimeScale) // so god damn late its a miss
            return "miss";
        return "sick";
    }

    public static function CalculateRanking(score:Int,scoreDef:Int,nps:Int,maxNPS:Int,accuracy:Float):String
    {
        return 
        (FlxG.save.data.npsDisplay ? "NPS: " + nps + " (Max " + maxNPS + ")" + (!FlxG.save.data.botplay ? " | " : "") : "") + (!FlxG.save.data.botplay ?	// NPS Toggle
        "Score:" + (Conductor.safeFrames != 10 ? score + " (" + scoreDef + ")" : "" + score) + 									// Score
        " | Misses:" + PlayState.misses + 																				// Misses/Combo Breaks
        " | Accuracy:" + (FlxG.save.data.botplay ? "N/A" : HelperFunctions.truncateFloat(accuracy, 2) + "%") +  				// Accuracy
        " | " + GenerateLetterRank(accuracy) : ""); 																			// Letter Rank
    }
}