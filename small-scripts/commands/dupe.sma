/*!
\defgroup script_command_dupe 'dupe
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_freeze(const chr)
\brief freezes a character

<B>syntax:<B> 'dupe ["target"]
<B>command params:</B>
<UL>
<LI> "target": pass this paramter if you want to bypass the area effect
</UL>

If area effect is active, all items in area will be cloned.
If no area effect is active, or if you pass "target", a target will appear and only 
the targetted item will be cloned.<br>
Items in the player's backpack are not copied.
\todo better duplicate() function, shoul copy more properties
*/
public cmd_dupe(const chr)
{
	new target = false;
	
	if(!strcmp(__cmdParams[1],"target"))
		target = true;
		
	
	new area = chr_getCmdArea(chr);
	new item,i = 0;
	//apply command to all items in area if an area is defined
	if(area_isValid(area) && !target)
	{
		
		for(set_rewind(area_items(area)); !set_end(area_items(area)); i++)
		{
			item = set_getItem(area_items(area));
			if(itm_getProperty(item,IP_CONTAINERSERIAL) != chr_getBackpack(chr)) 
				duplicate(item,chr);
		}

		chr_message(chr,_,"%d items copied",i);
				
		return;
	}

	//if we are here it means we need a target
	chr_message(chr,_,"Select an item to duplicate");
	target_create(chr,0,_,_,"cmd_dupe_targ");
}

/*!
\author Fax
\fn cmd_freeze_targ(target, chr, object, x, y, z, unused, freeze)
\params all standard target callback params
\brief handles single character targetting and freezing
*/
public cmd_dupe_targ(target, chr, object, x, y, z, unused, unused1)
{
	if(!isItem(object))
	{
		chr_message(chr,_,"It must be an item");
		return;
	}
	
	duplicate(object,chr);
	chr_message(chr,_,"Item copied");
}


static duplicate(const item, const chr)
{
	new copy = itm_create(itm_getProperty(item,IP_SCRIPTID));
	new x,y,z;
	itm_getPosition(item,x,y,z);
	itm_setProperty(copy,IP_CONTAINERSERIAL,_,chr_getBackpack(chr));	
}
/*! }@ */