/*!
\defgroup script_command_options 'options
\ingroup script_commands

@{
*/

public cmd_options( const caller )
{
	chr_message(caller, _, msg_commandsDef[7]);
	target_create( caller, _, _, _, "target_options");
}

public target_options( const chr, const target, const item )
{
	if(!isChar(chr)) 
		return;

	if( isChar(target)) {
		options_char( chr, target );
	}
	else if( isItem( item )) {
		options_item( chr, item );
	}
	else chr_message(chr,_ , msg_commandsDef[8] );

}

public options_char( const caller, const chr )
{
	new menu = gui_create( 50, 50, true, true, true, "handle_options_char" );
	gui_addGump( menu, 0, 0, 0x04CC, 0 );
//	gui_addBackground( menu, 0x0E14, 128, 128 );
	gui_setProperty( menu, MP_BUFFER, 0, PROP_CHARACTER );
	gui_setProperty( menu, MP_BUFFER, 1, chr );
	gui_setProperty( menu, MP_BUFFER, 3, 111 );

	gui_addButton( menu, 250, 265, 0x084A, 0x084B, 111 );
	const colorEdit = 32;

	gui_addText( menu, 53, 63, _, msg_commandsDef[10] );
	gui_addPropField( menu, 108, 63, 125, 30, CP_STR_NAME, _, colorEdit );

	gui_addText( menu, 195, 78, _, msg_commandsDef[11], chr );
	gui_addText( menu, 195, 93, _, msg_commandsDef[12], chr_getProperty( chr, CP_ACCOUNT ));

	gui_addButton( menu, 53, 95, 0x08B0, 0x08B0, 1 );
	gui_addText( menu, 75, 91, _, msg_commandsDef[13] );

	gui_addButton( menu, 53, 115, 0x08B0, 0x08B0, 2 );
	gui_addText( menu, 75, 111, _, msg_commandsDef[14] );

	gui_addButton( menu, 53, 135, 0x08B0, 0x08B0, 3 );
	gui_addText( menu, 75, 131, _, msg_commandsDef[15] );

	gui_addButton( menu, 53, 155, 0x08B0, 0x08B0, 4 );
	gui_addText( menu, 75, 151, _, msg_commandsDef[16] );

	gui_addButton( menu, 53, 175, 0x08B0, 0x08B0, 5 );
	if( chr_getProperty( chr, CP_JAILED ))
		gui_addText( menu, 75, 171, _, msg_commandsDef[17] );
	else {
		gui_addText( menu, 75, 171, _, msg_commandsDef[18] );
		//here add edit for jail time
	}

	gui_addText( menu, 53, 195, _, msg_commandsDef[19] );
	gui_addPropField( menu, 103, 195, 30, 30, CP_FROZEN, _, 0 );

	gui_show( menu, caller);
}

public handle_options_char( const caller, const menu, const button )
{
	if( button==MENU_CLOSED )
		return;

	new chr = gui_getProperty( menu, MP_BUFFER, 1 );

	switch( button ) {
		case 1:
			menu_stats_char( caller, chr, 1 );
		case 2:
			tweak_char( caller, chr, 1 );
		case 3: {
			chr_moveTo( chr, chr_getProperty( caller, CP_POSITION, CP2_X ), chr_getProperty( caller, CP_POSITION, CP2_Y ), chr_getProperty( caller, CP_POSITION, CP2_Z ));
			chr_teleport( chr );
		}
		case 4: {
			chr_moveTo( caller, chr_getProperty( chr, CP_POSITION, CP2_X ), chr_getProperty( chr, CP_POSITION, CP2_Y ), chr_getProperty( chr, CP_POSITION, CP2_Z ));
			chr_teleport( caller );
		}
		case 5: {
			if( chr_getProperty( chr, CP_JAILED ))
				chr_unjail( caller, chr );
			else 
				chr_jail( caller, chr, 60*60*24 ); // jailed a day for now, need to add a edit
		}
	}
}

public options_item( const caller, const item )
{
	chr_message(caller,_ , msg_commandsDef[9] );
}

/*! }@ */