static const rowSpacing	= 2;
static const rowHeight	= 25;
static rowDistance	= 0;
static rowY		= 0;
static const colSpacing	= 2;
static const col1Len	= 170;
static const col2Len	= 170;
static const col1X	= 10;
static col2X		= 0;
static col1XTxt		= 0;
static col2XTxt		= 0;
static const colBackGump= 0x52;
static lastPage		= 2;
static const rowsPerPage= 12;
static currentPageRow	= 0;
static stringMode	= 0;
//
// Field identifiers
//
static const propName		= 1;
static const propAbbreviation	= 2;
static const propCharter	= 3;
static const propWebPage	= 4;
static const propType		= 5;
//
// Button Identifiers
//
static const buttonCancel	= 0;

public gui_guildProps( const guild, const showToWhom, const edit )
{
	guildPropsPage( guild, showToWhom, edit, 1 );
}

public gui_guildPropsResp( const gump, const guild, const button, const pc )
{
	if( button != buttonCancel )
	{
		new page;
		new edit;
		new updateChar = 0;
		guildPropsRespInit( button, edit, page );
		if( page != button )
		{
			guildPropsRespExit( guild, pc, page, edit )
			return;
		}
		new newString[64];	// packed string arrays for max 256 chars including trailing '/0'
		new oldString[64];
		new newNumeric;
		new oldNumeric;
		if( page == 1 )
		{
			//
			// process changes to: Abbreviation
			// --------------------------------
			//
			gui_getInputField( propAbbreviation, newString );
			trim( newString );
			guild_getProperty( guild, GP_ABBREVIATION, _, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( newString ) > 3 )
					newString{3} = 0;
				guild_setProperty( guild, GP_ABBREVIATION, _, newString );
			}
			//
			// process changes to: Charter
			// ---------------------------
			//
			gui_getInputField( propCharter, newString );
			trim( newString );
			guild_getProperty( guild, GP_CHARTER, _, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( newString ) > 50 )
					newString{50} = 0;
				guild_setProperty( guild, GP_CHARTER, _, newString );
			}
			//
			// process changes to: Name
			// ------------------------
			//
			gui_getInputField( propName, newString );
			trim( newString );
			guild_getProperty( guild, GP_NAME, _, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( newString ) > 29 )
					newString{29} = 0;
				guild_setProperty( guild, GP_NAME, _, newString );
			}
			//
			// process changes to: Type
			// ------------------------
			//
			gui_getInputField( propType, newString );
			oldNumeric = guild_getProperty( guild, GP_TYPE, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric && newNumeric >= 0 && newNumeric <= 2)
				guild_setProperty( guild, GP_TYPE, _, newNumeric );
			//
			// Finish
			//
			guildPropsRespExit( guild, pc, page, edit );
			return;
		}
		if( page == 2 )
		{
			//
			// process changes to: Webpage
			// ---------------------------
			//
			gui_getInputField( propWebPage, newString );
			trim( newString );
			guild_getProperty( guild, GP_WEBPAGE, _, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( newString ) > 29 )
					newString{29} = 0;
				guild_setProperty( guild, GP_WEBPAGE, _, newString );
			}
			//
			// Finish
			//
			guildPropsRespExit( guild, pc, page, edit );
			return;
		}
	}
}

static guildPropsRespInit( const button, &edit, &page )
{
	if( button > lastPage )
		if( button > lastPage * 2 )
		{
			page = button - lastPage * 2; // edit gump
			edit = 1;
		}
		else
		{
			page = button - lastPage; // read gump
			edit = 0;
		}
	else
	{
		page = button; // button apply respond from edit gump;
		edit = 1;
	}

	stringMode = getStringMode();
	//
	// switch to packed string mode
	//
	if( !stringMode )
		setStringMode( 1 );
}

static guildPropsRespExit( const guildSerial, const pc, const page, const edit )
{
	//
	// reset original stringmode
	//
	setStringMode( stringMode );
	guildPropsPage( guildSerial, pc, edit, page );
}

