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
	
	//link the char name map with the char
	if(chr_isaLocalVar( viewerchr, UNKNOWN_CHAR_VAR, VAR_TYPE_ANY ) == 0 ) //0 means no var at globalVar
        {
        	chr_addLocalIntVar( viewerchr, UNKNOWN_CHAR_VAR, char_unknown_map );
        	printf("char %d got 'unknown char system' var %d^n", viewerchr, UNKNOWN_CHAR_VAR);
        }
        if((chr_isaLocalVar( viewerchr, UNKNOWN_CHAR_VAR, VAR_TYPE_STRING ) == 1)) //there already is a string variable (shouldn't happen)
        {
        	chr_delLocalVar( viewerchr, UNKNOWN_CHAR_VAR, VAR_TYPE_STRING);
        	chr_addLocalIntVar( viewerchr, UNKNOWN_CHAR_VAR, char_unknown_map );
        }
        
        //char name - we have a problem here, what about polymorphed chars and the changed name?
        chr_getProperty(viewerchr, CP_STR_NAME, _,tempStr);
        if(chr_isaLocalVar( viewerchr, UNKNOWN_CHAR_NAME, VAR_TYPE_ANY ) == 0 ) //0 means no var at globalVar
        {
        	chr_addLocalStrVar( viewerchr, UNKNOWN_CHAR_NAME, tempStr );
        	printf("char %d got 'unknown char system' var %d^n", viewerchr, UNKNOWN_CHAR_NAME);
        }
        if((chr_isaLocalVar( viewerchr, UNKNOWN_CHAR_NAME, VAR_TYPE_INTEGER ) == 1)) //there already is a string variable (shouldn't happen)
        {
        	chr_delLocalVar( viewerchr, UNKNOWN_CHAR_NAME, VAR_TYPE_INTEGER);
        	chr_addLocalStrVar( viewerchr, UNKNOWN_CHAR_NAME, tempStr );
        }
        if( chr_getProperty(viewerchr, CP_POLYMORPH) != 1) //lets hope this is enough so we store the real name of the char in the localVar
        {
        	chr_setLocalStrVar( viewerchr, UNKNOWN_CHAR_NAME, tempStr);
        }
        
        //add onsingleclick event to the char
        chr_getEventHandler(viewerchr, 28, tempStr);
        trim(tempStr);
        if( strcmp(tempStr, "chr_unknown_singleclick")) //different event, that is bad, so make a log entry but change the event
        {
        	chr_setEventHandler(viewerchr, 28, EVENTTYPE_STATIC, "chr_unknown_singleclick");
        	log_error("ERROR! Char %d already had a different single click event when single click for UNKNOWN CHAR SYSTEM was added! This previous event function was %s^n", viewerchr, tempStr);
        }
}

public stop_unknown_char(const viewerchr)
{
	new tempStr[100];
	
	//delete the onsingleclick event handler so the function is not fired
	chr_getEventHandler(viewerchr, 28, tempStr);
        trim(tempStr);
        if( !strcmp(tempStr, "chr_unknown_singleclick")) //we have an event here that is SAME to char unknown system function so DON'T KEEP this and delete it for further use because "unknown char" is now shut off ! Otherwise we need to keep this!
        {
        	chr_delEventHandler(viewerchr, 28);
	}
	
	//delete the localVar to save space
	if(chr_isaLocalVar( viewerchr, UNKNOWN_CHAR_VAR, VAR_TYPE_ANY ) == 1 ) //1 means there is a var at globalVar
	{
		chr_delLocalVar( viewerchr, UNKNOWN_CHAR_VAR, VAR_TYPE_ANY);
	}
}

public chr_unknown_singleclick(const clicked, const viewer)
{
	bypass();
	new tempStr[100];
	new charmap = chr_getLocalIntVar( viewer, UNKNOWN_CHAR_VAR);
	chr_getLocalStrVar( clicked, UNKNOWN_CHAR_NAME, tempStr); //real name clicked char
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
		status=1;
	if( status == 1)
		chr_speech(clicked,viewer,_,flag,0,tempStr);
	else
		chr_speech(clicked,viewer,_,flag,0,msg_chrUnknownDef[0]);
}

public chr_unknown_dblclick(const clicked, const viewer)
{
	new tempStr[100];
	new charmap = chr_getLocalIntVar( viewer, UNKNOWN_CHAR_VAR);
	chr_getLocalStrVar( clicked, UNKNOWN_CHAR_NAME, tempStr); //real name clicked char
	new status = getResourceStringValue(charmap, tempStr);
	chr_getLocalStrVar( viewer, UNKNOWN_CHAR_NAME, tempStr); //real Charname
	
	if ((chr_isNpc(clicked)) || (viewer == clicked) || (chr_isGMorCns(viewer)) || (chr_isGMorCns(clicked)))
		status=1;
	if( status == 0)
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
public introduce_name_targ(target, viewerchr, clicked, x, y, z, unused, param)
{
	new tempStr[100];
	new charmap = chr_getLocalIntVar( viewerchr, UNKNOWN_CHAR_VAR);
	chr_getProperty(clicked, CP_STR_NAME, _,tempStr); //here we better use the RECENT name of the targeted char to prevent name check exploit
	new status = getResourceStringValue(charmap, tempStr);
	if( status == 0)
	{
		chr_getProperty(viewerchr, CP_STR_NAME, _, tempStr); //here we better use the RECENT name of the targeted char to prevent name check exploit
		setResourceStringValue(charmap, 1, tempStr );
		chr_message(clicked,viewerchr,msg_chrUnknownDef[2],tempStr);
	}
	else
	{
		chr_message(viewerchr,_,msg_chrUnknownDef[3],tempStr);
	}
}

public delete_char()
{
	printf("bla");
}