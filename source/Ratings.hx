import flixel.FlxG;

class Ratings
{
    public static function GenerateLetterRank(accuracy:Float)
    {
        var ranking:String = "No Rank";
		if(FlxG.save.data.botplay)
			ranking = "BotPlay";

        if (PlayState.misses == 0 && PlayState.bads == 0 && PlayState.shits == 0 && PlayState.goods == 0) // Marvelous (SICK) Full Combo
            ranking = "MARVELOUS -";
        else if (PlayState.misses == 0 && PlayState.bads == 0 && PlayState.shits == 0 && PlayState.goods >= 1) // Good Full Combo (Nothing but Goods & Sicks)
            ranking = "GOOD -";
        else if (PlayState.misses == 0) // Regular FC
            ranking = "Ok -";
        else if (PlayState.misses < 10) // Single Digit Combo Breaks
            ranking = "Ehh -";
        else
            ranking = "Shit -";


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
                        ranking += " A++++++"; //A+++++ instead of a humble of A's
                    case 1:
                        ranking += " A+++++";
                    case 2:
                        ranking += " A++++";
                    case 3:
                        ranking += " A+++";
                    case 4:
                        ranking += " A+++";
                    case 5:
                        ranking += " A+++";
                    case 6:
                        ranking += " A++";
                    case 7:
                        ranking += " A++";
                    case 8:
                        ranking += " A++";
                    case 9:
                        ranking += " A++";
                    case 10:
                        ranking += " A+";
                    case 11:
                        ranking += " A+";
                    case 12:
                        ranking += " A";
                    case 13:
                        ranking += " B";
                    case 14:
                        ranking += " C";
                    case 15:
                        ranking += " D";
                }
                break;
            }
        }

        if (accuracy == 0)
            ranking = "No Rank";
		else if(FlxG.save.data.botplay)
			ranking = "BotPlay";

        return ranking;
    }
    
    public static function CalculateRating(noteDiff:Float, ?customSafeZone:Float):String
    {

        var customTimeScale = Conductor.timeScale;

        if (customSafeZone != null)
            customTimeScale = customSafeZone / 166;


        // trace('Hit Info\nDifference: ' + noteDiff + '\nZone: ' + Conductor.safeZoneOffset * 1.5 + "\nTS: " + customTimeScale + "\nLate: " + 155 * customTimeScale);

	if (FlxG.save.data.botplay)
	    return "good"; // FUNNY
	    
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

    public static function CalculateRanking(score:Int,scoreDef:Int,nps:Int,maxNPS:Int,accuracy:Float):String
    {
        return 
        (FlxG.save.data.npsDisplay ? "Notes Per Second: " + nps + " (Max " + maxNPS + ")" + (!FlxG.save.data.botplay ? " | " : "") : "") + (!FlxG.save.data.botplay ?	// If NPS Toggle, then shows counter
        "Score:" + (Conductor.safeFrames != 10 ? score + " (" + scoreDef + ")" : "" + score) + 									// Score
        " | Miss Counter:" + PlayState.misses + 																				// Misses
        " | Accuracy Percentage:" + (FlxG.save.data.botplay ? "No Rank" : HelperFunctions.truncateFloat(accuracy, 2) + " %") +  // Accuracy 
        " | " + GenerateLetterRank(accuracy) : ""); 																			// Letter Rank
    }
}
