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
#include "small-scripts/API/guild/constant.sma"


#define RENAMEPRICE 40000
#define ABBREVPRICE 40000
#define ALIGNMENTPRICE 25000

#define GUILD_POLITICS_WAR 0
#define	GUILD_POLITICS_PEACE 1
#define	GUILD_POLITICS_ALLIED 2

//if define guildstone place is get from target, else from player position
#define GUILD_POSITION_WITH_TARGET

#if defined( GUILD_POSITION_WITH_TARGET )
#else
	#define GUILD_POSITION_WHERE_PLAYER
#endif

// Duplicate definition from guild/constants.sma, since small doesn't seem to handle static defs in include right

enum GUILD_RANK {
		RANK_GUILDMASTER=0,
		RANK_GUILDVICE,
		RANK_GUILDMEMBER,
		RANK_GUILDRECRUIT,
		ALL_RANKS
		};

static ranks[ALL_RANKS][] = { //rank name
	"GuildMaster",
	"GuildVice",
	"Member",
	"Recruit"
};

static rank_male_name[ALL_RANKS][] = {	//rank male name
	"GuildMaster",
	"Vice guild master",
	"Member",
	"Novice"
};

static rank_female_name[ALL_RANKS][] = {	//rank female name
	"Guild Mistress",
	"Vice guild mistress",
	"Member",
	"Novice"
};

enum GUILD_ALIGN {
	GUILD_NEUTRAL = 0,
	GUILD_CHAOS=1,
	GUILD_ORDER=2,
	GUILD_TOWN=3

};

static alignments[GUILD_TOWN][] = {
	"neutral",
	"chaotic",
	"lawful"
	};

/*!
\brief a guild deed double-click
\author Endymion
\fn guild_dclickDeed( const deed, const chr )
\param deed the guildstone deed
\param chr who click
*/
public guild_dclickDeed( const deed, const chr ) {

	new master = chr;
	if( master<=INVALID ) return;

	bypass();

	if( chr_getProperty( master, CP_GUILD ) > 0 ) {
		chr_message( master, _, "Resign from your guild before creating a new guild" );
		return;
	}

	chr_message( master, _, "Where do you want to place the guildstone?" );
	target_create( master, deed, _, true, "guildPlace" );

}

/*!
\author Endymion, modified by Wintermute
\fn guildPlace( const target, const master, const obj, const x, const y, const z, const model, const deed )
\param target: target location for the guildstone
\param master: Character serial who places the stone
\param obj: Unknown/Unused
\param x: X Position of target location
\param y: Y Position of target location
\param z: Z Position of target location
\param model: Unknown/Unused
\param deed: serial of the guildstone deed, used for placing
\brief callback method for placing a guildstone, checks for current membership of placing char in antoher guild and opens the naming gump
*/

public guildPlace( const target, const master, const obj, const x, const y, const z, const model, const deed )
{

	if( master<=INVALID ) return;
	if( (chr_getProperty( master, CP_GUILD ) > 0) && (! chr_isGMorCns(master)))
	{
		chr_message( master, _, "Resign from your guild before creating a new guild" );
		return;
	}
	printf("T: %d, M: %d, O: %d, x: %d, y: %d, z: %d, model: %d, deed: %d\n", target, master, obj, x, y, z, model, deed);
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
	gui_addResizeGump( gui, 0, 0,  0x0A28, 500, 200 );
	gui_setProperty( gui, MP_BUFFER, 0, deed );
	gui_setProperty( gui, MP_BUFFER, 1, x );
	gui_setProperty( gui, MP_BUFFER, 2, y );
	gui_setProperty( gui, MP_BUFFER, 3, z );
	gui_addButton( gui, 400, 160, 0x084A, 0x084B, 1 ); // apply
	gui_addButton( gui, 350, 160, 0x849,  0x847, 0, 1); // Cancel
	gui_addText( gui, 20, 30, _, "   Guild Name " );
	gui_addInputField( gui, 190, 30, 225, 30, 55, colorEdit, "Enter name");
	gui_addText( gui, 20, 70, _, "   Guild Short Name " );
	gui_addInputField( gui, 190, 70, 120, 30, 56, colorEdit, "Enter short name");
	gui_show( gui, master );
}

/*!
\author Endymion, modified by Wintermute
\fn guildgui_callback( const gui, const chr, const button )
\param chr: Character serial who places the stone
\param gui: serial of the menu
\param button: button id that was pressed
\brief callback method for placing a guildstone, checks for current membership of placing char in antoher guild and opens the naming gump
*/

public guildgui_callback( const gui, const chr, const button )
{
	if( button<=MENU_CLOSED )
		return;

	new master = chr;
	if( master<=INVALID )
		return;

	if( chr_getProperty( master, CP_GUILD ) > 0 && ! chr_isGMorCns(master))
	{
		chr_message( master, _, "Resign from your guild before creating a new guild" );
		return;
	}
	new name[150];
	gui_getProperty( gui, MP_UNI_TEXT, 55, name );

	new shortname[150];
	gui_getProperty( gui, MP_UNI_TEXT, 56, shortname );

	new stone = itm_createByDef( "$item_guildstone" );
	new guild = _createStdGuild( stone, master ); // create a standard guild.. see guild.sma
	guild_setProperty( guild, GP_STR_NAME, _, name );
	guild_setProperty( guild, GP_STR_ABBREVIATION, _, shortname );

	itm_setProperty( stone, IP_POSITION, IP2_X, gui_getProperty( gui, MP_BUFFER, 1 ) );
	itm_setProperty( stone, IP_POSITION, IP2_Y, gui_getProperty( gui, MP_BUFFER, 2 ) );
	itm_setProperty( stone, IP_POSITION, IP2_Z, gui_getProperty( gui, MP_BUFFER, 3 ) );

	itm_setProperty( stone, IP_PRIV, _, 0 );

	itm_refresh( stone );

	new deed = gui_getProperty( gui, MP_BUFFER, 0 );
	itm_remove(deed);

}

/*!
\author Wintermute
\fn getGuildMaster( const guild)
\param guild: guild serial to search for master
\brief helper function to obtain the guildmaster until it is available in the properties
*/

public getGuildMaster(const guild)
{
	new guildMemberSet=set_create();
	new member;
	set_addGuildMembers( guildMemberSet, guild );
	for ( set_rewind(guildMemberSet);!set_end(guildMemberSet);)
	{
		member=set_get(guildMemberSet);
		new rank = gmember_getProperty(member, GMP_RANK, _ );
		if ( rank == 0 )
		{
			return member;
		}
	}
	return -1;
}