static guildPropsPage( const guild, const showToWhom, const edit, const page )
{
	rowDistance	= rowSpacing + rowHeight;
	col2X		= col1X + col1Len + colSpacing;
	col1XTxt	= col1X + 5;
	col2XTxt	= col2X + 5;

	gui_delete( GUI_GUILDPROP );
	if( gui_create( GUI_GUILDPROP, 0, 0, 1, 1, 1, guild ) )
	{
		//
		// VARIABLES
		//
		new string[50];
		lastPage	= 2;
		currentPageRow	= 1;
		//
		//	Background
		//
		gui_addPage( GUI_GUILDPROP, 0 );
		if( edit )
		{
			gui_addResizeGump( GUI_GUILDPROP, 0, 0, 5120, 360, 365 );
			gui_addTiledGump(  GUI_GUILDPROP,  10,  335, 342, rowHeight, colBackGump, 0 );
			gui_addButton( GUI_GUILDPROP,  15, 337, 1209, 1209, page );
			gui_addText( GUI_GUILDPROP,  35, 337, "Apply", 45);
			gui_addButton( GUI_GUILDPROP, 335, 337, 1209, 1209, buttonCancel );
			gui_addText( GUI_GUILDPROP,  295, 337, "Cancel", 45);
		}
		else
			gui_addResizeGump( GUI_GUILDPROP, 0, 0, 5120, 360, 345 );
		//
		// 	Form Title
		//
		rowY = 10;
		gui_addTiledGump( GUI_GUILDPROP,  10,  rowY, 342, rowHeight, colBackGump, 0 );
		gui_addText( GUI_GUILDPROP, 50, rowY+2, "NoX-Wizard - Guild properties", 45);
		gui_addPage( GUI_GUILDPROP, 1 );
		//
		// 	Guild properties
		//
		if( page == 1 )
		{
			//
			guild_getProperty( guild, GP_ABBREVIATION, _, string, 0, 0, ( edit ? propAbbreviation : 0 ) );
			addProperty( "Abbreviation", string );
			//
			guild_getProperty( guild, GP_CHARTER, _, string, 0, 0, ( edit ? propCharter : 0 ) );
			addProperty( "Charter", string );
			//
			addProperty( "Founder", "" );
			//
			addProperty( "Founded at", "" );
			//
			sprintf( string, "%d", guild );
			addProperty( "Id", string );
			//
			guild_getProperty( guild, GP_NAME, _, string );
			addProperty( "Name", string, 0, 0, ( edit ? propName : 0 ) );
			//
			sprintf( string, "%d", guild_countMember( guild ) );
			addProperty( "Number of members", string );
			//
			sprintf( string, "%d", guild_countRecruit( guild ) );
			addProperty( "Number of recruits", string );
			//
			chr_getProperty( guild_getProperty( guild, GP_GUILDMASTER, _), CP_STR_NAME, _, string );
			addProperty( "Master", string );
			//
			sprintf( string, "%d", guild_getProperty( guild, GP_TYPE, _ ) );
			addProperty( "Type", string, 0, 0, ( edit ? propType : 0 ) );
		}
		if( page == 2 )
		{
			//
			guild_getProperty( guild, GP_WEBPAGE, _, string );
			addProperty( "Webpage", string, 0, 0, ( edit ? propWebPage : 0 ) );
		}
		//
		addToolBars( page, edit );
		//
		gui_show( GUI_GUILDPROP, showToWhom );
		gui_delete( GUI_GUILDPROP );
	}
}

static addProperty( const colVal1[], colVal2[], const cropCol1 = 0, const cropCol2 = 0, const editField = 0 )
{
	rowY += rowDistance;
	gui_addTiledGump( GUI_GUILDPROP, col1X,   rowY,   col1Len, rowHeight, colBackGump, 0 );
	if ( cropCol1 )
		gui_addCroppedText( GUI_GUILDPROP, col1XTxt, rowY+2, col1Len, rowHeight, colVal1, 45);
	else
		gui_addText( GUI_GUILDPROP, col1XTxt,rowY+2, colVal1, 45);
	gui_addTiledGump( GUI_GUILDPROP, col2X,   rowY,   col2Len, rowHeight, colBackGump, 0 );
	if( editField )
		gui_addInputField( GUI_GUILDPROP, col2XTxt, rowY+2, col2Len, rowHeight, editField, colVal2, 11);
	else
		if( cropCol2 )
			gui_addCroppedText( GUI_GUILDPROP, col2XTxt,rowY+2, col2Len, rowHeight, colVal2, 45);
		else
			gui_addText( GUI_GUILDPROP, col2XTxt,rowY+2, colVal2, 45);
}

static addToolBars( const page, const edit )
{
	new pagebuttonOffset = ( edit ? lastPage * 2 : lastPage );

	rowY = 10 + rowDistance * 11;
	if( page != 1 )
	{
		gui_addButton( GUI_CHARPROP, col1XTxt,  rowY+2, 1210, 1210, (1 + pagebuttonOffset) );
		gui_addButton( GUI_CHARPROP,  40,  rowY+2, 1210, 1210, ( page == 1 ? (1 + pagebuttonOffset) : (pagebuttonOffset + page - 1) ) );
	}
	if( page != lastPage )
	{
		gui_addButton( GUI_CHARPROP, 310,  rowY+2, 1210, 1210, ( page == lastPage ? (pagebuttonOffset + lastPage) : (pagebuttonOffset + page + 1) ) );
		gui_addButton( GUI_CHARPROP, 335,  rowY+2, 1210, 1210, (pagebuttonOffset + lastPage) );
	}
	gui_addTiledGump(  GUI_CHARPROP,  col1X,  rowY, 342, rowHeight, colBackGump, 0 );
	gui_addText(	   GUI_CHARPROP,  col1XTxt, rowY+2, "|<", 45);
	gui_addText(	   GUI_CHARPROP,  40, rowY+2, "<", 45);
	gui_addText(	   GUI_CHARPROP,  312, rowY+2, ">", 45);
	gui_addText(	   GUI_CHARPROP,  337, rowY+2, ">|", 45);
}

