/*!
\defgroup script_commands_cset 'cset
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_cset(const chr)
\brief sets properties of a character

<B>syntax:<B> 'cset property value 
<B>command params:</B>
<UL>
<LI> property: the property to be set,choose from the list below,each property allows different values:
	<UL>
	<LI> "ai": npcai
	<LI> "dir": direction - values: "n" "ne" "e" "se" "s" "sw" "w" "nw")
	<LI> "gmfx": gm moving effect
	<LI> "owner": owner serial
	<LI> "shop": is character is a shopkeeper (0 no - 1 yes)
	<LI> "spattack": type of spell attack
	<LI> "spadelay": delay between 2 spell attacks
	<LI> "speech": speech block
	<LI> "split": split
	<LI> "splitchance": splitchance
	<LI> "train": if npc can train (0 no - 1 yes)
	<LI> "trigger": npc trigger
	</UL>
<LI> "target": pass this parameter if you want to bypass the area effect
</UL>

Properties are recognized also if you type only a few initial letters. Unless there is ambiguity
between properties names you can ype only the forst letter, if you get an ambiguity message type some
more letters.
*/
public cmd_cset(const chr)
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
	new i = 0, item,chr2;
	//apply command to all items in area
	if(area_isValid(area))
	{
		area_useCommand(area);
		for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
		{
				chr2 = set_getChar(area_chars(area));
				if(chr2 != chr) chr_setProperty(item,prop,_,val);
				chr_update(item);
		}

		chr_message(chr,_,"%s set to %d characters",__cmdParams[0],i);		
		return;
	}

	//store parameters to be read by the callback
	chr_setLocalIntVar(chr,CLV_CMDTEMP,prop);

	chr_message(chr,_,"Select a character to set the %s",__cmdParams[0]);
	target_create(chr,val,_,_,"cmd_cset_targ");
}

/*!
\author Fax
\fn cmd_setdir_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and setdiring
*/
public cmd_cset_targ(target, chr, object, x, y, z, unused, val)
{
	new prop = chr_getLocalIntVar(chr,CLV_CMDTEMP);

	if(isChar(object))
	{
		chr_setProperty(object,prop,_,val);
		chr_update(object);
		chr_message(chr,_,"property set to %d",val);
	}

	else chr_message(chr,_,"You must target an item");
}

static readPropAndVal(chr,&prop,&val)
{
	//switch on first property letter, if there is ambiguity add 
	//another switch on the second letter __cmdParams[0][1]
	switch(__cmdParams[0][0])
	{
		case 'a': prop = CP_NPCAI;
		case 'd':
			{
				if(!strlen(__cmdParams[0]))
				{
					chr_message(chr,_,"You must specify the direction: n ne e se s sw w nw");
					return INVALID;
				}
		
				prop = CP_DIR;
				val = str2Dir(__cmdParams[1]);
		
				if(val == INVALID)
				{
					chr_message(chr,_,"invalid direction, choose between: n ne e se s sw w nw");
					return INVALID;
				}
		
				return OK;
			}

		case 'g': prop = CP_GMMOVEEFF;
		case 'o': prop = CP_OWNSERIAL;
		case 's':
			switch(__cmdParams[0][1])
			{ 
				case 's': prop = CP_SHOPKEEPER;
				case 'p': 
					switch(__cmdParams[0][1])
					{ 
						case 'a': //split splitchance
						{
							if(!strcmp(__cmdParams[0],"spattack"))
								prop = CP_SPATTACK;
							else prop = CP_SPADELAY;
						}
				
						case 'e': prop = CP_SPEECH;
						case 'l': //split splitchance
						{
							if(!strcmp(__cmdParams[0],"split"))
								prop = CP_SPLIT;
							else prop = CP_SPLITCHNC;
						}
					}
		
				default:
				{
					chr_message(chr,_,"Maybe you wanted to type'speech','split' or 'splitchance'?");
					return INVALID;
				}
			}

		case 't': 
			switch(__cmdParams[0][1])
			{ 
				case 'r': 
					switch(__cmdParams[0][2])
					{ 
						case 'i': prop = CP_TRIGGER;
						case 'a': prop = CP_CANTRAIN;
					}
				default:
				{
					chr_message(chr,_,"Maybe you wanted to type 'trigger' or 'trainer'?");
					return INVALID;
				}
			}
		
		default:
		{
			chr_message(chr,_,"Invalid property, allowed properties are: ai dir owner spattack spadelay speech train trigger");
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