/*!
\author Tuzzi, modified by Wintermute
\fn guild_dclickStone( const guild, const chr )
\brief a guild stone double-click, opens the guild menu gump
*/
public guild_dclickStone( const guild, const chr )
{
	bypass();

	const colorEdit = 32;
	new gui = gui_create( 40, 40, true, true, true, "guildDclick_cback" );
	gui_addResizeGump( gui, 0, 0, 0x0A28, 420, 400 );

	gui_setProperty( gui, MP_BUFFER, 0, guild );
	new guildName[60];
	new ypos;

	guild_getProperty( guild, GP_STR_NAME, _, guildName );
	new master = getGuildMaster(guild)
	if ( master > 0 )
	{
		new nameMaster[30];
		chr_getProperty(master, CP_STR_NAME, _, nameMaster);
		if ( chr_getProperty(master, CP_ID) == BODY_FEMALE || chr_getProperty(master, CP_ID) == BODY_DEADFEMALE )
			sprintf( guildName, "%s, %s %s", guildName , rank_female_name[0], nameMaster);
		else
			sprintf( guildName, "%s, %s %s", guildName, rank_male_name[0], nameMaster );
		gui_addText( gui, 45, 20, colorEdit, guildName );
	}
	else
	{
		// if the master cannot be found, the klicking char becomes guildmaster
		if( chr_getProperty( master, CP_ID )==BODY_MALE )
		{
			guild_addMember( guild, master, RANK_GUILDMASTER, 0, rank_male_name[ RANK_GUILDMASTER ][RANK_GUILDMASTER] );
		}
		else
		{
			guild_addMember( guild, master, RANK_GUILDMASTER, 0, rank_female_name[ RANK_GUILDMASTER ][RANK_GUILDMASTER] );
		}

		gui_addText( gui, 45, 20, colorEdit, "GuildStone Menu" );
	}
	// View the current roster
	ypos=59;
	gui_addText( gui, 45, ypos, _, "View the current roster" );
	gui_addButton( gui, 25, ypos, 0x4B9, 0x4BA, 1 );
	ypos += 30;
	// View the guild's charter
	gui_addText( gui, 45, ypos, _, "View the guild description" );
	gui_addButton( gui, 25, ypos, 0x4B9, 0x4BA, 2 );
	if (( chr_getProperty(chr, CP_GUILD) == guild ) || chr_isGMorCns(chr) )
	{
		// This char is a member of the guild and can recruit people
		ypos += 30;
		gui_addText( gui, 45, ypos, _, "Recruit someone into the guild" );
		gui_addButton( gui, 25, ypos, 0x4B9, 0x4BA, 3 );
		ypos += 30;
		// declare your fealty
		gui_addText( gui, 45, ypos, _, "Declare your fealty" );
		gui_addButton( gui, 25, ypos, 0x4B9, 0x4BA, 4 );
		ypos += 30;
		// Show guild abbreviation
		gui_addText( gui, 45, ypos, _, "Toggle showing guild abbreviation" );
		gui_addButton( gui, 25, ypos, 0x4B9, 0x4BA, 5 );
		ypos += 30;
		// Resign from guild
		gui_addText( gui, 45, ypos, _, "Resign From Guild" );
		gui_addButton( gui, 25, ypos, 0x4B9, 0x4BA, 6 );
		ypos += 30;
		// View candidates
		gui_addText( gui, 45,ypos, _, "View  the candidates list" );
		gui_addButton( gui, 25, ypos, 0x4B9, 0x4BA, 7 );
	}
	ypos += 30;
	gui_addText( gui, 45, ypos, _, "View the guilds that are at war with this guild " );
	gui_addButton( gui, 25, ypos, 0x4B9, 0x4BA, 8 );

//	ypos += 30;
//	gui_addText( gui, 45, ypos, _, "View the guilds that war has been declared on" );
//	gui_addButton( gui, 25, ypos, 0x4B9, 0x4BA, 9 );
	ypos += 30;
	if ((chr_getProperty(chr, CP_GUILD) == guild) && ( gmember_getProperty(chr, GMP_RANK, _) == RANK_GUILDMASTER ) || chr_isGMorCns(chr) )
	{
		gui_addText( gui, 45, ypos, _, "Access guild master menu" );
		gui_addButton( gui, 25, ypos, 0x4B9, 0x4BA, 10 );
	}
	gui_show( gui, chr );

}

/*!
\author Wintermute
\fn guildDclick_cback( const gui, const chr, const button )
\param chr: Character serial who places the stone
\param gui: serial of the menu
\param button: button id that was pressed
\brief callback method for the guild menu, calling the approbriate sub methods
*/

public guildDclick_cback( const gui, const chr, const button )
{
	new guild = gui_getProperty( gui, MP_BUFFER, 0 );

	switch(button){
		case 0: return;

		case 1:
		{
			guild_viewRoster(chr, guild);
			return;
		}
		case 2:
		{
			guild_viewDesc(chr, guild);
			return;
		}
		case 3:
		{
			guildRecruitNew(chr, guild);
			return;
		}
		case 4:
		{
			declareFealty(chr, guild);
			return;
		}
		case 5:
		{
			toggleAbbreviation(chr, guild);
			return;
		}
		case 6:
		{
			resignGuild(chr, guild);
			return;
		}
		case 7:
		{
			viewCandidatesList(chr, guild);
			return;
		}
		case 8:
		{
			viewGuildAtWar(chr, guild);
			return;
		}
		case 9: return;
		case 10:
			guildmasterMenu(chr, guild);
		default:
		{
			chr_message(chr, _, "Something gone wrong!");
			return;
		}
	}
}

/*!
\author Wintermute
\fn viewCB( const gui, const chr, const button )
\param chr: Character serial who places the stone
\param gui: serial of the menu
\param button: button id that was pressed
\brief common callback method for the guild menu, called for all view xxx dialogs
*/

public viewCB( const gui, const chr, const button )
{
	new guild = gui_getProperty( gui, MP_BUFFER, 0 );

	switch(button)
	{
		case 0: return;
		case 1:
			guild_dclickStone(guild, chr);
	}
}

/*!
\author Wintermute
\fn viewCB( const gui, const chr, const button )
\param chr: Character serial who places the stone
\param gui: serial of the menu
\param button: button id that was pressed
\brief common callback method for the guild menu, called for all view xxx dialogs
*/

