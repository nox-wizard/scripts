/*!
\defgroup script_command_dupe 'dupe
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_dupe(const chr)
\brief duplicates an item

<B>syntax:<B> 'dupe 
<B>command params:</B>
<UL>

</UL>

If area effect is active, all items in area will be cloned.
If no area effect is active, or if you pass "target", a target will appear and only 
the targetted item will be cloned.<br>
Items in the player's backpack are not copied.
*/
public cmd_dupe(const chr)
{
	readCommandParams(chr);
	
	new n = 1;
	if(isStrInt(__cmdParams[0]))
		n = str2Int(__cmdParams[0]);


	new area = chr_getCmdArea(chr);
	new item,i = 0;
	//apply command to all items in area if an area is defined
	if(area_isValid(area))
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
	target_create(chr,n,_,_,"cmd_dupe_targ");
}

/*!
\author Fax
\fn cmd_freeze_targ(target, chr, object, x, y, z, unused, freeze)
\params all standard target callback params
\brief handles single character targetting and freezing
*/
public cmd_dupe_targ(target, chr, object, x, y, z, unused, n)
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


	new copy;
	itm_getPosition(object,x,y,z);
	
	for(new i; i < n; i++)
	{
		copy = itm_duplicate(object);
	
		if(!isItem(copy))
		{
			chr_message(chr,_,"That item can't be duplicated");
			return;
		}
			
		itm_moveTo(copy,x,y,z);
	}
}


/*! }@ */