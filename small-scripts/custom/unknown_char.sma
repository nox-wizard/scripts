/*
Flag is an 8bit number containing information about reputation status, bitfields are:
    - 0x1: red
    - 0x2: grey
    - 0x4: Blue
    - 0x8: green
    - 0x10: Orange
    
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
	
\brief Add to given set all chars of an account
\author Wintermute
\since 0.82
\param 1 the set
\param 2 the account number
\return 0
native set_addAccountChars(const set, const accountnum);
*/

new tempStr2[256]; //recent name 
new tempStr[100]; //org name 
new tempStr3[256]; //speech 

public start_unknown_char(const viewerchr) 
{ 
/*we have a problem here, we need to make sure we can identify the char later on, since it may be the char is polymorphed 
(name different) we can't call the hashmap by the charname, so we better use the tempStr and char serial as identification, 
both combined should be unique even when the char is deleted later*/ 
	chr_getProperty(viewerchr, CP_STR_ACCOUNT, _,tempStr); 
	sprintf(tempStr, "%s_%d", tempStr,viewerchr); 
	 
	//create the char name map 
	new char_unknown_map = createResourceMap( RESOURCEMAP_STRING, 1, tempStr); 
	new polycheck = chr_getProperty(viewerchr, CP_POLYMORPH); 
	 
	//link the char name map with the char 
	if(chr_isaLocalVar( viewerchr, UNKNOWN_CHAR_VAR, VAR_TYPE_ANY ) == 0 ) //0 means no var at globalVar 
	   { 
		   chr_addLocalIntVar( viewerchr, UNKNOWN_CHAR_VAR, char_unknown_map ); 
		   log_message("char %d got 'unknown char system' var %d^n", viewerchr, UNKNOWN_CHAR_VAR); 
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
		   log_message("now set char original name to: %s^n", tempStr); 
		   chr_addLocalStrVar( viewerchr, UNKNOWN_CHAR_NAME, tempStr ); 
	   } 
	    
	   //ATTENTION: we only create this local var, when we have the correct name, so if we have a polymorphed char, no local var is created! 
			  
	   //add onsingleclick event to the char 
	   chr_getEventHandler(viewerchr, 28, tempStr); 
	   trim(tempStr); 
	   if( strcmp(tempStr, "unknown_sglclick") ) //different event, that is bad, so make a log entry but change the event 
	   { 
		   if(strlen(tempStr) != 0) 
		   { 
			   log_error("ERROR! Char %d already had a different single click event when single click for UNKNOWN CHAR SYSTEM was added!^n", viewerchr); 
			   log_error("This previous event function was %s^n", tempStr); 
		   } 
		   chr_setEventHandler(viewerchr, 28, EVENTTYPE_STATIC, "unknown_sglclick"); 
		   log_message("added singleclick event^n"); 
	   } 
	   //add ondoubleclick event to the char 
	   chr_getEventHandler(viewerchr, 41, tempStr); 
	   trim(tempStr); 
	   if( strcmp(tempStr, "unknown_dblclick")) //different event, that is bad, so make a log entry but change the event 
	   { 
		   if(strlen(tempStr) != 0) 
		   { 
			   log_error("ERROR! Char %d already had a different double click event when double click for UNKNOWN CHAR SYSTEM was added!^n", viewerchr); 
			   log_error("This previous event function was %s^n", tempStr); 
		   } 
		   chr_setEventHandler(viewerchr, 41, EVENTTYPE_STATIC, "unknown_dblclick"); 
		   log_message("added doubleclick event^n"); 
	   } 
			  
	   //add onhearplayer event to the char 
	   chr_getEventHandler(viewerchr, 32, tempStr); 
	   trim(tempStr); 
	   if( strcmp(tempStr, "unknown_hearPl") ) //different event, that is bad, so make a log entry but change the event 
	   { 
		   if(strlen(tempStr) != 0) 
		   { 
			   log_error("ERROR! Char %d already had a different ONHEARPLAYER event when hear-player for UNKNOWN CHAR SYSTEM was added!^n", viewerchr); 
			   log_error("This previous event function was %s^n", tempStr); 
		   } 
		   chr_setEventHandler(viewerchr, 32, EVENTTYPE_STATIC, "unknown_hearPl"); 
		   log_message("added hearplayer event^n"); 
 
	   } 
	    
	   //add onhearplayer event to the char 
	   chr_getEventHandler(viewerchr, 35, tempStr); 
	   trim(tempStr); 
	   if( strcmp(tempStr, "unknown_speech") ) //different event, that is bad, so make a log entry but change the event 
	   { 
		   if(strlen(tempStr) != 0) 
		   { 
			   log_error("ERROR! Char %d already had a different ONSPEECH event when speech for UNKNOWN CHAR SYSTEM was added!^n", viewerchr); 
			   log_error("This previous event function was %s^n", tempStr); 
		   } 
		   chr_setEventHandler(viewerchr, 35, EVENTTYPE_STATIC, "unknown_speech"); 
		   log_message("added speech event^n"); 
 
	   } 
}


