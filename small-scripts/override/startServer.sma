public __startServer()
{
	printf("^n================  SMALL SCRIPTS STARTED  ===================^n^n");
	
	initCommandSystem();
	initPageSystem();
	#if ACTIVATE_EXTENDED_SKILLSYSTEM 
	initExtendedSkillsystem();
	#endif
	
	printf("^n================  END OF STARTUP SCRIPTS ===================^n^n");
}