/*
Flag is an 8bit number containing information about reputation status, bitfields are:
    - 0x1: red
    - 0x2: grey
    - 0x4: Blue
    - 0x8: green
    - 0x10: Orange
    

\brief Add to given set all chars of an account
\author Wintermute
\since 0.82
\param 1 the set
\param 2 the account number
\return 0
native set_addAccountChars(const set, const accountnum);
*/

public start_unknown_char(const viewerchr)
{
/*we have a problem here, we need to make sure we can identify the char later on, since it may be the char is polymorphed
(name different) we can't call the hashmap by the charname, so we better use the tempStr and char serial as identification,
both combined should be unique even when the char is deleted later*/
	new tempStr[100];
	chr_getProperty(viewerchr, CP_STR_ACCOUNT, _,tempStr);
	sprintf(tempStr, "%s_%d", tempStr,viewerchr);
	
	//create the char name map
	new char_unknown_map = createResourceMap( RESOURCEMAP_STRING, 1, tempStr);
	new polycheck = chr_getProperty(viewerchr, CP_POLYMORPH);
	
	//link the char name map with the char
	if(chr_isaLocalVar( viewerchr, UNKNOWN_CHAR_VAR, VAR_TYPE_ANY ) == 0 ) //0 means no var at globalVar
        {
        	chr_addLocalIntVar( viewerchr, UNKNOWN_CHAR_VAR, char_unknown_map );
        	//printf("char %d got 'unknown char system' var %d^n", viewerchr, UNKNOWN_CHAR_VAR);
        }
        if((chr_isaLocalVar( viewerchr, UNKNOWN_CHAR_VAR, VAR_TYPE_STRING ) == 1)) //there already is a string variable (shouldn't happen)
        {
        	chr_delLocalVar( viewerchr, UNKNOWN_CHAR_VAR, VAR_TYPE_STRING);
        	chr_addLocalIntVar( viewerchr, UNKNOWN_CHAR_VAR, char_unknown_map );
        }
        
        //char name - we have a problem here, what about polymorphed chars and the changed name?
        chr_getProperty(viewerchr, CP_STR_NAME, _,tempStr);
        if((chr_isaLocalVar( viewerchr, UNKNOWN_CHAR_NAME, VAR_TYPE_INTEGER ) == 1)) //there already is a integer variable (shouldn't happen)
        {
        	chr_delLocalVar( viewerchr, UNKNOWN_CHAR_NAME, VAR_TYPE_INTEGER);
        }
        else if( (polycheck != 1) && (chr_isaLocalVar( viewerchr, UNKNOWN_CHAR_NAME, VAR_TYPE_STRING ) == 0) && (strcmp(tempStr, msg_chrUnknownDef[0])) ) //char is not polymorph, chars name is not "unknown" and string var does not exist -> create it
        {
        	printf("now set char original name to: %s^n", tempStr);
        	chr_addLocalStrVar( viewerchr, UNKNOWN_CHAR_NAME, tempStr );
        }
        
        //ATTENTION: we only create this local var, when we have the correct name, so if we have a polymorphed char, no local var is created!
                
        //add onsingleclick event to the char
        chr_getEventHandler(viewerchr, 28, tempStr);
        trim(tempStr);
        if( strcmp(tempStr, "unknown_sglclick") && (strlen(tempStr) != 0)) //different event, that is bad, so make a log entry but change the event
        {
        	chr_setEventHandler(viewerchr, 28, EVENTTYPE_STATIC, "unknown_sglclick");
        	log_error("ERROR! Char %d already had a different single click event when single click for UNKNOWN CHAR SYSTEM was added!^n", viewerchr);
        	log_error("This previous event function was %s^n", tempStr);
        }
        //add ondoubleclick event to the char
        chr_getEventHandler(viewerchr, 41, tempStr);
        trim(tempStr);
        if( (strcmp(tempStr, "unknown_dblclick")) && (strlen(tempStr) != 0)) //different event, that is bad, so make a log entry but change the event
        {
        	chr_setEventHandler(viewerchr, 41, EVENTTYPE_STATIC, "unknown_dblclick");
       		log_error("ERROR! Char %d already had a different double click event when double click for UNKNOWN CHAR SYSTEM was added!^n", viewerchr);
        	log_error("This previous event function was %s^n", tempStr);
        }
                
        //add onhearplayer event to the char
        chr_getEventHandler(viewerchr, 32, tempStr);
        trim(tempStr);
        if( strcmp(tempStr, "unknown_hearPl") && (strlen(tempStr) != 0)) //different event, that is bad, so make a log entry but change the event
        {
        	chr_setEventHandler(viewerchr, 32, EVENTTYPE_STATIC, "unknown_hearPl");
       		log_error("ERROR! Char %d already had a different ONHEARPLAYER event when hear-player for UNKNOWN CHAR SYSTEM was added!^n", viewerchr);
        	log_error("This previous event function was %s^n", tempStr);
        }
}

