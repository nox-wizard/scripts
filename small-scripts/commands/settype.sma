/*!
\defgroup script_commands_settype 'settype
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_settype(const chr)
\brief settypes an item

<B>syntax:<B> 'settype type

If area effect is active, all items in area will have type set.
If no area effect is active, or if you pass "target", a target will appear and only 
the targetted item will be affected.<br>
*/
public cmd_settype(const chr)
{
	readCommandParams(chr);

	if(!strlen(__cmdParams[0]) || !isStrInt(__cmdParams[0]))
	{
		chr_message(chr,_,msg_commandsDef[242]);
		return;
	}

	new type = str2Int(__cmdParams[0]);



	new area = chr_getCmdArea(chr);
	new i = 0, item;
	//apply command to all items in area
	if(area_isValid(area))
	{
		area_useCommand(area);
		for(set_rewind(area_items(area)); !set_end(area_items(area)); i++)
		{
				item = set_getItem(area_items(area));
				itm_setProperty(item,IP_TYPE,_,type);
		}

		chr_message(chr,_,msg_commandsDef[243],i);		
		return;
	}

	chr_message(chr,_,msg_commandsDef[244]);
	target_create(chr,type,_,_,"cmd_settype_targ");
}

/*!
\author Fax
\fn cmd_settype_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
*/
public cmd_settype_targ(target, chr, object, x, y, z, unused, type)
{
	if(isItem(object))
	{
		itm_setProperty(object,IP_TYPE,_,type);
		chr_message(chr,_,msg_commandsDef[245]);
	}
	else chr_message(chr,_,msg_commandsDef[103]);
}

/*! }@ */