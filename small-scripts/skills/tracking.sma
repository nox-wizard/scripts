const seconds = 25;

static typeQuestion[3][] = {
	"Which animal do you wish to track?",
	"Which creature do you wish to track?",
	"Whom do you wish to track?"
};

static where[8][] = {
"North", 
"Northeast",
"East", 
"Southeast", 
"South", 
"Southwest", 
"West", 
"Northwest"
};

public __nxw_sk_tracking( const chr )
{
	new menu = gui_createIconList( "handle_tracking", "What do you wish to track?"  );

	gui_addIcon( menu, 0x20D4, _, _, "Animals" );
	gui_addIcon( menu, 0x20E9, _, _, "Creatures" );
	gui_addIcon( menu, 0x2106, _, _, "Players" );
	
	gui_show( menu, chr );
}


public handle_tracking( const oldtrackMenu, const chr, const button, const model, const color, const data )
{
	if( button==0 )
		return;

	if ( !chr_checkSkill(chr, SK_TRACKING, 0, 1000, 1) ) {
		chr_message( chr, _, "You cannot see any signs" ); 
		return;
	}
	
	new range = VISRANGE;
	new set = set_create();
		
	new id1, id2;
	new icon;
	
	switch( button ) {
		case 1: { //Animals
			set_addNpcsNearObj( set, chr, range );
			id1=62; // default tracking animals
			id2=399;
		}
		case 2: { //Creatures
			set_addNpcsNearObj( set, chr, range );
			id1=1;
			id2=61;
		}
		case 3: { //Players
			set_addNpcsNearObj( set, chr, range );
			set_addOnPlNearObj( set, chr, true, range );
			id1=BODY_MALE;
			id2=BODY_FEMALE;
		}
	}
	
	new trackMenu=INVALID;
	

	new seeName = ( chr_getProperty( chr, CP_SKILL, SK_TRACKING ) >= 800 );

	for( set_rewind(set); !set_end( set ); ) {
		new c=set_getChar( set );
		if( c!=INVALID && !chr_getProperty( c, CP_DEAD ) ) {
			
			new str[100]
			chr_getProperty( c, CP_STR_NAME, _, str );
						
			new id = chr_getProperty( c, CP_ID );
			if( (id>=id1) && (id<=id2) ) {
			
				if( trackMenu==INVALID )
					trackMenu = gui_createIconList( "handle_track_choose", typeQuestion[button-1] );

				new whereIdx = chr_getDirForSee( chr, chr_getProperty( c, CP_POSITION, CP2_X ), chr_getProperty( c, CP_POSITION, CP2_Y ) );
				printf("c: %d", c);
				icon = chr_getProperty( c, CP_ICON );
				if( icon==INVALID ) //icon not exist
					icon=0x20D1;			
				
				if( seeName ) {
					new name[100];
					chr_getProperty( c, CP_STR_NAME, _, name );
					gui_addIcon( trackMenu, icon, _, c, "%s to the %s", name, where[ whereIdx ]  );
				}
				else {
					if(id == BODY_MALE)
						gui_addIcon( trackMenu, icon, _, c, "a man to the %s", where[ whereIdx ] );
					else if( id == BODY_FEMALE )
						gui_addIcon( trackMenu, icon, _, c, "a woman to the %s", where[ whereIdx ] );
					else
						gui_addIcon( trackMenu, icon, _, c, "a creature to the %s", where[ whereIdx ] );
				}
			}
		}
	}
	
	set_delete( set );
	if ( trackMenu != INVALID )
		gui_show( trackMenu, chr );
	else {
		switch( button )
		{
			case 1:
				chr_message( chr, _, "You see no signs of any animals." );
			case 2:
				chr_message( chr, _, "You see no signs of any creatures." );
			case 3:
				chr_message( chr, _, "You see no signs of anyone." );
		}
	}
}

public handle_track_choose( const trackMenu, const chr, const button, const model, const color, const data )
{
	if( button==0 )
		return;
	
	new x=chr_getProperty( data, CP_POSITION, CP2_X );
	new y=chr_getProperty( data, CP_POSITION, CP2_Y );
	
	send_questArrow( chr, true, x, y );
	
	tempfx_activate(_, chr, chr, ((x<<16)+y), seconds, funcidx("removeTracking") ); 
	
}
 
public removeTracking(const chr, const dummy1, const data, const mode )
{  
	if (mode!=TFXM_END) 
		return;
		
	send_questArrow( chr, false, data>>16, data&0xFFFF );
	
}

