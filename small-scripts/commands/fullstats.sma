/*!
\defgroup script_command_fullstats 'fullstats
\ingroup script_commands
\brief raises all stats (hp,mana,stamina) to maximum

\b syntax: 'fullstats ["t"]
- "t": bypass command area and get a target

If area effect is active, all characters in area will have stats raised.

@{
*/

/*!
\author Fax
\fn cmd_fullstats(const chr)
\param chr: the character who used the command
\since 0.82
\brief 'fullstats command start function

This function is called by sources on 'fullstats command detection.\n
You can change it in commands.txt.
*/
public cmd_fullstats(const chr)
{
	readCommandParams(chr);

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
				{
					chr_setProperty(chr,CP_STRENGTH,CP2_HP,chr_getProperty(chr,CP_STRENGTH,CP2_REAL));
					chr_setProperty(chr,CP_DEXTERITY,CP2_STAMINA,chr_getProperty(chr,CP_DEXTERITY,CP2_REAL));
					chr_setProperty(chr,CP_INTELLIGENCE,CP2_MANA,chr_getProperty(chr,CP_INTELLIGENCE,CP2_REAL));
				}
		}

		chr_message(chr,_,msg_commandsDef[138],i);
		return;
	}

	//if we are here it means we need a target
	chr_message(chr,_,msg_commandsDef[139]);
	target_create(chr,_,_,_,"cmd_fullstats_targ");
}

/*!
\author Fax
\fn cmd_fullstats_targ(target, chr, object, x, y, z, unused, freeze)
\params all standard target callback params
\brief handles single character targetting and freezing
*/
public cmd_fullstats_targ(target, chr, object, x, y, z, unused, unused2)
{
	if(isChar(object))
	{
		chr_setProperty(chr,CP_STRENGTH,CP2_HP,chr_getProperty(chr,CP_STRENGTH,CP2_REAL));
		chr_setProperty(chr,CP_DEXTERITY,CP2_STAMINA,chr_getProperty(chr,CP_DEXTERITY,CP2_REAL));
		chr_setProperty(chr,CP_INTELLIGENCE,CP2_MANA,chr_getProperty(chr,CP_INTELLIGENCE,CP2_REAL));
		chr_message(chr,_,msg_commandsDef[140]);
	}
	else chr_message(chr,_,msg_commandsDef[32]);
}

/*! }@ */