/*
	Work in progress
	
	SMALL guild handling based on Endymions new guild code

*/
static const rowSpacing	= 2;
static const rowHeight	= 25;
static rowDistance	= 0;
static rowY		= 0;
static const colLen	= 342;
static const colX	= 10;
static colXTxt		= 0;
static const colBackGump= 0x52;
static lastPage		= 0;
static const rowsPerPage= 12;
static currentPageRow	= 0;
//
// Button Identifiers
//
static const buttonAboutYou	= 1;
static const buttonAboutGuild	= 2;
static const buttonCandidates	= 3;
static const buttonFealty	= 4;
static const buttonRecruit	= 5;
static const buttonRelations	= 6;
static const buttonResign	= 7;
static const buttonRoster	= 8;
static const buttonGuildmaster	= 9;

/*!
\syntax gui_guildStoneResp( const gump, const serial, const button, const pc )
\brief perform action depending on button pressed on guildstone gump
\author Sparhawk
\since 0.82
\param gump	: gumpid - should be GUI_GUILDSTONE
\param guild	: guild serial
\param button	: button pressed on guildstone gump
\param pc	: serial of the pc who pressed the button on the guildstone gump
\return nothing
*/
public gui_guildStoneResp( const gump, const guild, const button, const pc )
{
	//
	// damn. somehow the small compiler does not accept static consts as a const value in switch/case
	//
	if( button == buttonRecruit )
	{
		gui_guildRecruit( pc );		// targeting cursor to select new recruit
		return;
	}
	if( button == buttonRoster )
	{
		//
		// show selection list of members
		//
		gui_guildMemberL( guild, pc );
		return;
	}
	if( button == buttonCandidates )
	{
		//
		// show selection list of recruits
		//
		gui_guildRecruitL( guild, pc );
		return;
	}
	if( button == buttonAboutGuild )
	{
		//
		// view/edit guild info
		//
		if( pc == guild_getProperty( guild, GP_GUILDMASTER ) )
			gui_guildProps( guild, pc, 1 );
		else
			gui_guildProps( guild, pc, 0 );
		return;
	}
	/*
	if( button == buttonCharter )
	{
		gui_guildCharter( serial, pc );
		return;
	}
	if( button == buttonFealty )
	{
		gui_guildFealty( serial, pc );
		return;
	}
	if( button == buttonToggle )
	{
		gui_guildToggle( serial, pc );
		return;
	}
	if( button == buttonResign )
	{
		gui_guildResign( serial, pc );
		return;
	}
	if( button == buttonGuildmaster )
	{
		gui_guildMaster( serial, pc );
		return;
	}
	if( button == buttonWarDeclared	)
	{
		gui_guildWarOn( serial, pc );
		return;
	}
	if( button == buttonWarOthers )
	{
		gui_guildWarBy( serial, pc );
		return;
	}
	*/
}

