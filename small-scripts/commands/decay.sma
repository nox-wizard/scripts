/*!
\defgroup script_commands_decay 'decay
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_decay(const chr)
\brief decays an item

<B>syntax:<B> 'decay a/t decayTime/"off" 
params:
<UL>
<LI> a/t: decides if area or single target to apply
<LI> decayTime/"off": the time the item will decay in, or pass "off" to set decay off
</UL>

If area effect is active, all items in area will have decay set.
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
	if(isStrInt(__cmdParams[1]))	
		decay = getTimerValue(str2Int(__cmdParams[1]));
		
	new area = chr_getCmdArea(chr);
	new i = 0, item;
	
	//apply command to all items in area
	if(area_isValid(area))
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