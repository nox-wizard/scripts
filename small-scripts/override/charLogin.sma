/*
\fn __charLogin(const chr)
\param chr: the character who is logging in
\brief handles login stuff

Use this function to call a script at character login, do not put code in the function but call
an external function
*/
public __charLogin(const chr)
{
	if( chr_isNpc (chr)) return;
	
	printf("^n");
	log_message(" == STARTING LOGIN SCRIPTS FOR CHARACTER %d ==",chr);
	
	//reset local vars
	globaltags(chr);
	
	//defined in small-scripts/comands.sma
	startCommandSystem(chr); 
		
	//defined in "small-scripts/skills/extendedSkillsystem.sma"
	startExtSkillsystem(chr);
		
	itm_potionStart(chr);
	
	//defined in "small-scripts/comands/page/pagesystem.sma"
	addOnlineStaff(chr);
	
	hungerandthirst(chr);
	
	new racemode = race_getGlobalProp( RP_MODE );
	printf("racemode: %d^n", racemode);
	if(racemode != 0)
	{
		new race = chr_getProperty(chr, CP_NPCRACE);
		printf("race is: %d^n ", race);
		if( race < 0)
			race_menu(chr, race);
	}
	
	#if ACTIVATE_UKNOWN_CHARSYS
		start_unknown_char(chr);
	#endif
	#if !ACTIVATE_UKNOWN_CHARSYS
		stop_unknown_char(chr);
	#endif
	
	//put here any function you want to be executed at character login
		
	log_message(" ============ END OF LOGIN SCRIPTS ============");
}




const Delay_Maptile = 300;
const NumGlobalVars = 10; //1002 hunger, 1003 thirst, 1004 + 1005 skills, 1006 Race, 1007 diverses useable, 1009 taming repeats, 1010 taming target

public npccreate(const c)
{
printf("creation start");
}

public globaltags(const c)
{
new globalVar = 1002; //first globalVar we use is 1002 for hunger
for (globalVar = 1002; globalVar < (1001+NumGlobalVars); globalVar++)
    {
    if(chr_isaLocalVar( c, globalVar, VAR_TYPE_ANY ) == 0 ) //0 means no var at globalVar
        {
        chr_addLocalIntVar( c, globalVar, 0 );
        printf("char %d got global var %d^n", c, globalVar);
        }
    if((chr_isaLocalVar( c, globalVar, VAR_TYPE_STRING ) == 1)) //there already is a string variable (shouldn't happen)
        {
        chr_delLocalVar(c, globalVar, VAR_TYPE_STRING);
        chr_addLocalIntVar( c, globalVar, 0 );
        printf("char %d got global var %d^n", c, globalVar);
        }
    }
    
    //delete temp variables - they shouldn't exist, but let's delete them for safety.
    	
    	log_message("Cleaning temp local vars");
	for(new p = CLV_TEMP1; p <= CLV_CMDTEMP; p++)
		chr_delLocalVar(c,p);
	
}
