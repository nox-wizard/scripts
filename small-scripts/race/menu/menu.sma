public race_menu( const chr, const race )
{
	new tempStr[50];
	if( race_getGlobalProp( RP_WITH_WEB_INTERFACE ) == 1)
		sprintf(tempStr,"race_webInterface");
	else sprintf(tempStr, "race_menu_Bck");
	new racemenu = gui_create( 10,10,1,0,0,tempStr );
	
	gui_setProperty( racemenu,MP_BUFFER,0,PROP_CHARACTER );
	printf("errorcheck^n");
	gui_setProperty( racemenu,MP_BUFFER,3,BUTTON_APPLY );

	gui_addPage(racemenu,0);
	gui_addBackground( racemenu, 5120, 320,  340 );
	gui_addGump( racemenu, 20, 80, 1418 );
	
	if( (race_getGlobalProp( RP_WITH_WEB_INTERFACE )) == 1)
	{
		gui_addTilePic( racemenu, 286, 8, 3811 );
		gui_addButtonFn( racemenu, 294, 30, 1209, 1210, race, _, "race_webInterface" )
		race_getGlobalProp( RP_STR_WEBLINK,_, tempStr );
		printf("weblink: %s, ", tempStr);
		race_getGlobalProp( RP_STR_WEBROOT, _, tempStr );
		printf("webroot: %s^n", tempStr);
	}
	
	gui_addText( racemenu, 73,   8,  152,  "N" );
	gui_addText( racemenu, 85,   8,   95,  "oxwizard" );
	gui_addText( racemenu, 151,   8,  152,  "R" );
	gui_addText( racemenu, 163,   8,   95,  "ace" );
	gui_addText( racemenu, 189,   8,  152,  "S" );
	gui_addText( racemenu, 201,   8,   95,  "ystem" );

	gui_addText( racemenu, 13,  42, 1153,  "D" );
	gui_addText( racemenu, 25,  42,   95,  "ear player the Noxwizard Race System" );
	gui_addText( racemenu, 13,  58,   95,  "has been activated on this shard." );

	gui_addText( racemenu, 13,  88, 1153, "A" );
	gui_addText( racemenu, 25,  88,   95, "s you do not belong to a race yet....." );
	gui_addText( racemenu, 13, 106,   95, "you must choose one now!" );
	
	new offset = 0;
	new telecheck = race_getGlobalProp( RP_TELEPORT_ON_ENLIST );
	printf("teleport check: %d", telecheck);
	if( telecheck == 1)
	{
		gui_addText( racemenu, 13, 136, 1153, "Y" );
		gui_addText( racemenu, 25, 136,   95, "ou have been transported to a safe location" );
		gui_addText( racemenu, 13, 154,   95, "and will be returned after you've made your" );
		gui_addText( racemenu, 13, 172,   95, "choice." );
		
		new racex = race_getGlobalProp( RP_STARTLOCATION,RP2_X );
		new racey = race_getGlobalProp( RP_STARTLOCATION,RP2_Y);
		new racez = race_getGlobalProp( RP_STARTLOCATION,RP2_Z );
		
		new chrx = chr_getProperty(chr,CP_POSITION,CP2_X);
		new chry = chr_getProperty(chr,CP_POSITION,CP2_Y);
		new chrz = chr_getProperty(chr,CP_POSITION,CP2_Z);
		
		chr_LocalVarMaker(chr, 0, RACE_STARTX, chrx, _);
		chr_LocalVarMaker(chr, 0, RACE_STARTY, chry, _);
		chr_LocalVarMaker(chr, 0, RACE_STARTZ, chrz, _);

		offset=60;
	}

	gui_addButton( racemenu, 13, 139 +offset, 1209, 1210, 1 ); // Information about races
	gui_addText( racemenu, 33, 136 +offset, 1153, "I" );
	gui_addText( racemenu, 42, 136 +offset,   95, "nformation about races" );
	gui_addButton( racemenu, 13, 169 +offset, 1209, 1209, 2 ); // Choose a race
	gui_addText( racemenu, 33, 166 +offset, 1153, "S" );
	gui_addText( racemenu, 45, 166 +offset,   95, "elect your race" );
	
	printf("blab");
	gui_show( racemenu, chr );

}

public race_menu_Bck(const racemenu, const chrsource, const buttonCode)
{
	printf("bla");
}

