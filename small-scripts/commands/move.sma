/*!
\defgroup script_command_move 'move
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_move(const chr)
\brief moves objects

<B>syntax:<B> 'move a/r x y [z] or 'move [param]

<B>command params:</B>
<UL>
<LI> 'move a x y z: moves to x y z<br>
<LI> 'move r dx dy dz: moves to x + dx, y + dy, z+ dz (relative mode)<br>
<LI> 'move me: moves the calling chatacer<br>
<LI> 'move here: moves object to charatcer's feet<br>
<LI> 'move loc: moves object to a location<br>
<LI> 'move bag: moves object to chars backpack<br>

</UL>

You can perform relative movement by specifing at least 1 sign ('move 0 0 +4  'move +1 -2 0) 
this command supports command areas only in "rel" mode, in that case all items in the area are
moved to new positions.
If you don't pass any parameter, you will be prompted to target both the object to move
and the destination
*/
public cmd_move(const chr)
{
	readCommandParams(chr);
	
	if(chr_isaLocalVar(chr,CLV_CMDTEMP))
		chr_delLocalVar(chr, CLV_CMDTEMP);
	
	//called 'move me
	if(!strcmp(__cmdParams[0],"me"))
	{
		chr_message(chr,_,msg_commandsDef[176]);
		target_create(chr,chr,_,_,"cmd_move_targ_dst");
		return;
	}

	//called 'move here
	else if(!strcmp(__cmdParams[0],"here"))
		if(strlen(__cmdParams[1]))
		{
			//handle multi word names (john smith the cool guy)
			for(new i = 2; i < __MAX_PARAMS; i++)
				if(strlen(__cmdParams[i]))
					sprintf(__cmdParams[1],"%s %s",__cmdParams[1],__cmdParams[i]);
					
			new chr2 = getOnlineCharFromName(__cmdParams[1]);
			if(!isChar(chr2))
			{
				chr_message(chr,_,msg_commandsDef[5],__cmdParams[1]);
				return;
			}
			
			cmd_move_targ_here(INVALID,chr,chr2,INVALID,INVALID,INVALID,INVALID,INVALID);
			return;
		}
		else
		{
			chr_message(chr,_,msg_commandsDef[177]);
			target_create(chr,chr,_,_,"cmd_move_targ_here");
			return;
		}

	//called 'move loc
	else if(!strcmp(__cmdParams[0],"loc"))
	{
		chr_message(chr,_,msg_commandsDef[178]);
		target_create(chr,chr,_,_,"cmd_move_targ_loc");
		return;
	}
	
	//called 'move bag
	else if(!strcmp(__cmdParams[0],"bag"))
	{
		chr_message(chr,_,msg_commandsDef[178]);
		target_create(chr,chr,_,_,"cmd_move_targ_bag");
		return;
	}

	//called with no params
	if(!strlen(__cmdParams[0]))
	{
		chr_message(chr,_,msg_commandsDef[179]);
		target_create(chr,_,_,_,"cmd_move_targ");
		return;
	}

	//READ PARAMETERS
	
	//these flags are true if we want to keep the old value
	new keep_movex = __cmdParams[0][0] == '_' || __cmdParams[0][0] == 0;
	new keep_movey = __cmdParams[1][0] == '_' || __cmdParams[1][0] == 0;
	new keep_movez = __cmdParams[2][0] == '_' || __cmdParams[2][0] == 0;
	
	new x,y,z;	

	if(isStrInt(__cmdParams[0]))
		x = str2Int(__cmdParams[0]);
	if(isStrInt(__cmdParams[1]))
		y = str2Int(__cmdParams[1]);	
	if(isStrInt(__cmdParams[2]))
		z = str2Int(__cmdParams[2]);
		
	//if one of the parameters has a sign character (+/-) the mode is "rel"
	new mode = __cmdParams[0][0] == '+' || __cmdParams[0][0] == '-' || __cmdParams[1][0] == '+' || __cmdParams[1][0] == '-';
	
	//check sign of x and y only in abs mode
	if((y < 0 || x < 0) && !mode)
	{
		chr_message(chr,_,msg_commandsDef[181]);
		return;
	}
	new area = chr_getCmdArea(chr);
	new oldx,oldy,oldz,newx,newy,newz,i;
	
	//command areas only in "rel" mode without "target"
	if(area_isValid(area)  && mode)
	{
		if(area_itemsIncluded(area))
			for(set_rewind(area_items(area)); !set_end(area_items(area));i++)
			{
				new itm = set_getItem(area_items(area));
				itm_getPosition(itm,oldx,oldy,oldz);
				newx = keep_movex ? x : oldx+x;
				newy = keep_movey ? y : oldy+y;
				newz = keep_movez ? z : oldz+z;
				//newz = z == -1000 ? map_getZ(newx,newy) : oldz + z;
				printf("moving %d to %d %d %d^n",itm,newx,newy,newz);
				itm_moveTo(itm,newx,newy,newz);
			}
	

		if(area_charsIncluded(area))
			for(set_rewind(area_chars(area)); !set_end(area_chars(area));i++)
			{
				new chr2 = set_getChar(area_chars(area));
				chr_getPosition(chr2,oldx,oldy,oldz);
				newx = keep_movex ? x : oldx+x;
				newy = keep_movey ? y : oldy+y;
				newz = keep_movez ? z : oldz+z;
				//newz = z == -1000 ? map_getZ(newx,newy) : oldz + z;
		
				chr_moveTo(chr2,newx,newy,newz);
			}
	
		chr_message(chr,_,msg_commandsDef[182],i);
		area_refresh(area);
		area_useCommand(area);
		return;
	}
		
	x = keep_movex ? -1 : x;
	y = keep_movey ? -1 : y;
	z = keep_movez ? -1 : z;
	
	//store mode and values
	chr_addLocalIntVec(chr,CLV_CMDTEMP,4);
	chr_setLocalIntVec(chr,CLV_CMDTEMP,0,mode);
	chr_setLocalIntVec(chr,CLV_CMDTEMP,1,x);
	chr_setLocalIntVec(chr,CLV_CMDTEMP,2,y);
	chr_setLocalIntVec(chr,CLV_CMDTEMP,3,z);
	
	chr_message(chr,_,msg_commandsDef[183]);
	target_create(chr,_,_,_,"cmd_move_targ");
}

