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

/*!
\author Doctor X
\fn guild_dclickDeed( const deed, const socket )
\brief a guild deed double-click
*/
public guild_dclickDeed( const deed, const socket )
{
	//
	// get pc serial from socket
	//
	new pc = getCharFromSocket(socket)
	//
	// Create the guild
	//
	new stone = guild_placeStone( pc, deed );
	//
	// Start set guild title
	//
	gui_guildStone( stone, pc )
	//
	bypass();
}

/*!
\author Doctor X
\fn guild_dclickStone( const guild, const socket )
\brief a guild stone double-click
*/
public guild_dclickStone( const guild, const socket )
{
	//
	// show guildstone menu
	//
	gui_guildStone( guild, getCharFromSocket( socket ) );
	bypass();
}

/*!
\author Doctor X
\fn guild_sclickStone( const guild, const socket )
\brief a guild stone single-click
*/
public guild_sclickStone( const guild, const socket )
{
	new stringMode = getStringMode();
	//
	// switch to packed string mode
	//
	if( !stringMode )
		setStringMode( 1 );
	new guildName[64];
	guild_getProperty( guild, GP_NAME, _, guildName );
	sprintf( guildName, "Guildstone for %s", guildName );
	itm_speech( socket, guild, guildName );
	bypass();
	setStringMode( stringMode );
}

/** @} */ // end of script_API_guild_various