public race_dialogRaceInfo( const chr, const race )
{

	new racemenu = gui_create( 30, 30, true, false, false, "handle_race_raceInfo" );

	gui_addBackground( racemenu, 5120, 320,  340 );
	gui_addGump( racemenu, 20, 80, 1418 );

	gui_addButton( racemenu, 10, 300, 2130, 2129, 1 ); 	// OKAY

	gui_addText( racemenu, 73, 8, 152, "N" );
	gui_addText( racemenu, 85, 8, 95, "oxwizard" );
	gui_addText( racemenu, 151, 8, 152, "R" );
	gui_addText( racemenu, 163, 8, 95, "ace" );
	gui_addText( racemenu, 189, 8, 152, "S" );
	gui_addText( racemenu, 201, 8, 95, "ystem" );

	gui_addText( racemenu, 13, 42, 1153, "C" );
	gui_addText( racemenu, 25, 42, 95, "hoose an option" );

	gui_addButton( racemenu, 13, 82, 1209, 1210, 1 ); // General Information
	gui_addText( racemenu, 33, 82, 1153, "G" );
	gui_addText( racemenu, 45, 82, 95, "eneral information" );

	gui_addButton( racemenu, 13, 102, 1209, 1210, 2 ); // Player races
	gui_addText( racemenu, 33, 102, 1153, "P" );
	gui_addText( racemenu, 45, 102, 95, "layer races" );

	gui_addButton( racemenu, 13, 122, 1209, 1210, 3 ); // Non player races
	gui_addText( racemenu, 33, 122, 1153, "N" );
	gui_addText( racemenu, 45, 122, 95, "on player races" );

	gui_addButton( racemenu, 13, 142, 1209, 1210, 4 ); // All races
	gui_addText( racemenu, 33, 142, 1153, "A" );
	gui_addText( racemenu, 45, 142, 95, "ll races" );

	if( race_getGlobalProp( RP_WITH_WEB_INTERFACE ) )
	{
		gui_addTilePic( racemenu, 286, 8, 3811 );
		gui_addButtonFn( racemenu, 294, 30, 1209, 1210, race, _, "race_webInterface" )
	}

	gui_show( racemenu, chr );

}



public race_nameList( const chr, const raceType, const canClose, const canMove, const withOk )
{
																																															// Must add static reference map < racename, &Race*> to class
	new racemenu = gui_create( 30, 30, canMove, canClose, false, "handle_race_nameList" );

	gui_addBackground( racemenu, 5120, 320,  340 );
	gui_addGump( racemenu, 20, 80, 1418 );

	if ( withOk )
		gui_addButton( racemenu, 10, 300, 2130, 2129, 1 ); 	// OKAY

	gui_addText( racemenu, 73,   8,  152,  "N" );
	gui_addText( racemenu, 84,   8,   95,  "oxwizard" );
	gui_addText( racemenu, 151,  8,  152, "R" );
	gui_addText( racemenu, 162,  8,   95,  "ace" );
	gui_addText( racemenu, 189,  8,  152,  "S" );
	gui_addText( racemenu, 200,  8,   95,  "ystem" );
	gui_addText( racemenu, 20,  32, 1153,  "C" );
	gui_addText( racemenu, 31,  32,   95,  "hoose a race:" );

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
				gui_addPage( racemenu, page );
			}
			
			new name[100];
			race_getProperty( race, RP_STR_NAME, _, name );
			
			gui_addText( racemenu, 40, position-4, 95, name );
			gui_addButton( racemenu, 20, position, 1209, 1210, race );

			position+=20;
			raceCount++;
			k++;
		}
	}

	if( race_getGlobalProp( RP_WITH_WEB_INTERFACE ) )
	{
		gui_addTilePic( racemenu, 286, 8, 3811 );
		gui_addButtonFn( racemenu, 294, 30, 1209, 1210, INVALID, _, "race_webInterface" )
	}

	//new pagenum = 0;
	for( new i=1; i<page; ++i )
	{
		gui_addPage( racemenu, i );
		if( i>1 )
			gui_addPageButton( racemenu, 270, 303, 2223, 2223, i-1 )

		if( i<page )
			gui_addPageButton( racemenu, 290, 303, 2224, 2224, i+1 )
		
	}

	gui_show( racemenu, chr );

}

