/*!
\defgroup script_command_heal 'heal
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_heal(const chr)
\brief heals a character

<B>syntax:<B> 'heal 
<B>command params:</B>
<UL>
<LI> "target": pass this parameter if you want to bypass the area effect
</UL>

If area effect is active, all characters in area will be healed.
If no area effect is active, or if you pass "target", a target will appear and only 
the targetted char will be healed
*/
public cmd_heal(const chr)
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
					chr_setProperty(chr,CP_STRENGTH,CP2_HP,chr_getProperty(chr,CP_STRENGTH,CP2_REAL));
		}

		chr_message(chr,_,"%d characters set to full stats",i);
		return;
	}

	//if we are here it means we need a target
	chr_message(chr,_,"Select a character to raise stats");
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
		chr_message(chr,_,"stats raised");
	}
	else chr_message(chr,_,"You must target a character");
}

/*! }@ */