/*!
\author Fax
\fn cmd_move_targ(target, chr, object, x, y, z, unused, unused2)
\params all standard target callback params
\brief handles first targetting in 'move command with no params
*/
public cmd_move_targ(target, chr, object, x, y, z, unused, unused2)
{
	if(!isChar(object) && !isItem(object))
	{
		chr_message(chr,_,msg_commandsDef[184]);
		return;
	}
	
	//this happens if we didn't specify parameters, so we nedd the destination
	if(!chr_isaLocalVar(chr,CLV_CMDTEMP))
	{
		chr_message(chr,_,"Select the destination");
		target_create(chr,object,_,_,"cmd_move_targ_dst");
		return;
	}
	
	
	new mode = chr_getLocalIntVec(chr,CLV_CMDTEMP,0);
	new oldx,oldy,oldz,newx,newy,newz;
	if(isChar(object))
	{
		chr_getPosition(object,oldx,oldy,oldz);
		
		if(chr_getLocalIntVec(chr,CLV_CMDTEMP,1) != -1) //don't keep that one
		{
			if(mode)//rel
			newx += chr_getLocalIntVec(chr,CLV_CMDTEMP,1);
			else
			newx = chr_getLocalIntVec(chr,CLV_CMDTEMP,1);
		}
		else newx = oldx;
		if(chr_getLocalIntVec(chr,CLV_CMDTEMP,2) != -1)//don't keep that one
		{
			if(mode)
			newy += chr_getLocalIntVec(chr,CLV_CMDTEMP,2);
			else
			newy = chr_getLocalIntVec(chr,CLV_CMDTEMP,2);
		}
		else newy = oldy;
		if(chr_getLocalIntVec(chr,CLV_CMDTEMP,3) != -1)//don't keep that one
		{
			if(mode)
			newz += chr_getLocalIntVec(chr,CLV_CMDTEMP,3) != -1000 ? chr_getLocalIntVec(chr,CLV_CMDTEMP,3) : map_getZ(newx,newy);
			else
			newz = chr_getLocalIntVec(chr,CLV_CMDTEMP,3) != -1000 ? chr_getLocalIntVec(chr,CLV_CMDTEMP,3) : map_getZ(newx,newy);
		}
		else newz = oldz;
		chr_delLocalVar(chr,CLV_CMDTEMP);
		chr_moveTo(object,newx,newy,newz);
		area_refresh(chr_getCmdArea(chr));
		return;
	}

	if(isItem(object))
	{
		itm_getPosition(object,oldx,oldy,oldz);
		
		if(chr_getLocalIntVec(chr,CLV_CMDTEMP,1) != -1)
		{
			if(mode)
			newx += chr_getLocalIntVec(chr,CLV_CMDTEMP,1);
			else
			newx = chr_getLocalIntVec(chr,CLV_CMDTEMP,1);
		}
		else newx = oldx;

		if(chr_getLocalIntVec(chr,CLV_CMDTEMP,2) != -1)
		{
			if(mode)
			newy += chr_getLocalIntVec(chr,CLV_CMDTEMP,2);
			else
			newy = chr_getLocalIntVec(chr,CLV_CMDTEMP,2);
		}
		else newy = oldy;
		
		if(chr_getLocalIntVec(chr,CLV_CMDTEMP,3) != -1)
		{
			if(mode)
			newz += chr_getLocalIntVec(chr,CLV_CMDTEMP,3) != -1000 ? chr_getLocalIntVec(chr,CLV_CMDTEMP,3) : map_getZ(newx,newy);
			else
			newz = chr_getLocalIntVec(chr,CLV_CMDTEMP,3) != -1000 ? chr_getLocalIntVec(chr,CLV_CMDTEMP,3) : map_getZ(newx,newy);
		}
		else newz = oldz;
		chr_delLocalVar(chr,CLV_CMDTEMP);
		
		itm_moveTo(object,newx,newy,newz);
		area_refresh(chr_getCmdArea(chr));
		return;
	}
}

