state("Inverto") 
{
	//Direct memory adress to level byte
	byte level : 0x01E0EA4, 0x0;
}

startup
{
	//Full game autosplitter settings
	settings.Add("Stage6SplitOff", false, "Do not split at the end of the run");
	settings.SetToolTip("Stage6SplitOff", "Will not split upon loading to main menu from Stage 6. If off, you must reset manually on stage 6.");
	//Individual level autosplitter settings
	settings.Add("IndividualLevels", false, "Enable individual level mode");
	settings.Add("LeveL1IL", false, "Level 1 IL");
	settings.Add("LeveL2IL", false, "Level 2 IL");
	settings.Add("LeveL3IL", false, "Level 3 IL");
	settings.Add("LeveL4IL", false, "Level 4 IL");
	settings.Add("LeveL5IL", false, "Level 5 IL");
	settings.Add("LeveL6IL", false, "Level 6 IL");
}

start
{
	//Full game autosplitter start
	if (current.level == 1 && old.level == 7)
	{
		print("Load to Stage 1 from Main Menu detected. Sending start command");
		return true;
	}
	//IL autosplitter start
}

reset
{
	//All autosplitters reset
	if (current.level == 7 && old.level !=7 && old.level != 0)
	{
		print("Load to Main Menu detected. Checking stage and settings.");
		//Stage 6 split off
		if (old.level == 6 && settings["Stage6SplitOff"])
		{
			print("Current stage is 6 and Stage 6 split is off. Sending reset command.");
			return true;
		}
		//Other stages reset
		if (old.level != 6)
		{
			print("Loaded to Main Menu from stage other than 6. Sending reset command.");
			return true;
		}
	}
}

split
{
	//Full game autosplitter split
	if (old.level != current.level && old.level + 1 == current.level && current.level >= 1 && current.level <= 8)
	{
		print("Load to next stage detected. Sending split command.");
		return true;
	}
	//IL autosplitter split
}

update
{

}
