/*!
\defgroup script_commands_decay 'decay
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_decay(const chr)
\brief decays an item

<B>syntax:<B> 'decay decayTime/"off" ["target"]
params:
<UL>
<LI> decayTime/"off": the time the item will decay in, or pass "off" to set decay off
<LI> "target": optionally pass targettobypass the area effect
</UL>

If area effect is active, all items in area will have decay set.
If no area effect is active, or if you pass "target", a target will appear and only 
the targetted item will be affected.<br>
*/
public cmd_decay(const chr)
{
	readCommandParams(chr);
	
	if(!strlen(__cmdParams[0]))
	{
		chr_message(chr,_,"You have to specify the decay time, or 'off'");
		return;
	}
	
	new decay = INVALID;
	if(isStrInt(__cmdParams[0]))	decay = getCurrentTime() + str2Int(__cmdParams[0]);
		
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
				itm_setDecay(item,decay);
		}
		
		chr_message(chr,_,"%d items had decay set",i);				
		return;
	}

	chr_message(chr,_,"Select an item to set decay");
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
		chr_message(chr,_,"Decay set");
	}
	else chr_message(chr,_,"You must target an item");
}

/*! }@ */