public guild_viewRoster(const chr, const guild)
{
	new gui = gui_create( 40, 40, true, true, true, "viewCB" );
	gui_addResizeGump( gui, 0, 0, 0x0A28, 420, 400);
	gui_setProperty( gui, MP_BUFFER, 0, guild );
	const colorEdit = 32;
	gui_addText( gui, 45, 25, colorEdit, "Current Roster");
	gui_addButton(gui, 330, 350, 0xf9, 0xf7, 1); // ok button
	new guildMemberSet=set_create();
	new member;
	new membername[30];
	new rank;
	new position;
	new pageMembers [10];
	set_addGuildMembers( guildMemberSet, guild );
	for ( new page=1;(page-1)*10<set_size(guildMemberSet);++page)
	{
		gui_addPage(gui, page);
		for ( set_rewind(guildMemberSet);!set_end(guildMemberSet);)
		{
			member=set_get(guildMemberSet);
			rank = gmember_getProperty(member, GMP_RANK);
			if ((  rank == RANK_GUILDMASTER ) && page == 1 ) // only put Guildmaster on position 1
			{
				pageMembers[0]=member;
			}
			else if 	( rank != RANK_GUILDMASTER )
			{
				pageMembers[position++]=member;
			}
		}
		for ( new i=0;i< 10; ++i)
		{
			if ( pageMembers[i] <= 0)
			{
				if ( page == 1 && i == 0 )
				{
					new master=getGuildMaster(guild);
					if ( master < 0 )
						return;
					chr_getProperty(master, CP_STR_NAME, _, membername);
				}
				else
					break; // no more members
			}
			chr_getProperty(member, CP_STR_NAME, _, membername);
			gui_addText( gui, 25, 55+i*30, _, membername);
		}
		if ( page < set_size(guildMemberSet)/10+1)
			gui_addPageButton(gui, 330, 365, 0x1458, 0x1458, page + 1)
		if ( page > 1 )
			gui_addPageButton(gui, 310, 365, 0x1458, 0x1458, page + 1)
	}
	gui_show( gui, chr );
}

public guild_viewDesc(const chr, const guild)
{
	new gui = gui_create( 40, 40, true, true, true, "viewCB" );
	gui_setProperty( gui, MP_BUFFER, 0, guild );
	gui_addResizeGump( gui, 0, 0, 0x0A28, 420, 400);
	gui_addButton(gui, 330, 350, 0xf9, 0xf7, 1); // ok button
	new charter[500];
	guild_getProperty(guild, GP_UNI_CHARTER, _, charter);
	for ( new i=1;i<=10;i++)
	{
		new charterline[31];
		strncpy( charterline, charter[(i-1)*30], 30 )
		gui_addText( gui, 40, 40+i*25, _, charterline );
	}
	gui_show( gui, chr );
}

public guildRecruitNew(const chr, const guild)
{
	// just being paranoid
	if (( chr_getProperty(chr, CP_GUILD) != guild) && ( ! chr_isGMorCns(chr) ))
	{
		chr_message(chr, _, "You cannot recruit people for other guilds ! ");
		return;
	}
	chr_message(chr, _, "Who do you want to recruit into the guild ?");
	target_create(chr,0,0,true,"addRecruit");
}

public addRecruit(const targetNum, const chr, const target, const x, const y, const z, const model, const param1 )
{
	if ( isItem(target) > 0 )
	{
		chr_message(chr, _, "You cannot recruit items ! ");
		return;
	}
	if ( isChar(target) > 0 )
	{
		if ( chr_getProperty(target, CP_NPC) > 0 )
		{
			chr_message(chr, _, "You cannot recruit npcs ! ");
			return;
		}
		if ( chr_getProperty(target, CP_GUILD) > 0 )
		{
			if ( chr_getProperty(target, CP_ID) == BODY_FEMALE || chr_getProperty(target, CP_ID) == BODY_DEADFEMALE )
				chr_message(chr, _, "She has to resign from her old guild first ! ");
			else
				chr_message(chr, _, "He has to resign from his old guild first ! ");
			return;
		}
		guild_addRecruit( chr_getProperty(chr, CP_GUILD), target, chr );
		if ( chr_getProperty(target, CP_ID) == BODY_FEMALE || chr_getProperty(target, CP_ID) == BODY_DEADFEMALE )
			chr_message(chr, _, "She has been added into your guild ! ");
		else
			chr_message(chr, _, "He has been added into your guild ! ");
	}
}

public declareFealty(const chr, const guild)
{
	new gui = gui_create( 40, 40, true, true, true, "fealtyCB" );
	gui_addResizeGump( gui, 0, 0, 0x0A28, 420, 400);
	gui_setProperty( gui, MP_BUFFER, 0, guild );
	const colorEdit = 32;
	gui_addText( gui, 45, 25, colorEdit, "Current Roster");
	gui_addButton(gui, 330, 350, 0xf9, 0xf7, 1); // ok button
	new guildMemberSet=set_create();
	new member;
	new membername[30];
	new page=0;
	set_addGuildMembers( guildMemberSet, guild );
	for ( set_rewind(guildMemberSet);!set_end(guildMemberSet);)
	{
		gui_addPage(gui, ++page);
		for ( new i=1;i < 10;++i)
		{
			member=set_get(guildMemberSet);
			chr_getProperty(member, CP_STR_NAME, _, membername);
			gui_addButton( gui, 25, 25+i*30, 0x4B9, 0x4BA, guild_getMemberIdx(guild, member) ); // Use internal numbering
			gui_addText( gui, 55, 20+i*30, _, membername);
			if ( set_end(guildMemberSet) )
				break;
		}
		if ( page < set_size(guildMemberSet)/10+1)
			gui_addPageButton(gui, 330, 365, 0x1458, 0x1458, page + 1)
		if ( page > 1 )
			gui_addPageButton(gui, 310, 365, 0x1458, 0x1458, page + 1)
	}
	gui_show( gui, chr );
}

public fealtyCB( const gui, const chr, const button )
{
	switch(button)
	{
		case 0:
			return;
		default:
			gmember_setProperty(chr, GMP_FEALTY, _, guild_memberAtIndex(gui_getProperty( gui, MP_BUFFER, 0 ), button));
	}
}

public toggleAbbreviation(const chr, const guild)
{
	if ( chr_getProperty(chr, CP_GUILD) < 0 )
	{
		chr_message(chr, _, "You are not currently a member of a guild!");
		return;
	}
	new status = gmember_getProperty(chr, GMP_TITLETOGGLE);
	if ( status < 0 )
		return;
	status = ! status;
	gmember_setProperty(chr, GMP_TITLETOGGLE,_,status);
}

public resignGuild(const chr, const guild)
{
	if ( chr_getProperty(chr, CP_GUILD) < 0 )
	{
		chr_message(chr, _, "You are not currently a member of a guild!");
		return;
	}
	new guildMemberSet=set_create();
	set_addGuildMembers( guildMemberSet, guild );
	if ( set_size(guildMemberSet) == 1 )
	{
		chr_message(chr, _, "You are the last member, the guild will be removed!");
		guild_resignMember (guild, chr);
		new stone = guild_getProperty(guild, GP_STONE);
		guild_remove(guild);
		itm_remove(stone);

	}
	else
		guild_resignMember (guild, chr);
	chr_message(chr, _, "You resigned from your guild");
}