/*!
\author Fax
\fn cmd_move_targ_here(target, chr, object, x, y, z, unused, unused2)
\params all standard target callback params
\brief handles 'move here commmand
*/
public cmd_move_targ_here(target, chr, object, x, y, z, unused, unused2)
{
	chr_getPosition(chr,x,y,z);

	if(isChar(object))
		chr_moveTo(object,x,y,z)
	else 	if(isItem(object))
			itm_moveTo(object,x,y,z)
		else
		{
			chr_message(chr,_,msg_commandsDef[184]);
			return;
		}
}

/*!
\author Fax
\fn cmd_move_targ_loc(target, chr, object, x, y, z, unused, unused2)
\params all standard target callback params
\brief handles 'move loc commmand
*/
public cmd_move_targ_loc(target, chr, object, x, y, z, unused, unused2)
{
	chr_getPosition(chr,x,y,z);

	if(isChar(object) || isItem(object))
		locationsMenu(chr,object)
	else
	{
		chr_message(chr,_,msg_commandsDef[184]);
		return;
	}
}

/*!
\author Fax
\fn cmd_move_targ_bag(target, chr, object, x, y, z, unused, unused2)
\params all standard target callback params
\brief handles 'move here commmand
*/
public cmd_move_targ_bag(target, chr, object, x, y, z, unused, unused2)
{
	//new pack = chr_getBackpack(chr, true);

	if(isChar(object))
		return;
	else
	{
		if(isItem(object))
		{
			itm_BounceToPack(chr, object);
			itm_refresh(object);
		}
	}
	
}

/*!
\author Fax
\fn cmd_move_targ_dst(target, chr, object, x, y, z, unused, param)
\params all standard target callback params
\brief handles the destination targetting in 'move when called without params
*/
public cmd_move_targ_dst(target, chr, object, x, y, z, unused2, param)
{
	if((x != INVALID && y != INVALID) || object != INVALID)
	{
		if(isItem(object)) 
			itm_getPosition(object,x,y,z);
		else 	if(isChar(object)) 
			{
				chr_getPosition(object,x,y,z);
				new bp = chr_getBackpack(object);
				if(isItem(bp)) 
				{
					itm_moveTo(param,x,y,z);
					itm_setProperty(param,IP_CONTAINERSERIAL,_,bp);
					itm_refresh(param);
					itm_refresh(bp);
				}
				else chr_message(chr,_,msg_commandsDef[186]);
			}

		if(isChar(param))
			chr_moveTo(param,x,y,z);
		if(isItem(param))
		{
			new cont = itm_getProperty(param,IP_CONTAINERSERIAL);
			itm_setProperty(param,IP_CONTAINERSERIAL,_,INVALID);
			itm_moveTo(param,x,y,z);
			itm_refresh(param);
			if(isItem(cont)) itm_refresh(cont);
		}
		
		area_refresh(chr_getCmdArea(chr));
		return;
	}
	chr_message(chr,_,msg_commandsDef[187]);
}

/*! }@ */