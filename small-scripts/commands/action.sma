/*!
\defgroup script_command_action 'action
\ingroup script_commands
\brief makes character perform an action

\b syntax: 'action action
- action: the action code, from \ref ACTION_ constants
@{
*/

/*!
\author Fax(const chr)
\fn cmd_action(const chr)
\param chr: the character who used the command
\since 0.82
\brief 'action command start function

This function is called by sources on 'action command detection.\n
You can change it in commands.txt.
*/
public cmd_action(const chr)
{
	readCommandParams(chr);
	
	if(!isStrInt(__cmdParams[0]))
	{
		chr_message(chr,_,msg_commandsDef[79]);
		return;
	}
	
	new act = str2Int(__cmdParams[0]);
	chr_message(chr,_,msg_commandsDef[80]);
	target_create(chr,act,_,_,"cmd_action_targ");
}

/*!
\author Fax
\fn cmd_action_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and actioning
*/
public cmd_action_targ(target, chr, object, x, y, z, unused, action)
{
	if(isChar(object))
		chr_action(object,action)
	else chr_message(chr,_,msg_commandsDef[32]);
}

/*! }@ */