/*!
\brief show guildstone action list, is displayed when pc dbl clicks on a guildstone and on guild creation
\author Sparhawk
\since 0.82
\param guild		: guild number
\param showToWhom	: serial of the pc who dbl clicked the guildstone
\return nothing
*/
public gui_guildStone( const guild, const showToWhom )
{
	rowDistance	= rowSpacing + rowHeight;
	colXTxt		= colX + 20;

	//
	// Always delete the previous guildstone gump from the server gump cache
	// This will change in the future. The server will then automatically delete dynamic gumps from memory while caching static ones.
	//
	gui_delete( GUI_GUILDSTONE );
	//
	// Now let's create the guildstone gump
	//
	if( gui_create( GUI_GUILDSTONE, 0, 0, 1, 1, 1, guild ) )
	{
		//
		// VARIABLES
		//
		new string[50];
		new string1[50];

		lastPage	= 0;
		currentPageRow	= 1;
		//
		// Create the background for our gump
		//
		gui_addPage( GUI_GUILDSTONE, lastPage );
		gui_addResizeGump( GUI_GUILDSTONE, 0, 0, 5120, 360, 345 );
		//
		// Create a gump title
		//
		rowY = 10;
		gui_addTiledGump( GUI_GUILDSTONE,  10,  rowY, 342, rowHeight, colBackGump, 0 );

		guild_getProperty( guild, GP_NAME, _, string );
		chr_getProperty( guild_getProperty( guild, GP_GUILDMASTER, _), CP_STR_NAME, _, string1 );
		sprintf( string, "Guild: %s Master: %s", string, string1 );
		gui_addText( GUI_GUILDSTONE, 20, rowY+2, string, 45);
		gui_addPage( GUI_GUILDSTONE, ++lastPage );
		//
		// Add the menu choices
		//
		addProperty( buttonAboutYou,	"About you");
		addProperty( buttonAboutGuild,	"About guild");
		addProperty( buttonCandidates,	"Candidates");
		addProperty( buttonFealty,	"Declare your fealty");
		addProperty( buttonRecruit,	"Recruit someone");
		addProperty( buttonRelations,	"Relations");
		addProperty( buttonResign,	"Resign");
		addProperty( buttonRoster,	"Roster");
		addProperty( buttonGuildmaster,	"Guildmaster functions");
		//
		// Add the toolbars
		//
		addToolBars();
		//
		gui_show( GUI_GUILDSTONE, showToWhom );
		//
		// Always delete the guildstone gump from the server gump cache
		// This will change in the future. 
		// The server will then automatically delete dynamic gumps from memory while caching static ones.
		//
		gui_delete( GUI_GUILDSTONE );
	}
	else
		log_error("gui_guildstone cannot create gump %d", GUI_GUILDSTONE );
}

/*!
\brief add a menu line to the guild command selection gump
\author Sparhawk
\since 0.82
\param menuChoice	: button number for the menu entry
\param menuText		: menu entry description
\return nothing
*/
static addProperty( const menuChoice, const menuText[] )
{
	if( ++currentPageRow == rowsPerPage )
	{
		gui_addPage( GUI_GUILDSTONE, ++lastPage );
		currentPageRow = 2;
		rowY = 10;
	}
	rowY += rowDistance;
	gui_addTiledGump( GUI_GUILDSTONE,  10,  rowY, 342, rowHeight, colBackGump, 0 );
	gui_addButton( GUI_GUILDSTONE, colX, rowY+4, 1210, 1210, menuChoice )
	gui_addText( GUI_GUILDSTONE, colXTxt, rowY+2, menuText, 45);
}

/*!
\brief Display move forward, backward, goto first and goto last page. Probably unneccessary here, will be changed
\author Sparhawk
\since 0.82
\return nothing
*/
static addToolBars()
{
	rowY = 10 + rowDistance * 11;
	gui_addTiledGump(  GUI_GUILDSTONE,  colX,  rowY, 342, rowHeight, colBackGump, 0 );
	/*
	for(new page = 1; page <= lastPage; ++page)
	{
		gui_addPage( GUI_GUILDSTONE, page );
		gui_addPageButton( GUI_GUILDSTONE, colX + 2,  rowY+2, 1210, 1210, 1 );
		gui_addPageButton( GUI_GUILDSTONE,  40,  rowY+2, 1210, 1210, ( page == 1 ? 1 : page - 1) );
		gui_addPageButton( GUI_GUILDSTONE, 310,  rowY+2, 1210, 1210, ( page == lastPage ? lastPage : page + 1 ) );
		gui_addPageButton( GUI_GUILDSTONE, 335,  rowY+2, 1210, 1210, lastPage );
		gui_addTiledGump(  GUI_GUILDSTONE,  colX,  rowY, 342, rowHeight, colBackGump, 0 );
		gui_addText(	   GUI_GUILDSTONE,  colX + 2, rowY+2, "|<", 45);
		gui_addText(	   GUI_GUILDSTONE,  40, rowY+2, "<", 45);
		gui_addText(	   GUI_GUILDSTONE,  312, rowY+2, ">", 45);
		gui_addText(	   GUI_GUILDSTONE,  337, rowY+2, ">|", 45);
	}
	*/
}

