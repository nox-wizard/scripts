
#include "small-scripts/commands/tweak/tweak.sma"
#include "small-scripts/commands/stats/stats.sma"
#include "small-scripts/commands/options/options.sma"
#include "small-scripts/commands/skills/skills.sma"

public command_tweak( const socket )
{
	getTarget( socket, funcidx("target_tweak"), "Select Object to tweak.. " );
}

public command_playerlist( const socket )
{
	new set=set_create();
	
	set_addAllOnlinePl( set );
	
	new count=set_size(set);
	/*if( count==1 ) {
		nprintf( socket, "No other player connected" );
		set_delete(set);
		return;
	}*/
	
	new menu = menu_create( 50, 50, true, true, true, "handle_playerlist" );
	menu_addGump( menu, 0, 0, 0x0027, 0 );
	
	const chrForPage = 14;
	new page=1;
	new i=0;
	for( set_rewind(set); !set_end(set); ++i ) {
	
		new chr=set_getChar(set);

		if( (i%chrForPage)==0 ) {
			menu_addPage( menu, page );
			if( page>1 )
				menu_addPageButton( menu, 205,   6, 0x824, GUMP_INVALID, page-1 );
			if( page<=(count/chrForPage) )
				menu_addPageButton( menu, 202, 265, 0x825, GUMP_INVALID, page+1 );
			++page;
		}
	
		menu_addButton( menu, 32, 39+(i%chrForPage)*15, 0x4B9, 0x4BA, chr );
		new str[100];
		chr_getProperty( chr, CP_STR_NAME, 0, str );
		menu_addText( menu, 52, 35+(i%chrForPage)*15, _, str );

	}
	
	set_delete(set);
	
	menu_show( menu, getCharFromSocket(socket) );
}

public handle_playerlist( const socket, const menu, const button )
{
	if( button==MENU_CLOSED )
		return;
		
	options_char( socket, button );
}




public command_stats( const socket )
{
	getTarget( socket, funcidx("target_stats"), "Select object to inspect.. " );
}

public command_options( const socket )
{
	getTarget( socket, funcidx("target_options"), "Select object.. " );
}

public command_skills( const socket )
{
	getTarget( socket, funcidx("target_skills"), "Select character.. " );
}
