#if defined skillsmenu_included
	#endinput
#endif
#define skillsmenu_included

static character;
static buttonGumps[5] =
{
	0x00FA, //lock
	0x00FC, //down
	0x082C, //up
	0x04B9, //use - up
	0x04BA  //use - down
}
/*!
\defgroup script_command_skills_menu menu
\ingroup script_commands_skills

@{
*/
/*!
\author Fax
\fn menu_skills_char( const caller, const chr, const edit )
\param caller: the character who willbe showed the menu
\param chr:the character whose skills are shown
\param edit: true if the menu is editable
\since 0.82
\brief builds the skills menu

If "edit" is true the menu will allow to change the base skill value
\return nothing
*/
public menu_skills_char( const caller, const chr, const edit )
{
	character = chr;
	new callback[] = "menu_skills_editable_row";
	if(!edit) sprintf(callback,"menu_skills_row");
	
	new title[50];
	chr_getProperty(chr,CP_STR_NAME,0,title);
	sprintf(title,"%s's skills",title);
	cursor_setProperty(CRP_TAB,40);
	cursor_setProperty(CRP_INTERLINE,11);
	
	new width = edit ? 35 : 30;
	createListMenu(40,40,SK_COUNT/3,width,SK_COUNT,title,callback,"handle_skills_char");
	
	if(edit)
	{ 
		cursor_right(width/2 - 3);
		menu_addApplyButton(-1);
	}
	else 
	{
		new text[20];
		sprintf(text,"Total: %d",chr_getSkillSum(chr));
		cursor_right(width/2 - strlen(text)/2);
		menu_addTitle(text);
	}
	menu_storeValue(0,chr);
	menu_storeValue(1,edit);
	menu_show(caller);
}

public menu_skills_row(page,line,col,i)
{
	//add blue button if skill is directly usable
	if(skill_isDirectlyUsable(i))
			menu_addButton(10001 + i,buttonGumps[3],buttonGumps[4]);
	
	cursor_right(2);
	
	new text[100];
	sprintf(text,"%s:",skillName[i]);
	menu_addText(text);
	cursor_right(18);
	
	sprintf(text,"%d",chr_getSkill(character,i));
	menu_addText(text);
	cursor_right(7);
	
	//draw lock status arrows
	new status = chr_getProperty(character,CP_LOCKSKILL,i);
	new gump = buttonGumps[status];
	menu_addButton(((status + 1)%3)*1000 + i + 1,gump,gump);
	cursor_back();
}

public menu_skills_editable_row(page,line,col,i)
{
	new text[100];
	
	sprintf(text,"%s:",skillName[i]);
	menu_addText(text);
	cursor_right(18);
	
	sprintf(text,"%d",chr_getSkill(character,i));
	menu_addText(text);
	cursor_right(7);
	
	sprintf(text,"%d",chr_getBaseSkill(character,i));
	menu_addInputField(i,text,6);
	
	cursor_right(7);
	
	//draw lock status arrows
	new status = chr_getProperty(character,CP_LOCKSKILL,i);
	new gump = buttonGumps[status];
	menu_addButton(((status + 1)%3)*1000 + i + 1,gump,gump);
	cursor_back();
}

public handle_skills_char( const menu, const caller, button )
{
	if( button == MENU_CLOSED )
		return;
	
	new chr = menu_readValue(menu,0);
	new edit = menu_readValue(menu,1);
	
	if( button == -1 ) 
	{ //apply
		new buffer[5];
		
		for(new sk = 0; sk < SK_COUNT; sk++)
		{
			//to be removed as soon as bug is fixed
			for(new i = 0; i < 5; i++)
				buffer[i] = 0;
				
			gui_getProperty(menu,MP_UNI_TEXT,sk,buffer);
			if(isStrInt(buffer))
				chr_setSkill(chr,sk,str2Int(buffer));
			else chr_message(caller,_,msg_commandsDef[33],buffer);
		}
		
		chr_teleport(chr);
		return;
	}
	
	button--;
	
	//skill lock button pressed
	if(0 <= button <= 9999)
	{
		new status = button/1000;
		new skill = button%1000;
		
		chr_setProperty(chr,CP_LOCKSKILL,skill,status);
		menu_skills_char(caller,chr,edit);
		return;
	}
	
	//direct skill use button pressed (blue button)
	if(button >= 10000)
	{
		new skill = button - 10000;
		__nxw_sk_main(chr,skill);
	}
}

/*! }@ */