/*!
\defgroup script_command_random 'random
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_random(const chr)
\brief applies a command randomly on online players

<B>syntax:</B> 'random chance command [param]
<UL>
	<LI> chance: the chance that a character is affected by command, in %
	<LI> command: the command to perform (without ')
	<LI> param: the param to pass to the command
</UL>

This command apllies a given command randomly on online characters.<br>
The applied command can only be a command with 0 or 1 parameters.<br>
If the command takes a parameter you can specify it with param.<br>
Examples:
- 'random 10 kill : kills 10% of characters
- 'random 100 freeze 1 : freezes all charcaters


*/
public cmd_random(const chr)
{
	readCommandParams(chr);
	
	new chance = str2Int(__cmdParams[0]);
	
	if(!strlen(__cmdParams[1]))
		return;
	
	
	new function[AMX_FUNCTION_LENGTH];
	sprintf(function,"cmd_%s_targ",__cmdParams[1]);
	
	new s = set_create();
	set_addAllOnlinePl(s);
	
	new chr2,n;
	for(set_rewind(s); !set_end(s);)
	{
		chr2 = set_getChar(s);
		if(random(100) < chance)
		{
			callFunction3P(funcidx(function),INVALID,chr,chr2);		
			n++;
		}
	}
	
	set_delete(s);
	
	chr_message(chr,_,msg_commandsDef[276],n);
}

/*! }@ */