/*!
\defgroup script_command_freeze 'freeze
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_freeze(const chr)
\brief freezes a character

<B>syntax:<B> 'freeze ["on"/"off"]
<B>command params:</B>
<UL>
	<UL>
	<LI> "on": freeze
	<LI> "off": off
	</UL>

</UL>

If area effect is active, all characters in area will be frozen.
*/
public cmd_freeze(const chr)
{
	readCommandParams(chr);

	new freeze = false;

	//parameters handling, if no parameters are given, keep defaults, else
	//read them
	if(!strlen(__cmdParams[0]))
	{
		chr_message(chr,_,msg_commandsDef[131]);
		return;
	}

	if(!strcmp(__cmdParams[0],"on"))
		freeze = true;
	else if(strcmp(__cmdParams[0],"off"))
		{
			chr_message(chr,_,msg_commandsDef[132]);
			return;
		}


	new area = chr_getCmdArea(chr);
	new chr2,i = 0;
	//apply command to all characters in area if an area is defined
	if(area_isValid(area))
	{
		area_useCommand(area);
		if(freeze)
		{
			for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
			{
					chr2 = set_getChar(area_chars(area));
					if(chr2 != chr) chr_freeze(chr2);
			}

			chr_message(chr,_,msg_commandsDef[133],i);
		}

		else
		{
			for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
			{
					chr2 = set_getChar(area_chars(area));
					if(chr2 != chr) chr_unfreeze(chr2);
			}
			chr_message(chr,_,msg_commandsDef[134],i);
		}	

		return;
	}

	//if we are here it means we need a target
	chr_message(chr,_,msg_commandsDef[135]);
	target_create(chr,freeze,_,_,"cmd_freeze_targ");
}

/*!
\author Fax
\fn cmd_freeze_targ(target, chr, object, x, y, z, unused, freeze)
\params all standard target callback params
\brief handles single character targetting and freezing
*/
public cmd_freeze_targ(target, chr, object, x, y, z, unused, freeze)
{
	if(isChar(object))
		if(freeze)
		{
			chr_freeze(object);
			chr_message(chr,_,msg_commandsDef[136]);
		}

		else 
		{
			chr_unfreeze(object);
			chr_message(chr,_,msg_commandsDef[137]);
		}
	else chr_message(chr,_,msg_commandsDef[32]);
}

/*! }@ */