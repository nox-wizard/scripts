#include "small-scripts/commands/page/pagemenu.sma"

/*!
\defgroup script_commands_pages
\ingroup script_commands

@{
*/

/*!
\author Fax
\since 0.82
\fn cmd_pages(const chr)
\brief shows the targetted character's pages

<B>syntax:<B> 'pages

Use this command to see a character's pages
*/
public cmd_pages(const chr)
{
	chr_message(chr,_,"Select the character you want to see the pages");
	target_create(chr,_,_,_,"cmd_pages_cback");
}

public cmd_pages_cback(const t, const chr, const object, x, y, z, unused, unused1)
{
	if(!isChar(object) || chr_isNpc(object))
	{
		chr_message(chr,_,"You must target a player");
		return;
	}

	drawPageListMenu(chr,object);
}
/*! @}*/