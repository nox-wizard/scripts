
public target_skills( const socket, const target, const item )
{
	if(socket < 0) 
		return;
		
	if( isChar(target) ) {
		skills_char( socket, target );
	}
	else nprintf( socket, "Skills work only on character" );

}




public skills_char( const socket, const chr )
{
	nprintf( socket, "ciao" );
	new menu = gui_create( 50, 50, true, true, true, "handle_skills_char" );
	gui_addGump( menu, 0, 0, 0x04CC, 0 );
//	gui_addBackground( menu, 0x0E14, 128, 128 );
	gui_setProperty( menu, MP_BUFFER, 0, PROP_CHARACTER );
	gui_setProperty( menu, MP_BUFFER, 1, chr );
	gui_setProperty( menu, MP_BUFFER, 3, 1 );
	
	gui_addButton( menu, 250, 265, 0x084A, 0x084B, 1 );
	
	const colorEdit = 32;
	
	new str[100];
	
	const skForPage = 10;
	new page=1;
	new position = 38;
	
	for( new i=0; i<SK_COUNT; ++i ) {
	
		if( (i%skForPage)==0 ) {
			gui_addPage( menu, page );
			if( page>1 )
				gui_addPageButton( menu, 356,  6, 0x824, GUMP_INVALID, page-1 );
			if( page<=(SK_COUNT/skForPage) )
				gui_addPageButton( menu, 350, 265, 0x825, GUMP_INVALID, page+1 );
			++page;
			position=38;
		}

		gui_addText( menu, 28, position, _, "%s : ", skillName[ skillByName[i] ] );
		gui_addPropField( menu, 220, position, 50, 30, CP_SKILL, skillByName[i], colorEdit );
		
		position+=20;
	}
	
	gui_show( menu, getCharFromSocket(socket) );
}

public handle_skills_char( const socket, const menu, const button )
{
	if( button==MENU_CLOSED )
		return;
		
	if( button==1 ) { //apply
		chr_teleport( gui_getProperty( menu, MP_BUFFER, 1 ) );
	}
		
}


