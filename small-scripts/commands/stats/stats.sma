
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
	new menu = gui_create( 50, 50, true, true, true, "handle_stats_char" );
	gui_addGump( menu, 0, 0, 0x08AC, 0 );
	gui_setProperty( menu, MP_BUFFER, 0, PROP_CHARACTER );
	gui_setProperty( menu, MP_BUFFER, 1, chr );
	gui_setProperty( menu, MP_BUFFER, 2, page );
	gui_setProperty( menu, MP_BUFFER, 3, 1 );
	
	gui_addButton( menu, 300, 185, 0x084A, 0x084B, 1 );

	const colorEdit = 32;
	new i=0;
	
	switch( page) {
	
	case 1: {
	
	gui_addText( menu, 58, 10+(20*i), _, "Account : " );
	gui_addText( menu, 228, 10+(20*i++), _, "%d", chr_getProperty( chr, CP_ACCOUNT ) );

	gui_addText( menu, 58, 10+(20*i), _, "Name : " );
	gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_STR_NAME, _, colorEdit );

	gui_addText( menu, 58, 10+(20*i), _, "Title : " );
	gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_STR_TITLE, _, colorEdit );

	gui_addText( menu, 58, 10+(20*i), _, "Dexterity : " );
	gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_DEXTERITY, CP2_REAL, colorEdit );

	gui_addText( menu, 58, 10+(20*i), _, "Strength : " );
	gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_STRENGHT, CP2_REAL, colorEdit );

	gui_addText( menu, 58, 10+(20*i), _, "Intelligence : " );
	gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_INTELLIGENCE, CP2_REAL, colorEdit );

	gui_addText( menu, 58, 10+(20*i), _, "Location : " );
	gui_addPropField( menu, 228, 10+(20*i), 35, 30, CP_POSITION, CP2_X, colorEdit );
	gui_addPropField( menu, 258, 10+(20*i), 35, 30, CP_POSITION, CP2_Y, colorEdit );
	gui_addPropField( menu, 298, 10+(20*i++), 35, 30, CP_POSITION, CP2_Z, colorEdit );

	gui_addText( menu, 58, 10+(20*i), _, "Fame : " );
	gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_FAME, _, colorEdit );

	gui_addText( menu, 58, 10+(20*i), _, "Karma : " );
	gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_KARMA, _, colorEdit );
	
	gui_addButton( menu, 321, 8, 0x089E, GUMP_INVALID, 10+2 );

	}

	case 2: {

	gui_addButton( menu, 50, 8, 0x089D, GUMP_INVALID, 10+1 );

	gui_addText( menu, 58, 20+(20*i), _, "Direction : " );
	gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_DIR, _, colorEdit );

	gui_addText( menu, 58, 20+(20*i), _, "Weight : " );
	gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_WEIGHT, _, colorEdit );

	gui_addText( menu, 58, 20+(20*i), _, "Body : " );
	gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_ID, _, colorEdit );

	gui_addText( menu, 58, 20+(20*i), _, "Criminal : " );
	gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_CRIMINALFLAG , _, colorEdit );

	gui_addText( menu, 58, 20+(20*i), _, "Guild Title : " );
	gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_GUILDNUMBER , _, colorEdit );

//	gui_addText( menu, 58, 10+(20*i), _, "Invulnerable : " );
//	gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_STR_NAME, _, colorEdit );

//stat gain today se si puo' farlo andare sarebbe ottimo 
//	gui_addText( menu, 58, 10+(20*i), _, "Name : " );
//	gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_STR_NAME, _, colorEdit );

//skills
//	gui_addText( menu, 58, 10+(20*i), _, "Name : " );
//	gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_STR_NAME, _, colorEdit );
	

	}
	
	}
	
	gui_show( menu, getCharFromSocket(socket) );
	
}

public handle_stats_char( const socket, const menu, const button )
{
	if( button==MENU_CLOSED )
		return;
		
	new chr = gui_getProperty( menu, MP_BUFFER, 1 );
		
	if( button>10 ) { //page button
		stats_char( socket, chr, button-10 );
	}
	else { //apply button, so resend current page
		chr_teleport( chr );
		stats_char( socket, chr, gui_getProperty( menu, MP_BUFFER, 2 ) );
	}
	
}

public handle_stats_item( const socket, const menu, const button )
{
	if( button==MENU_CLOSED )
		return;
		
	new chr = gui_getProperty( menu, MP_BUFFER, 1 );
		
	if( button>10 ) { //page button
		stats_item( socket, chr, button-10 );
	}
	else { //apply button, so resend current page
		chr_teleport( chr );
		stats_item( socket, chr, gui_getProperty( menu, MP_BUFFER, 2 ) );
	}
	
}

