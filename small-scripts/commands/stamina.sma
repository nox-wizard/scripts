/*!
\defgroup script_command_stamina 'stamina
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_stamina(const chr)
\brief staminas a character

<B>syntax:<B> 'stamina 
<B>command params:</B>
<UL>
<LI> "target": pass this parameter if you want to bypass the area effect
</UL>

If area effect is active, all characters in area will be staminaed.
*/
public cmd_stamina(const chr)
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
					chr_setProperty(chr,CP_DEXTERITY,CP2_STAMINA,chr_getProperty(chr,CP_DEXTERITY,CP2_REAL));
		}

		chr_message(chr,_,msg_commandsDef[248],i);
		return;
	}

	//if we are here it means we need a target
	chr_message(chr,_,msg_commandsDef[249]);
	target_create(chr,_,_,_,"cmd_stamina_targ");
}

/*!
\author Fax
\fn cmd_stamina_targ(target, chr, object, x, y, z, unused, freeze)
\params all standard target callback params
\brief handles single character targetting and freezing
*/
public cmd_stamina_targ(target, chr, object, x, y, z, unused, unused2)
{
	if(isChar(object))
	{
		chr_setProperty(chr,CP_DEXTERITY,CP2_STAMINA,chr_getProperty(chr,CP_DEXTERITY,CP2_REAL));
		chr_message(chr,_,msg_commandsDef[250]);
	}
	else chr_message(chr,_,msg_commandsDef[32]);
}

/*! }@ */