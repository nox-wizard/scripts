/*!
\defgroup script_command_mana 'mana
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_mana(const chr)
\brief refreshes mana to a character

<B>syntax:<B> 'mana 
<B>command params:</B>
<UL>
<LI> "target": pass this parameter if you want to bypass the area effect
</UL>

If area effect is active, all characters in area will have mana refreshed.
*/
public cmd_mana(const chr)
{
	readCommandParams(chr);

	//parameters handling, if no parameters are given, keep defaults, else
	//read them

	
	new area = chr_getCmdArea(chr);
	new chr2,i = 0;
	//apply command to all characters in area if an area is defined
	if(area_isValid(area))
	{
		area_useCommand(area);
		for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
		{
				chr2 = set_getChar(area_chars(area));
				if(chr2 != chr)
					chr_setProperty(chr,CP_INTELLIGENCE,CP2_MANA,chr_getProperty(chr,CP_INTELLIGENCE,CP2_REAL));
		}

		chr_message(chr,_,msg_commandsDef[138],i);
		return;
	}

	//if we are here it means we need a target
	chr_message(chr,_,msg_commandsDef[139]);
	target_create(chr,_,_,_,"cmd_mana_targ");
}

/*!
\author Fax
\fn cmd_mana_targ(target, chr, object, x, y, z, unused, freeze)
\params all standard target callback params
\brief handles single character targetting and freezing
*/
public cmd_mana_targ(target, chr, object, x, y, z, unused, unused2)
{
	if(isChar(object))
	{
		chr_setProperty(chr,CP_INTELLIGENCE,CP2_MANA,chr_getProperty(chr,CP_INTELLIGENCE,CP2_REAL));
		chr_message(chr,_,msg_commandsDef[140]);
	}
	else chr_message(chr,_,msg_commandsDef[32]);
}

/*! }@ */