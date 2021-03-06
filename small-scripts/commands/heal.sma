/*!
\defgroup script_command_heal 'heal
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_heal(const chr)
\brief heals a character

<B>syntax:<B> 'heal ["t"] 
<B>command params:</B>
<UL>
	<LI> "t": bypass command area and get a target
</UL>

If area effect is active, all characters in area will be healed.
*/
public cmd_heal(const chr)
{
	readCommandParams(chr);

	//parameters handling, if no parameters are given, keep defaults, else
	//read them

	
	new area = chr_getCmdArea(chr);
	new chr2,i = 0;
	//apply command to all characters in area if an area is defined
	if(area_isValid(area) && __cmdParams[0][0] != 't')
	{
		area_useCommand(area);
		for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
		{
				chr2 = set_getChar(area_chars(area));
				if(chr2 != chr)
					chr_setProperty(chr,CP_STRENGTH,CP2_HP,chr_getProperty(chr,CP_STRENGTH,CP2_REAL));
		}

		chr_message(chr,_,msg_commandsDef[147],i);
		return;
	}

	//if we are here it means we need a target
	chr_message(chr,_,msg_commandsDef[148]);
	target_create(chr,_,_,_,"cmd_heal_targ");
}

/*!
\author Fax
\fn cmd_heal_targ(target, chr, object, x, y, z, unused, freeze)
\params all standard target callback params
\brief handles single character targetting and freezing
*/
public cmd_heal_targ(target, chr, object, x, y, z, unused, unused2)
{
	if(isChar(object))
	{
		chr_setProperty(chr,CP_STRENGTH,CP2_HP,chr_getProperty(chr,CP_STRENGTH,CP2_REAL));
		chr_message(chr,_,msg_commandsDef[149]);
	}
	else chr_message(chr,_,msg_commandsDef[32]);
}

/*! }@ */