/*!
\defgroup script_commands_setmoreb12 'setmoreb12
\ingroup script_commands

@{
*/

/*!
\author Horian according to fax system
\fn cmd_setmoreb12(const chr)
\brief setmoreb12s an item

<B>syntax:<B> 'setmoreb12 value

If area effect is active, all items in area will have moreb12 set.
If no area effect is active, or if you pass "target", a target will appear and only 
the targetted item will be affected
*/
public cmd_setmoreb12(const chr)
{
	readCommandParams(chr);

	if(!strlen(__cmdParams[0]) )
	{
		chr_message(chr,_,"You have to specify 1 value for moreb12!");
		return;
	}

	if(!isStrInt(__cmdParams[0]))
	{
		chr_message(chr,_,"value must be an integer number");
		return;
	}

	new moreb12 = str2Int(__cmdParams[0]);



	new area = chr_getCmdArea(chr);
	new i = 0, item;
	//apply command to all items in area
	if(area_isValid(area))
	{
		area_useCommand(area);
		for(set_rewind(area_items(area)); !set_end(area_items(area)); i++)
		{
				item = set_getItem(area_items(area));
				itm_setProperty(item, IP_MOREB, 1, moreb12%256);
				itm_setProperty(item, IP_MOREB, 2, moreb12/256);
		}

		chr_message(chr,_,"%d items had moreb12 set",i);		
		return;
	}

	chr_message(chr,_,"Select an item to set moreb12");
	target_create(chr,moreb12,_,_,"cmd_setmoreb12_targ");
}

/*!
\author Fax
\fn cmd_setmoreb12_targ(target, chr, object, x, y, z, unused, value)
\params all standard target callback params
*/
public cmd_setmoreb12_targ(target, chr, object, x, y, z, unused, moreb12)
{
	if(isItem(object))
	{
		itm_setProperty(target, IP_MOREB, 1, moreb12%256);
		itm_setProperty(target, IP_MOREB, 2, moreb12/256);
		chr_message(chr,_,"New moreb12:%d",(itm_getProperty(object,IP_MOREB,1)&0xff) + ((itm_getProperty(object,IP_MOREB,2)&0xff)<<8) );
	}
	else chr_message(chr,_,"You must target an item");
}

/*! }@ */