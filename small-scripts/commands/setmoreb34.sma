/*!
\defgroup script_commands_setmoreb34 'setmoreb34
\ingroup script_commands

@{
*/

/*!
\author Horian according to fax system
\fn cmd_setmoreb34(const chr)
\brief setmoreb34s an item

<B>syntax:<B> 'setmoreb34 value

If area effect is active, all items in area will have moreb34 set.
If no area effect is active, or if you pass "target", a target will appear and only 
the targetted item will be affected
*/
public cmd_setmoreb34(const chr)
{
	readCommandParams(chr);

	if(!strlen(__cmdParams[0]) )
	{
		chr_message(chr,_,"You have to specify 1 value for moreb34!");
		return;
	}

	if(!isStrInt(__cmdParams[0]))
	{
		chr_message(chr,_,"value must be an integer number");
		return;
	}

	new moreb34 = str2Int(__cmdParams[0]);



	new area = chr_getCmdArea(chr);
	new i = 0, item;
	//apply command to all items in area
	if(area_isValid(area))
	{
		area_useCommand(area);
		for(set_rewind(area_items(area)); !set_end(area_items(area)); i++)
		{
				item = set_getItem(area_items(area));
				itm_setProperty(item, IP_MOREB, 3, moreb34%256);
				itm_setProperty(item, IP_MOREB, 4, moreb34/256);
		}

		chr_message(chr,_,"%d items had moreb34 set",i);		
		return;
	}

	chr_message(chr,_,"Select an item to set moreb34");
	target_create(chr,moreb34,_,_,"cmd_setmoreb34_targ");
}

/*!
\author Fax
\fn cmd_setmoreb34_targ(target, chr, object, x, y, z, unused, value)
\params all standard target callback params
*/
public cmd_setmoreb34_targ(target, chr, object, x, y, z, unused, moreb34)
{
	if(isItem(object))
	{
		itm_setProperty(target, IP_MOREB, 3, moreb34%256);
		itm_setProperty(target, IP_MOREB, 4, moreb34/256);
		chr_message(chr,_,"New moreb34:%d",(itm_getProperty(object,IP_MOREB,3)&0xff) + ((itm_getProperty(object,IP_MOREB,4)&0xff)<<8) );
	}
	else chr_message(chr,_,"You must target an item");
}

/*! }@ */