#include "small-scripts/commands/stats/statsmenu.sma"

/*!
\defgroup script_command_stats_menu menu
\ingroup script_commands_stats

@{
*/

/*!
\author Fax
\fn cmd_stats(const chr)
\brief shows character's stats

<B>syntax:</B> 'stats
Shows a small ingame menu that allows all kinds of modifications to chars and items<BR>
<br>
*/

public cmd_stats( const chr )
{
	menu_stats_char(chr,chr,false);
}

/*! }@ */