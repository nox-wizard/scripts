/*!
\defgroup script_command_gmopen 'gmopen
\ingroup script_commands

@{
*/

/*!
\author Fax(const chr)
\fn cmd_gmopen
\brief opens a character's backpack

<B>syntax:<B> 'gmopen [special]
<UL>
	<LI> special: can be 26(sell) 27(buy) 28(bought)
</UL>

the targetted character's backpack will be opened
*/
public cmd_gmopen(const chr)
{
	readCommandParams(chr);
	new type;
	if(strlen(__cmdParams[0]))
		type = str2Int(__cmdParams[0]);
		
	chr_message(chr,_,msg_commandsDef[141]);
	target_create(chr,type,_,_,"cmd_gmopen_targ");
}

/*!
\author Fax
\fn cmd_gmopen_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and gmopening
*/
public cmd_gmopen_targ(target, chr, object, x, y, z, unused, layer)
{
	if(isChar(object))
	{
		new cont = chr_getItemOnLayer(object,layer);
		
		if(!isItem(cont))
		{
			chr_message(chr,_,msg_commandsDef[142],layer);
			return;
		}

		if(itm_getProperty(cont,IP_TYPE) == ITYPE_CONTAINER)
			itm_showContainer(cont,chr);
		else chr_message(chr,_,msg_commandsDef[270],layer);
	}
	else chr_message(chr,_,msg_commandsDef[32]);
}

/*! }@ */