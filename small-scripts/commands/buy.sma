/*!
\defgroup script_command_buy 'buy
\ingroup script_commands

@{
*/

/*!
\author Fax(const chr)
\fn cmd_buy
\brief shows a venfor buy gump

<B>syntax:<B> 'buy 

the targetted character will show you his buy gump
*/
public cmd_buy(const chr)
{
	chr_message(chr,_,msg_commandsDef[31]);
	target_create(chr,_,_,_,"cmd_buy_targ");
}

/*!
\author Fax
\fn cmd_buy_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and buying
*/
public cmd_buy_targ(target, chr, object, x, y, z, unused, unused1)
{
	if(isChar(object))
		chr_showBuyGump(object,chr);
	else chr_message(chr,_,msg_commandsDef[32]);
}

/*! }@ */