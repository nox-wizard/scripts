/*!
\defgroup script_command_bolt 'bolt
\ingroup script_commands

@{
*/

/*!
\author Horian(const chr)
\fn cmd_bolt
\brief kills a character with showing a lightning bolt

<B>syntax:<B> 'bolt 
<B>command params:</B>
<UL>

</UL>

If area effect is active, all characters in area will die.
*/
public cmd_bolt(const chr)
{


	new area = chr_getCmdArea(chr);
	new i = 0, chr2;
	//apply command to all characters in area
	if(area_isValid(area))
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