public viewCandidatesList(const chr, const guild)
{
	new gui = gui_create( 40, 40, true, true, true, "viewCB" );
	gui_addResizeGump( gui, 0, 0, 0x0A28, 420, 400);
	gui_setProperty( gui, MP_BUFFER, 0, guild );
	const colorEdit = 32;
	gui_addText( gui, 45, 25, colorEdit, "Candidates applying for membership");
	gui_addButton(gui, 330, 350, 0xf9, 0xf7, 1); // ok button
	new guildMemberSet=set_create();
	new member;
	new membername[30];
	new page;
	set_addGuildRecruit( guildMemberSet, guild );
	for ( set_rewind(guildMemberSet);!set_end(guildMemberSet);)
	{
		gui_addPage(gui, ++page);
		for ( new i=1;i < 10;++i)
		{
			member=set_get(guildMemberSet);
			chr_getProperty(member, CP_STR_NAME, _, membername);
			gui_addText( gui, 25, 55+i*30, _, membername);
			if ( set_end(guildMemberSet))
				break;
		}
		if ( page < set_size(guildMemberSet)/10+1)
			gui_addPageButton(gui, 330, 365, 0x1458, 0x1458, page + 1)
		if ( page > 1 )
			gui_addPageButton(gui, 310, 365, 0x1458, 0x1458, page + 1)
	}
	// OK Button
	gui_show( gui, chr );
}

public viewGuildAtWar(const chr, const guild)
{
	new gui = gui_create( 40, 40, true, true, true, "viewCB" );
	gui_addResizeGump( gui, 0, 0, 0x0A28, 420, 400);
	gui_setProperty( gui, MP_BUFFER, 0, guild );
	const colorEdit = 32;
	gui_addText( gui, 45, 25, colorEdit, "Guilds that are at war with this guild");
	gui_addButton(gui, 330, 350, 0xf9, 0xf7, 1); // ok button
	new member;
	new membername[30];
	new page;
	new guildMemberSet=set_create();
	set_addGuilds( guildMemberSet, guild, GUILD_POLITICS_WAR );
	// set_addGuilds( guildMemberSet, guild);
	for ( set_rewind(guildMemberSet);!set_end(guildMemberSet);)
	{
		gui_addPage(gui, ++page);
		for ( new i=1;i < 10;++i)
		{
			member=set_get(guildMemberSet);

			guild_getProperty(member, GP_STR_NAME, _, membername);

			gui_addText( gui, 25, 55+i*30, _, membername);
			if ( set_end(guildMemberSet))
				break;
		}
		if ( page < set_size(guildMemberSet)/10+1)
			gui_addPageButton(gui, 330, 365, 0x1458, 0x1458, page + 1)
		if ( page > 1 )
			gui_addPageButton(gui, 310, 365, 0x1458, 0x1458, page + 1)
	}
	gui_show( gui, chr );
}

public guildmasterMenu(const chr, const guild)
{
	new gui = gui_create( 40, 40, true, true, true, "guildMasterMenuCB" );
	gui_addResizeGump( gui, 0, 0, 0x0A28, 420, 400 );
	new name[60];
	gui_setProperty( gui, MP_BUFFER, 0 , guild);

	new ypos=15;
	guild_getProperty( guild, GP_STR_NAME, _, name );
	new master = getGuildMaster(guild)
	if ( master > 0 )
	{
		new nameMaster[30];
		chr_getProperty(master, CP_STR_NAME, _, nameMaster);
		if ( chr_getProperty(master, CP_ID) == BODY_FEMALE || chr_getProperty(master, CP_ID) == BODY_DEADFEMALE )
			sprintf( name, "%s, %s %s", name , rank_female_name[0], nameMaster);
		else
			sprintf( name, "%s, %s %s", name, rank_male_name[0], nameMaster );
		gui_addText( gui, 45, ypos, _, name );
	}
	else
		gui_addText( gui, 45, ypos, _, "Guild Master Menu" );
	// change guildname
	ypos+=20;
	gui_addText( gui, 45, ypos, _, "Set the guild name." );
	gui_addButton( gui, 25, ypos, 0x4B9, 0x4BA, 1 );

	ypos+=30;
	gui_addText( gui, 45, ypos, _, "Set the guilds abbreviation." );
	gui_addButton( gui, 25, ypos, 0x4B9, 0x4BA, 2 );

	ypos+=30;
	new alignment = guild_getProperty(guild, GP_TYPE, _);
	sprintf(name, "Change the alignment of guild. (currently %s)" , alignments[GUILD_ALIGN:alignment][0]);
	gui_addText( gui, 45, ypos, _,  name);
	gui_addButton( gui, 25, ypos, 0x4B9, 0x4BA, 3 );

	ypos+=30;
	gui_addText( gui, 45, ypos, _, "Set the guild's charter." );
	gui_addButton( gui, 25, ypos, 0x4B9, 0x4BA, 4 );

	ypos+=30;
	gui_addText( gui, 45, ypos, _, "Dismiss a member." );
	gui_addButton( gui, 25, ypos, 0x4B9, 0x4BA, 5 );

	ypos+=30;
	gui_addText( gui, 45, ypos, _, "Declare war." );
	gui_addButton( gui, 25, ypos, 0x4B9, 0x4BA, 6 );

	ypos+=30;
	gui_addText( gui, 45, ypos, _, "Declare peace." );
	gui_addButton( gui, 25, ypos, 0x4B9, 0x4BA, 7 );

	ypos+=30;
	gui_addText( gui, 45, ypos, _, "Accept a candidate seeking membership." );
	gui_addButton( gui, 25, ypos, 0x4B9, 0x4BA, 8 );

	ypos+=30;
	gui_addText( gui, 45, ypos, _, "Refuse a candidate seeking membership." );
	gui_addButton( gui, 25, ypos, 0x4B9, 0x4BA, 9 );

	ypos+=30;
	gui_addText( gui, 45, ypos, _, "Grant a title to a member" );
	gui_addButton( gui, 25, ypos, 0x4B9, 0x4BA, 10 );

	// Issue Chaos or Order Shields
	if ((guild_getProperty(guild, GP_TYPE, _) == GUILD_TYPE_CHAOS ) || (guild_getProperty(guild, GP_TYPE, _) == GUILD_TYPE_ORDER ))
	{
		ypos+=30;
		gui_addText( gui, 45, ypos, _, "Issue guild alignment shields" );
		gui_addButton( gui, 25, ypos, 0x4B9, 0x4BA, 11 );
	}
	// Return to main menu.
	ypos+=30;
	gui_addText( gui, 45, ypos, _, "Return to main menu" );
	gui_addButton( gui, 25, ypos, 0x4B9, 0x4BA, 12 );

	gui_show( gui, chr );
}

