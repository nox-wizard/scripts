/*!
\defgroup script_command_shutdown 'shutdown
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_shutdown(const chr)
\brief shutdowns

<B>syntax:</B> 'shutdown seconds
*/
public cmd_shutdown(chr)
{
	readCommandParams(chr);
	
	new delay = 60;
	if(isStrInt(__cmdParams[0]))
		delay = str2Int(__cmdParams[0]);
	
	shutdown(delay);
}

/*! }@ */