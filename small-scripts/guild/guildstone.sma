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
\fn guild_dclickDeed( const deed, const socket )
\param deed the guildstone deed
\param socket who click
*/
public guild_dclickDeed( const deed, const socket ) {

	if( socket<=INVALID ) return;
    new master = getCharFromSocket(socket);
    if( master<=INVALID ) return;

	bypass();

	if( chr_getProperty( master, CP_GUILD )!=INVALID ) {
		sysmessage( master, _, "Resign from your guild before creating a new guild" );
		return;
	}
	
	sysmessage( master, _, "Where you want place guildstone?" );
	target_create( master, deed, _, true, "guildPlace" );

}
	
public guildPlace( const target, const master, const obj, const x, const y, const z, const model, const deed )
{

	if( master<=INVALID ) return;
	
	if( chr_getProperty( master, CP_GUILD )!=INVALID ) {
		sysmessage( master, _, "Resign from your guild before creating a new guild" );
		return;
	}
	
#if defined( GUILD_POSITION_WITH_TARGET )
	if( x==INVALID || y==INVALID ) {
		sysmessage( master, _, "This is not a valid place" );
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

public guildgui_callback( const socket, const gui, const button )
{
	if( button<=MENU_CLOSED )
		return;

    new master = getCharFromSocket(socket);
    if( master<=INVALID ) return;

	if( chr_getProperty( master, CP_GUILD )!=INVALID ) {
		sysmessage( master, _, "Resign from your guild before creating a new guild" );
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
	
	new deed = gui_getProperty( gui, MP_BUFFER, 0 );
}



/*!
\author Doctor X
\fn guild_dclickStone( const guild, const socket )
\brief a guild stone double-click
*/
public guild_dclickStone( const guild, const socket ){
	
	const colorEdit = 32;
	new gui = gui_create( 40, 40, true, true, true, "guildDclick_callback" );
	gui_addGump( gui, 0, 0, 0x04CC, 0 );
	
	gui_setProperty( gui, MP_BUFFER, 0, guild );
	
	gui_addText( gui, 40, 30, colorEdit, "Recruit someone in the gild" );
	gui_addButton( gui, 20, 30, 0x4B9, 0x4BA, 1 );
	
	gui_addText( gui, 40, 60, colorEdit, "See the member list" );
	gui_addButton( gui, 20, 60, 0x4B9, 0x4BA, 1 );
	
	gui_addText( gui, 40, 90, colorEdit, "Reath the guild description" );
	gui_addButton( gui, 20, 90, 0x4B9, 0x4BA, 1 );
	
	gui_addText( gui, 40, 120, colorEdit, "Resign From Guild" );
	gui_addButton( gui, 20, 120, 0x4B9, 0x4BA, 1 );
	
	gui_addText( gui, 40, 150, colorEdit, "Read the candidates list" );
	gui_addButton( gui, 20, 150, 0x4B9, 0x4BA, 1 );
	
	gui_addText( gui, 40, 180, colorEdit, "Advanced Menu" );
	gui_addButton( gui, 20, 180, 0x4B9, 0x4BA, 1 );
	
	gui_addText( gui, 40, 210, colorEdit, "Read the guilds that are in war with you " );
	gui_addButton( gui, 20, 210, 0x4B9, 0x4BA, 1 );
	
	gui_addText( gui, 40, 240, colorEdit, "Read the guilds that you have declared war" );
	gui_addButton( gui, 20, 240, 0x4B9, 0x4BA, 1 );
	
	gui_show( gui, socket );
	
}

/*!
\author Endymion
\fn guild_sclickStone( const guild, const socket )
\brief a guild stone single-click
*/
public guild_sclickStone( const guild, const socket )
{
	new guildName[64];
	guild_getProperty( guild, GP_STR_NAME, _, guildName );
	sprintf( guildName, "Guildstone for %s", guildName );
	itm_speech( socket, guild, guildName );
	bypass();
}

/** @} */ // end of script_API_guild_various
