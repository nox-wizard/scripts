/*!
\defgroup script_commands_cset 'cset
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_cset(const chr)
\brief sets properties of a character

<B>syntax:<B> 'cset property value ["t"] 
<B>command params:</B>
<UL>
<LI> property: the property to be set,choose from the list below,each property allows different values:
	<UL>
	<LI> "ai": npcai
	<LI> "dir": direction - values: "n" "ne" "e" "se" "s" "sw" "w" "nw")
	<LI> "gmfx": gm moving effect
	<LI> "light": character fixed light level
	<LI> "owner": owner serial
	<LI> "shop": is character is a shopkeeper (0 no - 1 yes)
	<LI> "spattack": type of spell attack
	<LI> "spadelay": delay between 2 spell attacks
	<LI> "speech": speech block
	<LI> "split": split
	<LI> "splitchance": splitchance
	<LI> "squelch": 1 squelched - 0 not squelched
	<LI> "train": if npc can train (0 no - 1 yes)
	<LI> "trigger": npc trigger
	</UL>
<LI> "t": bypass command area and get a target
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
		chr_message(chr,_,msg_commandsDef[99]);
		return;
	}

	new prop,val = -1000;
	readPropAndVal(chr,prop,val);



	new area = chr_getCmdArea(chr);
	new i = 0, item,chr2;
	//apply command to all items in area
	if(area_isValid(area) && __cmdParams[2][0] != 't')
	{
		area_useCommand(area);
		for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
		{
				chr2 = set_getChar(area_chars(area));
				if(chr2 != chr) chr_setProperty(item,prop,_,val);
				chr_update(item);
		}

		chr_message(chr,_,msg_commandsDef[100],__cmdParams[0],i);		
		return;
	}

	//store parameters to be read by the callback
	chr_addLocalIntVar(chr,CLV_CMDTEMP,prop);

	chr_message(chr,_,msg_commandsDef[101],__cmdParams[0]);
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
	chr_delLocalVar(chr,CLV_CMDTEMP);

	if(isChar(object))
	{
		if(val != -1000)
		{
			chr_setProperty(object,prop,_,val);
			chr_update(object);
			chr_message(chr,_,msg_commandsDef[102],val);
		}
		else
			chr_message(chr,_,msg_commandsDef[261],chr_getProperty(object,prop));
	}
	else chr_message(chr,_,msg_commandsDef[103]);
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
					chr_message(chr,_,msg_commandsDef[104]);
					return INVALID;
				}
		
				prop = CP_DIR;
				val = str2Dir(__cmdParams[1]);
		
				if(val == INVALID)
				{
					chr_message(chr,_,msg_commandsDef[105]);
					return INVALID;
				}
		
				return OK;
			}

		case 'g': prop = CP_GMMOVEEFF;
		case 'l':prop = CP_FIXEDLIGHT;
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
				case 'q': prop = CP_SQUELCHED;
		
				default:
				{
					chr_message(chr,_,msg_commandsDef[106]);
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
					chr_message(chr,_,msg_commandsDef[107]);
					return INVALID;
				}
			}
		
		default:
		{
			chr_message(chr,_,msg_commandsDef[108]);
			return INVALID;
		}
	}

	if(!strlen(__cmdParams[1]) || !isStrInt(__cmdParams[1]))
		return INVALID;
	
	val = str2Int(__cmdParams[1]);
	return OK;
}
/*! }@ */