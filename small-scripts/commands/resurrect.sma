/*!
\defgroup script_command_freeze 'freeze
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_resurrect(const chr)
\brief resurrects a character

<B>syntax:<B> 'resurrect ["t"]
<B>command params:</B>
<UL>
	<LI> "t": bypass command area and get a target
</UL>

If area effect is active, all characters in area will be resurrected.
*/
public cmd_resurrect(const chr)
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
				if(chr2 != chr) chr_resurrect(chr2);
		}

		chr_message(chr,_,msg_commandsDef[217],i);
		return;
	}

	//if we are here it means we need a target
	chr_message(chr,_,msg_commandsDef[218]);
	target_create(chr,_,_,_,"cmd_resurrect_targ");
}

/*!
\author Fax
\fn cmd_resurrect_targ(target, chr, object, x, y, z, unused, freeze)
\params all standard target callback params
\brief handles single character targetting and freezing
*/
public cmd_resurrect_targ(target, chr, object, x, y, z, unused, unused2)
{
	if(isChar(object))
	{
		chr_resurrect(object);
		chr_message(chr,_,msg_commandsDef[219]);
	}
	else chr_message(chr,_,msg_commandsDef[32]);
}

/*! }@ */