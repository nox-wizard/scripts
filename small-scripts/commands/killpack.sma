/*!
\defgroup script_command_killpack 'killpack
\ingroup script_commands

@{
*/

/*!
\author Horian, analogoues to Fax killpack(const chr)
\fn cmd_killpack
\brief removes character's pack

<B>syntax:<B> 'killpack
*/
public cmd_killpack(const chr)
{
	chr_message(chr,_,msg_commandsDef[167]);
	target_create(chr,_,_,_,"cmd_killpack_targ");
}

/*!
\author Horian
\fn cmd_killpack_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and killpacking
*/
public cmd_killpack_targ(target, chr, object, x, y, z, unused, unused1)
{
	if(isChar(object))
	{
		new pack = chr_getItemOnLayer(chr,LAYER_BACKPACK);
		if(isItem(pack))
			itm_remove(pack);
	}
	else chr_message(chr,_,msg_commandsDef[32]);
}

/*! }@ */