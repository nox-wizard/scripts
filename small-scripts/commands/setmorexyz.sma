/*!
\defgroup script_commands_setmorexyz 'setmorexyz
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_setmorexyz(const chr)
\brief setmorexyzs an item

<B>syntax:<B> 'setmorexyz morex morey morez ["target"]

If area effect is active, all items in area will have morex morey morez set.
If no area effect is active, or if you pass "target", a target will appear and only 
the targetted itemwill be affected
*/
public cmd_setmorexyz(const chr)
{
	readCommandParams(chr);
	
	if(!strlen(__cmdParams[0]) || !strlen(__cmdParams[1]) || !strlen(__cmdParams[2]))
	{
		chr_message(chr,_,"You have to specify 3 values for morex morey morez");
		return;
	}
	
	if(!isStrInt(__cmdParams[0]) || !isStrInt(__cmdParams[1]) || !isStrInt(__cmdParams[2]))
	{
		chr_message(chr,_,"morex morey morez must be integer numbers");
		return;
	}
	
	new morex = str2Int(__cmdParams[0]);
	new morey = str2Int(__cmdParams[1]);
	new morez = str2Int(__cmdParams[2]);
	
	new target = false;
	
	if(!strcmp(__cmdParams[3],"target"))
		target = true;
	
	new area = chr_getCmdArea(chr);
	new i = 0, item;
	//apply command to all items in area
	if(area_isValid(area) && !target)
	{
		area_useCommand(area);
		for(set_rewind(area_items(area)); !set_end(area_items(area)); i++)
		{
				item = set_getItem(area_items(area));
				itm_setProperty(item,IP_MORE,IP2_X,morex);
				itm_setProperty(item,IP_MORE,IP2_Y,morey);
				itm_setProperty(item,IP_MORE,IP2_Z,morez);
		}
		
		chr_message(chr,_,"%d items had morex morey morez set",i);				
		return;
	}

	chr_message(chr,_,"Select an item to set morex morey morez");
	target_create(chr,(morex << 16) + (morey << 8) + morez,_,_,"cmd_setmorexyz_targ");
}

/*!
\author Fax
\fn cmd_setmorexyz_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
*/
public cmd_setmorexyz_targ(target, chr, object, x, y, z, unused, morexyz)
{
	if(isItem(object))
	{
		itm_setProperty(object,IP_MORE,IP2_X, morexyz >> 16);
		itm_setProperty(object,IP_MORE,IP2_Y,(morexyz >> 8) & 0xFF);
		itm_setProperty(object,IP_MORE,IP2_Z, morexyz & 0xFF);
		chr_message(chr,_,"New morex: %d morey:%d morez:%d",itm_getProperty(object,IP_MORE,IP2_X),itm_getProperty(object,IP_MORE,IP2_Y),itm_getProperty(object,IP_MORE,IP2_Z));
	}
	else chr_message(chr,_,"You must target an item");
}

/*! }@ */