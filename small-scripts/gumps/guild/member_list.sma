/*
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
*/
/*!
\syntax gui_guildMemberLR( const gump, const serial, const button, const pc )
\brief respond to choice int list of guild members
\author Sparhawk
\since 0.82
\param gump	: gumpid
\param guild	: guild serial
\param button	: button pressed on guild member list gump. Is either a member serial or the cancel button
\param pc	: serial of the pc
\return nothing
*/
public gui_guildMemberLR( const gump, const guild, const button, const pc )
{
/*	if( button != buttonCancel )
	{
		if( button < pageOffSet )
			gui_guildMemberLP( guild, pc, button )
		else
			printf(!"gui_guildMemberLR member button %d pressed^n", button - pageOffSet );
	}
	else
		gui_guildStone( guild, pc );*/
}

/*!
\syntax gui_guildMemberL( const guild, const showToWhowm )
\brief show a list of guild members
\author Sparhawk
\since 0.82
\param guild		: guild serial
\param showToWhom	: serial of pc to display the gump for
\return nothing
*/
public gui_guildMemberL( const guild, const showToWhom )
{
/*
	gui_guildMemberLP( guild, showToWhom, 1 );
*/
}

static gui_guildMemberLP( const guild, const showToWhom, const page )
{
/*
	rowDistance	= rowSpacing + rowHeight;
	colXTxt		= colX + 20;

	gui_delete( GUI_GUILDMEMLIST );
	if( gui_create( GUI_GUILDMEMLIST, 0, 0, 1, 1, 1, guild ) )
	{
		//
		// VARIABLES
		//
		new str[50];
		currentPageRow	= 1;
		//
		//	Background
		//
		gui_addPage( GUI_GUILDMEMLIST, 0 );
		gui_addResizeGump( GUI_GUILDMEMLIST, 0, 0, 5120, 360, 345 );
		//
		// 	Form Title
		//
		rowY = 10;
		gui_addTiledGump( GUI_GUILDMEMLIST,  10,  rowY, 342, rowHeight, colBackGump, 0 );
		guild_getProperty( guild, GP_NAME, _, str );
		sprintf( str, "NoX-Wizard - Roster for %s", str );
		gui_addText( GUI_GUILDMEMLIST, 45, rowY+2, str, 45);
		gui_addPage( GUI_GUILDMEMLIST, 1 );
		//
		// 	Build member list
		//
		new numberOfMembers = guild_countMember( guild );
		lastPage = numberOfMembers / (rowsPerPage - 2) + ( (numberOfMembers%(rowsPerPage - 2)) ? 1 : 0 );
		new member;
		new firstMember = (page - 1) * 10;
		new lastMember  = firstMember + 10;
		for( new i = firstMember; i < lastMember && i < numberOfMembers; ++i )
		{
			member = guild_getMbrByIdx( guild, i );
			chr_getProperty( member, CP_STR_NAME, _, str );
			addProperty( member, str );
		}
		//
		addToolBars( page );
		//
		gui_show( GUI_GUILDMEMLIST, showToWhom );
		gui_delete( GUI_GUILDMEMLIST );
	}
*/
}

static addProperty( const memberId, const memberName[] )
{
/*
	//if( ++currentPageRow == rowsPerPage )
	//{
	//	gui_addPage( GUI_GUILDMEMLIST, ++lastPage );
	//	currentPageRow = 2;
	//	rowY = 10;
	//}
	rowY += rowDistance;
	gui_addTiledGump(  GUI_GUILDMEMLIST,  colX,  rowY, 342, rowHeight, colBackGump, 0 );
	gui_addButton( GUI_GUILDMEMLIST, colX, rowY+4, 1210, 1210, memberId + pageOffSet )
	gui_addText( GUI_GUILDMEMLIST, colXTxt, rowY+2, memberName, 45);
*/
}

static addToolBars( const page )
{
/*
	rowY = 10 + rowDistance * 11;
	gui_addPageButton( GUI_GUILDMEMLIST, colX + 2,  rowY+2, 1210, 1210, 1 );
	gui_addPageButton( GUI_GUILDMEMLIST,  40,  rowY+2, 1210, 1210, ( page == 1 ? 1 : page - 1) );
	gui_addPageButton( GUI_GUILDMEMLIST, 310,  rowY+2, 1210, 1210, ( page == lastPage ? lastPage : page + 1 ) );
	gui_addPageButton( GUI_GUILDMEMLIST, 335,  rowY+2, 1210, 1210, lastPage );
	gui_addTiledGump(  GUI_GUILDMEMLIST,  colX,  rowY, 342, rowHeight, colBackGump, 0 );
	gui_addText(	   GUI_GUILDMEMLIST,  colX + 2, rowY+2, "|<", 45);
	gui_addText(	   GUI_GUILDMEMLIST,  40, rowY+2, "<", 45);
	gui_addText(	   GUI_GUILDMEMLIST,  312, rowY+2, ">", 45);
	gui_addText(	   GUI_GUILDMEMLIST,  337, rowY+2, ">|", 45);
*/
}
