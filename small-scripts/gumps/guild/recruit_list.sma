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
static const buttonCancel	= 0;
static const pageOffSet		= 100;

/*!
\syntax gui_guildRecruitLR( const gump, const serial, const button, const pc )
\brief respond to choice in list of guild candidates
\author Sparhawk
\since 0.82
\param gump	: gumpid
\param guild	: guild serial
\param button	: button pressed on guild candidate list gump. Is either a candidate serial or the cancel button
\param pc	: serial of the pc who pressed the button
\return nothing
*/
public gui_guildRecruitLR( const gump, const guild, const button, const pc )
{
	if( button != buttonCancel )
	{
		if( button < pageOffSet )
			guildRecruitLP( guild, pc, button )
		else
			printf(!"gui_guildRecruitLR member button %d pressed^n", button - pageOffSet );
	}
	else
		gui_guildStone( guild, pc );
}

/*!
\syntax gui_guildRecruitL( const guild, const showToWhowm )
\brief show a list of guild candidates
\author Sparhawk
\since 0.82
\param guild		: guild serial
\param showToWhom	: serial of pc to display the gump for
\return nothing
*/
public gui_guildRecruitL( const guild, const showToWhom )
{
	guildRecruitLP( guild, showToWhom, 1 );
}

static guildRecruitLP( const guild, const showToWhom, const page )
{
	rowDistance	= rowSpacing + rowHeight;
	colXTxt		= colX + 20;

	gui_delete( GUI_GUILDRCRLIST );
	if( gui_create( GUI_GUILDRCRLIST, 0, 0, 1, 1, 1, guild ) )
	{
		//
		// VARIABLES
		//
		new str[50];
		currentPageRow	= 1;
		//
		//	Background
		//
		gui_addPage( GUI_GUILDRCRLIST, 0 );
		gui_addResizeGump( GUI_GUILDRCRLIST, 0, 0, 5120, 360, 345 );
		//
		// 	Form Title
		//
		rowY = 10;
		gui_addTiledGump( GUI_GUILDRCRLIST,  10,  rowY, 342, rowHeight, colBackGump, 0 );
		guild_getProperty( guild, GP_NAME, _, str );
		sprintf( str, "Candidates for %s", str );
		gui_addText( GUI_GUILDRCRLIST, 45, rowY+2, str, 45);
		gui_addPage( GUI_GUILDRCRLIST, 1 );
		//
		// 	Build recruit list
		//
		new numberOfRecruits = guild_countRecruit( guild );
		lastPage = numberOfRecruits / (rowsPerPage - 2) + ( (numberOfRecruits%(rowsPerPage - 2)) ? 1 : 0 );
		new recruit;
		new firstRecruit = (page - 1) * 10;
		new lastRecruit  = firstRecruit + 10;
		for( new i = firstRecruit; i < lastRecruit && i < numberOfRecruits; ++i )
		{
			recruit = guild_getRecByIdx( guild, i );
			chr_getProperty( recruit, CP_STR_NAME, _, str );
			addProperty( recruit, str );
		}
		//
		addToolBars( page );
		//
		gui_show( GUI_GUILDRCRLIST, showToWhom );
		gui_delete( GUI_GUILDRCRLIST );
	}
}

static addProperty( const recruitId, const recruitName[] )
{
	rowY += rowDistance;
	gui_addTiledGump(  GUI_GUILDRCRLIST,  colX,  rowY, 342, rowHeight, colBackGump, 0 );
	gui_addButton( GUI_GUILDRCRLIST, colX, rowY+4, 1210, 1210, recruitId + pageOffSet )
	gui_addText( GUI_GUILDRCRLIST, colXTxt, rowY+2, recruitName, 45);
}

static addToolBars( const page )
{
	rowY = 10 + rowDistance * 11;
	gui_addPageButton( GUI_GUILDRCRLIST, colX + 2,  rowY+2, 1210, 1210, 1 );
	gui_addPageButton( GUI_GUILDRCRLIST,  40,  rowY+2, 1210, 1210, ( page == 1 ? 1 : page - 1) );
	gui_addPageButton( GUI_GUILDRCRLIST, 310,  rowY+2, 1210, 1210, ( page == lastPage ? lastPage : page + 1 ) );
	gui_addPageButton( GUI_GUILDRCRLIST, 335,  rowY+2, 1210, 1210, lastPage );
	gui_addTiledGump(  GUI_GUILDRCRLIST,  colX,  rowY, 342, rowHeight, colBackGump, 0 );
	gui_addText(	   GUI_GUILDRCRLIST,  colX + 2, rowY+2, "|<", 45);
	gui_addText(	   GUI_GUILDRCRLIST,  40, rowY+2, "<", 45);
	gui_addText(	   GUI_GUILDRCRLIST,  312, rowY+2, ">", 45);
	gui_addText(	   GUI_GUILDRCRLIST,  337, rowY+2, ">|", 45);
}

