/*!
\defgroup script_command_showbank 'showbank
\ingroup script_commands

@{
*/

/*!
\author Fax(const chr)
\fn cmd_showbank
\brief opens a character's bankbox

<B>syntax:<B> 'showbank ["gold"]
<UL>
<LI> "gold": pass "gold" if you want to open gold-only bank
</UL>

the targetted character's bankbox will be opened
*/
public cmd_showbank(const chr)
{
	new type = BANKBOX_NORMAL;
	if(!strcmp(__cmdParams[0],"gold"))
		type = BANKBOX_GOLDONLY;

	chr_message(chr,_,msg_commandsDef[246]);
	target_create(chr,type,_,_,"cmd_showbank_targ");
}

/*!
\author Fax
\fn cmd_showbank_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and showbanking
*/
public cmd_showbank_targ(target, chr, object, x, y, z, unused, type)
{
	if(isChar(object))
	{
		new bank = chr_getBankBox(object,type);
		if(!isItem(bank))
		{
			chr_message(chr,_,msg_commandsDef[247]);
			return;
		}
		itm_showContainer(bank,chr);
	}
	else chr_message(chr,_,msg_commandsDef[32]);
}

/*! }@ */