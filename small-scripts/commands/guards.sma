/*!
\defgroup script_command_guards 'guards
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_guards(const chr)
\brief guardss accounts/XSS/commands/small

<B>syntax:</B> 'guards "on"/"off" [region]
<UL>
	<LI>"on"/"off": switch guards on or off
	<LI>region: if left blank all regions will be affected, else only the given region
<UL>

<br>
*/
public cmd_guards(chr)
{
	readCommandParams(chr);
	
	new status = 1;
	if(!strcmp(__cmdParams[0],"off"))
		status = 0;
	
	if(strlen(__cmdParams[1]))
		rgn_setGuarded(str2Int(__cmdParams[1]),status);
	else
		for(new r = 0; r < 255; r++)
			rgn_setGuarded(r,status);
}

/*! }@ */