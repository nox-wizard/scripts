/*!
\defgroup script_commands_setmoreb12 'setmoreb12
\ingroup script_commands

@{
*/

/*!
\author Horian according to fax system
\fn cmd_setmoreb12(const chr)
\brief setmoreb12s an item

<B>syntax:<B> 'setmoreb12 value ["t"]
<UL>
	<LI> "t": bypass command area and get a target
<LI>
If area effect is active, all items in area will have moreb12 set.
*/
public cmd_setmoreb12(const chr)
{
	readCommandParams(chr);

	if(!strlen(__cmdParams[0]) )
	{
		chr_message(chr,_,msg_commandsDef[223]);
		return;
	}

	if(!isStrInt(__cmdParams[0]))
	{
		chr_message(chr,_,msg_commandsDef[109]);
		return;
	}

	new moreb12 = str2Int(__cmdParams[0]);



	new area = chr_getCmdArea(chr);
	new i = 0, item;
	//apply command to all items in area
	if(area_isValid(area) && __cmdParams[1][0] != 't')
	{
		area_useCommand(area);
		for(set_rewind(area_items(area)); !set_end(area_items(area)); i++)
		{
				item = set_getItem(area_items(area));
				itm_setProperty(item, IP_MOREB, 1, moreb12%256);
				itm_setProperty(item, IP_MOREB, 2, moreb12/256);
		}

		chr_message(chr,_,msg_commandsDef[224],i);		
		return;
	}

	chr_message(chr,_,msg_commandsDef[225]);
	target_create(chr,moreb12,_,_,"cmd_moreb12_targ");
}

/*!
\author Fax
\fn cmd_targ_setmoreb12(target, chr, object, x, y, z, unused, value)
\params all standard target callback params
*/
public cmd_moreb12_targ(target, chr, object, x, y, z, unused, moreb12)
{
	if(isItem(object))
	{
		itm_setProperty(target, IP_MOREB, 1, moreb12%256);
		itm_setProperty(target, IP_MOREB, 2, moreb12/256);
		chr_message(chr,_,msg_commandsDef[226],(itm_getProperty(object,IP_MOREB,1)&0xff) + ((itm_getProperty(object,IP_MOREB,2)&0xff)<<8) );
	}
	else chr_message(chr,_,msg_commandsDef[103]);
}

/*! }@ */