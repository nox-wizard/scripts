/*!
\defgroup script_command_killbeard 'killbeard
\ingroup script_commands

@{
*/

/*!
\author Fax(const chr)
\fn cmd_killbeard
\brief removes character's beard

<B>syntax:<B> 'killbeard
*/
public cmd_killbeard(const chr)
{
	chr_message(chr,_,msg_commandsDef[167]);
	target_create(chr,_,_,_,"cmd_killbeard_targ");
}

/*!
\author Fax
\fn cmd_killbeard_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and killbearding
*/
public cmd_killbeard_targ(target, chr, object, x, y, z, unused, unused1)
{
	if(isChar(object))
	{
		new beard = chr_getItemOnLayer(chr,LAYER_BEARD);
		if(isItem(beard))
			itm_remove(beard);
	}
	else chr_message(chr,_,msg_commandsDef[32]);
}

/*! }@ */