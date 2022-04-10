import flixel.FlxG;

class Ratings
{
	public static function GenerateLetterRank(accuracy:Float) // generate a letter ranking
	{
		var ranking:String = "N/A";
		if (FlxG.save.data.botplay && !PlayState.loadRep)
			ranking = "AutoPlay";

		if (PlayState.misses == 0 && PlayState.bads == 0 && PlayState.shits == 0 && PlayState.goods == 0)
			ranking = "[PFC]";
		else if (PlayState.misses == 0 && PlayState.bads == 0 && PlayState.shits == 0 && PlayState.goods >= 1)
			ranking = "[GFC]";
		else if (PlayState.misses == 0)
			ranking = "[FC]";
		else if (PlayState.misses < 10)
			ranking = "[SDCB]";
		else
			ranking = "(Clear)";

		var wifeConditions:Array<Bool> = [
			accuracy >= 99.9935, // S
			accuracy >= 99.980, // A
			accuracy >= 99.970, // A
			accuracy >= 99.955, // A
			accuracy >= 99.90, // A
			accuracy >= 99.80, // A
			accuracy >= 99.70, // A
			accuracy >= 99, // A
			accuracy >= 96.50, // A
			accuracy >= 93, // A
			accuracy >= 90, // A
			accuracy >= 90, // A
			accuracy >= 90, // A
			accuracy >= 80, // B
			accuracy >= 70, // C
			accuracy >= 60, // D
			accuracy < 59.9935 // F
		];

		for (i in 0...wifeConditions.length)
		{
			var b = wifeConditions[i];
			if (b)
			{
				switch (i)
				{
					case 0:
						ranking += " S";
					case 1:
						ranking += " A";
					case 2:
						ranking += " A";
					case 3:
						ranking += " A";
					case 4:
						ranking += " A";
					case 5:
						ranking += " A";
					case 6:
						ranking += " A";
					case 7:
						ranking += " A";
					case 8:
						ranking += " A";
					case 9:
						ranking += " A";
					case 10:
						ranking += " A";
					case 11:
						ranking += " A";
					case 12:
						ranking += " A";
					case 13:
						ranking += " B";
					case 14:
						ranking += " C";
					case 15:
						ranking += " D";
					case 16:
						ranking += " F";
				}
				break;
			}
		}

		if (accuracy == 0)
			ranking = "N/A";
		else if (FlxG.save.data.botplay && !PlayState.loadRep)
			ranking = "AutoPlay";

		return ranking;
	}

	public static function CalculateRating(noteDiff:Float, ?customSafeZone:Float):String // Generate a judgement through timing
	{
		var customTimeScale = Conductor.timeScale;

		if (customSafeZone != null)
			customTimeScale = customSafeZone / 166;

		// trace(customTimeScale + ' vs ' + Conductor.timeScale);

		// trace('Hit Info\nDifference: ' + noteDiff + '\nZone: ' + Conductor.safeZoneOffset * 1.5 + "\nTS: " + customTimeScale + "\nLate: " + 155 * customTimeScale);

		if (FlxG.save.data.botplay && !PlayState.loadRep)
			return "sick"; // FUNNY

		var rating = checkRating(noteDiff, customTimeScale);

		return rating;
	}

	public static function checkRating(ms:Float, ts:Float)
	{
		var rating = "sick";
		if (ms <= 166 * ts && ms >= 135 * ts)
			rating = "shit";
		if (ms < 135 * ts && ms >= 90 * ts)
			rating = "bad";
		if (ms < 90 * ts && ms >= 45 * ts)
			rating = "good";
		if (ms < 45 * ts && ms >= -45 * ts)
			rating = "sick";
		if (ms > -90 * ts && ms <= -45 * ts)
			rating = "good";
		if (ms > -135 * ts && ms <= -90 * ts)
			rating = "bad";
		if (ms > -166 * ts && ms <= -135 * ts)
			rating = "shit";
		return rating;
	}

	public static function CalculateRanking(score:Int, scoreDef:Int, nps:Int, maxNPS:Int, accuracy:Float):String
	{
		return (FlxG.save.data.npsDisplay ? // NPS Toggle
			"NPS: "
			+ nps
			+ " (Max "
			+ maxNPS
			+ ")"
			+ (!PlayStateChangeables.botPlay || PlayState.loadRep ? " | " : "") : "") + // 	NPS
			(!PlayStateChangeables.botPlay
				|| PlayState.loadRep ? "Score:" + (Conductor.safeFrames != 10 ? score + " (" + scoreDef + ")" : "" + score) + // Score
					(FlxG.save.data.accuracyDisplay ? // Accuracy Toggle
						" // Misses:"
						+ PlayState.misses
						+ // 	Misses/Combo Breaks
						" // Accuracy:"
						+ (PlayStateChangeables.botPlay && !PlayState.loadRep ? "N/A" : HelperFunctions.truncateFloat(accuracy, 2) + " %")
						+ // 	Accuracy
						" // "
						+ GenerateLetterRank(accuracy) : "") : ""); // 	Letter Rank
	}
}
