
public target_tweak( const socket, const target, const item )
{
	if(socket < 0) 
		return;
		
	if( isChar(target) ) {
		tweak_char( socket, target, 1 );
	}
	else if( isItem( item ) ) {
		tweak_item( socket, item, 1 );
	}
	else nprintf( socket, "Tweak work only on object" );

}

const TWEAK_CHAR_PROP = 2;

static propCharName[TWEAK_CHAR_PROP][] = {
"Serial",
"Name"
}

static propCharInfo[TWEAK_CHAR_PROP][2] = {
{ CP_SERIAL, 0 },
{ CP_STR_NAME, 0 }
}

public tweak_char( const socket, const chr, const page )
{
	new menu = menu_create( 50, 50, true, true, true, "handle_tweak_char" );
	menu_addGump( menu, 0, 0, 0x0898, 0 );
	menu_setProperty( menu, MP_BUFFER, 0, PROP_CHARACTER );
	menu_setProperty( menu, MP_BUFFER, 1, chr );
	
	for( new i=0; i<TWEAK_CHAR_PROP; ++i ) {
		menu_addText( menu, 35, 16+(20*i), _, "%s : ", propCharName[i] );
		menu_addPropField( menu, 197, 16+(20*i), 125, 30, propCharInfo[i][0], propCharInfo[i][1], 0 );
	}
	
	menu_show( menu, getCharFromSocket(socket) );
	
}


public tweak_item( const socket, const item, const page )
{
	nprintf( socket, "Tweak on item" );
}
