/*!
\defgroup script_commands_dye 'dye
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_dye(const chr)
\brief dyes an item

<B>syntax:<B> 'dye color ["t"] 
<B>command params:</B>
<UL>
<UL>
	<LI> color: color code, integer or hexadecimal (preceded by 0x)
	<LI> "t": bypass command area and get a target
</UL>
</UL>

If area effect is active, all characters in area will be dyed.
\todo dye gump
*/
public cmd_dye(const chr)
{
	readCommandParams(chr);

	if(!strlen(__cmdParams[0]))
	{
		chr_message(chr,_,msg_commandsDef[125]);
		return;
	}

	new color;
	if(!isStrHex(__cmdParams[0]))
		if(!isStrInt(__cmdParams[0]))
		{
			chr_message(chr,_,msg_commandsDef[126]);
			return;
		}
		else color = str2Int(__cmdParams[0]);
	else color = str2Hex(__cmdParams[0]);


	new area = chr_getCmdArea(chr);
	new i = 0, item;
	//apply command to all items in area
	if(area_isValid(area) && __cmdParams[1][0] != 't')
	{
		area_useCommand(area);
		for(set_rewind(area_items(area)); !set_end(area_items(area)); i++)
		{
			item = set_getItem(area_items(area));
			itm_setProperty(item,IP_COLOR,_,color);
			itm_refresh(item);
		}
		chr_message(chr,_,msg_commandsDef[127],i);		
		return;
	}

	chr_message(chr,_,msg_commandsDef[128]);
	target_create(chr,color,_,_,"cmd_dye_targ");
}

/*!
\author Fax
\fn cmd_dye_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and dyeing
*/
public cmd_dye_targ(target, chr, object, x, y, z, unused, color)
{
	if(isItem(object))
	{
		itm_setProperty(object,IP_COLOR,_,color);
		itm_refresh(object);
		chr_message(chr,_,msg_commandsDef[129]);
	}
	else chr_message(chr,_,msg_commandsDef[103]);
}

/*! }@ */