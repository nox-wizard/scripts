/*!
\defgroup script_command_buy 'buy
\ingroup script_commands
\brief shows a venfor buy gump

\b syntax: 'buy 

the targetted character will show you his buy gump
@{
*/

/*!
\author Fax
\fn cmd_buy(const chr)
\param chr: the character who used the command
\brief 'buy command start function

This function is called by sources on 'buy command detection.\n
You can change it in commands.txt.
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