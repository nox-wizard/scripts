/*!
\defgroup script_command_dupe 'dupe
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_dupe(const chr)
\brief duplicates an item

<B>syntax:<B> 'dupe n ["t"]
<B>command params:</B>
<UL>
	<LI> n: number of copies
	<LI> "t": bypass command area and get a target
</UL>

If area effect is active, all items in area will be cloned.<br>
Items in the player's backpack are not copied.<br>
New items are moved to original item's position
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
	if(area_isValid(area) && __cmdParams[1][0] != 't')
	{

		for(set_rewind(area_items(area)); !set_end(area_items(area)); i++)
		{
			item = set_getItem(area_items(area));
			if(itm_getProperty(item,IP_CONTAINERSERIAL) != chr_getBackpack(chr)) 
			{
				new x,y,z;
				itm_getPosition(item,x,y,z);
				new copy;
				for(new j; j < n; j++)
				{
					copy = itm_duplicate(item);
				
					if(!isItem(copy))
					{
						chr_message(chr,_,msg_commandsDef[124]);
						return;
					}
						
					itm_moveTo(copy,x,y,z);
				}
			}
		}

		chr_message(chr,_,msg_commandsDef[120],i);
		
		return;
	}

	//if we are here it means we need a target
	chr_message(chr,_,msg_commandsDef[121]);
	target_create(chr,n,_,_,"cmd_dupe_targ");
}

/*!
\author Fax
\fn cmd_dupe_targ(target, chr, object, x, y, z, unused, freeze)
\params all standard target callback params
\brief handles single character targetting and freezing
*/
public cmd_dupe_targ(target, chr, object, x, y, z, unused, n)
{
	if(!isItem(object))
	{
		chr_message(chr,_,msg_commandsDef[122]);
		return;
	}

	if(itm_getProperty(object,IP_CONTAINERSERIAL) != INVALID)
	{
		chr_message(chr,_,msg_commandsDef[123]);
		return;
	}


	new copy;
	itm_getPosition(object,x,y,z);
	
	for(new i; i < n; i++)
	{
		copy = itm_duplicate(object);
	
		if(!isItem(copy))
		{
			chr_message(chr,_,msg_commandsDef[124]);
			return;
		}
			
		itm_moveTo(copy,x,y,z);
	}
}


/*! }@ */