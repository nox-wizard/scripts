/*!
\defgroup script_commands_iset 'iset
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_iset(const chr)
\brief sets properties of an item or character

<B>syntax:<B> 'iset property value 
<B>command params:</B>
<UL>
<LI> property: the property to be set,choose from the list below,each property allows different values:
	<UL>
	<LI> "amount": amount
	<LI> "dir": direction - values: "n" "ne" "e" "se" "s" "sw" "w" "nw")
	<LI> "type": item type
	<LI> "value": item price
	<LI> "restock": restock rate
	</UL>
<LI> "target": pass this parameter if you want to bypass the area effect
</UL>

Properties are recognized also if you type only a few initial letters. Unless there is ambiguity
between properties names you can ype only the forst letter, if you get an ambiguity message type some
more letters.
*/
public cmd_iset(const chr)
{
	readCommandParams(chr);

	if(!strlen(__cmdParams[0]))
	{
		chr_message(chr,_,"You must specify the property to set");
		return;
	}

	new prop,val = 0;
	if(readPropAndVal(chr,prop,val) == INVALID) return;



	new area = chr_getCmdArea(chr);
	new i = 0, item;
	//apply command to all items in area
	if(area_isValid(area))
	{
		area_useCommand(area);
		for(set_rewind(area_items(area)); !set_end(area_items(area)); i++)
		{
				item = set_getItem(area_items(area));
				itm_setProperty(item,prop,_,val);
				itm_refresh(item);
		}

		chr_message(chr,_,"%s set to %d items",__cmdParams[0],i);		
		return;
	}

	//store parameters to be read by the callback
	chr_setLocalIntVar(chr,CLV_CMDTEMP,prop);

	chr_message(chr,_,"Select an item to set the %s",__cmdParams[0]);
	target_create(chr,val,_,_,"cmd_iset_targ");
}

/*!
\author Fax
\fn cmd_setdir_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and setdiring
*/
public cmd_iset_targ(target, chr, object, x, y, z, unused, val)
{
	new prop = chr_getLocalIntVar(chr,CLV_CMDTEMP);

	if(isItem(object))
	{
		itm_setProperty(object,prop,_,val);
		itm_refresh(object);
		chr_message(chr,_,"property set");
	}

	else chr_message(chr,_,"You must target an item");
}

static readPropAndVal(chr,&prop,&val)
{
	//switch on first property letter, if there is ambiguity add 
	//another switch on the second letter __cmdParams[0][1]
	switch(__cmdParams[0][0])
	{
		case 'a': prop = IP_AMOUNT;
		case 'd': //direction
		{
			if(!strlen(__cmdParams[0]))
			{
				chr_message(chr,_,"You must specify the direction: n ne e se s sw w nw");
				return INVALID;
			}
	
			prop = IP_DIR;
			val = str2Dir(__cmdParams[1]);
	
			if(val == INVALID)
			{
				chr_message(chr,_,"invalid direction, choose between: n ne e se s sw w nw");
				return INVALID;
			}
	
			return OK;
		}

		//case 'm': prop = IP_MOVEABLE;
		case 't': prop = IP_TYPE;
		case 'v': 
			switch(__cmdParams[0][1])
			{
				case 'a': prop = IP_VALUE;
				case 'i': prop = IP_VISIBLE;
				default:
				{
					chr_message(chr,_,"maybe you want totype 'value'or 'visible'");
					return INVALID;
				}
			}
		case 'r': prop = IP_RESTOCK;
		case 'w': prop = IP_WIPE;

		default:
		{
			chr_message(chr,_,"Invalid property, allowed properties are: amount dir movable type value visible wipe");
			return INVALID;
		}
	}

	if(!strlen(__cmdParams[1]) || !isStrInt(__cmdParams[1]))
	{
		chr_message(chr,_,"Integer value required");
		return INVALID;
	}

	val = str2Int(__cmdParams[1]);
	return OK;
}
/*! }@ */