public stop_unknown_char(const viewerchr)
{
	new tempStr[100];
	
	//delete the onsingleclick event handler so the function is not fired
	chr_getEventHandler(viewerchr, 28, tempStr);
        trim(tempStr);
        if( !strcmp(tempStr, "unknown_sglclick")) //we have an event here that is SAME to char unknown system function so DON'T KEEP this and delete it for further use because "unknown char" is now shut off ! Otherwise we need to keep this!
        {
        	chr_delEventHandler(viewerchr, 28);
	}
	
	chr_getEventHandler(viewerchr, 41, tempStr);
        trim(tempStr);
        if( !strcmp(tempStr, "unknown_dblclick")) //we have an event here that is SAME to char unknown system function so DON'T KEEP this and delete it for further use because "unknown char" is now shut off ! Otherwise we need to keep this!
        {
        	chr_delEventHandler(viewerchr, 41);
	}
	
	chr_getEventHandler(viewerchr, 32, tempStr);
        trim(tempStr);
        if( !strcmp(tempStr, "unknown_hearPl")) //we have an event here that is SAME to char unknown system function so DON'T KEEP this and delete it for further use because "unknown char" is now shut off ! Otherwise we need to keep this!
        {
        	chr_delEventHandler(viewerchr, 32);
	}
	
	//delete the localVars to save space
	if(chr_isaLocalVar( viewerchr, UNKNOWN_CHAR_VAR, VAR_TYPE_INTEGER ) == 1 ) //1 means there is a var at globalVar
	{
		chr_delLocalVar( viewerchr, UNKNOWN_CHAR_VAR, VAR_TYPE_INTEGER);
	}
	if(chr_isaLocalVar( viewerchr, UNKNOWN_CHAR_NAME, VAR_TYPE_STRING ) == 1 ) //1 means there is a var at globalVar
	{
		chr_delLocalVar( viewerchr, UNKNOWN_CHAR_NAME, VAR_TYPE_STRING);
	}
}

public unknown_hearPl(const listener, const speaker)
{
	new tempStr[100];
	chr_getProperty(listener, CP_STR_ACCOUNT, _,tempStr);
	new charmap = chr_getLocalIntVar( listener, UNKNOWN_CHAR_VAR);
	new polycheck = chr_getProperty(listener, CP_POLYMORPH);
	
        //emergency: what happens if we don't have the originals char name for checking because the char was polymorphed at login? Well, only chance is we try to get every single/double-click its real name again ...
        if( (polycheck != 1) && (chr_isaLocalVar( listener, UNKNOWN_CHAR_NAME, VAR_TYPE_STRING ) == 0) && (strcmp(tempStr, msg_chrUnknownDef[0])) ) //char is not polymorph, chars name is not "unknown" and string var does not exist -> create it
        {
        	printf("now set char original name to: %s^n", tempStr);
        	chr_addLocalStrVar( listener, UNKNOWN_CHAR_NAME, tempStr );
        }
	
	/* npc-starter-function for testing system offline
	if(chr_isNpc(speaker))
	{
		//char name - we have a problem here, what about polymorphed chars and the changed name?
		chr_getProperty(speaker, CP_STR_NAME, _,tempStr);
		if(chr_isaLocalVar( speaker, UNKNOWN_CHAR_NAME, VAR_TYPE_ANY ) == 0 ) //0 means no var at globalVar
		{
			chr_addLocalStrVar( speaker, UNKNOWN_CHAR_NAME, tempStr );
			printf("char %d got 'unknown char system' var %d^n", speaker, UNKNOWN_CHAR_NAME);
		}
		if((chr_isaLocalVar( speaker, UNKNOWN_CHAR_NAME, VAR_TYPE_INTEGER ) == 1)) //there already is a integer variable (shouldn't happen)
		{
			chr_delLocalVar( speaker, UNKNOWN_CHAR_NAME, VAR_TYPE_INTEGER);
			chr_addLocalStrVar( speaker, UNKNOWN_CHAR_NAME, tempStr );
		}
	}*/
	if(chr_isaLocalVar( speaker, UNKNOWN_CHAR_NAME, VAR_TYPE_STRING ) == 1 ) //1 means there is a var at globalVar
	{
		chr_getLocalStrVar( speaker, UNKNOWN_CHAR_NAME, tempStr); //now replace recent char name in tempStr with real name speaker char, if we have this one
	}
		
	new status = getResourceStringValue(charmap, tempStr);
	new flag = chr_getRelation(listener, speaker);
	switch(flag)
	{
		case 1: flag = 1205;
		case 2: flag = 2305;
		case 4: flag = 2124;
		case 8: flag = 1354;
		case 10: flag = 2084;
		default: log_error("unknown char relation between Char1 %d and Char2 %d^n", listener, speaker);
	}
	if ((chr_isNpc(speaker)) || (listener == speaker) || (chr_isGMorCns(listener)) || (chr_isGMorCns(speaker)))
	//if ((listener == speaker) || (chr_isGMorCns(speaker)))
		status=1;
	//printf("char listener is: %d and status towards %s is: %d^n", listener, tempStr, status);
			
	if( status == -1)
		chr_setProperty(speaker,CP_STR_NAME,0,msg_chrUnknownDef[0]);
	else
		chr_setProperty(speaker,CP_STR_NAME,0,tempStr);
}

