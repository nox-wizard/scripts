#include "small-scripts/commands/page/pagemenu.sma"

/*!
\defgroup script_commands_solvepage 'solvepage
\ingroup script_commands

@{
*/

/*!
\author Fax
\since 0.82
\fn cmd_solvepage(const chr)
\brief solves targetted character's page

<B>syntax:<B> 'solvepage [n]
<B>params:</B>
<UL>
<LI> n: page index
<UL>

Use this command to solve a character's page, if you don't pass n all pages will be solved
*/
public cmd_solvepage(const chr)
{
	readCommandParams(chr);
	new page = INVALID;

	if(isStrInt(__cmdParams[0]))
		page = str2Int(__cmdParams[0]);

	chr_message(chr,_,msg_commandsDef[27]);
	target_create(chr,page,_,_,"cmd_solvepage_cback");
}

public cmd_solvepage_cback(const t, const chr, const object, x, y, z, unused, page)
{
	if(!isChar(object) || chr_isNpc(object))
	{
		chr_message(chr,_,msg_commandsDef[28]);
		return;
	}

	for(new p = 1; p <= MAX_GM_PAGES_PER_CHAR; p++)
		if(page == INVALID || p == page)
			chr_solveGmPage(object,p);
	
	if(page == INVALID)
		chr_message(chr,_,msg_commandsDef[266]);
	else 	if(page <= MAX_GM_PAGES_PER_CHAR) 
			chr_message(chr,_,msg_commandsDef[265],page);
}
/*! @}*/