
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
	new menu = menu_create( 50, 50, true, true, true, "handle_skills_char" );
	menu_addGump( menu, 0, 0, 0x04CC, 0 );
//	menu_addBackground( menu, 0x0E14, 128, 128 );
	menu_setProperty( menu, MP_BUFFER, 0, PROP_CHARACTER );
	menu_setProperty( menu, MP_BUFFER, 1, chr );
	menu_setProperty( menu, MP_BUFFER, 3, 1 );
	
	menu_addButton( menu, 250, 265, 0x084A, 0x084B, 1 );
	
	
	new str[100];
	
	const skForPage = 10;
	new page=1;
	
	for( new i=0; i<SK_COUNT; ++i ) {
	
		if( (i%skForPage)==0 ) {
			menu_addPage( menu, page );
			if( page>1 )
				menu_addPageButton( menu, 356,  6, 0x824, GUMP_INVALID, page-1 );
			if( page<=(SK_COUNT/skForPage) )
				menu_addPageButton( menu, 350, 265, 0x825, GUMP_INVALID, page+1 );
			++page;
		}

		menu_addText( menu, 28, 38+(20*(i%skForPage)), _, "%s : ", skillName[ skillByName[i] ] );
		menu_addPropField( menu, 220, 38+(20*(i%skForPage)), 50, 30, CP_BASESKILL, skillByName[i], 0 );
	}
	
	menu_show( menu, getCharFromSocket(socket) );
}

public handle_skills_char( const socket, const menu, const button )
{
	if( button==MENU_CLOSED )
		return;
		
	if( button==1 ) { //apply
		chr_teleport( menu_getProperty( menu, MP_BUFFER, 1 ) );
	}
		
}