public stop_unknown_char(const viewerchr) 
{
	//delete the onsingleclick event handler so the function is not fired 
	chr_getEventHandler(viewerchr, 28, tempStr); 
	   trim(tempStr); 
	   if( !strcmp(tempStr, "unknown_sglclick")) //we have an event here that is SAME to char unknown system function so DON'T KEEP this and delete it for further use because "unknown char" is now shut off ! Otherwise we need to keep this! 
	   { 
		   chr_delEventHandler(viewerchr, 28); 
	} 
	 
	chr_getEventHandler(viewerchr, 41, tempStr); 
	   trim(tempStr); 
	   if( !strcmp(tempStr, "unknown_sglclick")) //we have an event here that is SAME to char unknown system function so DON'T KEEP this and delete it for further use because "unknown char" is now shut off ! Otherwise we need to keep this! 
	   { 
		   chr_delEventHandler(viewerchr, 41); 
	} 
	 
	chr_getEventHandler(viewerchr, 32, tempStr); 
	   trim(tempStr); 
	   if( !strcmp(tempStr, "unknown_hearPl")) //we have an event here that is SAME to char unknown system function so DON'T KEEP this and delete it for further use because "unknown char" is now shut off ! Otherwise we need to keep this! 
	   { 
		   chr_delEventHandler(viewerchr, 32); 
	} 
	 
	chr_getEventHandler(viewerchr, 35, tempStr); 
	   trim(tempStr); 
	   if( !strcmp(tempStr, "unknown_speech")) //we have an event here that is SAME to char unknown system function so DON'T KEEP this and delete it for further use because "unknown char" is now shut off ! Otherwise we need to keep this! 
	   { 
		   chr_delEventHandler(viewerchr, 35); 
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

public unknown_speech(const speaker) 
{
	log_message("^n enter unknown-speech, speaker is: %d^n", speaker);
} 

public unknown_hearPl(const listener, const speaker) 
{	
	bypass(); 
	log_message("enter unknown-hear, speaker: %d, listener: %d^n", speaker, listener); 
	//if(chr_isNpc(speaker)) 
	//	return; 

	chr_getProperty(speaker, CP_UNI_SPEECH_CURRENT,_,tempStr3); 
 
	chr_getProperty(listener, CP_STR_NAME, _,tempStr); 
	new charmap = chr_getLocalIntVar( listener, UNKNOWN_CHAR_VAR); 
	new polycheck = chr_getProperty(listener, CP_POLYMORPH); 
	   //emergency: what happens if we don't have the originals char name for checking because the char was polymorphed at login? Well, only chance is we try to get every single/double-click its real name again ... 
	   if( (polycheck != 1) && (chr_isaLocalVar( listener, UNKNOWN_CHAR_NAME, VAR_TYPE_STRING ) == 0) && (strcmp(tempStr, msg_chrUnknownDef[0])) ) //char is not polymorph, chars name is not "unknown" and string var does not exist -> create it 
	   { 
		   log_message("now set char original name to: %s^n", tempStr); 
		   chr_addLocalStrVar( listener, UNKNOWN_CHAR_NAME, tempStr ); 
	   } 
	 
	if(chr_isaLocalVar( speaker, UNKNOWN_CHAR_NAME, VAR_TYPE_STRING ) == 1 ) //1 means there is a var at globalVar 
	{ 
		chr_getLocalStrVar( speaker, UNKNOWN_CHAR_NAME, tempStr); //now replace recent char name in tempStr with real name speaker char, if we have this one 
	} 
		 
	new status = getResourceStringValue(charmap, tempStr); 
	 
	//if ((chr_isNpc(speaker)) || (listener == speaker) || (chr_isGMorCns(listener)) || (chr_isGMorCns(speaker))) 
	if (listener == speaker) 
	{ 
		status=1; 
		log_message("listener is: %d, speaker is: %d, status: %d^n^n", listener, speaker, status); 
		return; 
	}	 
	else	 bypass(); 
	log_message("listener is: %d, speaker is: %d, status: %d^n^n", listener, speaker, status); 
 
	if( status == -1) //set name temporary 
	{ 
		sprintf(tempStr2, "%s:",msg_chrUnknownDef[0]); 
	} 
	else 
	{ 
		sprintf(tempStr2, "%s:",tempStr); 
	} 
	chr_setProperty(speaker,CP_STR_NAME,0,tempStr2); //set the char name temporary to the appropriate one 
	chr_speech(speaker, listener, SPEECH_NORMAL, 1310, 1, tempStr3); // we let the char say its wished name over his head, his name for the server at this moment is "You see:" for the paperdoll to show the line: "You see: (name)" 
	chr_setProperty(speaker,CP_STR_NAME,0,tempStr); //set the char name back to origin 
}
 


public unknown_sglclick(const clicked, const viewer) 
{
	log_message("enter sglclick pre bypass");
	bypass(); 
	chr_getProperty(viewer, CP_STR_NAME, _,tempStr); 
	new charmap = chr_getLocalIntVar( viewer, UNKNOWN_CHAR_VAR); 
	new polycheck = chr_getProperty(viewer, CP_POLYMORPH); 
	 
	   //emergency: what happens if we don't have the originals char name for checking because the char was polymorphed at login? Well, only chance is we try to get every single/double-click its real name again ... 
	   if( (polycheck != 1) && (chr_isaLocalVar( viewer, UNKNOWN_CHAR_NAME, VAR_TYPE_STRING ) == 0) && (strcmp(tempStr, msg_chrUnknownDef[0])) ) //char is not polymorph, chars name is not "unknown" and string var does not exist -> create it 
	   { 
		   log_message("now set char original name to: %s^n", tempStr); 
		   chr_addLocalStrVar( viewer, UNKNOWN_CHAR_NAME, tempStr ); 
	   } 
	 
	if(chr_isaLocalVar( clicked, UNKNOWN_CHAR_NAME, VAR_TYPE_STRING ) == 1 ) //1 means there is a var at globalVar 
	{ 
		chr_getLocalStrVar( clicked, UNKNOWN_CHAR_NAME, tempStr); //now replace recent char name in tempStr with real name clicked char, if we have this one 
	} 
		 
	new status = getResourceStringValue(charmap, tempStr); 
 
	//if ((chr_isNpc(clicked)) || (viewer == clicked) || (chr_isGMorCns(viewer)) || (chr_isGMorCns(clicked))) 
	if (viewer == clicked) 
		status=1; 
	 
	log_message("Enter single click, viewer is: %d, clicked is: %d, status: %d^n^n", viewer, clicked, status);
	
	if( status == -1 ) 
	{ 
		sprintf(tempStr3, "%s",msg_chrUnknownDef[0]); //set the string to say to unknown 
	} 
	else
	{ 
		sprintf(tempStr3, "%s",tempStr); 		
	}
	log_message("vor name setzen^n");
	chr_setProperty(clicked,CP_STR_NAME,_,"you see:"); //set the char name temporary to "you see" 
	log_message("^n single click after name setting");
	
	chr_speech(clicked, viewer, SPEECH_NORMAL, 1310, 1, tempStr3); // we let the char say its wished name over his head, his name for the server at this moment is "You see:" for the paperdoll to show the line: "You see: (name)" 
	chr_setProperty(clicked,CP_STR_NAME,0,tempStr); //set the char name to origin 
}

public unknown_dblclick(const clicked, const viewer) 
{ 
	bypass();  
	chr_getProperty(viewer, CP_STR_NAME, _,tempStr); 
	new charmap = chr_getLocalIntVar( viewer, UNKNOWN_CHAR_VAR); 
	new polycheck = chr_getProperty(viewer, CP_POLYMORPH); 
	 
	   //emergency: what happens if we don't have the originals char name for checking because the char was polymorphed at login? Well, only chance is we try to get every single/double-click its real name again ... 
	   if( (polycheck != 1) && (chr_isaLocalVar( viewer, UNKNOWN_CHAR_NAME, VAR_TYPE_STRING ) == 0) && (strcmp(tempStr, msg_chrUnknownDef[0])) ) //char is not polymorph, chars name is not "unknown" and string var does not exist -> create it 
	   { 
		   printf("now set char original name to: %s^n", tempStr); 
		   chr_addLocalStrVar( viewer, UNKNOWN_CHAR_NAME, tempStr ); 
	   } 
	 
	if(chr_isaLocalVar( clicked, UNKNOWN_CHAR_NAME, VAR_TYPE_STRING ) == 1 ) //1 means there is a var at globalVar 
	{ 
		chr_getLocalStrVar( clicked, UNKNOWN_CHAR_NAME, tempStr); //now replace recent char name in tempStr with real name clicked char, if we have this one 
	} 
		 
	new status = getResourceStringValue(charmap, tempStr); 
 
	//if ((chr_isNpc(clicked)) || (viewer == clicked) || (chr_isGMorCns(viewer)) || (chr_isGMorCns(clicked))) 
	if (viewer == clicked) 
		status=1; 
	 
	printf("double click, viewer is: %d, clicked is: %d, status: %d^n^n", viewer, clicked, status); 
	if( status == -1) 
		chr_setProperty(clicked,CP_STR_NAME,0,msg_chrUnknownDef[0]); 
	else 
		chr_setProperty(clicked,CP_STR_NAME,0,tempStr); 
	chr_showPaperdoll(viewer, clicked); 
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
	new charmap = chr_getLocalIntVar( clicked, UNKNOWN_CHAR_VAR); 
	chr_getProperty(viewer, CP_STR_NAME, _,tempStr); //here we better use the RECENT name of the introducing char to prevent name check exploit 
	new status = getResourceStringValue(charmap, tempStr); 
	//log_message("%s status towards target is: %d", tempStr, status); 
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