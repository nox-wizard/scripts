/*!
\defgroup script_commands_dye 'dye
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_dye(const chr)
\brief dyes an item

<B>syntax:<B> 'dye a/t color 
<B>command params:</B>
<UL>
<LI> a/t: decides if area or single target to apply
<UL>
	<LI> color: color code, integer or hexadecimal (preceded by 0x)
</UL>
</UL>

If area effect is active, all characters in area will be dyed.
If no area effect is active, or if you pass "t", a target will appear and only 
the targetted char will be dyed
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
	if(!isStrHex(__cmdParams[1]))
		if(!isStrInt(__cmdParams[1]))
		{
			chr_message(chr,_,msg_commandsDef[126]);
			return;
		}
		else color = str2Int(__cmdParams[1]);
	else color = str2Hex(__cmdParams[1]);



	new areacheck = 0;
	if(__cmdParams[0][0] == 'a')
		areacheck=1;
		
	if(areacheck==1)
	{
		new area = chr_getCmdArea(chr);
		new i = 0, item;
		//apply command to all items in area
		if(area_isValid(area))
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