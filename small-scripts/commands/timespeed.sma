/*!
\defgroup script_command_timespeed 'timespeed
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_timespeed(const chr)
\brief timespeeds

<B>syntax:</B> 'timespeed seconds
*/
public cmd_timespeed(chr)
{
	getCommandParams(chr);
	
	new seconds = 60;
	if(isStrInt(__cmdParams[0]))
		seconds = str2Int(__cmdParams[0]);
	else return;
	
	secondsPerUoMinute(seconds);
}

/*! }@ */