#include "small-scripts/commands/page/pagemenu.sma"

/*!
\defgroup script_commands_pagelist 'pagelist
\ingroup script_commands

@{
*/

/*!
\author Fax
\since 0.82
\fn cmd_pagelist(const chr)
\brief shows the GM page list ina gump

<B>syntax:<B> 'pagelist

Use this command tosee the GM page list
*/
public cmd_pagelist(const chr)
{
	drawPageListMenu(chr,INVALID);
}
/*! @}*/