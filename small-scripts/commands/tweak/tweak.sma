
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
	new menu = gui_create( 50, 50, true, true, true, "handle_tweak_char" );
	gui_addGump( menu, 0, 0, 0x0898, 0 );
	gui_setProperty( menu, MP_BUFFER, 0, PROP_CHARACTER );
	gui_setProperty( menu, MP_BUFFER, 1, chr );
	gui_setProperty( menu, MP_BUFFER, 2, page );
	gui_setProperty( menu, MP_BUFFER, 3, 1 );
	
	gui_addButton( menu, 250, 210, 0x084A, 0x084B, 1 );
	
	new isNpc = chr_getProperty( chr, CP_NPC );
	new i=0;
	
	const colorEdit = 32;
	
	switch( page ) {
	
	case 1: {
		
		gui_addText( menu, 35, 16+(20*i), _, "Account :"  );
		gui_addText( menu, 197, 16+(20*i++), _, "%d", chr_getProperty( chr, CP_ACCOUNT )  );
		
		
		//gui_addText( menu, 35, 16+(20*i), _, "All move ability : " );
		//gui_addPropField( menu, 197, 16+(20*i++), 125, 30, CP_ACCOUNT, 0, colorEdit );

		gui_addText( menu, 35, 16+(20*i), _, "Attack First :"  );
		gui_addText( menu, 197, 16+(20*i++), _, "%s", chr_getProperty( chr, CP_ATTACKFIRST )? "True" : "False"  );
		
		gui_addText( menu, 35, 16+(20*i), _, "Body [current] : " );
		gui_addPropField( menu, 197, 16+(20*i++), 125, 30, CP_SKIN, 0, colorEdit );

		gui_addText( menu, 35, 16+(20*i), _, "Body [old] :" );
		gui_addText( menu, 197, 16+(20*i++), _, "%d", chr_getProperty( chr, CP_XSKIN )  );
		
		//"Broadcast ability"
		
		gui_addText( menu, 35, 16+(20*i), _, "Command Level :" );
		gui_addPropField( menu, 197, 16+(20*i++), 125, 30, CP_COMMANDLEVEL, 0, colorEdit );
		
		gui_addText( menu, 35, 16+(20*i), _, "Deaths :" );
		gui_addPropField( menu, 197, 16+(20*i++), 125, 30, CP_DEATHS, 0, colorEdit );
		
		gui_addText( menu, 35, 16+(20*i), _, "Defence :" );
		gui_addPropField( menu, 197, 16+(20*i++), 125, 30, CP_DEF, 0, colorEdit );
		
		gui_addText( menu, 35, 16+(20*i), _, "Defence :" );
		gui_addPropField( menu, 197, 16+(20*i++), 125, 30, CP_DEXTERITY, CP2_REAL, colorEdit );
		
		gui_addText( menu, 35, 16+(20*i), _, "Direction :" );
		gui_addPropField( menu, 197, 16+(20*i++), 125, 30, CP_DIR, 0, colorEdit );
	}
	
	}
		
	gui_show( menu, getCharFromSocket(socket) );
	
}


public tweak_item( const socket, const item, const page )
{
	nprintf( socket, "Tweak on item" );
}
