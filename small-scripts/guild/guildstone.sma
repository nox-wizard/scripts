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
\brief a guild deed double-click
\author Endymion
\fn guild_dclickDeed( const deed, const socket )
\param deed the guildstone deed
\param socket who click
*/
public guild_dclickDeed( const deed, const socket ) {

	if( s<=INVALID ) return;
    new master = getCharFromSocket(s);
    if( master<=INVALID ) return;

	if( chr_getProperty( master, CP_GUILD )!=INVALID ) {
		sysmsg( "Resign from your guild before creating a new guild" );
		return;
	}
	
	static fnGuildPlace =  funcidx("guildPlace");
	getTarget( socket, fnGuildPlace, "Where you want place guildstone?");

}

//if define guildstone place is get from target, else from player position
#define GUILD_POSITION_WITH_TARGET

public guildPlace( const s, const target, const item, const x, const y, const z ) {

	if( s<=INVALID ) return;	
	new master = getCharFromSocket(s);
	if( master<=INVALID ) return;
	
	if( chr_getProperty( master, CP_GUILD )!=INVALID ) {
		sysmsg( "Resign from your guild before creating a new guild" );
		return;
	}
	
#if defined( GUILD_POSITION_WITH_TARGET )
	if( x==INVALID || y==INVALID || z==INVALID ) {
		nprintf(s, "This is not a valid place", name);
		return;
	}
#endif
		
	new stone = itm_createByDef( "$item_guildstone" );
	guild_makeGuildstone( stone, master );
	
#if not defined( GUILD_POSITION_WITH_TARGET )
	x = chr_getProperty( master, CP_POSITION, CP_X );
	y = chr_getProperty( master, CP_POSITION, CP_Y );
	z = chr_getProperty( master, CP_POSITION, CP_Z );
#endif

	itm_setProperty( stone, IP_POSITION, IP_X, x );
	itm_setProperty( stone, IP_POSITION, IP_Y, y );
	itm_setProperty( stone, IP_POSITION, IP_Z, z );
	
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
	gui_guildStone( guild, getCharFromSocket( socket ) );
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
