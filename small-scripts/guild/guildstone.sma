// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard	: Embedded Small Scripts			||
// || Maintained by	: Luxor, Sparhawk				||
// || Last Update	: 06-apr-2003					||
// || Designed for NXW 	: 0.82						||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

/** \defgroup script_API_guild_various Variuos guild function
 *  \ingroup script_API_guild
 *  \attention not used now
 *  @{
 */
 
 
//if define guildstone place is get from target, else from player position
#define GUILD_POSITION_WITH_TARGET

#if defined( GUILD_POSITION_WITH_TARGET )
#else 
	#define GUILD_POSITION_WHERE_PLAYER
#endif

 
 
 
/*!
\brief a guild deed double-click
\author Endymion
\fn guild_dclickDeed( const deed, const master )
\param deed the guildstone deed
\param master who click
*/
public guild_dclickDeed( const deed, const master ) {

	bypass();

	if( chr_getProperty( master, CP_GUILD )!=INVALID ) {
		chr_message( master, _, "Resign from your guild before creating a new guild" );
		return;
	}
	
	chr_message( master, _, "Where you want place guildstone?" );
	target_create( master, deed, _, _, "guildPlace" );

}
	
public guildPlace( const target, const master, const obj, const x, const y, const z, const model, const deed )
{

	if( master<=INVALID ) return;
	
	if( chr_getProperty( master, CP_GUILD )!=INVALID ) {
		chr_message( master, _, "Resign from your guild before creating a new guild" );
		return;
	}
	
#if defined( GUILD_POSITION_WITH_TARGET )
	if( x==INVALID || y==INVALID ) {
		chr_message( master, _, "This is not a valid place" );
		return;
	}
#endif
	
#if defined( GUILD_POSITION_WHERE_PLAYER )
	x = chr_getProperty( master, CP_POSITION, CP2_X );
	y = chr_getProperty( master, CP_POSITION, CP2_Y );
	z = chr_getProperty( master, CP_POSITION, CP2_Z );
#endif
	const colorEdit = 32;
	new gui = gui_create( 40, 40, true, true, true, "guildgui_callback" );
	// gui_addBackground( gui, 0x0A2C, 300, 100 );
	gui_addGump( gui, 0, 0, 0x04CC, 0 );
	gui_setProperty( gui, MP_BUFFER, 0, deed );
	gui_setProperty( gui, MP_BUFFER, 1, x );
	gui_setProperty( gui, MP_BUFFER, 2, y );
	gui_setProperty( gui, MP_BUFFER, 3, z );
	gui_addButton( gui, 250, 265, 0x084A, 0x084B, 1 );
	gui_addText( gui, 20, 30, _, "   Guild Name " );
	gui_addInputField( gui, 190, 30, 125, 30, 55, colorEdit, "Guild");
	gui_addText( gui, 20, 70, _, "   Guild Short Name " );
	gui_addInputField( gui, 190, 70, 125, 30, 56, colorEdit, "Guild Short Name");

	
	gui_show( gui, master );

	
}

public guildgui_callback( const gui, const master, const button )
{
	if( button<=MENU_CLOSED )
		return;

	if( chr_getProperty( master, CP_GUILD )!=INVALID ) {
		chr_message( master, _, "Resign from your guild before creating a new guild" );
		return;
	}
	
	new name[150];
	gui_getProperty( gui, MP_UNI_TEXT, 55, name );
	
	new shortname[150];
	gui_getProperty( gui, MP_UNI_TEXT, 56, name );
	
	new stone = itm_createByDef( "$item_guildstone" );
	new guild = _guild_createStandardGuild( stone, master ); // create a standard guild.. see guild.sma
	guild_setProperty( guild, GP_STR_NAME, _, name ); 
	guild_setProperty( guild, GP_STR_ABBREVIATION, _, shortname ); 
	
	itm_setProperty( stone, IP_POSITION, IP2_X, gui_getProperty( gui, MP_BUFFER, 1 ) );
	itm_setProperty( stone, IP_POSITION, IP2_Y, gui_getProperty( gui, MP_BUFFER, 2 ) );
	itm_setProperty( stone, IP_POSITION, IP2_Z, gui_getProperty( gui, MP_BUFFER, 3 ) );
	
	itm_setProperty( stone, IP_PRIV, _, 0 );
	
	itm_refresh( stone );
	
	/*new deed =*/ gui_getProperty( gui, MP_BUFFER, 0 );
}



/*!
\author Tuzzi
\fn guild_dclickStone( const guild, const socket )
\brief a guild stone double-click
*/
public guild_dclickStone( const guild, const curr ){
	
	bypass();
	
	const colorEdit = 32;
	new gui = gui_create( 40, 40, true, true, true, "guildDclick_callback" );
	gui_addGump( gui, 0, 0, 0x04CC, 0 );
	
	gui_setProperty( gui, MP_BUFFER, 0, guild );
	
	gui_addText( gui, 45, 5, colorEdit, "GuildStone Menu" );
	
	gui_addText( gui, 45, 29, _, "Recruit someone in the gild" );
	gui_addButton( gui, 25, 29, 0x4B9, 0x4BA, 1 );
	
	gui_addText( gui, 45, 59, _, "See the member list" );
	gui_addButton( gui, 25, 59, 0x4B9, 0x4BA, 2 );
	
	gui_addText( gui, 45, 89, _, "Reath the guild description" );
	gui_addButton( gui, 25, 89, 0x4B9, 0x4BA, 3 );
	
	gui_addText( gui, 45, 119, _, "Resign From Guild" );
	gui_addButton( gui, 25, 119, 0x4B9, 0x4BA, 4 );
	
	gui_addText( gui, 45, 149, _, "Read the candidates list" );
	gui_addButton( gui, 25, 149, 0x4B9, 0x4BA, 5 );
	
	gui_addText( gui, 45, 179, _, "Advanced Menu" );
	gui_addButton( gui, 25, 179, 0x4B9, 0x4BA, 6 );
	
	gui_addText( gui, 45, 209, _, "Read the guilds that are in war with you " );
	gui_addButton( gui, 25, 209, 0x4B9, 0x4BA, 7 );
	
	gui_addText( gui, 45, 239, _, "Read the guilds that you have declared war" );
	gui_addButton( gui, 25, 239, 0x4B9, 0x4BA, 8 );
	
	gui_show( gui, curr );
	
}

public guildDclick_callback( const gui, const curr, const button )
{

	new guild = gui_getProperty( gui, MP_BUFFER, 0 );
	
	switch(button){
		case 0: return;
		
		case 1: return;
		
		case 2: return;
		
		case 3: return;
		
		case 4: return;
		
		case 5: return;
		
		case 6: return;
		
		case 7: return;
		
		case 8: return;
		
		default:{
			chr_message( curr, _, "Something gone wrong!");
			return;
		}
	}
}

/*!
\author Endymion
\fn guild_sclickStone( const guild, const curr )
\brief a guild stone single-click
*/
public guild_sclickStone( const guild, const curr )
{
	new guildName[64];
	guild_getProperty( guild, GP_STR_NAME, _, guildName );
	sprintf( guildName, "Guildstone for %s", guildName );
	itm_speech( curr, guild, guildName );
	bypass();
}

/** @} */ // end of script_API_guild_various
