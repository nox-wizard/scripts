
#include "small-scripts/commands/tweak/tweak.sma"
#include "small-scripts/commands/stats/stats.sma"
#include "small-scripts/commands/options/options.sma"
#include "small-scripts/commands/skills/skills.sma"

public command_tweak( const caller )
{
	chr_message(caller, _, "Select Object to tweak.. ");
	target_create( caller, _, _, _, "target_tweak");
}

public command_playerlist( const caller )
{
	new set=set_create();
	
	set_addAllOnlinePl( set );
	
	new count=set_size(set);
	if( count==1 ) {
		chr_message(caller,_ , "No other player connected" );
		set_delete(set);
		return;
	}
	
	new menu = gui_create( 50, 50, true, true, true, "handle_playerlist" );
	gui_addGump( menu, 0, 0, 0x0027, 0 );
	gui_addText( menu, 20, 4, _, "User Online : " );
	gui_addText( menu, 150, 4, _, "%d", count );
	
	const chrForPage = 14;
	new page=1;
	new i=0;
	for( set_rewind(set); !set_end(set); ++i ) {
	
		new chr=set_getChar(set);

		if( (i%chrForPage)==0 ) {
			gui_addPage( menu, page );
			if( page>1 )
				gui_addPageButton( menu, 205,   6, 0x824, GUMP_INVALID, page-1 );
			if( page<=(count/chrForPage) )
				gui_addPageButton( menu, 202, 265, 0x825, GUMP_INVALID, page+1 );
			++page;
		}
	
		gui_addButton( menu, 32, 39+(i%chrForPage)*15, 0x4B9, 0x4BA, chr );
		new str[100];
		chr_getProperty( chr, CP_STR_NAME, 0, str );
		gui_addText( menu, 52, 35+(i%chrForPage)*15, _, str );

	}
	
	set_delete(set);
	
	gui_show( menu, caller);
}

public handle_playerlist( const caller, const menu, const button )
{
	if( button==MENU_CLOSED )
		return;
		
	options_char( caller, button );
}




public command_stats( const caller )
{
	chr_message(caller, _, "Select object to inspect.. " );
	target_create( caller, _, _, _, "target_stats");
}

public command_options( const caller )
{
	chr_message(caller, _, "Select object.. ");
	target_create( caller, _, _, _, "target_options");
}

public command_skills( const caller )
{
	chr_message(caller, _, "Select character.. "); 
	target_create( caller, _, _, _, "target_skills");
}
