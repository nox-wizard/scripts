
public target_stats( const socket, const target, const item )
{
	if(socket < 0) 
		return;
		
	if( isChar(target) ) {
		stats_char( socket, target, 1 );
	}
	else if( isItem( item ) ) {
		stats_item( socket, item, 1 );
	}
	else nprintf( socket, "stats work only on object" );

}

public stats_char( const socket, const chr, const page )
{
	new menu = menu_create( 50, 50, true, true, true, "handle_stats_char" );
	menu_addGump( menu, 0, 0, 0x08AC, 0 );
	menu_setProperty( menu, MP_BUFFER, 0, PROP_CHARACTER );
	menu_setProperty( menu, MP_BUFFER, 1, chr );
	menu_setProperty( menu, MP_BUFFER, 2, page );
	menu_setProperty( menu, MP_BUFFER, 3, 1 );
	
	menu_addButton( menu, 300, 185, 0x084A, 0x084B, 1 );

	new i=0;
	
	switch( page) {
	
	case 1: {
	
	menu_addText( menu, 58, 10+(20*i), _, "Account : " );
	menu_addText( menu, 228, 10+(20*i++), _, "%d", chr_getProperty( chr, CP_ACCOUNT ) );

	menu_addText( menu, 58, 10+(20*i), _, "Name : " );
	menu_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_STR_NAME, _, 0 );

	menu_addText( menu, 58, 10+(20*i), _, "Title : " );
	menu_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_STR_TITLE, _, 0 );

	menu_addText( menu, 58, 10+(20*i), _, "Dexterity : " );
	menu_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_DEXTERITY, CP2_REAL, 0 );

	menu_addText( menu, 58, 10+(20*i), _, "Strength : " );
	menu_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_STRENGHT, CP2_REAL, 0 );

	menu_addText( menu, 58, 10+(20*i), _, "Intelligence : " );
	menu_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_INTELLIGENCE, CP2_REAL, 0 );

	menu_addText( menu, 58, 10+(20*i), _, "Location : " );
	menu_addPropField( menu, 228, 10+(20*i), 35, 30, CP_POSITION, CP2_X, 0 );
	menu_addPropField( menu, 258, 10+(20*i), 35, 30, CP_POSITION, CP2_Y, 0 );
	menu_addPropField( menu, 298, 10+(20*i++), 35, 30, CP_POSITION, CP2_Z, 0 );

	menu_addText( menu, 58, 10+(20*i), _, "Fame : " );
	menu_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_FAME, _, 0 );

	menu_addText( menu, 58, 10+(20*i), _, "Karma : " );
	menu_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_KARMA, _, 0 );
	
	menu_addButton( menu, 321, 8, 0x089E, GUMP_INVALID, 10+2 );

	}

	case 2: {

	menu_addButton( menu, 50, 8, 0x089D, GUMP_INVALID, 10+1 );

	menu_addText( menu, 58, 20+(20*i), _, "Direction : " );
	menu_addPropField( menu, 228, 20+(20*i++), 125, 30, CP_DIR, _, 0 );

	menu_addText( menu, 58, 20+(20*i), _, "Weight : " );
	menu_addPropField( menu, 228, 20+(20*i++), 125, 30, CP_WEIGHT, _, 0 );

//	menu_addText( menu, 58, 10+(20*i), _, "Frozen : " );
//	menu_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_STR_NAME, _, 0 );

//	menu_addText( menu, 58, 10+(20*i), _, "Criminal : " );
//	menu_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_CRIMINAL, _, 0 );

//	menu_addText( menu, 58, 10+(20*i), _, "Guild Title : " );
//	menu_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_STR_NAME, _, 0 );

//	menu_addText( menu, 58, 10+(20*i), _, "Invulnerable : " );
//	menu_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_STR_NAME, _, 0 );

//stat gain today se si puo' farlo andare sarebbe ottimo 
//	menu_addText( menu, 58, 10+(20*i), _, "Name : " );
//	menu_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_STR_NAME, _, 0 );

//skills
//	menu_addText( menu, 58, 10+(20*i), _, "Name : " );
//	menu_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_STR_NAME, _, 0 );
	

	}
	
	}
	
	menu_show( menu, getCharFromSocket(socket) );
	
}

public handle_stats_char( const socket, const menu, const button )
{
	if( button==MENU_CLOSED )
		return;
		
	new chr = menu_getProperty( menu, MP_BUFFER, 1 );
		
	if( button>10 ) { //page button
		stats_char( socket, chr, button-10 );
	}
	else { //apply button, so resend current page
		stats_char( socket, chr, menu_getProperty( menu, MP_BUFFER, 2 ) );
	}
	
}

public stats_item( const socket, const item, const page )
{
	nprintf( socket, "stats on item" );
}

