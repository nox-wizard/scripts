
/*!
\defgroup script_command_gmhide 'gmhide
\ingroup script_commands

@{
*/

/*!
\author SlasHeR
\fn cmd_gmhide(const chr)
\brief hides a gm-character permanently

<B>syntax:<B> 'gmhide ["on"/"off"]
<B>command params:</B>
<UL>
<LI>	<UL>
	<LI>"on": hides character
	<LI>"off": unhides character
	</UL>
</UL>
*/
public cmd_gmhide(const chr)
{
	readCommandParams(chr);
	log_message("0: %s, 1: %s",__cmdParams[0],__cmdParams[1]);
	if(!strcmp(__cmdParams[0],"on"))
	{
		chr_setProperty( chr, 121, _, chr_getProperty( chr, 121 ) | 8 );
		chr_setProperty( chr, 110, _, 2 );
		chr_update( chr );
		chr_message( chr,_,"You are now permanently hidden." );
	}
	else if(!strcmp(__cmdParams[0],"off"))
	{
		chr_setProperty( chr, 110, _, 0);
		chr_setProperty( chr, 121, _, chr_getProperty( chr, 121) &~ 8 );
		chr_update( chr );
		chr_message( chr,_,"You are now visible again." );
	}
	else
	{
		chr_message(chr, _, "Syntax: 'gmhide [on/off]");
		return;
	}
	return;
}

/*! }@ */
