/*!
\defgroup script_commands_imore 'imore
\ingroup script_commands

@{
*/

/*!
\author Horian, basing at fax setimorexyz
\fn cmd_imore(const chr)
\brief sets different imore properties of an item

<B>syntax:<B> 'imore property value 
<B>command params:</B>
<UL>
<LI> property: the property to be set,choose from the list below,each property allows different values:
	<UL>
	<LI> "xyz": imorex,y,z
	<LI> "x":
	<LI> "y":
	<LI> "z":
	</UL>
<LI> "target": pass this parameter if you want to bypass the area effect
</UL>

*/
public cmd_imore(const chr)
{
	readCommandParams(chr);

	if(!strlen(__cmdParams[0]))
	{
		chr_message(chr,_,msg_commandsDef[99]);
		return;
	}
	
	new stringlen1 = strlen(__cmdParams[1]);

	new morex, morey, morez,type = 0;
	//type decides which more is set here, type 1 is morexyz, type2 is morex, type3 is morey, type4 is morez, type5 is morexy, type6 is moreyz, type7 is morexz
	if(stringlen1==3) //xyz, type1
	{
		if(!strlen(__cmdParams[2]) || !strlen(__cmdParams[3]) || !strlen(__cmdParams[4]))
		{
			chr_message(chr,_,msg_commandsDef[231]);
			return;
		}
		else 
		{
			morex = str2Int(__cmdParams[2]);
			morey = str2Int(__cmdParams[3]);
			morez = str2Int(__cmdParams[4]);
			type = 1;
		}
	}
	else if(stringlen1==2) //type2-4
	{
		if(!strlen(__cmdParams[2]) || !strlen(__cmdParams[3]))
		{
			chr_message(chr,_,msg_commandsDef[278]);
			return;
		}
		else
		{
			if(!strcmp(__cmdParams[1],"xy"))
			{
				morex = str2Int(__cmdParams[2]);
				morey = str2Int(__cmdParams[3]);
				type=2;
			}
			else if(!strcmp(__cmdParams[1],"yz"))
			{
				morey = str2Int(__cmdParams[2]);
				morez = str2Int(__cmdParams[3]);
				type=3;
			}
			else if(!strcmp(__cmdParams[1],"xz"))
			{
				morex = str2Int(__cmdParams[2]);
				morez = str2Int(__cmdParams[3]);
				type=4;
			}
		}
	}
	else if(stringlen1==1) //type5-7
	{
		if(!strlen(__cmdParams[2]) )
		{
			chr_message(chr,_,msg_commandsDef[278]);
			return;
		}
		else
		{
			if(!strcmp(__cmdParams[0],"x"))
			{
				type=5;
				morex = str2Int(__cmdParams[2]);
			}
			else if(!strcmp(__cmdParams[0],"y"))
			{
				type=6;
				morey = str2Int(__cmdParams[2]);
			}
			else if(!strcmp(__cmdParams[0],"z"))
			{
				type=7;
				morez = str2Int(__cmdParams[2]);
			}
		}
	}

	new areacheck = 0;
	if(__cmdParams[0][0] == 'a')
		areacheck=1;
		
	if(areacheck==1)
	{
		new area = chr_getCmdArea(chr);
		new i = 0, item;
		//apply command to all items in area
		if(area_isValid(area))
		{
			area_useCommand(area);
			for(set_rewind(area_items(area)); !set_end(area_items(area)); i++)
			{
				//type decides which more is set here, type 1 is morexyz, type2 is morex, type3 is morey, type4 is morez, type5 is morexy, type6 is moreyz, type7 is morexz
				switch(type)
				{
					case 1:
					{
						itm_setProperty(item,IP_MORE,IP2_X, morex);
						itm_setProperty(item,IP_MORE,IP2_Y, morey);
						itm_setProperty(item,IP_MORE,IP2_Z, morez);
					}
					case 2:
					{
						itm_setProperty(item,IP_MORE,IP2_X, morex);
					}
					case 3:
					{
						itm_setProperty(item,IP_MORE,IP2_Y, morey);
					}
					case 4:
					{
						itm_setProperty(item,IP_MORE,IP2_Z, morez);
					}
					case 5:
					{
						itm_setProperty(item,IP_MORE,IP2_X, morex);
						itm_setProperty(item,IP_MORE,IP2_Y, morey);
					}
					case 6:
					{
						itm_setProperty(item,IP_MORE,IP2_Y, morey);
						itm_setProperty(item,IP_MORE,IP2_Z, morez);
					}
					case 7:
					{
						itm_setProperty(item,IP_MORE,IP2_X, morex);
						itm_setProperty(item,IP_MORE,IP2_Z, morez);
					}
					default: log_error("Invalid imore type");
				}
			}
			chr_message(chr,_,msg_commandsDef[160],__cmdParams[0],i);		
			return;
		}
	}

	//store parameters to be read by the callback
	chr_message(chr,_,msg_commandsDef[161],__cmdParams[0]);
	target_create(chr,(morex<<24)+(morey << 16) + (morez << 8) + type,_,_,"cmd_imore_targ");
}

/*!
\author Fax
\fn cmd_setdir_targ(target, chr, item, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and setdiring
*/
public cmd_imore_targ(target, chr, item, x, y, z, unused, morexyz)
{
	new prop = chr_getLocalIntVar(chr,CLV_CMDTEMP);
	chr_delLocalVar(chr,CLV_CMDTEMP);
	
	new morex = (morexyz >> 24)& 0xFF;
	new morey = (morexyz >> 16) & 0xFF;
	new morez = morexyz & 0xFF;
	new type = morexyz;

	if(isItem(item))
	{
		//type decides which more is set here, type 1 is morexyz, type2 is morex, type3 is morey, type4 is morez, type5 is morexy, type6 is moreyz, type7 is morexz
		switch(type)
		{
			case 1:
			{
				itm_setProperty(item,IP_MORE,IP2_X, morex);
				itm_setProperty(item,IP_MORE,IP2_Y, morey);
				itm_setProperty(item,IP_MORE,IP2_Z, morez);
			}
			case 2:
			{
				itm_setProperty(item,IP_MORE,IP2_X, morex);
			}
			case 3:
			{
				itm_setProperty(item,IP_MORE,IP2_Y, morey);
			}
			case 4:
			{
				itm_setProperty(item,IP_MORE,IP2_Z, morez);
			}
			case 5:
			{
				itm_setProperty(item,IP_MORE,IP2_X, morex);
				itm_setProperty(item,IP_MORE,IP2_Y, morey);
			}
			case 6:
			{
				itm_setProperty(item,IP_MORE,IP2_Y, morey);
				itm_setProperty(item,IP_MORE,IP2_Z, morez);
			}
			case 7:
			{
				itm_setProperty(item,IP_MORE,IP2_X, morex);
				itm_setProperty(item,IP_MORE,IP2_Z, morez);
			}
			default: log_error("Invalid imore type");
		}
		itm_refresh(item);
		chr_message(chr,_,msg_commandsDef[279]);
	}
	else chr_message(chr,_,msg_commandsDef[2]);
}

/*! }@ */