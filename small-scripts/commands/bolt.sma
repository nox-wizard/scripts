/*!
\defgroup script_command_bolt 'bolt
\ingroup script_commands
\brief kills a character with showing a lightning bolt

\b syntax: 'bolt ["t"]
- "t": bypass command area and get a target

@{
*/

/*!
\author Horian(const chr)
\fn cmd_bolt
\brief start function for 'bolt command

This function is called by sources on 'bolt command detection.\n
You can change it in commands.txt.
*/
public cmd_bolt(const chr)
{
	
	readCommandParams(chr);

	new area = chr_getCmdArea(chr);
	new i = 0, chr2;
	//apply command to all characters in area
	if(area_isValid(area) && __cmdParams[1][0] != 't')
	{
		area_useCommand(area);
		for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
		{
				chr2 = set_getChar(area_chars(area));
				if(chr2 != chr) 
				{
					chr_kill(chr2);
					send_boltfx(chr2);
				}
		}

		chr_message(chr,_,msg_commandsDef[165],i);
		area_refresh(area);	
		return;
	}

	chr_message(chr,_,msg_commandsDef[166]);
	target_create(chr,area,_,_,"cmd_bolt_targ");
}

/*!
\author Fax
\fn cmd_bolt_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and bolting
*/
public cmd_bolt_targ(target, chr, object, x, y, z, unused, area)
{
	if(isChar(object))
	{
		chr_kill(object);
		send_boltfx(object);
		area_refresh(area);
	}
	else chr_message(chr,_,msg_commandsDef[32]);
}

/*! }@ */