public stats_item( const socket, const item, const page )
{
	new menu = gui_create( 50, 50, true, true, true, "handle_stats_item" );
	gui_addGump( menu, 0, 0, 0x08AC, 0 );
	gui_setProperty( menu, MP_BUFFER, 0, PROP_ITEM );
	gui_setProperty( menu, MP_BUFFER, 1, item );
	gui_setProperty( menu, MP_BUFFER, 3, page );
	gui_setProperty( menu, MP_BUFFER, 3, 1 );
	
	gui_addButton( menu, 300, 185, 0x084A, 0x084B, 1 );

	const colorEdit = 32;
	new i=0;
	
	switch( page) {
	
		case 1: {
		
			gui_addText( menu, 58, 10+(20*i), _, "Name : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_STR_NAME, _, colorEdit );
		
			gui_addText( menu, 58, 10+(20*i), _, "Damage Min : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_LODAMAGE , _, colorEdit );
		
			gui_addText( menu, 58, 10+(20*i), _, "Damage Max : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_HIDAMAGE, _, colorEdit );
		
			gui_addText( menu, 58, 10+(20*i), _, "Hitpoints : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_HP , _, colorEdit );
		
			gui_addText( menu, 58, 10+(20*i), _, "Hitpoints Max : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_MAXHP , _, colorEdit );
		
			gui_addText( menu, 58, 10+(20*i), _, "Color : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_COLOR , _, colorEdit );
		
			gui_addText( menu, 58, 10+(20*i), _, "Armor Bonus : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_DEF, _, colorEdit );
			
			gui_addText( menu, 58, 10+(20*i), _, "Frozen : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_MAGIC, _, colorEdit );
			
			gui_addText( menu, 58, 10+(20*i), _, "Speed : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_SPEED, _, colorEdit );
			
			gui_addButton( menu, 321, 8, 0x089E, GUMP_INVALID, 10+2 );
	
		}
	
		case 2: {
	
			gui_addButton( menu, 50, 8, 0x089D, GUMP_INVALID, 10+1 );
			gui_addButton( menu, 321, 8, 0x089E, GUMP_INVALID, 10+3 );
		
			gui_addText( menu, 58, 20+(20*i), _, "Pileable : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_PILEABLE , _, colorEdit );
		
			gui_addText( menu, 58, 20+(20*i), _, "ID : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_ID, _, colorEdit );
		
			gui_addText( menu, 58, 20+(20*i), _, "Item Hand : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_ITEMHAND, _, colorEdit );
		
			gui_addText( menu, 58, 20+(20*i), _, "Str Required : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_STRREQUIRED  , _, colorEdit );
		
			gui_addText( menu, 58, 20+(20*i), _, "Dex Required : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_DEXREQUIRED  , _, colorEdit );
		
			gui_addText( menu, 58, 20+(20*i), _, "Int Required : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_INTREQUIRED , _, colorEdit );
		
			gui_addText( menu, 58, 20+(20*i), _, "Bonus Str : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_STRBONUS, _, colorEdit );
		
			gui_addText( menu, 58, 20+(20*i), _, "Bonus Dex : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_DEXBONUS, _, colorEdit );
			
			gui_addText( menu, 58, 20+(20*i), _, "Bonus Int : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_INTBONUS, _, colorEdit );
	
		}
		
		case 3: {
	
			gui_addButton( menu, 50, 8, 0x089D, GUMP_INVALID, 10+2 );
		
			gui_addText( menu, 58, 20+(20*i), _, "Dyeable : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_DYE , _, colorEdit );
		
			gui_addText( menu, 58, 20+(20*i), _, "Poisoned : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_POISONED , _, colorEdit );
		
			gui_addText( menu, 58, 20+(20*i), _, "Script Item ID : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_SCRIPTID , _, colorEdit );
		
			gui_addText( menu, 58, 20+(20*i), _, "Visible : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_VISIBLE   , _, colorEdit );
		
			gui_addText( menu, 58, 20+(20*i), _, "Layer : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_LAYER   , _, colorEdit );
		
			gui_addText( menu, 58, 20+(20*i), _, "Decay Time : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_DECAYTIME  , _, colorEdit );
		
			gui_addText( menu, 58, 20+(20*i), _, "Direction : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_DIR, _, colorEdit );
		
			gui_addText( menu, 58, 20+(20*i), _, "Value : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_VALUE, _, colorEdit );
			
		}
	
	}
	
	gui_show( menu, getCharFromSocket(socket) );
}

