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

	if( chr_getProperty( master, CP_GUILD )!=INVALID ) {
		nprintf( socket, "Resign from your guild before creating a new guild" );
		return;
	}
	
	static fnGuildPlace =  INVALID;
	if( fnGuildPlace==INVALID )
		fnGuildPlace=funcidx("guildPlace");
		
	getTarget( socket, fnGuildPlace, "Where you want place guildstone?");

}

public guildPlace( const s, const target, const item, const x, const y, const z ) {

	if( s<=INVALID ) return;	
	new master = getCharFromSocket(s);
	if( master<=INVALID ) return;
	
	if( chr_getProperty( master, CP_GUILD )!=INVALID ) {
		nprintf( s, "Resign from your guild before creating a new guild" );
		return;
	}
	
#if defined( GUILD_POSITION_WITH_TARGET )
	if( x==INVALID || y==INVALID || z==INVALID ) {
		nprintf(s, "This is not a valid place" );
		return;
	}
#endif
		
	new stone = itm_createByDef( "$item_guildstone" );
	guild_guildstone( stone, master );
	
#if defined( GUILD_POSITION_WHERE_PLAYER )
	x = chr_getProperty( master, CP_POSITION, CP2_X );
	y = chr_getProperty( master, CP_POSITION, CP2_Y );
	z = chr_getProperty( master, CP_POSITION, CP2_Z );
#endif

	itm_setProperty( stone, IP_POSITION, IP2_X, x );
	itm_setProperty( stone, IP_POSITION, IP2_Y, y );
	itm_setProperty( stone, IP_POSITION, IP2_Z, z );
	
	itm_setProperty( stone, IP_PRIV, _, 0 );
	
	itm_refresh( stone );
	
}

/*!
\author Doctor X
\fn guild_dclickStone( const guild, const socket )
\brief a guild stone double-click
*/
public guild_dclickStone( const guild, const socket )
{
	//show menu
	//gui_guildStone( guild, getCharFromSocket( socket ) );
	bypass();
}

/*!
\author Endymion
\fn guild_sclickStone( const guild, const socket )
\brief a guild stone single-click
*/
public guild_sclickStone( const guild, const socket )
{
	new guildName[64];
	guild_getProperty( guild, GP_NAME, _, guildName );
	sprintf( guildName, "Guildstone for %s", guildName );
	itm_speech( socket, guild, guildName );
	bypass();
}

/** @} */ // end of script_API_guild_various
