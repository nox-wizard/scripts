
public race_enlistDialog1( const socket, const race )
{

	if( socket<0 ) 
		return;
		
	new chr = getCharFromSocket( socket );
	
	new menu = menu_create( 30, 30, true, false, false, "handle_race_enlist1" );

	menu_addBackground( menu, 5120, 320,  340 );
	menu_addGump( menu, 20, 80, 1418 );
	
	if( race_getGlobalProp( RP_WITH_WEB_INTERFACE ) )
	{
		menu_addTilePic( menu, 286, 8, 3811 );
		menu_addButtonFn( menu, 294, 30, 1209, 1210, race, _, "race_webInterface" )
	}

	menu_addText( menu, 73,   8,  152,  "N" );
	menu_addText( menu, 85,   8,   95,  "oxwizard" );
	menu_addText( menu, 151,   8,  152,  "R" );
	menu_addText( menu, 163,   8,   95,  "ace" );
	menu_addText( menu, 189,   8,  152,  "S" );
	menu_addText( menu, 201,   8,   95,  "ystem" );

	menu_addText( menu, 13,  42, 1153,  "D" );
	menu_addText( menu, 25,  42,   95,  "ear player the Noxwizard Race System" );
	menu_addText( menu, 13,  58,   95,  "has been activated on this shard." );

	menu_addText( menu, 13,  88, 1153, "A" );
	menu_addText( menu, 25,  88,   95, "s you do not belong to a race yet....." );
	menu_addText( menu, 13, 106,   95, "you must choose one now!" );

	new offset = 0;
	if( race_getProperty( race, RP_TELEPORT_ON_ENLIST ) )
	{
		menu_addText( menu, 13, 136, 1153, "Y" );
		menu_addText( menu, 25, 136,   95, "ou have been transported to a safe location" );
		menu_addText( menu, 13, 154,   95, "and will be returned after you've made your" );
		menu_addText( menu, 13, 172,   95, "choice." );

		offset=60;
	}

	menu_addButton( menu, 13, 139 +offset, 1209, 1210, 1 ); // Information about races
	menu_addText( menu, 33, 136 +offset, 1153, "I" );
	menu_addText( menu, 42, 136 +offset,   95, "nformation about races" );
	menu_addButton( menu, 13, 169 +offset, 1209, 1209, 2 ); // Choose a race
	menu_addText( menu, 33, 166 +offset, 1153, "S" );
	menu_addText( menu, 45, 166 +offset,   95, "elect your race" );
	
	menu_show( menu, chr );

}


public race_dialogRaceInfo( const socket, const race )
{

	if( socket<0 ) 
		return;
		
	new chr = getCharFromSocket( socket );
	
	new menu = menu_create( 30, 30, true, false, false, "handle_race_raceInfo" );

	menu_addBackground( menu, 5120, 320,  340 );
	menu_addGump( menu, 20, 80, 1418 );

	menu_addButton( menu, 10, 300, 2130, 2129, 1 ); 	// OKAY

	menu_addText( menu, 73, 8, 152, "N" );
	menu_addText( menu, 85, 8, 95, "oxwizard" );
	menu_addText( menu, 151, 8, 152, "R" );
	menu_addText( menu, 163, 8, 95, "ace" );
	menu_addText( menu, 189, 8, 152, "S" );
	menu_addText( menu, 201, 8, 95, "ystem" );

	menu_addText( menu, 13, 42, 1153, "C" );
	menu_addText( menu, 25, 42, 95, "hoose an option" );

	menu_addButton( menu, 13, 82, 1209, 1210, 1 ); // General Information
	menu_addText( menu, 33, 82, 1153, "G" );
	menu_addText( menu, 45, 82, 95, "eneral information" );

	menu_addButton( menu, 13, 102, 1209, 1210, 2 ); // Player races
	menu_addText( menu, 33, 102, 1153, "P" );
	menu_addText( menu, 45, 102, 95, "layer races" );

	menu_addButton( menu, 13, 122, 1209, 1210, 3 ); // Non player races
	menu_addText( menu, 33, 122, 1153, "N" );
	menu_addText( menu, 45, 122, 95, "on player races" );

	menu_addButton( menu, 13, 142, 1209, 1210, 4 ); // All races
	menu_addText( menu, 33, 142, 1153, "A" );
	menu_addText( menu, 45, 142, 95, "ll races" );

	if( race_getGlobalProp( RP_WITH_WEB_INTERFACE ) )
	{
		menu_addTilePic( menu, 286, 8, 3811 );
		menu_addButtonFn( menu, 294, 30, 1209, 1210, race, _, "race_webInterface" )
	}

	menu_show( menu, chr );

}



