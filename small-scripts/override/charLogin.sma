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
		if( race == 0)
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
	//Test_Noob(chr);
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

const AMX_VECTOR = 1000;
public Test_Noob (const chr)
{
	printf("^n################^nCreation^n");
	DVct_Create(chr, AMX_VECTOR);
	printf("size (0) : %d^n", DVct_GetSize(chr, AMX_VECTOR));
	
	DVct_AddElement(chr, AMX_VECTOR, 0);
	DVct_AddElement(chr, AMX_VECTOR, 1);
	DVct_AddElement(chr, AMX_VECTOR, 2);
	DVct_AddElement(chr, AMX_VECTOR, 3);
	DVct_AddElement(chr, AMX_VECTOR, 4);
	DVct_AddElement(chr, AMX_VECTOR, 5);
	DVct_AddElement(chr, AMX_VECTOR, 6);
	DVct_AddElement(chr, AMX_VECTOR, 7);
	DVct_AddElement(chr, AMX_VECTOR, 8);
	printf("first show^n");
	DisplayVector(chr);
	
	DVct_AddElement(chr, AMX_VECTOR, 9);
	DVct_AddElement(chr, AMX_VECTOR, 10);
	DVct_AddElement(chr, AMX_VECTOR, 11);
	DVct_AddElement(chr, AMX_VECTOR, 12);
	printf("second show^n");
	DisplayVector(chr);
	
	DVct_DelElement(chr, AMX_VECTOR, 2);
	DVct_DelElement(chr, AMX_VECTOR, 4);
	DVct_DelElement(chr, AMX_VECTOR, 6);
	DVct_DelElement(chr, AMX_VECTOR, 8);
	printf("third show^n");
	DisplayVector(chr);
	
	DVct_DelIndex(chr, AMX_VECTOR, 0);
	DVct_DelIndex(chr, AMX_VECTOR, 0);
	DVct_DelIndex(chr, AMX_VECTOR, 0);
	DVct_DelIndex(chr, AMX_VECTOR, 0);
	printf("fourth show^n");
	DisplayVector(chr);
	
	DVct_SetElement(chr, AMX_VECTOR, 0, 20)
	DVct_SetElement(chr, AMX_VECTOR, 1, 30)
	DVct_SetElement(chr, AMX_VECTOR, 2, 40)
	DVct_SetElement(chr, AMX_VECTOR, 3, 50)
	printf("fifst show^n");
	DisplayVector(chr);
	
	printf("^nDestruction^n################^n");
	DVct_Delete(chr, AMX_VECTOR);
}
	
public DisplayVector(const chr)
{
	printf("size : %d^n", DVct_GetSize(chr, AMX_VECTOR));
	
	printf("Element #0 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 0));
	printf("Element #1 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 1));
	printf("Element #2 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 2));
	printf("Element #3 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 3));
	printf("Element #4 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 4));
	printf("Element #5 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 5));
	printf("Element #6 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 6));
	printf("Element #7 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 7));
	printf("Element #8 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 8));
	printf("Element #9 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 9));
	printf("Element #10 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 10));
	printf("Element #11 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 11));
	printf("Element #12 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 12));
	
	printf("pos of 0 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 0));
	printf("pos of 1 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 1));
	printf("pos of 2 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 2));
	printf("pos of 3 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 3));
	printf("pos of 4 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 4));
	printf("pos of 5 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 5));
	printf("pos of 6 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 6));
	printf("pos of 7 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 7));
	printf("pos of 8 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 8));
	printf("pos of 9 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 9));
	printf("pos of 10 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 10));
	printf("pos of 11 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 11));
	printf("pos of 12 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 12));
}