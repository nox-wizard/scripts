
public target_stats( const chr, const target, const item )
{
	if(!isChar(chr)) 
		return;
		
	if( isChar(target) ) {
		stats_char( chr, target, 1 );
	}
	else if( isItem( item ) ) {
		stats_item( chr, item, 1 );
	}
	else chr_message(chr,_ , "stats work only on object" );

}

public stats_char( const caller, const chr, const page )
{
	new menu = gui_create( 50, 50, true, true, true, "handle_stats_char" );
	gui_addGump( menu, 0, 0, 0x08AC, 0 );
	gui_setProperty( menu, MP_BUFFER, 0, PROP_CHARACTER );
	gui_setProperty( menu, MP_BUFFER, 1, chr );
	gui_setProperty( menu, MP_BUFFER, 3, page );
	gui_setProperty( menu, MP_BUFFER, 5, 1 );
	
	gui_addButton( menu, 300, 185, 0x084A, 0x084B, 1 );

	const colorEdit = 32;
	new i=0;
	
	switch( page) {
	
		case 1: {
				gui_addButton( menu, 321, 8, 0x089E, GUMP_INVALID, 10+2 );
				gui_addText( menu, 58, 10+(20*i), _, "Account : " );
				gui_addText( menu, 228, 10+(20*i++), _, "%d", chr_getProperty( chr, CP_ACCOUNT ) );
			
				gui_addText( menu, 58, 10+(20*i), _, "Name : " );
				gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_STR_NAME, _, colorEdit );
			
				gui_addText( menu, 58, 10+(20*i), _, "Title : " );
				gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_STR_TITLE, _, colorEdit );
			
				gui_addText( menu, 58, 10+(20*i), _, "Dexterity : " );
				gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_DEXTERITY, CP2_REAL, colorEdit );
			
				gui_addText( menu, 58, 10+(20*i), _, "Strength : " );
				gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_STRENGHT, CP2_REAL, colorEdit );
			
				gui_addText( menu, 58, 10+(20*i), _, "Intelligence : " );
				gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_INTELLIGENCE, CP2_REAL, colorEdit );
				
				gui_addText( menu, 58, 10+(20*i), _, "Weight : " );
				gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_WEIGHT, _, colorEdit );
				
				gui_addText( menu, 58, 10+(20*i), _, "Body : " );
				gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_ID, _, colorEdit );
			
				gui_addText( menu, 58, 10+(20*i), _, "Skin : " );
				gui_addPropField( menu, 228, 10+(20*i++), 125, 30, CP_SKIN , _, colorEdit );
	
		}
	
		case 2: {
	
				gui_addButton( menu, 50, 8, 0x089D, GUMP_INVALID, 10+1 );
				gui_addButton( menu, 321, 8, 0x089E, GUMP_INVALID, 10+3 );
				
				gui_addText( menu, 58, 20+(20*i), _, "Npc Ai : " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, CP_NPCAI , _, colorEdit );
				
				gui_addText( menu, 58, 20+(20*i), _, "NPC Defence power : " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, CP_DEF  , _, colorEdit );
			
				gui_addText( menu, 58, 20+(20*i), _, "NPC Attack power : " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, CP_ATT  , _, colorEdit );
				
				gui_addText( menu, 58, 20+(20*i), _, "High Damage : " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, CP_HIDAMAGE   , _, colorEdit );
	
				gui_addText( menu, 58, 20+(20*i), _, "Low Damage : " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, CP_HIDDEN, _, colorEdit );
				
				gui_addText( menu, 58, 20+(20*i), _, "Criminal : " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, CP_CRIMINALFLAG , _, colorEdit );
				
				gui_addText( menu, 58, 20+(20*i), _, "Time to be Murder : " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, CP_MURDERRATE     , _, colorEdit );
				
				gui_addText( menu, 58, 20+(20*i), _, "Jailed : " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, CP_JAILED, _, colorEdit );
				
				gui_addText( menu, 58, 20+(20*i), _, "Kills : " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, CP_KILLS , _, colorEdit );
		
	
		}
		
		case 3: {
	
				gui_addButton( menu, 50, 8, 0x089D, GUMP_INVALID, 10+2 );
				gui_addButton( menu, 321, 8, 0x089E, GUMP_INVALID, 10+4 );
				
				
				gui_addText( menu, 58, 20+(20*i), _, "Fame : " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, CP_FAME, _, colorEdit );
			
				gui_addText( menu, 58, 20+(20*i), _, "Karma : " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, CP_KARMA, _, colorEdit );
				
				gui_addText( menu, 58, 20+(20*i), _, "Hunger : " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, CP_HUNGER  , _, colorEdit );
			
				gui_addText( menu, 58, 20+(20*i), _, "Hunger Time : " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, CP_HUNGERTIME , _, colorEdit );
				
				gui_addText( menu, 58, 20+(20*i), _, "Location : " );
				gui_addPropField( menu, 228, 20+(20*i), 35, 30, CP_POSITION, CP2_X, colorEdit );
				gui_addPropField( menu, 285, 20+(20*i), 35, 30, CP_POSITION, CP2_Y, colorEdit );
				gui_addPropField( menu, 325, 20+(20*i++), 35, 30, CP_POSITION, CP2_Z, colorEdit );
			
				gui_addText( menu, 58, 20+(20*i), _, "Poisoned : " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, CP_POISONED  , _, colorEdit );
			
				gui_addText( menu, 58, 20+(20*i), _, "Poison NPC Attack: " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, CP_POISON  , _, colorEdit );
			
				gui_addText( menu, 58, 20+(20*i), _, "Poison Time : " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, CP_POISONWEAROFFTIME , _, colorEdit );
				
				gui_addText( menu, 58, 20+(20*i), _, "Direction : " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, CP_DIR, _, colorEdit );
				
		}
		
		case 4: {
				gui_addButton( menu, 50, 8, 0x089D, GUMP_INVALID, 10+3 );
				
				gui_addText( menu, 58, 20+(20*i), _, "Guild : " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, CP_GUILD, _, colorEdit );
				
				gui_addText( menu, 58, 20+(20*i), _, "Guild Name: " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, GP_STR_NAME, _, colorEdit );
				
				gui_addText( menu, 58, 20+(20*i), _, "Guild WebPage: " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, GP_STR_WEBPAGE, _, colorEdit );
				
				gui_addText( menu, 58, 20+(20*i), _, "Guild Abbreviation: " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, GP_STR_ABBREVIATION, _, colorEdit );
				
				gui_addText( menu, 58, 20+(20*i), _, "Guild Rank: " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, GMP_RANK, _, colorEdit );
				
				gui_addText( menu, 58, 20+(20*i), _, "Guild Title Toggle: " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, GMP_TITLETOGGLE, _, colorEdit );
				
				gui_addText( menu, 58, 20+(20*i), _, "Guild Title: " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, GMP_STR_TITLE, _, colorEdit );
				
				gui_addText( menu, 58, 20+(20*i), _, "Guild Can Recruit: " );
				gui_addPropField( menu, 228, 20+(20*i++), 125, 30, GRP_I_RECRUITER, _, colorEdit );
				
		}
	}
	
	gui_show( menu, caller);
	
}