public guildMasterMenuCB( const gui, const chr, const buttonCode )
{
	new guild = gui_getProperty( gui, MP_BUFFER, 0 );

	switch ( buttonCode)
	{
		case 1:
			renameGuild(chr, guild);
		case 2:
			changeAbbreviation(chr, guild);
		case 3:
			changeAlignment(chr, guild);
		case 4:
			setCharter(chr, guild);
		case 5:
			dismissMember(chr, guild);
		case 6:
			declareWar(chr, guild);
		case 7:
			declarePeace(chr, guild);
		case 8:
			acceptMember(chr, guild);
		case 9:
			refuseCandidate(chr, guild);
		case 10:
			setMemberTitle(chr, guild);
		case 11:
			issueGuildShields(chr, guild);
		case 12:
			guild_dclickStone(guild, chr);
	}

}

public renameGuild(const chr, const guild)
{
	new gui = gui_create( 40, 40, true, true, true, "renameGuildCB" );
	gui_addResizeGump( gui, 0, 0,  0x0A28, 400, 140 );

	new guildName[60];
	gui_setProperty( gui, MP_BUFFER, 0 , guild);
	gui_addText( gui, 45, 29, _, "Guild renaming will cost you %d gp", RENAMEPRICE );
	gui_addText( gui, 45, 59, _, "What shall be the new name of the guild ?" );
	gui_addInputField( gui,  45,  90, 150, 30, 1, 0, guildName);
	// Cancel Button plazieren
	gui_addButton( gui, 230, 95, 0xf3, 0xf1, 0, 1);
	// OK Button
	gui_addButton( gui, 300, 95, 0xf9, 0xf7, 1, 1);
	gui_show( gui, chr );

}

public renameGuildCB(const gui, const chr, const buttonCode)
{
	new guild = gui_getProperty( gui, MP_BUFFER, 0 );
	if ( buttonCode == 1 )
	{
		new name [60];
		new guildName[60];
		guild_getProperty(guild, GP_STR_ABBREVIATION, _, guildName);
		gui_getProperty(gui, MP_UNI_TEXT, 1, name);
		if ( strcmp(name, guildName) == 0 )
			return; // name wasn't changed
		if ( chr_countGold(chr) > RENAMEPRICE )
		{
			itm_delAmountByID(chr_getBackpack(chr), RENAMEPRICE, getIntFromDefine("$item_gold_coin"));
		}
		else if ( chr_countBankGold(chr) > RENAMEPRICE )
		{
			itm_delAmountByID(chr_getBankBox(chr, 0), RENAMEPRICE, getIntFromDefine("$item_gold_coin"));
		}
		else if (! chr_isGMorCns(chr))
		{
			chr_message(chr,_,"You need %d gold coins.", RENAMEPRICE );
			return;
		}
		guild_setProperty(guild, GP_STR_NAME, _, name);
	}
	guildmasterMenu(chr, guild);
}

public changeAbbreviation(const chr, const guild)
{
	new gui = gui_create( 40, 40, true, true, true, "changeAbbrevCB" );
	gui_addResizeGump( gui, 0, 0,  0x0A28, 400, 140 );

	new guildAbbrev[60];
	guild_getProperty(guild, GP_STR_ABBREVIATION, _, guildAbbrev );
	gui_setProperty( gui, MP_BUFFER, 0 , guild);
	gui_addText( gui, 45, 29, _, "Changing the abbreviation will cost you %d gp", ABBREVPRICE );
	gui_addText( gui, 45, 59, _, "What shall be the new name of the guild ?" );
	gui_addInputField( gui,  45,  90, 150, 30, 1, 0, guildAbbrev);
	// Cancel Button plazieren
	gui_addButton( gui, 230, 95, 0xf3, 0xf1, 0, 1);
	// OK Button
	gui_addButton( gui, 300, 95, 0xf9, 0xf7, 1, 1);
	gui_show( gui, chr );
}

public changeAbbrevCB(const gui, const chr, const buttonCode)
{
	new guild = gui_getProperty( gui, MP_BUFFER, 0 );
	if ( buttonCode == 1 )
	{
		new name [60];
		new oldAbbrev[60];
		guild_getProperty(guild, GP_STR_ABBREVIATION, _, oldAbbrev);
		gui_getProperty(gui, MP_UNI_TEXT, 1, name);
		if ( strcmp(name, oldAbbrev) == 0 )
			return; // name wasn't changed
		if ( chr_countGold(chr) > ABBREVPRICE )
		{
			itm_delAmountByID(chr_getBackpack(chr), ABBREVPRICE, getIntFromDefine("$item_gold_coin"));
		}
		else if ( chr_countBankGold(chr) > ABBREVPRICE )
		{
			itm_delAmountByID(chr_getBankBox(chr, 0), ABBREVPRICE, getIntFromDefine("$item_gold_coin"));
		}
		else if (! chr_isGMorCns(chr))
		{
			chr_message(chr,_,"You need %d gold coins.", ABBREVPRICE );
			return;
		}
		guild_setProperty(guild, GP_STR_ABBREVIATION, _, name);
	}
	guildmasterMenu(chr, guild);
}

public changeAlignment(const chr, const guild)
{
	new gui = gui_create( 40, 40, true, true, true, "changeAlignCB" );
	gui_addResizeGump( gui, 0, 0,  0x0A28, 450, 200 );

	new guildName[60];
	guild_getProperty(guild, GP_STR_NAME, _, guildName );
	gui_setProperty( gui, MP_BUFFER, 0 , guild);
	gui_addText( gui, 45, 29, _, "Changing the alignment will cost you %d gp", ALIGNMENTPRICE );
	gui_addText( gui, 85, 75, _, "Neutral" );
	gui_addButton( gui, 45, 75, 0x4B9, 0x4BA, 1 );
	gui_addText( gui, 85, 105, _, "Order" );
	gui_addButton( gui, 45, 105, 0x4B9, 0x4BA, 3 );
	gui_addText( gui, 85, 135, _, "Chaos" );
	gui_addButton( gui, 45, 135, 0x4B9, 0x4BA, 2 );
	// Cancel Button plazieren
	gui_addButton( gui, 350, 160, 0xf3, 0xf1, 0, 1);
	gui_show( gui, chr );

}