public race_nameList( const socket, const raceType, const canClose, const canMove, const withOk )
{
																																															// Must add static reference map < racename, &Race*> to class
	if( socket<0 ) 
		return;
		
	new chr = getCharFromSocket( socket );
	
	new menu = menu_create( 30, 30, canMove, canClose, false, "handle_race_nameList" );

	menu_addBackground( menu, 5120, 320,  340 );
	menu_addGump( menu, 20, 80, 1418 );

	if ( withOk )
		menu_addButton( menu, 10, 300, 2130, 2129, 1 ); 	// OKAY

	menu_addText( menu, 73,   8,  152,  "N" );
	menu_addText( menu, 84,   8,   95,  "oxwizard" );
	menu_addText( menu, 151,  8,  152, "R" );
	menu_addText( menu, 162,  8,   95,  "ace" );
	menu_addText( menu, 189,  8,  152,  "S" );
	menu_addText( menu, 200,  8,   95,  "ystem" );
	menu_addText( menu, 20,  32, 1153,  "C" );
	menu_addText( menu, 31,  32,   95,  "hoose a race:" );

	new set = set_create();
	set_addAllRaces( set, true );
	
	
	new k=0;
	new raceCount = 0;
	new page = 0;
	new position = 62;

	for( set_rewind( set ); !set_end( set );  )
	{
		
		new race = set_get(set);

		new currRaceType = race_getProperty( race, RP_TYPE );	

		if( raceType == currRaceType )
		{
			if( ( k%10 )==0 )
			{
				position=62;
				page++;
				menu_addPage( menu, page );
			}
			
			new name[100];
			race_getProperty( race, RP_STR_NAME, _, name );
			
			menu_addText( menu, 40, position-4, 95, name );
			menu_addButton( menu, 20, position, 1209, 1210, race );

			position+=20;
			raceCount++;
			k++;
		}
	}

	if( race_getGlobalProp( RP_WITH_WEB_INTERFACE ) )
	{
		menu_addTilePic( menu, 286, 8, 3811 );
		menu_addButtonFn( menu, 294, 30, 1209, 1210, INVALID, _, "race_webInterface" )
	}

	new pagenum = 0;
	for( new i=1; i<page; ++i )
	{
		menu_addPage( menu, i );
		if( i>1 )
			menu_addPageButton( menu, 270, 303, 2223, 2223, i-1 )

		if( i<page )
			menu_addPageButton( menu, 290, 303, 2224, 2224, i+1 )
		
	}

	menu_show( menu, chr );

}

public race_description( const socket, const race, const canClose, const canMove, const withOk )
{

	if( socket<0 ) 
		return;
		
	new chr = getCharFromSocket( socket );
	
	new menu = menu_create( 30, 30, canMove, canClose, false, "handle_race_description" );

	menu_addBackground( menu, 5120, 640,  340 );
	menu_addGump( menu, 340, 80, 1418 );

	if ( withOk )
		menu_addButton( menu, 10, 300, 2130, 2129, 1 ); 	// OKAY

	menu_addText( menu, 233, 8,  152,  "N" );
	menu_addText( menu, 244, 8,   95,  "oxwizard" );
	menu_addText( menu, 311, 8,  152,  "R" );
	menu_addText( menu, 322, 8,   95,  "ace" );
	menu_addText( menu, 349, 8,  152,  "S" );
	menu_addText( menu, 360, 8,   95,  "ystem" );

	new name[100];
	race_getProperty( race, RP_STR_NAME, _, name );
	new footerCenter = ( 640 - ( strlen(name) * PIXELFORCHAR ) ) / 2;
	menu_addText( menu, footerCenter, 300, 152,  name );

	if( race_getGlobalProp( RP_WITH_WEB_INTERFACE ) )
	{
		menu_addTilePic( menu, 606, 8, 3811 );
		menu_addButtonFn( menu, 614, 30, 1209, 1210, race, _, "race_webInterface" )
	}


const descForPage = 11;

	new page = 0;

	new k = 0;
	new position = 62;
	new descCount = race_getProperty( race, RP_STR_DESCRIPTION, RP2_DESCRIPTION_COUNT );
	for( new i=0; i<descCount; ++i )
	{
		if( ( k % descForPage )==0 )
		{
			position=62;
			page++;
			menu_addPage( menu, page );
		}

		k++;
		
		new desc[200];
		race_getProperty( race, RP_STR_DESCRIPTION, _, desc );
		
		
		//note 0x5E is '^'
		if( ( desc[0] == 0x5E ) && ( desc[1] == 'p' ) ) { // insert a new page
			k=descForPage;
			continue;
		}
		
		
		menu_addText( menu, 20, position-4, 95, desc );

		position+=20;

	}

	for( new i=1; i<page; ++i )
	{
		menu_addPage( menu, i );
		if( i>1 )
			menu_addPageButton( menu, 590, 303, 2223, 2223, i-1 )

		if( i<page )
			menu_addPageButton( menu, 610, 303, 2224, 2224, i+1 )
			
	}

	menu_show( menu, chr );
}