public handle_stats_char( const caller, const menu, const button )
{
	if( button==MENU_CLOSED )
		return;
		
	new chr = gui_getProperty( menu, MP_BUFFER, 1 );
		
	if( button>10 ) { //page button
		stats_char( caller, chr, button-10 );
	}
	else { //apply button, so resend current page
		chr_teleport( chr );
		stats_char( caller, chr, gui_getProperty( menu, MP_BUFFER, 3 ) );
	}
	
}

public handle_stats_item( const caller, const menu, const button )
{
	if( button==MENU_CLOSED )
		return;
		
	new item = gui_getProperty( menu, MP_BUFFER, 1 );
	new page = gui_getProperty( menu, MP_BUFFER, 3 )
	
	if( button == 1 ) { //apply button
		chr_teleport( item );
		stats_item( caller, item, page );
	}
	
	if (button == 2) { // more button
		chr_message( caller,_ ,"Click on a Key" );
		target_create( caller, item, _, true, "MakeMorePD" );
	}
		
	if( button>10 ) { //page button
		stats_item( caller, item, button-10 );
	}

	
}

public MakeMorePD( const target, const chr, const key, const x, const y, const z, const unused, const itemTweaked ){
	
	// nprintf(socket, "target %d, key %d,unused %d, ItemT %d", target, key, unused, itemTweaked);
	
	new MoreA = key>>16 ; 
	new MoreB = key&0xFFFF;

	// nprintf(socket, "MoreA %d, MoreB %d", MoreA, MoreB);
		
	// Setto i more Nell'item che e' stato targhettato da 'stats
	itm_setProperty(itemTweaked,IP_MORE,_,MoreA);
	itm_setProperty(itemTweaked,IP_MOREB,_,MoreB);
	
	// Setto i more nella chiave (usando il serial della chiave stessa)
	itm_setProperty(key,IP_MORE,_,MoreA);
	itm_setProperty(key,IP_MORE,_,MoreB);
	
	stats_item( chr, itemTweaked, 4 );
}