public unknown_sglclick(const clicked, const viewer)
{
	new tempStr[100];
	chr_getProperty(viewer, CP_STR_ACCOUNT, _,tempStr);
	new charmap = chr_getLocalIntVar( viewer, UNKNOWN_CHAR_VAR);
	new polycheck = chr_getProperty(viewer, CP_POLYMORPH);
	
        //emergency: what happens if we don't have the originals char name for checking because the char was polymorphed at login? Well, only chance is we try to get every single/double-click its real name again ...
        if( (polycheck != 1) && (chr_isaLocalVar( viewer, UNKNOWN_CHAR_NAME, VAR_TYPE_STRING ) == 0) && (strcmp(tempStr, msg_chrUnknownDef[0])) ) //char is not polymorph, chars name is not "unknown" and string var does not exist -> create it
        {
        	printf("now set char original name to: %s^n", tempStr);
        	chr_addLocalStrVar( viewer, UNKNOWN_CHAR_NAME, tempStr );
        }
	
	/* npc-starter-function for testing system offline
	if(chr_isNpc(clicked))
	{
		//char name - we have a problem here, what about polymorphed chars and the changed name?
		chr_getProperty(clicked, CP_STR_NAME, _,tempStr);
		if(chr_isaLocalVar( clicked, UNKNOWN_CHAR_NAME, VAR_TYPE_ANY ) == 0 ) //0 means no var at globalVar
		{
			chr_addLocalStrVar( clicked, UNKNOWN_CHAR_NAME, tempStr );
			printf("char %d got 'unknown char system' var %d^n", clicked, UNKNOWN_CHAR_NAME);
		}
		if((chr_isaLocalVar( clicked, UNKNOWN_CHAR_NAME, VAR_TYPE_INTEGER ) == 1)) //there already is a integer variable (shouldn't happen)
		{
			chr_delLocalVar( clicked, UNKNOWN_CHAR_NAME, VAR_TYPE_INTEGER);
			chr_addLocalStrVar( clicked, UNKNOWN_CHAR_NAME, tempStr );
		}
	}*/
	if(chr_isaLocalVar( clicked, UNKNOWN_CHAR_NAME, VAR_TYPE_STRING ) == 1 ) //1 means there is a var at globalVar
	{
		chr_getLocalStrVar( clicked, UNKNOWN_CHAR_NAME, tempStr); //now replace recent char name in tempStr with real name clicked char, if we have this one
	}
		
	new status = getResourceStringValue(charmap, tempStr);
	new flag = chr_getRelation(viewer, clicked);
	switch(flag)
	{
		case 1: flag = 1205;
		case 2: flag = 2305;
		case 4: flag = 2124;
		case 8: flag = 1354;
		case 10: flag = 2084;
		default: log_error("unknown char relation between Char1 %d and Char2 %d^n", viewer, clicked);
	}
	if ((chr_isNpc(clicked)) || (viewer == clicked) || (chr_isGMorCns(viewer)) || (chr_isGMorCns(clicked)))
	//if ((viewer == clicked) || (chr_isGMorCns(clicked)))
		status=1;
	//printf("char viewer is: %d and status towards %s is: %d^n", viewer, tempStr, status);
			
	if( status == -1)
		chr_setProperty(clicked,CP_STR_NAME,0,msg_chrUnknownDef[0]);
	else
		chr_setProperty(clicked,CP_STR_NAME,0,tempStr);
}

