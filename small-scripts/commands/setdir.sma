/*!
\defgroup script_commands_setdir 'setdir
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_setdir(const chr)
\brief setdirs an item

<B>syntax:<B> 'setdir dir ["target"]
<B>command params:</B>
<UL>
<LI> dir: the direction -  "n" "ne" "e" "se" "s" "sw" "w" "nw"
<LI> "target": pass this parameter if you want to bypass the area effect
</UL>

*/
public cmd_setdir(const chr)
{
	readCommandParams(chr);
	
	if(!strlen(__cmdParams[0]))
	{
		chr_message(chr,_,"You must specify the direction: n ne e se s sw w nw");
		return;
	}
	
	new dir = 0;
	switch(__cmdParams[0][0])
	{
		case 'n':
			switch(__cmdParams[0][1])
			{
				case 'e': dir = DIR_NORTHEAST;
				case 'w': dir = DIR_NORTHWEST;
				default:  dir = DIR_NORTH;
			}
		case 's':
			switch(__cmdParams[0][1])
			{
				case 'e': dir = DIR_SOUTHEAST;
				case 'w': dir = DIR_SOUTHWEST;
				default:  dir = DIR_SOUTH;
			}
		case 'e': dir = DIR_EAST;
		case 'w': dir = DIR_WEST;
		default:
			{
				chr_message(chr,_,"Invalid direction");
				return;
			}
	}
	
	new target = false;
	
	if(!strcmp(__cmdParams[1],"target"))
		target = true;
	
	new area = chr_getCmdArea(chr);
	new i = 0, item,chr2;
	//apply command to all items in area
	if(area_isValid(area) && !target)
	{
		area_useCommand(area);
		for(set_rewind(area_items(area)); !set_end(area_items(area)); i++)
		{
				item = set_getItem(area_items(area));
				itm_setProperty(item,IP_DIR,_,dir);
				itm_refresh(item);
		}
		
		for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
		{
				chr2 = set_getChar(area_chars(area));
				chr_setProperty(chr2,CP_DIR,_,dir);
				chr_update(chr2);
		}
		chr_message(chr,_,"%d objects directed",i);				
		return;
	}

	chr_message(chr,_,"Select an item to set the direction");
	target_create(chr,dir,_,_,"cmd_setdir_targ");
}

/*!
\author Fax
\fn cmd_setdir_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and setdiring
*/
public cmd_setdir_targ(target, chr, object, x, y, z, unused, dir)
{
	if(isItem(object))
	{
		itm_setProperty(object,IP_DIR,_,dir);
		itm_refresh(object);
		chr_message(chr,_,"Direction set");
	}
	else if(isChar(object))
		{
			chr_setProperty(object,CP_DIR,_,dir);
			chr_update(object);
			chr_message(chr,_,"Direction set");
		}
	else chr_message(chr,_,"You must target an item or character");
}

/*! }@ */