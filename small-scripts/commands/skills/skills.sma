/*!
\defgroup script_command_skills 'skills
\ingroup script_commands

@{
*/

public cmd_setskills( const caller )
{
	readCommandParams(caller);
	
	new skill = INVALID, value = INVALID, skillValue = INVALID;
	
	if(strlen(__cmdParams[0]) || strlen(__cmdParams[1]))
		if(!isStrInt(__cmdParams[0]) || !isStrInt(__cmdParams[1]))
		{
			chr_message(caller,_,"You must give the skill and value as integers");
			return;
		}
		else
		{
			skill = str2Int(__cmdParams[0]);
			value =str2Int(__cmdParams[1]);
			skillValue = (skill << 16) + value;
		}
	
	chr_message(caller, _, "Select character.. "); 
	target_create( caller,skillValue , _, _, "target_setskills");
}

public cmd_skills(chr)
{
	skills_char( chr, chr, false );
}

public target_setskills( const target, const caller, const chr,x,y,z,unused,skillValue)
{
	if(!isChar(chr)) 
	{
		chr_message(caller,_ , "Skills work only on character" );
		return;
	}
	
	//opengump if no params are given
	if(skillValue == INVALID)
	{
		//skills_char( caller, chr, true );
		chr_message(caller,_,"Sorry, due to a little bug the 'setskills gump is not available, use 'setskills <skill> <value> instead");
		return;
	}
	
	new skill = skillValue >> 16;
	new value = skillValue & 0xFFFF;
	
	chr_setSkill(chr,skill,value);
}


public skills_char( const caller, const chr, const edit )
{
	new menu = gui_create( 50, 50, true, true, true, "handle_skills_char" );
	gui_addGump( menu, 0, 0, 0x04CC, 0 );
	
	chr_setLocalIntVar(caller,CLV_CMDTEMP,chr);	

	if(edit) gui_addButton( menu, 250, 265, 0x084A, 0x084B, 1 );

	const colorEdit = 32;

	//new str[100];

	const skForPage = 10;
	new page=1;
	new position = 38;

	for( new i=0; i<SK_COUNT; ++i ) {

		if( (i%skForPage)==0 ) {
			gui_addPage( menu, page );
			if( page>1 )
				gui_addPageButton( menu, 356,  6, 0x824, GUMP_INVALID, page-1 );
			if( page<=(SK_COUNT/skForPage))
				gui_addPageButton( menu, 350, 265, 0x825, GUMP_INVALID, page+1 );
			++page;
			position=38;
		}

		gui_addText( menu, 28, position, _, "%s : ", skillName[i] );
		
		gui_addText( menu, 220, position, _, "%d", chr_getSkill(chr,i));
		if(edit)
			gui_addInputField( menu, 260, position, 50, 30, i, TXT_COLOR,"%d",chr_getBaseSkill(chr,i));
		else gui_addText( menu, 260, position, _, "%d", chr_getBaseSkill(chr,i));
		position += 20;
	}

	gui_show( menu, caller);
}

public handle_skills_char( const menu, const caller, const button )
{
	if( button == MENU_CLOSED )
		return;

	if( button == 1 ) 
	{ //apply
		new buffer[5],chr = chr_getLocalIntVar( caller, CLV_CMDTEMP);
		
		for(new sk = 0; sk < SK_COUNT; sk++)
		{
			gui_getProperty(menu,MP_UNI_TEXT,sk,buffer);
			if(isStrInt(buffer))
				chr_setSkill(chr,sk,str2Int(buffer));
			else chr_message(chr,_,"Invalid skill value '%d'",buffer);
			
			log_message("buffer %d:'%s'^n",sk,buffer);
		}
		
		chr_teleport(chr);
	}	
}

/*! }@ */