public changeAlignCB(const gui, const chr, const buttonCode)
{
	new guild = gui_getProperty( gui, MP_BUFFER, 0 );
	if ( buttonCode >= 1 )
	{
		if ( chr_countGold(chr) > ALIGNMENTPRICE )
		{
			itm_delAmountByID(chr_getBackpack(chr), ALIGNMENTPRICE, getIntFromDefine("$item_gold_coin"));
		}
		else if ( chr_countBankGold(chr) > ALIGNMENTPRICE )
		{
			itm_delAmountByID(chr_getBankBox(chr, 0), ALIGNMENTPRICE, getIntFromDefine("$item_gold_coin"));
		}
		else if (! chr_isGMorCns(chr))
		{
			chr_message(chr,_,"You need %d gold coins.", ALIGNMENTPRICE );
			return;
		}
		guild_setProperty(guild, GP_TYPE, _, buttonCode -1);
	}
	guildmasterMenu(chr, guild);
}

public setCharter(const chr, const guild)
{
	new gui = gui_create( 40, 40, true, true, true, "setCharterCB" );
	gui_setProperty( gui, MP_BUFFER, 0 , guild);
	gui_addResizeGump( gui, 0, 0, 0x0A28, 420, 400);
	gui_addText( gui, 115, 10, _, "Set guild charter and web link");
	new charter[500];
	guild_getProperty(guild, GP_UNI_CHARTER, _, charter);
	new charterline[31];
	for ( new i=1;i<=10;i++)
	{
		strncpy( charterline, charter[(i-1)*30], 31 )
		gui_addResizeGump( gui, 40,40+i*25, 5054,300,20);
		gui_addInputField( gui, 40, 40+i*25, 340, 20, i, _, charterline );
	}
	// Cancel Button plazieren
	gui_addButton( gui, 260, 350, 0xf3, 0xf1, 0, 1);
	// OK Button
	gui_addButton( gui, 320, 350, 0xf9, 0xf7, 1, 1);
	gui_show( gui, chr );
}

public setCharterCB(const gui, const chr, const buttonCode)
{
	new guild = gui_getProperty( gui, MP_BUFFER, 0 );
	if ( buttonCode == 1)
	{
		new charter[500];
		new charterline[500];
		new realline[31];
		gui_getProperty( gui, MP_UNI_TEXT, 1, charterline);
		strncpy( charter, charterline, 30 )
		for ( new i=2;i<=10;i++)
		{
			gui_getProperty( gui, MP_UNI_TEXT, i, charterline);
			strncpy( realline, charterline, 30 )
			sprintf(charter, "%s%s", charter, realline);
		}
		guild_setProperty(guild, GP_UNI_CHARTER, _, charter);
	}
	guildmasterMenu(chr, guild);
}

public dismissMember(const chr, const guild)
{
	new gui = gui_create( 40, 40, true, true, true, "dismissMemberCB" );
	gui_addResizeGump( gui, 0, 0,  0x0A28, 500, 200 );
	gui_setProperty( gui, MP_BUFFER, 0 , guild);

	new guildMemberSet=set_create();
	new membername[50];
	new page;
	new member;

	set_addGuildMembers( guildMemberSet, guild );
	for ( set_rewind(guildMemberSet);!set_end(guildMemberSet);)
	{
		gui_addPage(gui, ++page);
		for ( new i=1;i < 10;++i)
		{
			member=set_get(guildMemberSet);
			if ( set_end(guildMemberSet))
				break;
			if ( member == chr )
				continue;
			chr_getProperty(member, CP_STR_NAME, _, membername);
			gui_addText( gui, 65, 55+i*30, _, membername);
			gui_addButton( gui, 25, 55+i*30, 0x4B9, 0x4BA, guild_getMemberIdx (guild,  member) );
		}
		if ( page < set_size(guildMemberSet)/10+1)
			gui_addPageButton(gui, 330, 365, 0x1458, 0x1458, page + 1);
		if ( page > 1 )
			gui_addPageButton(gui, 310, 365, 0x1458, 0x1458, page + 1);
	}
	set_delete(guildMemberSet);
	// Cancel Button plazieren
	gui_addButton( gui, 300, 120, 0xf3, 0xf1, 0, 1);
	gui_show( gui, chr );
}

public dismissMemberCB(const gui, const chr, const buttonCode)
{
	new guild = gui_getProperty( gui, MP_BUFFER, 0 );
	if ( buttonCode > 0 )
	{
		new dismissedMember=guild_memberAtIndex ( guild,  buttonCode);
		guild_resignMember ( guild,  dismissedMember);
	}
	guildmasterMenu(chr, guild);
}

public declareWar(const chr, const guild)
{
	new gui = gui_create( 40, 40, true, true, true, "declareWarCB" );
	gui_addResizeGump( gui, 0, 0,  0x0A28, 400, 350 );
	gui_setProperty( gui, MP_BUFFER, 0 , guild);

	new guildSet=set_create();
	new page;
	new member;
	new membername[50];
	set_addGuilds( guildSet);
	for ( set_rewind(guildSet);!set_end(guildSet);)
	{
		gui_addPage(gui, ++page);
		new i = 1;
		new guildIndex=0;
		while ( i <= 10)
		{
			member=set_get(guildSet);
			guildIndex++;
			if ( ! guild_hasWarWith(guild, member) && guild != member)
			{
				guild_getProperty(member, GP_STR_NAME, _, membername);
				gui_addButton( gui, 25, 25+i*30, 0x4B9, 0x4BA, page*10+guildIndex ); // Buttons start at 10
				gui_addText( gui, 55, 25+i*30, _, membername);
				i++;
			}
			if ( set_end(guildSet) )
				break;
		}
		if ( page < set_size(guildSet)/10+1)
			gui_addPageButton(gui, 330, 365, 0x1458, 0x1458, page + 1);
		if ( page > 1 )
			gui_addPageButton(gui, 310, 365, 0x1458, 0x1458, page + 1);
	}
	// Cancel Button plazieren
	gui_addButton( gui, 300, 180, 0xf3, 0xf1, 0, 1);
	gui_show( gui, chr );
}

public declareWarCB(const gui, const chr, const buttonCode)
{
	new guild = gui_getProperty( gui, MP_BUFFER, 0 );
	if ( buttonCode >= 10 )
	{
		new guildSet=set_create();
		new guildAtWar=INVALID;
		new count=10;
		// Searching through list of guilds, hopefully they didn't change in the meantime
		// Better would be storing the guild serial with the button code, but how to store it ?
		set_addGuilds( guildSet);
		for ( set_rewind(guildSet);!set_end(guildSet);)
		{
			count++;
			guildAtWar=set_get(guildSet);
			if ( count==buttonCode )
			{
				if ( ! guild_hasWarWith(guild, guildAtWar) && guild != guildAtWar)
				{
					guild_setProperty(guild, GP_WAR, _, guildAtWar);
					guild_setProperty(guildAtWar, GP_WAR, _, guild);
					break;
				}
			}
		}
		set_delete(guildSet);
	}
	guildmasterMenu(chr, guild);
}

