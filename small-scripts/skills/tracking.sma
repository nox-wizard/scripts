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

/*
\author Luxor
\brief Tell which icon has to be put in the tracking menu
*/
static getTrackIconById( const id )
{
	new icon;
	switch( id )
	{
		case 0x1:	icon = 8415;
		case 0x2:	icon = 8480;
		case 0x3:	icon = 8428;
		case 0x4:	icon = 8409;
		case 0x5:	icon = 8434;
		case 0x6:	icon = 8430;
		case 0x7:	icon = 8416;
		case 0x8:	icon = 8402;
		case 0x9,
		0xA:		icon = 8403;
		case 0xC:	icon = 8406;
		case 0xD:	icon = 8429;
		case 0xE:	icon = 8407;
		case 0xF:	icon = 8435;
		case 0x10:	icon = 8459;
		case 0x11:	icon = 8416;
		case 0x12:	icon = 8408;
		case 0x15:	icon = 8446;
		case 0x16:	icon = 8426;
		case 0x18:	icon = 8440;
		case 0x1A:	icon = 8457;
		case 0x1C:	icon = 8445;
		case 0x1D:	icon = 8437;
		case 0x1F:	icon = 8458;
		case 0x21,
		0x23,
		0x24,
		0x25,
		0x26:		icon = 8414;
		case 0x27:	icon = 8441;
		case 0x29:	icon = 8416;
		case 0x2A,
		0x2C,
		0x2D:		icon = 8419;
		case 0x2F:	icon = 8442;
		case 0x30:	icon = 8420;
		case 0x32:	icon = 8423;
		case 0x33:	icon = 8424;
		case 0x34:	icon = 8444;
		case 0x35,
		0x36,
		0x37:		icon = 8425;
		case 0x38,
		0x39:		icon = 8423;
		case 0x3A:	icon = 8448;
		case 0x3B,
		0x3C,
		0x3D:		icon = 8406;
		case 0x96:	icon = 8446;
		case 0x97:	icon = 8433;
		case 0xC8:	icon = 8479;
		case 0xC9:	icon = 8475;
		case 0xCA:	icon = 8410;
		case 0xCB:	icon = 8449;
		case 0xCC:	icon = 8481;
		case 0xCD:	icon = 8485;
		case 0xCF:	icon = 8427;
		case 0xD0:	icon = 8401;
		case 0xD1:	icon = 8422;
		case 0xD3:	icon = 8399;
		case 0xD4:	icon = 8411;
		case 0xD5:	icon = 8417;
		case 0xD6:	icon = 8473;
		case 0xD7:	icon = 8400;
		case 0xD8:	icon = 8432;
		case 0xD9:	icon = 8405;
		case 0xDC:	icon = 8438;
		case 0xDD:	icon = 8447;
		case 0xDF:	icon = 8422;
		case 0xE1:	icon = 8426;
		case 0xE2:	icon = 8484;
		case 0xE4:	icon = 8480;
		case 0xE7:	icon = 8432;
		case 0xE8:	icon = 8431;
		case 0xE9:	icon = 8451;
		case 0xEA:	icon = 8404;
		case 0xED:	icon = 8404;
		case 0xEE:	icon = 8483;
		case 0x122:	icon = 8449;
		case 0x123:	icon = 8487;
		case 0x124:	icon = 8487;
		case 0x600:	icon = 8473;
		case 0x190:	icon = 8454;
		case 0x191:	icon = 8455;
		default:	icon = 0;
	}
	return icon;
}

public __nxw_sk_tracking( const socket )
{
	new menu = menu_createIconList( "handle_tracking", "What do you wish to track?"  );

	menu_addIcon( menu, 0x20D4, _, _, "Animals" );
	menu_addIcon( menu, 0x20E9, _, _, "Creatures" );
	menu_addIcon( menu, 0x2106, _, _, "Players" );
	
	menu_show( menu, getCharFromSocket( socket ) );
}


public handle_tracking( const socket, const oldmenu, const button, const model, const color, const data )
{
	if( !isValidSocket( socket ) )
		return;
	
	if( button==MENU_CLOSED )
		return;
		
	new chr=getCharFromSocket( socket );
	new range = VISRANGE * 2;
	new set = set_create();
		
	new id1, id2;
	new icon;
	
	switch( button ) {
		case 1: { //Animals
			set_addNpcsNearObj( set, chr, range );
			id1=62; // default tracking animals
			id2=399;
			icon=8404;
		}
		case 2: { //Creatures
			set_addNpcsNearObj( set, chr, range );
			id1=1;
			id2=61;
			icon=0x20d1;
		}
		case 3: { //Players
			set_addNpcsNearObj( set, chr, range );
			set_addOnPlNearObj( set, chr, true, range );
			id1=BODY_MALE;
			id2=BODY_FEMALE;
			icon=8454;
		}
	}
	
	new menu=INVALID;
	

	new seeName = ( chr_getProperty( chr, CP_SKILL, SK_TRACKING ) >= 800 );

	for( set_rewind(set); !set_end( set ); ) {
		new c=set_getChar( set );
		if( c!=INVALID && !chr_getProperty( c, CP_DEAD ) ) {
			
			new str[100]
			chr_getProperty( c, CP_STR_NAME, _, str );
						
			new id = chr_getProperty( c, CP_ID );
			if( (id>=id1) && (id<=id2) ) {
			
				if( menu==INVALID )
					menu = menu_createIconList( "handle_track_choose", typeQuestion[button-1] );

				new whereIdx = chr_getDirForSee( chr, chr_getProperty( c, CP_POSITION, CP2_X ), chr_getProperty( c, CP_POSITION, CP2_Y ) );
				
				icon = getTrackIconById( id );
				if( seeName ) {
					new name[100];
					chr_getProperty( c, CP_STR_NAME, _, name );
					menu_addIcon( menu, icon, _, c, "%s to the %s", name, where[ whereIdx ]  );
				}
				else {
					if(id == BODY_MALE)
						menu_addIcon( menu, icon, _, c, "a man to the %s", where[ whereIdx ] );
					else if( id == BODY_FEMALE )
						menu_addIcon( menu, icon, _, c, "a woman to the %s", where[ whereIdx ] );
					else
						menu_addIcon( menu, icon, _, c, "a creature to the %s", where[ whereIdx ] );
				}
			}
		}
	}
	
	set_delete( set );
	if ( menu != INVALID )
		menu_show( menu, chr );
	else {
		switch( button )
		{
			case 1:
				ntprintf( socket, "You see no signs of any animals." );
			case 2:
				ntprintf( socket, "You see no signs of any creatures." );
			case 3:
				ntprintf( socket, "You see no signs of anyone." );
		}
	}
}

public handle_track_choose( const socket, const menu, const button, const model, const color, const data )
{
	if( button==MENU_CLOSED )
		return;
	
	new x=chr_getProperty( data, CP_POSITION, CP2_X );
	new y=chr_getProperty( data, CP_POSITION, CP2_Y );
	
	new chr = getCharFromSocket( socket );
	send_questArrow( chr, true, x, y );
	
	new seconds=25;
	
	tempfx_activate(_, chr, chr, ((x<<16)+y), seconds, funcidx("removeTracking") ); 
	
}
 
public removeTracking(const chr, const dummy1, const data, const mode )
{  
	if (mode!=TFXM_END) 
		return;
		
	send_questArrow( getCharFromSocket(chr), false, data>>16, data&0xFFFF );
	
}

