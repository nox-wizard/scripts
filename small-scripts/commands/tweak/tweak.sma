
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

public tweak_char( const socket, const chr, const page )
{
	new menu = menu_create( 50, 50, true, true, true, "handle_tweak_char" );
	menu_addGump( menu, 0, 0, 0x0898, 0 );
	menu_setProperty( menu, MP_BUFFER, 0, PROP_CHARACTER );
	menu_setProperty( menu, MP_BUFFER, 1, chr );
	menu_setProperty( menu, MP_BUFFER, 2, page );
	menu_setProperty( menu, MP_BUFFER, 3, 1 );
	
	menu_addButton( menu, 250, 210, 0x084A, 0x084B, 1 );
	
	new isNpc = chr_getProperty( chr, CP_NPC );
	new i=0;
	
	const colorEdit = 32;
	
	switch( page ) {
	
	case 1: {
		
		menu_addText( menu, 35, 16+(20*i), _, "Account :"  );
		menu_addText( menu, 197, 16+(20*i++), _, "%d", chr_getProperty( chr, CP_ACCOUNT )  );
		
		
		//menu_addText( menu, 35, 16+(20*i), _, "All move ability : " );
		//menu_addPropField( menu, 197, 16+(20*i++), 125, 30, CP_ACCOUNT, 0, colorEdit );

		menu_addText( menu, 35, 16+(20*i), _, "Attack First :"  );
		menu_addText( menu, 197, 16+(20*i++), _, "%s", chr_getProperty( chr, CP_ATTACKFIRST )? "True" : "False"  );
		
		menu_addText( menu, 35, 16+(20*i), _, "Body [current] : " );
		menu_addPropField( menu, 197, 16+(20*i++), 125, 30, CP_SKIN, 0, colorEdit );

		menu_addText( menu, 35, 16+(20*i), _, "Body [old] :" );
		menu_addText( menu, 197, 16+(20*i++), _, "%d", chr_getProperty( chr, CP_XSKIN )  );
		
		//"Broadcast ability"
		
		menu_addText( menu, 35, 16+(20*i), _, "Command Level :" );
		menu_addPropField( menu, 197, 16+(20*i++), 125, 30, CP_COMMANDLEVEL, 0, colorEdit );
		
		menu_addText( menu, 35, 16+(20*i), _, "Deaths :" );
		menu_addPropField( menu, 197, 16+(20*i++), 125, 30, CP_DEATHS, 0, colorEdit );
		
		menu_addText( menu, 35, 16+(20*i), _, "Defence :" );
		menu_addPropField( menu, 197, 16+(20*i++), 125, 30, CP_DEF, 0, colorEdit );
		
		menu_addText( menu, 35, 16+(20*i), _, "Defence :" );
		menu_addPropField( menu, 197, 16+(20*i++), 125, 30, CP_DEXTERITY, CP2_REAL, colorEdit );
		
		menu_addText( menu, 35, 16+(20*i), _, "Direction :" );
		menu_addPropField( menu, 197, 16+(20*i++), 125, 30, CP_DIR, 0, colorEdit );
	}
	
	}
		
	menu_show( menu, getCharFromSocket(socket) );
	
}


public tweak_item( const socket, const item, const page )
{
	nprintf( socket, "Tweak on item" );
}
