/*!
\defgroup script_commands_csetxyz 'csetxyz
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_csetxyz(const chr)
\brief sets location-type properties of a character

<B>syntax:<B> 'csetxyz property x y z ["t"]
<B>command params:</B>
<UL>
<LI> property: the property to be set,choose from the list below,each property allows different values:
	<UL>
	<LI> "food": food position, for freely wandering npcs
	<LI> "home": home position, for freely wandering npcs
	<LI> "work": work place, for freely wandering npcs
</UL>
<LI> "t": bypass command area and get a target
</UL>

Properties are recognized also if you type only a few initial letters. Unless there is ambiguity
between properties names you can ype only the forst letter, if you get an ambiguity message type some
more letters.
*/
public cmd_csetxyz(const chr)
{
	readCommandParams(chr);

	if(!strlen(__cmdParams[0]))
	{
		chr_message(chr,_,msg_commandsDef[99]);
		return;
	}

	new prop,val[3];
	if(readPropAndxyz(chr,prop,val) == INVALID) return;



	new area = chr_getCmdArea(chr);
	new i = 0, item,chr2;
	//apply command to all items in area
	if(area_isValid(area) && __cmdParams[4][0] != 't')
	{
		area_useCommand(area);
		for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
		{
				chr2 = set_getChar(area_chars(area));
				if(chr2 != chr)
				{
					 chr_setProperty(chr2,prop,CP2_X,val[0]);
					chr_setProperty(chr2,prop,CP2_Y,val[1]);
					chr_setProperty(chr2,prop,CP2_Z,val[2]);
					chr_update(item);
				}
		}

		chr_message(chr,_,msg_commandsDef[100],__cmdParams[0],i);		
		return;
	}

	chr_addLocalIntVec(chr,CLV_CMDTEMPVEC,3);
	chr_setLocalIntVec(chr,CLV_CMDTEMPVEC,0,val[0]);
	chr_setLocalIntVec(chr,CLV_CMDTEMPVEC,1,val[1]);
	chr_setLocalIntVec(chr,CLV_CMDTEMPVEC,2,val[2]);

	chr_message(chr,_,msg_commandsDef[101],__cmdParams[0]);
	target_create(chr,prop,_,_,"cmd_csetxyz_targ");
}

/*!
\author Fax
\fn cmd_setdir_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and setdiring
*/
public cmd_csetxyz_targ(target, chr, object, x, y, z, unused, prop)
{
	new val[3];
	val[0] = chr_getLocalIntVec(chr,CLV_CMDTEMPVEC,0);
	val[1] = chr_getLocalIntVec(chr,CLV_CMDTEMPVEC,1);
	val[2] = chr_getLocalIntVec(chr,CLV_CMDTEMPVEC,2);

	chr_delLocalVar(chr,CLV_CMDTEMPVEC);

	if(isChar(object))
	{
		chr_setProperty(object,prop,CP2_X,val[0]);
		chr_setProperty(object,prop,CP2_Y,val[1]);
		chr_setProperty(object,prop,CP2_Z,val[2]);

		chr_update(object);
		chr_message(chr,_,msg_commandsDef[110]);
	}

	else chr_message(chr,_,msg_commandsDef[103]);
}

static readPropAndxyz(chr,&prop,val[])
{
	//switch on first property letter, if there is ambiguity add 
	//another switch on the second letter __cmdParams[0][1]
	switch(__cmdParams[0][0])
	{
		case 'f': prop = CP_FOODPOSITION;
		case 'h': prop = CP_HOMELOCPOS;
		case 'w': prop = CP_WORKLOCPOS;

		default:
		{
			chr_message(chr,_,msg_commandsDef[111]);
			return INVALID;
		}
	}

	if(!isStrInt(__cmdParams[1]) || !isStrInt(__cmdParams[2]) || !isStrInt(__cmdParams[3]))
	{
		chr_message(chr,_,msg_commandsDef[109]);
		return INVALID;
	}

	val[0] = str2Int(__cmdParams[1]);
	val[1] = str2Int(__cmdParams[2]);
	val[2] = str2Int(__cmdParams[3]);

	return OK;
}
/*! }@ */