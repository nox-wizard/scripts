
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

options_char( const socket, const chr )
{
	new menu = menu_create( 50, 50, true, true, true, "handle_options_char" );
//	menu_addGump( menu, 0, 0, 0x04CC, 0 );
	menu_addBackground( menu, 0x0E14, 128, 128 );
	
	new str[100];
	
	chr_getProperty( chr, CP_STR_NAME, 0, str );
	menu_addText( menu, 53, 63, _, "Name : %s", str );
	
	menu_addText( menu, 195, 78, _, "Serial : %d", chr );
	menu_addText( menu, 195, 93, _, "Account : %d", chr_getProperty( chr, CP_ACCOUNT ) );

	menu_addButton( menu, 53, 95, 0x08B0, 0x08B0, 1 );
	menu_addText( menu, 75, 91, _, "Stats" );
	
	menu_addButton( menu, 53, 115, 0x08B0, 0x08B0, 2 );
	menu_addText( menu, 75, 111, _, "Tweak" );
	
	menu_addButton( menu, 53, 135, 0x08B0, 0x08B0, 3 );
	menu_addText( menu, 75, 131, _, "Go to Character" );
	
	menu_addButton( menu, 53, 155, 0x08B0, 0x08B0, 4 );
	menu_addText( menu, 75, 151, _, "Move character here" );
	
	menu_addButton( menu, 53, 175, 0x08B0, 0x08B0, 5 );
//need to add CP_JAILED to character constant
//	if( chr_getProperty( chr, CP_JAILED ) )
		menu_addText( menu, 75, 171, _, "Jail or Release" );
//	else
//		menu_addText( menu, 75, 171, _, "Release" );
	
	menu_show( menu, getCharFromSocket(socket) );
}


options_item( const socket, const item )
{
	nprintf( socket, "Options on item" );
}