public stats_item( const caller, const item, const page )
{
	new menu = gui_create( 50, 50, true, true, true, "handle_stats_item" );
	gui_addGump( menu, 0, 0, 0x08AC, 0 );
	gui_setProperty( menu, MP_BUFFER, 0, PROP_ITEM );
	gui_setProperty( menu, MP_BUFFER, 1, item );
	gui_setProperty( menu, MP_BUFFER, 3, page );
	gui_setProperty( menu, MP_BUFFER, 5, 1 );
	
	gui_addButton( menu, 300, 185, 0x084A, 0x084B, 1 );

	const colorEdit = 32;
	new i=0;
	
	switch( page) {
	
		case 1: {
		
			gui_addText( menu, 58, 10+(20*i), _, "Name : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_STR_NAME, _, colorEdit );
		
			gui_addText( menu, 58, 10+(20*i), _, "Damage Min : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_LODAMAGE , _, colorEdit );
		
			gui_addText( menu, 58, 10+(20*i), _, "Damage Max : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_HIDAMAGE, _, colorEdit );
		
			gui_addText( menu, 58, 10+(20*i), _, "Hitpoints : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_HP , _, colorEdit );
		
			gui_addText( menu, 58, 10+(20*i), _, "Hitpoints Max : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_MAXHP , _, colorEdit );
		
			gui_addText( menu, 58, 10+(20*i), _, "Color : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_COLOR , _, colorEdit );
		
			gui_addText( menu, 58, 10+(20*i), _, "Armor Bonus : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_DEF, _, colorEdit );
			
			gui_addText( menu, 58, 10+(20*i), _, "Frozen : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_MAGIC, _, colorEdit );
			
			gui_addText( menu, 58, 10+(20*i), _, "Speed : " );
			gui_addPropField( menu, 228, 10+(20*i++), 125, 30, IP_SPEED, _, colorEdit );
			
			gui_addButton( menu, 321, 8, 0x089E, GUMP_INVALID, 10+2 );
	
		}
	
		case 2: {
	
			gui_addButton( menu, 50, 8, 0x089D, GUMP_INVALID, 10+1 );
			gui_addButton( menu, 321, 8, 0x089E, GUMP_INVALID, 10+3 );
		
			gui_addText( menu, 58, 20+(20*i), _, "Str Required : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_STRREQUIRED  , _, colorEdit );
		
			gui_addText( menu, 58, 20+(20*i), _, "Dex Required : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_DEXREQUIRED  , _, colorEdit );
		
			gui_addText( menu, 58, 20+(20*i), _, "Int Required : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_INTREQUIRED , _, colorEdit );
		
			gui_addText( menu, 58, 20+(20*i), _, "Bonus Str : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_STRBONUS, _, colorEdit );
		
			gui_addText( menu, 58, 20+(20*i), _, "Bonus Dex : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_DEXBONUS, _, colorEdit );
			
			gui_addText( menu, 58, 20+(20*i), _, "Bonus Int : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_INTBONUS, _, colorEdit );
			
			gui_addText( menu, 58, 20+(20*i), _, "Attack Power : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_ATT , _, colorEdit );

			gui_addText( menu, 58, 20+(20*i), _, "ID : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_ID, _, colorEdit );
			
			gui_addText( menu, 58, 20+(20*i), _, "Weight : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_WEIGHT, _, colorEdit );
	
		}
		
		case 3: {
	
	
			gui_addButton( menu, 50, 8, 0x089D, GUMP_INVALID, 10+2 );
			gui_addButton( menu, 321, 8, 0x089E, GUMP_INVALID, 10+4 );
			
			gui_addText( menu, 58, 20+(20*i), _, "Poisoned : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_POISONED , _, colorEdit );
			
			gui_addText( menu, 58, 20+(20*i), _, "Unloot : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_PRIV , _, colorEdit );
			
			gui_addText( menu, 58, 20+(20*i), _, "Creator : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_STR_CREATOR  , _, colorEdit );
			
			gui_addText( menu, 58, 20+(20*i), _, "Item Hand : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_ITEMHAND, _, colorEdit );
			
			gui_addText( menu, 58, 20+(20*i), _, "Dyeable : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_DYE , _, colorEdit );
			
			gui_addText( menu, 58, 20+(20*i), _, "Pileable : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_PILEABLE , _, colorEdit );
		
			gui_addText( menu, 58, 20+(20*i), _, "Visible : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_VISIBLE   , _, colorEdit );
		
			gui_addText( menu, 58, 20+(20*i), _, "Decay Time : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_DECAYTIME  , _, colorEdit );
			
			gui_addText( menu, 58, 20+(20*i), _, "Murder (if a Corpse) : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_STR_MURDERER , _, colorEdit );
			
			
		}
		
		case 4: {
	
	
			gui_addButton( menu, 50, 8, 0x089D, GUMP_INVALID, 10+3 );
			
			gui_addText( menu, 58, 20+(20*i), _, "Script Item ID : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_SCRIPTID , _, colorEdit );
		
			gui_addText( menu, 58, 20+(20*i), _, "Description : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_STR_DESCRIPTION, _, colorEdit );
			
			gui_addText( menu, 58, 20+(20*i), _, "IP More : " );
			gui_addButton( menu, 258, 20+(20*i), 0x4B9, 0x4BA, 2 );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_MORE, _, colorEdit );
			
			gui_addText( menu, 58, 20+(20*i), _, "IP More B : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_MOREB, _, colorEdit );
			
			gui_addText( menu, 58, 20+(20*i), _, "IP Type : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_TYPE, _, colorEdit );
			
			gui_addText( menu, 58, 20+(20*i), _, "IP Type 2 : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_TYPE2, _, colorEdit );
			
			gui_addText( menu, 58, 20+(20*i), _, "IP Amount : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_AMOUNT, _, colorEdit );
			
			gui_addText( menu, 58, 20+(20*i), _, "Layer : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_LAYER, _, colorEdit );
			
			gui_addText( menu, 58, 20+(20*i), _, "Serial : " );
			gui_addPropField( menu, 228, 20+(20*i++), 125, 30, IP_SERIAL, _, colorEdit );
			
		}
	
	}
	
	gui_show( menu, caller );
}

