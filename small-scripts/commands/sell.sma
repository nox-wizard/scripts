/*!
\defgroup script_command_sell 'sell
\ingroup script_commands

@{
*/

/*!
\author Fax(const chr)
\fn cmd_sell
\brief shows a venfor sell gump

<B>syntax:<B> 'sell 

the targetted character will show you his sell gump
*/
public cmd_sell(const chr)
{
	chr_message(chr,_,msg_commandsDef[31]);
	target_create(chr,_,_,_,"cmd_soll_targ");
}

/*!
\author Fax
\fn cmd_sell_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and selling
*/
public cmd_soll_targ(target, chr, object, x, y, z, unused, unused1)
{
	if(isChar(object))
		chr_showSellGump(object,chr);
	else
	{
	chr_message(chr,_,msg_commandsDef[32]);
	chr_message(chr,_,"sell call");
	}
}

/*! }@ */