public race_webInterface( const socket, const menu, const race )
{
	if( socket<0 )
		return;
		
	new root[200];
	race_getGlobalProp( RP_STR_WEBROOT, _, root );
	
	if( race!=INVALID ) {
		new link[100];
		race_getProperty( race, RP_STR_WEBLINK, _, link );
		weblaunch( socket, "%s%s", root, link );
	}
	else
		weblaunch( socket, root );
	
	
}


public race_make( const socket, const menu, const race, const chr )
{

	if( socket<0 )
		return;
		
	if( race==INVALID )
		return;	
	
	new curr = getCharFromSocket( socket );
	
	chr_unmorph( chr );
	
	chr_setProperty( chr, CP_RACE, _, race );

	//
	// Alter appearance if necessary
	//
	// Only alter skincolor if set in race.xss
	//
	new skincolor = race_getProperty( race, RP_SKIN );
	if( skincolor!=INVALID )
	{
		chr_setProperty( chr, CP_XSKIN, _, skincolor );
		chr_setProperty( chr, CP_SKIN,  _, skincolor );
	}
	
	new killBeard = ( race_getProperty( race, RP_LAYER_PERMITTED, LAYER_BEARD ) == RT_PROHIBITED )? true : false;
	new killHair = ( race_getProperty( race, RP_LAYER_PERMITTED, LAYER_HAIR ) == RT_PROHIBITED )? true : false;
		
	
	//
	// unequip/unwear most things and put them in the backpack
	//


	new backpack = chr_getBackpack( chr, true );

	new set = set_create();
	set_addItemWeared( set, chr, false, false, false );
	
	for( set_rewind(set); !set_end(set); ) {
		new item = set_getItem( set );
		if( item!=INVALID )
			itm_contAddItem( backpack, item );
	}
	
	//
	// equip / wear items or put them in backpack
	//
	
	new item_set = set_create();
	set_getRaceStuff( item_set, race, RP_BACKPACK_ITEM, chr  );
	new amount_set = set_create();
	set_getRaceStuff( amount_set, race, RP_BACKPACK_ITEM, chr  );
	
	for( set_rewind( item_set ); !set_end( item_set ); ) {
		new def = set_get( item_set );
		new amount = set_get( amount_set );
		
		itm_createInBp( def, chr, amount );

	}
	

	set_clear( item_set );
	set_getRaceStuff( item_set, race, RP_BANK_ITEM, chr  );
	set_clear( amount_set );
	set_getRaceStuff( amount_set, race, RP_BANK_ITEM, chr  );
	
	for( set_rewind( item_set ); !set_end( item_set ); ) {
		new def = set_get( item_set );
		new amount = set_get( amount_set );
		
		itm_createInBank( def, chr, amount );

	}
	
	set_clear( item_set );
	set_getRaceStuff( item_set, race, RP_EQUIP_ITEM, chr  );
	set_clear( amount_set );
	set_getRaceStuff( amount_set, race, RP_EQUIP_ITEM, chr  );
	
	for( set_rewind( item_set ); !set_end( item_set ); ) {
		new def = set_get( item_set );
		new amount = set_get( amount_set );
		
		new item = itm_create( def, INVALID, amount );
		
		//TODO if layer is occupied, move or remove item
		chr_equip( chr, item );

	}
	
	// if teleported to safe location return player to original position
	if( race_getGlobalProp( RP_TELEPORT_ON_ENLIST  ) ) {
	{
		// TODO allow pc to be teleported to racial home region
		chr_moveTo( chr, chr_getProperty( chr, CP_OLDPOS, CP2_X ), chr_getProperty( chr, CP_OLDPOS, CP2_Y ), chr_getProperty( chr, CP_OLDPOS, CP2_Z ) );
	}

	chr_teleport(chr);
	
	new race_name[100];
	race_getProperty( race, CP_STR_NAME, _, race_name );
	sysmessage( socket, _, "You have become a %s", race_name );
	
	if( curr!=chr ) {
		new name[100];
		chr_getProperty( chr, CP_STR_NAME, _, name );
		sysmessage( socket, _, "Now %s is a %s", name, race_name );
	}

}

}
