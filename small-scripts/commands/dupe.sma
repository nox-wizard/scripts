/*!
\defgroup script_command_dupe 'dupe
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_dupe(const chr)
\brief duplicates an item

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
			{	
				new copy = itm_duplicate(item);
	
				if(!isItem(copy))
				{
					chr_message(chr,_,"That item can't be duplicated");
					return;
				}
				
				new x,y,z;
				itm_getPosition(item,x,y,z);
				itm_moveTo(copy,x,y,z);
			}	
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
	
	if(itm_getProperty(object,IP_CONTAINERSERIAL) != INVALID)
	{
		chr_message(chr,_,"Item must not be in a container");
		return;
	}
	
	new copy = itm_duplicate(object);
	
	if(!isItem(copy))
	{
		chr_message(chr,_,"That item can't be duplicated");
		return;
	}
	
	itm_getPosition(object,x,y,z);
	itm_moveTo(copy,x,y,z);
	chr_message(chr,_,"Item %d created at %d %d %d",copy,x,y,z);
}


public itm_duplicate(const item)
{
	new copy = itm_create(itm_getProperty(item,IP_SCRIPTID));
	
	for(new prop = IP_DOORDIR; prop <= IP_AUXDAMAGETYPE; prop++)
		if(	//These properties must not be copied
			106 <= prop <= 109 ||
			prop == 116 || prop == 119 )
			continue;
		else itm_setProperty(copy,prop,_,itm_getProperty(item,prop));
	
	
	for(new prop = IP_ATT; prop <= IP_AMMOFX; prop++)
		if(	//These properties must not be copied
			prop == 210 ||
			prop == IP_SERIAL ||	
			prop == IP_AMXFLAGS ||
			prop == IP_TIME_UNUSED ||
			prop == IP_TIME_UNUSEDLAST)
			continue;
		else itm_setProperty(copy,prop,_,itm_getProperty(item,prop));
		
	for(new prop = IP_AMOUNT; prop < IP_ID; prop++)
		itm_setProperty(copy,prop,_,itm_getProperty(item,prop));
	
	new string[100];
	for(new prop = IP_STR_CREATOR; prop < IP_STR_NAME2; prop++)
	{
		itm_getProperty(item,prop,0,string);
		itm_setProperty(copy,prop,0,string);
	}
	
	return copy;	
}
/*! }@ */