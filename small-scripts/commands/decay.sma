/*!
\defgroup script_commands_decay 'decay
\ingroup script_commands
\brief decays an item

\b syntax: 'decay time ["t"] 

- time: the time the item will decay in (in seconds), pass "off" to set decay off
- "t": bypass command area and get a target

If area effect is active, all items in area will have decay set.

@{
*/

/*!
\author Fax
\fn cmd_decay(const chr)
\param chr: the character who used the command
\since 0.82
\brief 'decay command start function

This function is called by sources on 'decay command detection.\n
You can change it in commands.txt.
*/
public cmd_decay(const chr)
{
	readCommandParams(chr);

	if(!strlen(__cmdParams[0]))
	{
		chr_message(chr,_,msg_commandsDef[116]);
		return;
	}
	
	new decay = INVALID;
	if(isStrInt(__cmdParams[0]))	
		decay = getTimerValue(str2Int(__cmdParams[0]));
		
	new area = chr_getCmdArea(chr);
	new i = 0, item;
	
	//apply command to all items in area
	if(area_isValid(area) && __cmdParams[1][0] != 't')
	{
		area_useCommand(area);
		for(set_rewind(area_items(area)); !set_end(area_items(area)); i++)
		{
			item = set_getItem(area_items(area));
			itm_setDecay(item,decay);
		}
		
		chr_message(chr,_,msg_commandsDef[117],i);		
		return;
	}
	
	chr_message(chr,_,msg_commandsDef[118]);
	target_create(chr,decay,_,_,"cmd_decay_targ");
}

/*!
\author Fax
\fn cmd_decay_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
*/
public cmd_decay_targ(target, chr, object, x, y, z, unused, decay)
{
	if(isItem(object))
	{
		itm_setDecay(object,decay);
		chr_message(chr,_,msg_commandsDef[119],itm_getProperty(object,IP_DECAYTIME));
	}
	else chr_message(chr,_,msg_commandsDef[103]);
}

/*! }@ */