public declarePeace(const chr, const guild)
{
	new gui = gui_create( 40, 40, true, true, true, "declarePeaceCB" );
	gui_addResizeGump( gui, 0, 0,  0x0A28, 400, 250 );
	gui_setProperty( gui, MP_BUFFER, 0 , guild);

	new guildSet=set_create();
	new page;
	new member;
	new membername[50];
	set_addGuilds( guildSet, guild, GUILD_POLITICS_WAR );
	// set_addGuilds( guildSet, guild);
	for ( set_rewind(guildSet);!set_end(guildSet);)
	{
		gui_addPage(gui, ++page);
		new guildIndex=0;
		new i=1;
		while ( i <= 10)
		{
			member=set_get(guildSet);
			guildIndex++;
			if ( ! guild_hasPeaceWith(guild, member) && guild != member)
			{
				guild_getProperty(member, GP_STR_NAME, _, membername);
				chr_message(chr, _, "Have Guild %s Adding index %d", membername, guildIndex );
				gui_addButton( gui, 25, 55+i*30, 0x4B9, 0x4BA, page*10+guildIndex ); // Buttons start at 10
				gui_addText( gui, 55, 55+i*30, _, membername);
				i++;
			}
			if ( set_end(guildSet) )
				break;
		}
		if ( page < set_size(guildSet)/10+1)
			gui_addPageButton(gui, 330, 365, 0x1458, 0x1458, page + 1);
		if ( page > 1 )
			gui_addPageButton(gui, 310, 365, 0x1458, 0x1458, page + 1);
	}
	// Cancel Button plazieren
	gui_addButton( gui, 300, 180, 0xf3, 0xf1, 0, 1);
	gui_show( gui, chr );
}

public declarePeaceCB(const gui, const chr, const buttonCode)
{
	new guild = gui_getProperty( gui, MP_BUFFER, 0 );

	if ( buttonCode >= 10 )
	{
		new guildSet=set_create();
		new guildAtWar=INVALID;
		new count=10;
		// Searching through list of guilds, hopefully they didn't change in the meantime
		// Better would be storing the guild serial with the button code, but how to store it ?
		set_addGuilds( guildSet, guild, GUILD_POLITICS_WAR);
		for ( set_rewind(guildSet);!set_end(guildSet);)
		{
			count++;
			guildAtWar=set_get(guildSet);
			if ( count==buttonCode )
			{
				guild_setProperty(guild, GP_PEACE, _, guildAtWar);
				break;
			}
		}
		set_delete(guildSet);
	}
	guildmasterMenu(chr, guild);
}

public declareAlliance(const chr, const guild)
{
	new gui = gui_create( 40, 40, true, true, true, "declareAllianceCB" );
	gui_addResizeGump( gui, 0, 0,  0x0A28, 400, 250 );
	gui_setProperty( gui, MP_BUFFER, 0 , guild);

	new guildSet=set_create();
	new page;
	new member;
	new membername[50];
	set_addGuilds( guildSet, guild, GUILD_POLITICS_ALLIED );
	// set_addGuilds( guildSet, guild);
	for ( set_rewind(guildSet);!set_end(guildSet);)
	{
		gui_addPage(gui, ++page);
		new guildIndex=0;
		new i=1;
		while ( i <= 10)
		{
			member=set_get(guildSet);
			guildIndex++;
			member=set_get(guildSet);
			if ( ! guild_hasAllianceWith(guild, member) && guild != member)
			{
				guild_getProperty(member, GP_STR_NAME, _, membername);
				gui_addButton( gui, 25, 55+i*30, 0x4B9, 0x4BA, page*10+ guildIndex); // Buttons start at 10
				gui_addText( gui, 55, 55+i*30, _, membername);
			}
			if ( set_end(guildSet))
				break;
		}
		if ( page < set_size(guildSet)/10+1)
			gui_addPageButton(gui, 330, 365, 0x1458, 0x1458, page + 1);
		if ( page > 1 )
			gui_addPageButton(gui, 310, 365, 0x1458, 0x1458, page + 1);
	}
	// Cancel Button plazieren
	gui_addButton( gui, 300, 180, 0xf3, 0xf1, 0, 1);
	gui_show( gui, chr );
}

public declareAllianceCB(const gui, const chr, const buttonCode)
{
	new guild = gui_getProperty( gui, MP_BUFFER, 0 );

	if ( buttonCode >= 10 )
	{
		new guildSet=set_create();
		new guildAtWar=INVALID;
		new count=10;
		// Searching through list of guilds, hopefully they didn't change in the meantime
		// Better would be storing the guild serial with the button code, but how to store it ?
		set_addGuilds( guildSet, guild, GUILD_POLITICS_ALLIED);
		for ( set_rewind(guildSet);!set_end(guildSet);)
		{
			count++;
			guildAtWar=set_get(guildSet);
			if ( count==buttonCode )
			{
				guild_setProperty(guild, GP_PEACE, _, guildAtWar);
				break;
			}
		}
		set_delete(guildSet);
	}
	guildmasterMenu(chr, guild);
}


public acceptMember(const chr, const guild)
{
	new gui = gui_create( 40, 40, true, true, true, "acceptMemberCB" );
	gui_setProperty( gui, MP_BUFFER, 0 , guild);
	gui_addResizeGump( gui, 0, 0,  0x0A28, 400, 250 );
	new guildRecruitSet=set_create();
	new membername[50];
	new page;
	new member;

	set_addGuildRecruit( guildRecruitSet, guild );
	for ( set_rewind(guildRecruitSet);!set_end(guildRecruitSet);)
	{
		gui_addPage(gui, ++page);
		for ( new i=1;i < 10;++i)
		{
			member=set_get(guildRecruitSet);
			chr_getProperty(member, CP_STR_NAME, _, membername);
			gui_addText( gui, 55, 55+i*30, _, membername);
			gui_addButton( gui, 25, 55+i*30, 0x4B9, 0x4BA, guild_getRecruitIdx (guild,  member) );
			if ( set_end(guildRecruitSet))
				break;
		}
		if ( page < set_size(guildRecruitSet)/10+1)
			gui_addPageButton(gui, 330, 365, 0x1458, 0x1458, page + 1);
		if ( page > 1 )
			gui_addPageButton(gui, 310, 365, 0x1458, 0x1458, page + 1);
	}
	// Cancel Button plazieren
	gui_addButton( gui, 300, 220, 0xf3, 0xf1, 0, 1);
	gui_show( gui, chr );
}

public acceptMemberCB(const gui, const chr, const buttonCode)
{
	new guild = gui_getProperty( gui, MP_BUFFER, 0 );
	if ( buttonCode > 0 )
	{
		new acceptedMember=guild_memberAtIndex ( guild,  buttonCode);
		guild_addMember ( guild, acceptedMember,RANK_GUILDMEMBER, true, "a loyal member");
	}
	guildmasterMenu(chr, guild);
}