public race_description( const chr, const race, const canClose, const canMove, const withOk )
{

	new racemenu = gui_create( 30, 30, canMove, canClose, false, "handle_race_description" );

	gui_addBackground( racemenu, 5120, 640,  340 );
	gui_addGump( racemenu, 340, 80, 1418 );

	if ( withOk )
		gui_addButton( racemenu, 10, 300, 2130, 2129, 1 ); 	// OKAY

	gui_addText( racemenu, 233, 8,  152,  "N" );
	gui_addText( racemenu, 244, 8,   95,  "oxwizard" );
	gui_addText( racemenu, 311, 8,  152,  "R" );
	gui_addText( racemenu, 322, 8,   95,  "ace" );
	gui_addText( racemenu, 349, 8,  152,  "S" );
	gui_addText( racemenu, 360, 8,   95,  "ystem" );

	new name[100];
	race_getProperty( race, RP_STR_NAME, _, name );
	new footerCenter = ( 640 - ( strlen(name) * PIXELFORCHAR ) ) / 2;
	gui_addText( racemenu, footerCenter, 300, 152,  name );

	if( race_getGlobalProp( RP_WITH_WEB_INTERFACE ) )
	{
		gui_addTilePic( racemenu, 606, 8, 3811 );
		gui_addButtonFn( racemenu, 614, 30, 1209, 1210, race, _, "race_webInterface" )
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
			gui_addPage( racemenu, page );
		}

		k++;
		
		new desc[200];
		race_getProperty( race, RP_STR_DESCRIPTION, _, desc );
		
		
		//note 0x5E is '^'
		if( ( desc[0] == 0x5E ) && ( desc[1] == 'p' ) ) { // insert a new page
			k=descForPage;
			continue;
		}
		
		
		gui_addText( racemenu, 20, position-4, 95, desc );

		position+=20;

	}

	for( new i=1; i<page; ++i )
	{
		gui_addPage( racemenu, i );
		if( i>1 )
			gui_addPageButton( racemenu, 590, 303, 2223, 2223, i-1 )

		if( i<page )
			gui_addPageButton( racemenu, 610, 303, 2224, 2224, i+1 )
			
	}

	gui_show( racemenu, chr );
}


public race_webInterface( const racemenu, const chr, const race )
{
	new root[200];
	race_getGlobalProp( RP_STR_WEBROOT, _, root );
	
	if( race!=INVALID ) {
		new link[100];
		race_getProperty( race, RP_STR_WEBLINK, _, link );
		weblaunch( chr, "%s%s", root, link );
	}
	else
		weblaunch( chr, root );
	
	
}


public race_make( const racemenu, const curr, const race, const chr )
{

	if( race==INVALID )
		return;	
	
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
	
	//new killBeard = ( race_getProperty( race, RP_LAYER_PERMITTED, LAYER_BEARD ) == RT_PROHIBITED )? true : false;
	//new killHair = ( race_getProperty( race, RP_LAYER_PERMITTED, LAYER_HAIR ) == RT_PROHIBITED )? true : false;
		
	
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
	set_getRaceStuff( item_set, race, RS_BACKPACK_ITEM, chr  );
	new amount_set = set_create();
	set_getRaceStuff( amount_set, race, RS_BACKPACK_ITEM, chr  );
	
	for( set_rewind( item_set ); !set_end( item_set ); ) {
		new def = set_get( item_set );
		new amount = set_get( amount_set );
		
		itm_createInBp( def, chr, amount );

	}
	

	set_clear( item_set );
	set_getRaceStuff( item_set, race, RS_BANK_ITEM, chr  );
	set_clear( amount_set );
	set_getRaceStuff( amount_set, race, RS_BANK_ITEM, chr  );
	
	for( set_rewind( item_set ); !set_end( item_set ); ) {
		new def = set_get( item_set );
		new amount = set_get( amount_set );
		
		itm_createInBank( def, chr, amount );

	}
	
	set_clear( item_set );
	set_getRaceStuff( item_set, race, RS_EQUIP_ITEM, chr  );
	set_clear( amount_set );
	set_getRaceStuff( amount_set, race, RS_EQUIP_ITEM, chr  );
	
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
	race_getProperty( race, RP_STR_NAME, _, race_name );
	chr_message( chr, _, "You have become a %s", race_name );
	
	if( curr!=chr ) {
		new name[100];
		chr_getProperty( chr, CP_STR_NAME, _, name );
		chr_message( curr, _, "Now %s is a %s", name, race_name );
	}

}

}