public unknown_dblclick(const clicked, const viewer)
{

	new tempStr[100];
	chr_getProperty(viewer, CP_STR_ACCOUNT, _,tempStr);
	new charmap = chr_getLocalIntVar( viewer, UNKNOWN_CHAR_VAR);
	new polycheck = chr_getProperty(viewer, CP_POLYMORPH);
	
        //emergency: what happens if we don't have the originals char name for checking because the char was polymorphed at login? Well, only chance is we try to get every single/double-click its real name again ...
        if( (polycheck != 1) && (chr_isaLocalVar( viewer, UNKNOWN_CHAR_NAME, VAR_TYPE_STRING ) == 0) && (strcmp(tempStr, msg_chrUnknownDef[0])) ) //char is not polymorph, chars name is not "unknown" and string var does not exist -> create it
        {
        	//printf("now set char original name to: %s^n", tempStr);
        	chr_addLocalStrVar( viewer, UNKNOWN_CHAR_NAME, tempStr );
        }
	
	/* npc-starter-function for testing system offline
	if(chr_isNpc(clicked))
	{
		//char name - we have a problem here, what about polymorphed chars and the changed name?
		chr_getProperty(clicked, CP_STR_NAME, _,tempStr);
		if(chr_isaLocalVar( clicked, UNKNOWN_CHAR_NAME, VAR_TYPE_ANY ) == 0 ) //0 means no var at globalVar
		{
			chr_addLocalStrVar( clicked, UNKNOWN_CHAR_NAME, tempStr );
			printf("char %d got 'unknown char system' var %d^n", clicked, UNKNOWN_CHAR_NAME);
		}
		if((chr_isaLocalVar( clicked, UNKNOWN_CHAR_NAME, VAR_TYPE_INTEGER ) == 1)) //there already is a integer variable (shouldn't happen)
		{
			chr_delLocalVar( clicked, UNKNOWN_CHAR_NAME, VAR_TYPE_INTEGER);
			chr_addLocalStrVar( clicked, UNKNOWN_CHAR_NAME, tempStr );
		}
	}*/
	if(chr_isaLocalVar( clicked, UNKNOWN_CHAR_NAME, VAR_TYPE_STRING ) == 1 ) //1 means there is a var at globalVar
	{
		chr_getLocalStrVar( clicked, UNKNOWN_CHAR_NAME, tempStr); //now replace recent char name in tempStr with real name clicked char, if we have this one
	}
		
	new status = getResourceStringValue(charmap, tempStr);
	new flag = chr_getRelation(viewer, clicked);
	switch(flag)
	{
		case 1: flag = 1205;
		case 2: flag = 2305;
		case 4: flag = 2124;
		case 8: flag = 1354;
		case 10: flag = 2084;
		default: log_error("unknown char relation between Char1 %d and Char2 %d^n", viewer, clicked);
	}
	if ((chr_isNpc(clicked)) || (viewer == clicked) || (chr_isGMorCns(viewer)) || (chr_isGMorCns(clicked)))
	//if ((viewer == clicked) || (chr_isGMorCns(clicked)))
		status=1;
	//printf("char viewer is: %d and status towards %s is: %d^n", viewer, tempStr, status);
			
	if( status == -1)
		chr_setProperty(clicked,CP_STR_NAME,0,msg_chrUnknownDef[0]);
	else
		chr_setProperty(clicked,CP_STR_NAME,0,tempStr);
}

public chr_introduce_name(const viewer)
{
	chr_message(viewer,_,msg_chrUnknownDef[2]);
	target_create(viewer,_,_,_,"introduce_name_targ");
}

//carefull here, if the person is under incognito or in polymorph the naming system needs to treat him accordingly, so don't use the localVar with the "real" name here
public introduce_name_targ(target, viewer, clicked, x, y, z, unused, param)
{
	new tempStr[100];
	new charmap = chr_getLocalIntVar( clicked, UNKNOWN_CHAR_VAR);
	chr_getProperty(viewer, CP_STR_NAME, _,tempStr); //here we better use the RECENT name of the introducing char to prevent name check exploit
	new status = getResourceStringValue(charmap, tempStr);
	//printf("%s status towards target is: %d", tempStr, status);
	if( status == -1)
	{
		setResourceStringValue(charmap, 1, tempStr ); //store introducing at targets map
		chr_message(viewer,clicked,msg_chrUnknownDef[2],tempStr);
	}
	else
	{
		chr_message(viewer,_,msg_chrUnknownDef[3], tempStr);
	}
}

public delete_char()
{
	printf("bla");
}