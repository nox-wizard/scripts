#if defined statsmenu_included
	#endinput
#endif
#define statsmenu_included
/*!
\defgroup script_command_stats_menu menu
\ingroup script_commands_stats

@{
*/
public menu_stats_char( const caller, const chr, const edit )
{
	new menu = gui_create( 50, 50, true, true, true, "handle_stats_char" );
	gui_addGump( menu, 0, 0, 0x04CC, 0 );
	
	chr_setLocalIntVar(caller,CLV_CMDTEMP,chr);	

	if(edit) gui_addButton( menu, 250, 265, 0x084A, 0x084B, 1 );

	new position = 38;
	gui_addText( menu, 28, position, _, "Strength :");
	if(edit)
		gui_addInputField( menu, 220, position, 50, 30, 0, TXT_COLOR,"%d",chr_getStr(chr));
	else gui_addText( menu, 220, position, _, "%d", chr_getStr(chr));
	
	position += 20;
	gui_addText( menu, 28, position, _, "Dexterity :");
	if(edit)
		gui_addInputField( menu, 220, position, 50, 30, 1, TXT_COLOR,"%d",chr_getDex(chr));
	else gui_addText( menu, 220, position, _, "%d", chr_getDex(chr));
	
	position += 20;
	gui_addText( menu, 28, position, _, "Intelligence :");
	if(edit)
		gui_addInputField( menu, 220, position, 50, 30, 2, TXT_COLOR,"%d",chr_getInt(chr));
	else gui_addText( menu, 220, position, _, "%d", chr_getInt(chr));
	
	gui_show( menu, caller);
}

public handle_stats_char( const menu, const caller, const button )
{
	if( button == MENU_CLOSED )
		return;

	new buffer[5],chr = chr_getLocalIntVar( caller, CLV_CMDTEMP);
	
	gui_getProperty(menu,MP_UNI_TEXT,0,buffer);
	if(isStrInt(buffer))
		chr_setProperty(chr,CP_STRENGTH,CP2_REAL,str2Int(buffer));
	else chr_message(chr,_,"Invalid strength value '%d'",buffer);
	
	gui_getProperty(menu,MP_UNI_TEXT,1,buffer);
	if(isStrInt(buffer))
		chr_setProperty(chr,CP_DEXTERITY,CP2_REAL,str2Int(buffer));
	else chr_message(chr,_,"Invalid dexterity value '%d'",buffer);
	
	gui_getProperty(menu,MP_UNI_TEXT,2,buffer);
	if(isStrInt(buffer))
		chr_setProperty(chr,CP_INTELLIGENCE,CP2_REAL,str2Int(buffer));
	else chr_message(chr,_,"Invalid intelligence value '%d'",buffer);
		
	chr_teleport(chr);	
}
/*! }@ */