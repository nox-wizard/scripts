/*!
\defgroup script_command_killhair 'killhair
\ingroup script_commands

@{
*/

/*!
\author Fax(const chr)
\fn cmd_killhair
\brief removes character's hair

<B>syntax:<B> 'killhair
*/
public cmd_killhair(const chr)
{
	chr_message(chr,_,"Select a character to kill his hair");
	target_create(chr,_,_,_,"cmd_killhair_targ");
}

/*!
\author Fax
\fn cmd_killhair_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and killhairing
*/
public cmd_killhair_targ(target, chr, object, x, y, z, unused, unused1)
{
	if(isChar(object))
	{
		new hair = chr_getItemOnLayer(chr,LAYER_HAIR);
		if(isItem(hair))
			itm_remove(hair);
	}
	else chr_message(chr,_,"You must target a character");
}

/*! }@ */