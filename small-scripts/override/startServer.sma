/*!
\author Fax
\fn __startServer()
\since 0.82
\brief performs server startup scripts

Called by OnStart override, use this function to perform code at server startup
\return nothing
*/

public __startServer()
{
	printf("^n================  SMALL SCRIPTS STARTED  ===================^n^n");
	
	//defined in "small-scripts/comands.sma"
	initCommandSystem();
	
	//defined in "small-scripts/comands/page/pagesystem.sma"
	initPageSystem();
	
	//defined in "small-scripts/skills/extendedSkillsystem.sma"
	initExtendedSkillsystem();
	
	//defined in "small-scripts/custom/worldstone.sma"
	initWorldstone();
	
	//defined in "small-scripts/custom/treasurehunt/treasurehunt.sma"
	initTreasure();
	
	printf("^n================  END OF STARTUP SCRIPTS ===================^n^n");
}
