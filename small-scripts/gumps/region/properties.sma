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
static lastPage		= 0;
static const rowsPerPage= 12;
static currentPageRow	= 0;
//
// Field identifiers
//
//static const propName		= 1;
//static const propMidi		= 2;
static const propGuarded	= 3;
static const propMark		= 4;
static const propGate		= 5;
static const propRecall		= 6;
//static const propRaining	= 7;
//static const propSnowing	= 8;
static const propMagic		= 9;
//static const propGuardOwner	= 10;
//static const propSnowChance	= 11;
//static const propRainChance	= 12;
//static const propDryChance	= 13;
//static const propKeepChance	= 14;
//
// Button Identifiers
//
static const buttonCancel	= 0;
static const buttonApply	= 1;


public gui_rgnPropsResp( const gump, const serial, const button, const pc )
{
	if( button == buttonApply )
	{
		new stringMode = getStringMode();
		//
		// switch to packed string mode
		//
		if( !stringMode )
			setStringMode( 1 );

		new newString[64];	// packed string arrays for max 256 chars including trailing '/0'
		new newNumeric;
		new oldNumeric;
		//
		// process changes to: Guarded
		// ---------------------------
		//
		gui_getInputField( propGuarded, newString );
		oldNumeric = rgn_isGuarded( serial );
		newNumeric = prop2Boolean( newString, oldNumeric );
		if( newNumeric != oldNumeric )
		{
			rgn_setGuarded( serial, newNumeric );
		}
		//
		// process changes to: Markable
		// ----------------------------
		//
		gui_getInputField( propMark, newString );
		oldNumeric = rgn_canMark( serial );
		newNumeric = prop2Boolean( newString, oldNumeric );
		if( newNumeric != oldNumeric )
		{
			rgn_setMark( serial, newNumeric );
		}
		//
		// process changes to: Gate allowed
		// --------------------------------
		//
		gui_getInputField( propGate, newString );
		oldNumeric = rgn_canGate( serial );
		newNumeric = prop2Boolean( newString, oldNumeric );
		if( newNumeric != oldNumeric )
		{
			rgn_setGate( serial, newNumeric );
		}
		//
		// process changes to: Recall allowed
		// ----------------------------------
		//
		gui_getInputField( propGate, newString );
		oldNumeric = rgn_canRecall( serial );
		newNumeric = prop2Boolean( newString, oldNumeric );
		if( newNumeric != oldNumeric )
		{
			rgn_setRecall( serial, newNumeric );
		}
		//
		// process changes to: No magic damage
		// -----------------------------------
		//
		gui_getInputField( propGate, newString );
		oldNumeric = rgn_noMagicDamage( serial );
		newNumeric = prop2Boolean( newString, oldNumeric );
		if( newNumeric != oldNumeric )
		{
			rgn_setMagicDamage( serial, newNumeric );
		}
		//
		// reset original stringmode
		//
		setStringMode( stringMode );
		gui_rgnProps( serial, pc, 0 );
	}
}

