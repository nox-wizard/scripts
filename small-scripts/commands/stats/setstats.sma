#include "small-scripts/commands/stats/statsmenu.sma"

/*!
\defgroup script_command_setstats 'setstats
\ingroup script_commands

@{
*/
/*!
\author Fax
\fn
\param chr: the character
\since 0.82
\brief sets character's stats
<b>syntax</b> 'setstats

\return nothing
*/
public cmd_setstats( const caller )
{
	chr_message(caller, _, "Select character.. "); 
	target_create( caller,_, _, _, "target_setstats");
}

public target_setstats( const target, const caller, const chr,x,y,z,unused,skillValue)
{
	if(!isChar(chr)) 
	{
		chr_message(caller,_ , "Skills work only on character" );
		return;
	}
	
	menu_stats_char( caller, chr, true );
}
/*! }@ */