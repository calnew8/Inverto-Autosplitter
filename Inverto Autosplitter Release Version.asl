state("Inverto")
{
	byte level : 0x01E0EA4, 0x0;
}

startup
{
	settings.Add("Stage6SplitOff", false, "Do not split at the end of the run");
	settings.SetToolTip("Stage6SplitOff", "Will not split upon loading to main menu from Stage 6. If off, you must reset manually on stage 6.");
}

start
{
	if (current.level == 1 && old.level == 7)
	{
		print("Load to Stage 1 from Main Menu detected. Sending start command");
		return true;
	}
}

reset
{
	if (current.level == 7 && old.level !=7 && old.level != 0)
	{
		print("Load to Main Menu detected. Checking stage and settings.");
		if (old.level == 6 && settings["Stage6SplitOff"])
		{
			print("Current stage is 6 and Stage 6 split is off. Sending reset command.");
			return true;
		}
		if (old.level != 6)
		{
			print("Loaded to Main Menu from stage other than 6. Sending reset command.");
			return true;
		}
	}
}
split
{
	if (old.level != current.level && old.level + 1 == current.level && current.level >= 1 && current.level <= 8)
	{
		print("Load to next stage detected. Sending split command.");
		return true;
	}
}