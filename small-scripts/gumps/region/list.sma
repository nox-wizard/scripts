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

public gui_rgnListResp( const gump, const serial, const button, const pc )
{
	if( button != buttonCancel )
	{
		gui_rgnProps( button, pc, 1 );
	}
}

public gui_rgnList( const showToWhom )
{
	rowDistance	= rowSpacing + rowHeight;
	colXTxt		= colX + 20;

	gui_delete( GUI_RGNLIST );
	if( gui_create( GUI_RGNLIST, 0, 0, 1, 1, 1, showToWhom ) )
	{
		//
		// VARIABLES
		//
		new str[50];
		lastPage	= 0;
		currentPageRow	= 1;
		//
		//	Background
		//
		gui_addPage( GUI_RGNLIST, lastPage );
		gui_addResizeGump( GUI_RGNLIST, 0, 0, 5120, 360, 345 );
		//
		// 	Form Title
		//
		rowY = 10;
		gui_addTiledGump( GUI_RGNLIST,  10,  rowY, 342, rowHeight, colBackGump, 0 );
		gui_addText( GUI_RGNLIST, 90, rowY+2, "NoX-Wizard - Region List", 45);
		gui_addPage( GUI_RGNLIST, ++lastPage );
		//
		// 	Character properties
		//
		for( new i = 0; i < 256; ++i )
		{
			if( rgn_isValid( i ) )
			{
				rgn_getName( i, str );
				sprintf( str, "[%d] %s", i, str );
				addProperty( i, str );
			}
		}
		//
		addToolBars();
		//
		gui_show( GUI_RGNLIST, showToWhom );
		gui_delete( GUI_RGNLIST );
	}
}

static addProperty( const regionId, const regionName[] )
{
	if( ++currentPageRow == rowsPerPage )
	{
		gui_addPage( GUI_RGNLIST, ++lastPage );
		currentPageRow = 2;
		rowY = 10;
	}
	rowY += rowDistance;
	gui_addButton( GUI_RGNLIST, colX, rowY+4, 1210, 1210, regionId )
	gui_addText( GUI_RGNLIST, colXTxt, rowY+2, regionName, 45);
}

static addToolBars()
{
	rowY = 10 + rowDistance * 11;
	for(new page = 1; page <= lastPage; ++page)
	{
		gui_addPage( GUI_RGNLIST, page );
		gui_addPageButton( GUI_RGNLIST, colX + 2,  rowY+2, 1210, 1210, 1 );
		gui_addPageButton( GUI_RGNLIST,  40,  rowY+2, 1210, 1210, ( page == 1 ? 1 : page - 1) );
		gui_addPageButton( GUI_RGNLIST, 310,  rowY+2, 1210, 1210, ( page == lastPage ? lastPage : page + 1 ) );
		gui_addPageButton( GUI_RGNLIST, 335,  rowY+2, 1210, 1210, lastPage );
		gui_addTiledGump(  GUI_RGNLIST,  colX,  rowY, 342, rowHeight, colBackGump, 0 );
		gui_addText(	   GUI_RGNLIST,  colX + 2, rowY+2, "|<", 45);
		gui_addText(	   GUI_RGNLIST,  40, rowY+2, "<", 45);
		gui_addText(	   GUI_RGNLIST,  312, rowY+2, ">", 45);
		gui_addText(	   GUI_RGNLIST,  337, rowY+2, ">|", 45);
	}
}