public refuseCandidate(const chr, const guild)
{
	new gui = gui_create( 40, 40, true, true, true, "refuseMemberCB" );
	gui_setProperty( gui, MP_BUFFER, 0 , guild);
	gui_addResizeGump( gui, 0, 0,  0x0A28, 400, 250 );
	new guildRecruitSet=set_create();
	new membername[50];
	new page;
	new member;

	set_addGuildRecruit( guildRecruitSet, guild );
	for ( set_rewind(guildRecruitSet);!set_end(guildRecruitSet);)
	{
		gui_addPage(gui, ++page);
		for ( new i=1;i < 10;++i)
		{
			member=set_get(guildRecruitSet);
			chr_getProperty(member, CP_STR_NAME, _, membername);
			gui_addText( gui, 55, 55+i*30, _, membername);
			gui_addButton( gui, 25, 55+i*30, 0x4B9, 0x4BA, guild_getRecruitIdx (guild,  member) );
			if ( set_end(guildRecruitSet))
				break;
		}
		if ( page < set_size(guildRecruitSet)/10+1)
			gui_addPageButton(gui, 330, 365, 0x1458, 0x1458, page + 1)
		if ( page > 1 )
			gui_addPageButton(gui, 310, 365, 0x1458, 0x1458, page + 1)
	}
	// Cancel Button plazieren
	gui_addButton( gui, 300, 220, 0xf3, 0xf1, 0, 1);
	gui_show( gui, chr );

}

public refuseMemberCB(const gui, const chr, const buttonCode)
{
	new guild = gui_getProperty( gui, MP_BUFFER, 0 );
	if ( buttonCode > 0 )
	{
		chr_message(chr, _, "The selected recruit Index is: %d", buttonCode);
		new refusedMember=guild_getRecrAtIdx ( guild,  buttonCode);
		guild_refuseRecruit ( guild, refusedMember );
	}
	guildmasterMenu(chr, guild);
}


public setMemberTitle(const chr, const guild)
{
	new gui = gui_create( 40, 40, true, true, true, "setMemberTitleCB" );
	gui_setProperty( gui, MP_BUFFER, 0 , guild);
	gui_addResizeGump( gui, 0, 0,  0x0A28, 300, 400 );
	new guildMemberSet=set_create();
	new membername[50];
	new page;
	new member;
	set_addGuildMembers( guildMemberSet, guild );
	for ( set_rewind(guildMemberSet);!set_end(guildMemberSet);)
	{
		gui_addPage(gui, ++page);
		for ( new i=1;i < 10;++i)
		{
			member=set_get(guildMemberSet);
			chr_getProperty(member, CP_STR_NAME, _, membername);
			gui_addText( gui, 65, 35+i*30, _, membername);
			gui_addButton( gui, 25, 35+i*30, 0x4B9, 0x4BA, guild_getMemberIdx (guild,  member)+10 );
			if ( set_end(guildMemberSet))
				break;
		}
		if ( page < set_size(guildMemberSet)/10+1)
			gui_addPageButton(gui, 330, 365, 0x1458, 0x1458, page + 1);
		if ( page > 1 )
			gui_addPageButton(gui, 310, 365, 0x1458, 0x1458, page + 1);
	}
	set_delete(guildMemberSet);
	// Cancel Button plazieren
	gui_addButton( gui, 130, 360, 0xf3, 0xf1, 0, 1);
	// OK Button
	gui_addButton( gui, 200, 360, 0xf9, 0xf7, 1, 1);
	gui_show( gui, chr );
}

public setMemberTitleCB(const gui, const chr, const buttonCode)
{
	new guild = gui_getProperty( gui, MP_BUFFER, 0 );
	if ( buttonCode > 0 )
	{
		new newTitleMember=guild_memberAtIndex ( guild,  buttonCode-10);
		new currTitle[31];
		chr_getProperty(newTitleMember, CP_STR_TITLE, _, currTitle);

		new gui2 = gui_create( 40, 40, true, true, true, "changeMemberTitleCB" );
		gui_setProperty( gui2, MP_BUFFER, 0 , guild);
		gui_setProperty( gui2, MP_BUFFER, 1 , newTitleMember);
		gui_addResizeGump( gui2, 0, 0,  0x0A28, 300, 150 );
		gui_addInputField( gui2, 130, 40, 290, 30, 1, _, currTitle);
		gui_addText( gui2, 40, 40, _, "New Title: " );
		// Cancel Button plazieren
		gui_addButton( gui2, 140, 110, 0xf3, 0xf1, 0, 1);
		// OK Button
		gui_addButton( gui2, 210, 110, 0xf9, 0xf7, 1, 1);
		gui_show( gui2, chr );
		return;
	}
	guildmasterMenu(chr, guild);
}

public changeMemberTitleCB(const gui, const chr, const buttonCode)
{
	new guild = gui_getProperty( gui, MP_BUFFER, 0 );
	new newTitleMember= gui_getProperty( gui, MP_BUFFER, 1 );
	if ( buttonCode > 0 )
	{
		if ( ( chr_getProperty(newTitleMember, CP_GUILD) != guild) && (! chr_isGMorCns(chr)))
		{
			chr_message(chr, _, "That player does not belong to your guild !");
			guildmasterMenu(chr, guild);
			return;
		}
		new titleCandidate[500];
		new title[30];
		gui_getProperty( gui, MP_UNI_TEXT, 1, titleCandidate);
		strncpy(title, titleCandidate, 30);
		chr_setProperty(newTitleMember, CP_STR_TITLE, _, title);
	}
	guildmasterMenu(chr, guild);
}

public issueGuildShields(const chr, const guild)
{
	if ( guild_getProperty(guild, GP_TYPE, _) == GUILD_TYPE_CHAOS )
	{
		itm_createInBp(getIntFromDefine("$item_chaos_shield"), chr);
		chr_message(chr, _, "You have received a chaos shield");
	}
	else if( guild_getProperty(guild, GP_TYPE, _) == GUILD_TYPE_ORDER )
	{
		itm_createInBp(getIntFromDefine("$item_order_shield"), chr);
		chr_message(chr, _, "You have received an order shield");
	}
	else
		chr_message(chr, _, "You cannot issue such shields in your type of guild");
}


/*!
\author Endymion
\fn guild_sclickStone( const guild, const chr )
\brief a guild stone single-click
*/
public guild_sclickStone( const guild, const chr )
{
	new guildName[64];
	guild_getProperty( guild, GP_STR_NAME, _, guildName );
	sprintf( guildName, "Guildstone for %s", guildName );
	itm_speech( chr, guild, guildName );
	bypass();
}

/** @} */ // end of script_API_guild_various
