// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts                                                  ||
// || Created by DoctorX                                                    ||
// || Last Update 05-dec-2002                                             ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This file contains NoX-Wizard functions to support guildstone       ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

/**********************************************************************************************
 FUNCTION : createGuildStone
 AUTHOR   : DoctorX
 *********************************************************************************************/
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

/**********************************************************************************************
 FUNCTION : guildMenu
 AUTHOR   : DoctorX
 *********************************************************************************************/
public guild_dclickStone( const guild, const socket )
{
	//
	// show guildstone menu
	//
	gui_guildStone( guild, getCharFromSocket( socket ) );
	bypass();
}

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
