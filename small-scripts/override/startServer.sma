public __startServer()
{
	printf("^n================  SMALL SCRIPTS STARTED  ===================^n^n");
	
	//defined in "small-scripts/comands.sma"
	initCommandSystem();
	
	//defined in "small-scripts/comands/page/pagesystem.sma"
	initPageSystem();
	
	//defined in "small-scripts/skills/extendedSkillsystem.sma"
	initExtendedSkillsystem();
	
	
	printf("^n================  END OF STARTUP SCRIPTS ===================^n^n");
}