
public target_options( const socket, const target, const item )
{
	if(socket < 0) 
		return;
		
	if( isChar(target) ) {
		options_char( socket, target );
	}
	else if( isItem( item ) ) {
		options_item( socket, item );
	}
	else nprintf( socket, "Options work only on object" );

}

public options_char( const socket, const chr )
{
	new menu = menu_create( 50, 50, true, true, true, "handle_options_char" );
	menu_addGump( menu, 0, 0, 0x04CC, 0 );
//	menu_addBackground( menu, 0x0E14, 128, 128 );
	menu_setProperty( menu, MP_BUFFER, 0, PROP_CHARACTER );
	menu_setProperty( menu, MP_BUFFER, 1, chr );
	menu_setProperty( menu, MP_BUFFER, 3, 111 );
	
	menu_addButton( menu, 250, 265, 0x084A, 0x084B, 111 );
	
	menu_addText( menu, 53, 63, _, "Name : " );
	menu_addPropField( menu, 108, 63, 125, 30, CP_STR_NAME, _, 0 );
	
	menu_addText( menu, 195, 78, _, "Serial : %d", chr );
	menu_addText( menu, 195, 93, _, "Account : %d", chr_getProperty( chr, CP_ACCOUNT ) );

	menu_addButton( menu, 53, 95, 0x08B0, 0x08B0, 1 );
	menu_addText( menu, 75, 91, _, "Stats" );
	
	menu_addButton( menu, 53, 115, 0x08B0, 0x08B0, 2 );
	menu_addText( menu, 75, 111, _, "Tweak" );
	
	menu_addButton( menu, 53, 135, 0x08B0, 0x08B0, 3 );
	menu_addText( menu, 75, 131, _, "Move character here" );
	
	menu_addButton( menu, 53, 155, 0x08B0, 0x08B0, 4 );
	menu_addText( menu, 75, 151, _, "Go to Character" );
	
	menu_addButton( menu, 53, 175, 0x08B0, 0x08B0, 5 );
	if( chr_getProperty( chr, CP_JAILED ) )
		menu_addText( menu, 75, 171, _, "Release" );
	else {
		menu_addText( menu, 75, 171, _, "Jail" );
		//here add edit for jail time
	}
	
	menu_addText( menu, 53, 195, _, "Frozen" );
	menu_addPropField( menu, 103, 195, 30, 30, CP_FROZEN, _, 0 );
	
	menu_show( menu, getCharFromSocket(socket) );
}

public handle_options_char( const socket, const menu, const button )
{
	if( button==MENU_CLOSED )
		return;
		
	new curr = getCharFromSocket( socket );
	new chr = menu_getProperty( menu, MP_BUFFER, 1 );
		
	switch( button ) {
		case 1:
			stats_char( socket, chr, 1 );
		case 2:
			tweak_char( socket, chr, 1 );
		case 3: {
			chr_moveTo( chr, chr_getProperty( curr, CP_POSITION, CP2_X ), chr_getProperty( curr, CP_POSITION, CP2_Y ), chr_getProperty( curr, CP_POSITION, CP2_Z ) );
			chr_teleport( chr );
		}
		case 4: {
			chr_moveTo( curr, chr_getProperty( chr, CP_POSITION, CP2_X ), chr_getProperty( chr, CP_POSITION, CP2_Y ), chr_getProperty( chr, CP_POSITION, CP2_Z ) );
			chr_teleport( curr );
		}
		case 5: {
			if( chr_getProperty( chr, CP_JAILED ) )
				chr_unjail( curr, chr );
			else 
				chr_jail( curr, chr, 60*60*24 ); // jailed a day for now, need to add a edit
		}
	}
}


public options_item( const socket, const item )
{
	nprintf( socket, "Options on item" );
}
