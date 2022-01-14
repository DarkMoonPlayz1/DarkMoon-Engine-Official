import flixel.FlxG;

class Ratings
{
	public static function GenerateLetterRank(accuracy:Float) //I fucking removed some unessecary line of code here
	{
		var ranking:String = "N/A";
		if (FlxG.save.data.botplay && !PlayState.loadRep)
			ranking = "BotPlay";

		if (PlayState.misses == 0 && PlayState.bads == 0 && PlayState.shits == 0 && PlayState.goods == 0)
			ranking = "Rank:";
		else if (PlayState.misses == 0 && PlayState.bads == 0 && PlayState.shits == 0 && PlayState.goods >= 1)
			ranking = "Rank:";
		else if (PlayState.misses == 0)
			ranking = "Rank:";
		else if (PlayState.misses < 10)
			ranking = "Rank:";
		else
			ranking = "Rank:";

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

		for (i in 0...wifeConditions.length)
		{
			var b = wifeConditions[i];
			if (b)
			{
				switch (i)
				{
					case 0:
						ranking += "S++++";
					case 1:
						ranking += "A+++";
					case 2:
						ranking += "A+++";
					case 3:
						ranking += "A+++";
					case 4:
						ranking += "A++";
					case 5:
						ranking += "A++";
					case 6:
						ranking += "A++";
					case 7:
						ranking += "A+";
					case 8:
						ranking += "A+";
					case 9:
						ranking += "A+";
					case 10:
						ranking += "A";
					case 11:
						ranking += "A";
					case 12:
						ranking += "A";
					case 13:
						ranking += "B";
					case 14:
						ranking += "C";
					case 15:
						ranking += "F";
				}
				break;
			}
		}

		if (accuracy == 0)
			ranking = "N/A";
		else if (FlxG.save.data.botplay && !PlayState.loadRep)
			ranking = "BotPlay";

		return ranking;
	}

	public static var timingWindows = [166.0, 135.0, 90.0, 45.0, 20.0];

	public static function judgeNote(noteDiff:Float)
	{
		var diff = Math.abs(noteDiff) / (PlayState.songMultiplier >= 1 ? PlayState.songMultiplier : 1);
		for (index in 0...timingWindows.length)
		{
			var time = timingWindows[index] * Conductor.timeScale;
			var nextTime = index + 1 > timingWindows.length - 1 ? 0 : timingWindows[index + 1];
			if (diff < time && diff >= nextTime * Conductor.timeScale)
			{
				switch (index)
				{
					case 0: // shit
						return "shit";
					case 1: // bad
						return "bad";
					case 2: // good
						return "good";
					case 3: // sick
						return "sick";
					case 4: // ultra
						return "ultra";
				}
			}
		}
		return "good";
	}

	public static function CalculateRanking(score:Int, scoreDef:Int, nps:Int, maxNPS:Int, accuracy:Float):String
	{
		return (FlxG.save.data.npsDisplay ?
			"NPS: "
			+ nps
			+ " (Max "
			+ maxNPS
			+ ")"
			+ (!PlayStateChangeables.botPlay || PlayState.loadRep ? " | " : "") : "") + // 	NPS
			(!PlayStateChangeables.botPlay
			|| PlayState.loadRep ? "Score:" + (Conductor.safeFrames != 10 ? score + " (" + scoreDef + ")" : "" + score) + // Score
								   (FlxG.save.data.accuracyDisplay ?
									" // Misses:"
									+ PlayState.misses
									+ // 	Misses/Combo Breaks
									" // Rating:"
									+ (PlayStateChangeables.botPlay && !PlayState.loadRep ? "N/A" : HelperFunctions.truncateFloat(accuracy, 2) + " %")
									+ // 	Accuracy
									" // "
									+ GenerateLetterRank(accuracy) : "") : ""); // 	Letter Rank
	}
}
