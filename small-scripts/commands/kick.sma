/*!
\defgroup script_command_kick 'kick
\ingroup script_commands

@{
*/

/*!
\author Fax(const chr)
\fn cmd_kick
\brief kicks a character

<B>syntax:<B> 'kick 

the targetted character will be disconnected from server
*/
public cmd_kick(const chr)
{
	readCommandParams(chr);
	
	if(!strlen(__cmdParams[0]))
	{
		chr_message(chr,_,msg_commandsDef[274]);
		target_create(chr,_,_,_,"cmd_kick_targ");
	}
	else chr_disconnect(str2Int(__cmdParams[0]));
}

/*!
\author Fax
\fn cmd_kick_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and kicking
*/
public cmd_kick_targ(target, chr, object, x, y, z, unused, unused1)
{
	if(isChar(object))
		chr_disconnect(chr);
	else chr_message(chr,_,msg_commandsDef[32]);
}

/*! }@ */