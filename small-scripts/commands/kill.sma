/*!
\defgroup script_command_kill 'kill
\ingroup script_commands

@{
*/

/*!
\author Fax(const chr)
\fn cmd_kill
\brief kills a character

<B>syntax:<B> 'kill ["t"]
<B>command params:</B>
<UL>
	<LI> "t": bypass command area and get a target
</UL>

If area effect is active, all characters in area will die.
*/
public cmd_kill(const chr)
{
	
	readCommandParams(chr);

	new area = chr_getCmdArea(chr);
	new i = 0, chr2;
	//apply command to all characters in area
	if(area_isValid(area) && __cmdParams[0][0] != 't')
	{
		area_useCommand(area);
		for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
		{
				chr2 = set_getChar(area_chars(area));
				if(chr2 != chr) chr_kill(chr2);
		}

		chr_message(chr,_,msg_commandsDef[165],i);
		area_refresh(area);	
		return;
	}

	chr_message(chr,_,msg_commandsDef[166]);
	target_create(chr,area,_,_,"cmd_kill_targ");
}

/*!
\author Fax
\fn cmd_kill_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and killing
*/
public cmd_kill_targ(target, chr, object, x, y, z, unused, area)
{
	if(isChar(object))
	{
		chr_kill(object);
		area_refresh(area);
	}
	else chr_message(chr,_,msg_commandsDef[32]);
}

/*! }@ */