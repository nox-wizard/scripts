// Define the gump id
// Note: users gumps must have an id >= 999
#define MYGUMP 1000

const btnFirst = 1;
const btnSecond = 2;

public gumpCallback( const gump, const serial, const button, const pc )
{
	switch( button )
	{
		case btnFirst:
			printf( "^nButton 1 pressed" );
		case btnSecond:
			printf( "^nButton 2 pressed" );
	}
}


/*!
\fn showGump( const pc )
\author Luxor
\brief This function creates a gump and shows it to a character
*/
public showGump( const chr )
{

	//
	// Make sure that the gump engine deleted the last gump with this id
	//
	gui_delete( MYGUMP );

	//
	// Create the gump (if there's error return)
	//
	if ( !gui_create( MYGUMP, 0, 0, 1, 1, 1, pc ) )
		return;

	//
	// Set the callback function
	//
	gui_setCallback( MYGUMP, "gumpCallback" );

	gui_addPage( MYGUMP, 0 );
	gui_addResizeGump( MYGUMP, 0, 0, 0xA3C, 300, 400 );
	
	gui_addText( MYGUMP, 100, 5, "Tutorial :)", WHITE );
	
	gui_addButton( MYGUMP, 10, 50, 0x4B9, 0x4B9, btnFirst );
	gui_addButton( MYGUMP, 10, 70, 0x4B9, 0x4B9, btnSecond );
	
	//
	// Show the gump
	//
	gui_show( MYGUMP, chr );

	//
	// Delete it! Very important!!
	//
	gui_delete( MYGUMP );
}