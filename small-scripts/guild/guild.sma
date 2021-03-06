// for array with ranks and alignment names, please look into translation folder (small-scripts/translation/small_speech.sma)

public _createStdGuild( const stone, const master )
{
	new guild = guild_create( stone );

	if( chr_getProperty( master, CP_ID )==BODY_MALE )
		guild_addMember( guild, master, RANK_GUILDMASTER, 0, rank_male_name[ RANK_GUILDMASTER ][RANK_GUILDMASTER] );
	else
		guild_addMember( guild, master, RANK_GUILDMASTER, 0, rank_female_name[ RANK_GUILDMASTER ][RANK_GUILDMASTER] );

	return guild;
}

public	guildgui_show( const guild, const who )
{
	if( guild==INVALID )
		return;

	if( guild!=chr_getGuild( who ) )
		guildgui_notmember( guild, who );
	else
		guildgui_member( guild, who );

}

public guildgui_notmember( const guild, const who )
{
	new gui = gui_create( 40, 40, true, true, true, "guildgui_notmemberH" );
	gui_addGump( gui, 0, 0, 0x04CC, 0 );
	gui_setProperty( gui, MP_BUFFER, 0, guild );

	new name[100];
	guild_getProperty( guild, GP_STR_NAME, _, name );

	new abbr[100];
	guild_getProperty( guild, GP_STR_ABBREVIATION, _, abbr );

	gui_addText( gui, 20, 20, _, "Guild of %s [ %s ]", name, abbr );
	gui_show( gui, who );
}

public guildgui_member( const guild, const member )
{
	new gui = gui_create( 40, 40, true, true, true, "guildgui_notmemberH" );
	gui_addGump( gui, 0, 0, 0x04CC, 0 );
	gui_setProperty( gui, MP_BUFFER, 0, guild );

	new name[100];
	guild_getProperty( guild, GP_STR_NAME, _, name );

	new abbr[100];
	guild_getProperty( guild, GP_STR_ABBREVIATION, _, abbr );

	gui_addText( gui, 20, 20, _, "Guild of %s [ %s ]", name, abbr );
	gui_show( gui, member );

}