public gui_rgnProps( const region, const showToWhom, const edit )
{
	rowDistance	= rowSpacing + rowHeight;
	col2X		= col1X + col1Len + colSpacing;
	col1XTxt	= col1X + 5;
	col2XTxt	= col2X + 5;

	gui_delete( GUI_RGNPROP );
	if( gui_create( GUI_RGNPROP, 0, 0, 1, 1, 1, region ) )
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
		gui_addPage( GUI_RGNPROP, lastPage );
		if( edit )
		{
			gui_addResizeGump( GUI_RGNPROP, 0, 0, 5120, 360, 365 );
			gui_addTiledGump(  GUI_RGNPROP,  10,  335, 342, rowHeight, colBackGump, 0 );
			gui_addButton( GUI_RGNPROP,  15, 337, 1209, 1209, buttonApply  );
			gui_addText( GUI_RGNPROP,  35, 337, "Apply", 45);
			gui_addButton( GUI_RGNPROP, 335, 337, 1209, 1209, buttonCancel );
			gui_addText( GUI_RGNPROP,  295, 337, "Cancel", 45);
		}
		else
			gui_addResizeGump( GUI_RGNPROP, 0, 0, 5120, 360, 345 );
		//
		// 	Form Title
		//
		rowY = 10;
		gui_addTiledGump( GUI_RGNPROP,  10,  rowY, 342, rowHeight, colBackGump, 0 );
		gui_addText( GUI_RGNPROP, 50, rowY+2, "NoX-Wizard - Region Properties", 45);
		gui_addPage( GUI_RGNPROP, ++lastPage );
		//
		// 	Character properties
		//
		addProperty( "Class", "Dynamic" );
		//
		addProperty( "", "Region" );
		//
		sprintf( str, "%d", region );
		addProperty( "Id", str );
		//
		rgn_getName( region, str );
		addProperty( "Name", str );
		//
		addProperty( "Guarded", (rgn_isGuarded( region ) ? "True" : "False" ), 0, 0, ( edit ? propGuarded : 0 ) );
		//
		addProperty( "Mark allowed", (rgn_canMark( region ) ? "True" : "False" ), 0, 0, ( edit ? propMark : 0 ) );
		//
		addProperty( "Gate allowed", (rgn_canGate( region ) ? "True" : "False" ), 0, 0, ( edit ? propGate : 0 ) );
		//
		addProperty( "Recall allowed", (rgn_canRecall( region ) ? "True" : "False" ), 0, 0, ( edit ? propRecall : 0 ) );
		//
		addProperty( "No magic damage", (rgn_noMagicDamage( region ) ? "True" : "False" ), 0, 0, ( edit ? propMagic : 0 ) );
		//
		addToolBars();
		//
		gui_show( GUI_RGNPROP, showToWhom );
		gui_delete( GUI_RGNPROP );
	}
}

static addProperty( const colVal1[], colVal2[], const cropCol1 = 0, const cropCol2 = 0, const editField = 0 )
{
	if( ++currentPageRow == rowsPerPage )
	{
		gui_addPage( GUI_RGNPROP, ++lastPage );
		currentPageRow = 2;
		rowY = 10;
	}
	rowY += rowDistance;
	gui_addTiledGump( GUI_RGNPROP, col1X,   rowY,   col1Len, rowHeight, colBackGump, 0 );
	if ( cropCol1 )
		gui_addCroppedText( GUI_RGNPROP, col1XTxt, rowY+2, col1Len, rowHeight, colVal1, 45);
	else
		gui_addText( GUI_RGNPROP, col1XTxt,rowY+2, colVal1, 45);
	gui_addTiledGump( GUI_RGNPROP, col2X,   rowY,   col2Len, rowHeight, colBackGump, 0 );
	if( editField )
		gui_addInputField( GUI_RGNPROP, col2XTxt, rowY+2, col2Len, rowHeight, editField, colVal2, 11);
	else
		if( cropCol2 )
			gui_addCroppedText( GUI_RGNPROP, col2XTxt,rowY+2, col2Len, rowHeight, colVal2, 45);
		else
			gui_addText( GUI_RGNPROP, col2XTxt,rowY+2, colVal2, 45);
}

static addToolBars()
{
	rowY = 10 + rowDistance * 11;
	for(new page = 1; page <= lastPage; ++page)
	{
		gui_addPage( GUI_RGNPROP, page );
		gui_addPageButton( GUI_RGNPROP, col1XTxt,  rowY+2, 1210, 1210, 1 );
		gui_addPageButton( GUI_RGNPROP,  40,  rowY+2, 1210, 1210, ( page == 1 ? 1 : page - 1) );
		gui_addPageButton( GUI_RGNPROP, 310,  rowY+2, 1210, 1210, ( page == lastPage ? lastPage : page + 1 ) );
		gui_addPageButton( GUI_RGNPROP, 335,  rowY+2, 1210, 1210, lastPage );
		gui_addTiledGump(  GUI_RGNPROP,  col1X,  rowY, 342, rowHeight, colBackGump, 0 );
		gui_addText(	   GUI_RGNPROP,  col1XTxt, rowY+2, "|<", 45);
		gui_addText(	   GUI_RGNPROP,  40, rowY+2, "<", 45);
		gui_addText(	   GUI_RGNPROP,  312, rowY+2, ">", 45);
		gui_addText(	   GUI_RGNPROP,  337, rowY+2, ">|", 45);
	}
}

