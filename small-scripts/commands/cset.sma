/*!
\defgroup script_commands_cset 'cset
\ingroup script_commands
\brief sets properties of a character

\b syntax: 'cset property value ["t"] 

- property/value: the property to be set,choose from the list below,each property allows different values:
	-# "ai": npcai
	-# "dex": dexterity
	-# "dir": direction - values: "n" "ne" "e" "se" "s" "sw" "w" "nw")
	-# "gmfx": gm moving effect
	-# "int": intelligence
	-# "light": character fixed light level
	-# "owner": owner serial
	-# "privon/privoff": special privs (1: can broadcast, 2: see serial numbers by single click, 3: no skill titles,4: Can snoop other,5: Allmove,6: View houses as icons,7: need no mana, 8: permanent magic reflect, 9:needs no reagents, 10: dispelable
	-# "shop": character is a shopkeeper (0 no - 1 yes)
	-# "spattack": type of spell attack
	-# "spadelay": delay between 2 spell attacks
	-# "speech": speech block
	-# "split": split
	-# "splitchance": splitchance
	-# "squelch": 1 squelched - 0 not squelched
	-# "str": strength
	-# "train": if npc can train (0 no - 1 yes)
	-# "trigger": npc trigger
	
- "t": bypass command area and get a target

Properties are recognized also if you type only a few initial letters. Unless there is ambiguity
between properties names you can ype only the first letter, if you get an ambiguity message type some
more letters.

@{
*/

/*!
\author Fax, modified by Horian
\fn cmd_cset(const chr)
\param chr: the character who used the command
\since 0.82
\brief 'cset command start function

This function is called by sources on 'cset command detection.\n
You can change it in commands.txt.

*/
public priv_array[10] = {
2,
8,
10,
40,
1,
4,
10,
40,
80,
20
};

new cset_subprop;

public cmd_cset(const chr)
{
	readCommandParams(chr);
	
	cset_subprop = '_';

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
				if(chr2 != chr) chr_setProperty(item,prop,cset_subprop,val);
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
			chr_setProperty(object,prop,cset_subprop,val);
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
		case 'a':  prop = CP_NPCAI;
		case 'd':
			switch(__cmdParams[0][1])
			{
				case 'i':
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
				case 'e':
				{
					prop = CP_DEXTERITY;
					cset_subprop = CP2_REAL;
				}
				default:
				{
					chr_message(chr,_,msg_commandsDef[106]);
					return INVALID;
				}
			}
		case 'g': prop = CP_GMMOVEEFF;
		case 'i':
		{
			prop = CP_INTELLIGENCE;
			cset_subprop = CP2_INTREAL;
		}
		case 'l':prop = CP_FIXEDLIGHT;
		case 'o': prop = CP_OWNSERIAL;
		case 'p':
		{
			if(!strlen(__cmdParams[1]) || !isStrInt(__cmdParams[1]))
			return INVALID;
			
			val = str2Int(__cmdParams[2]);
			
			switch(val)
			{
				case 1..4:
				{
					if (__cmdParams[0][6]== 'f') //off
					{
						chr_setProperty( chr, CP_PRIV, _, chr_getProperty(chr,CP_PRIV) & ~priv_array[val-1]);
					}
					else chr_setProperty( chr, CP_PRIV, _, chr_getProperty(chr,CP_PRIV) | priv_array[val-1]);
				}
				case 5..10:
				{
					if (__cmdParams[0][6]== 'f') //off
					{
						chr_setProperty( chr, CP_PRIV2, _, chr_getProperty(chr,CP_PRIV2) & ~priv_array[val-1]);
					}
					else chr_setProperty( chr, CP_PRIV2, _, chr_getProperty(chr,CP_PRIV2) | priv_array[val-1]);
				}
				default:
				{
					chr_message(chr,_,msg_commandsDef[106]);
					return INVALID;
				}
			}
			return OK;
		}
		case 's':
			switch(__cmdParams[0][1])
			{ 
				case 'h': prop = CP_SHOPKEEPER;
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
				case 't':
				{
					prop = CP_STRENGTH;
					cset_subprop = CP2_REAL;
				}
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