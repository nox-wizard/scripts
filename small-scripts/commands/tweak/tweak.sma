
public target_tweak( const socket, const target, const item )
{
	if(socket < 0) 
		return;
		
	if( isChar(target) ) {
		tweak_char( socket, target );
	}
	else if( isItem( item ) ) {
		tweak_item( socket, item );
	}
	else nprintf( socket, "Tweak work only on object" );

}

const TWEAK_PROP = 1;

static propName[TWEAK_PROP][] = {
"Name"
}

static propInfo[TWEAK_PROP][2] = {
{ CP_STR_NAME, INVALID }
}

tweak_char( const socket, const chr )
{
	new menu = menu_create( 50, 50, true, true, true, "handle_tweak_char" );
	menu_addGump( menu, 0, 0, 0x0898, 0 );
	menu_setProperty( menu, MP_BUFFER, 0, PROP_CHARACTER );
	menu_setProperty( menu, MP_BUFFER, 1, chr );
	
	for( new i=0; i<TWEAK_PROP; ++i ) {
		menu_addText( menu, 35, 16, _, "%s : ", propName[i] );
		menu_addPropField( menu, 8, 16, 80, 30, propInfo[i][0], propInfo[i][1], 0 );
	}
	
	menu_show( menu, getCharFromSocket(socket) );
	
}


tweak_item( const socket, const item )
{
	nprintf( socket, "Tweak on item" );
}
