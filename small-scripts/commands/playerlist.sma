/*!
\defgroup script_command_playerlist 'playerlist
\ingroup script_commands

@{
*/

const chrForPage = 14;
public cmd_playerlist( const caller )
{
	new set=set_create();

	set_addAllOnlinePl( set );

	new count=set_size(set);
	if( count==1 ) {
		chr_message(caller,_ , msg_commandsDef[0] );
		set_delete(set);
		return;
	}

	new menu = gui_create( 50, 50, true, true, true, "handle_playerlist" );

	//add background gump
	gui_addGump( menu, 0, 0, 0x0027, 0 );

	//Users online: ##
	gui_addText( menu, 20, 4, _, msg_commandsDef[1] );
	gui_addText( menu, 150, 4, _, "%d", count );

	//create player list
	new page=1;
	new i=0;
	for( set_rewind(set); !set_end(set); ++i ) 
	{
		new chr=set_getChar(set);

		//add a page every chrForPage chars
		if( (i % chrForPage)==0 ) 
		{
			gui_addPage( menu, page );
	
			//add page buttons (up and down arrows)
			if( page > 1 )	gui_addPageButton( menu, 205,   6, 0x824, GUMP_INVALID, page-1 );
			if( page <= (count/chrForPage))gui_addPageButton( menu, 202, 265, 0x825, GUMP_INVALID, page+1 );
			++page;
		}

		//add a line like:
		//	o  name
		//for every charater
		gui_addButton( menu, 32, 39+(i%chrForPage)*15, 0x4B9, 0x4BA, chr );
		new str[100];
		chr_getProperty( chr, CP_STR_NAME, 0, str );
		gui_addText( menu, 52, 35+(i%chrForPage)*15, _, str );

	}

	set_delete(set);
	gui_show( menu, caller);
}

public handle_playerlist( const menu, const caller, const button )
{
	//on button press open character's options
	if( button == MENU_CLOSED )	return;
		tweak_char(caller,button, 1);
}

/*! }@ */