/*!
\defgroup script_command_move 'move
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_move(const chr)
\brief moves objects

<B>syntax:<B> 'move x y ["abs"/"rel"] or 'move me or 'move here or 'move loc

<B>command params:</B>
<UL>
<LI> me: if command is called as 'move me, the character is teleported in a targetted location
When using this option no other parameters are needed.<br>
<LI> here: if command is called as 'move here, the targetted character is teleported to the command user<br>
<LI> x: x movement
<LI> y : y movement
<LI> 
	<UL>
	<LI> "abs": x and y are intended as absolute (non-negative) coordinates, new position is x,y
	<LI> "rel": x and y are intended as relative movement, new position is oldx + x, oldy + y (default)
	</UL> 
<LI> "target": pass this parameter if you want to bypass the command area
</UL>

this command supports command areas only in "rel" mode, in that case all items in the area are
moved to new positions.
If you don't pass any parameter, you will be prompted to target both the object to move
and the destination
*/
public cmd_move(const chr)
{
	readCommandParams(chr);

	//called 'move me
	if(!strcmp(__cmdParams[0],"me"))
	{
		chr_message(chr,_,"Select a location where to go");
		target_create(chr,chr,_,_,"cmd_move_targ_dst");
		return;
	}

	//called 'move here
	if(!strcmp(__cmdParams[0],"here"))
	{
		chr_message(chr,_,"Select an object to move to you");
		target_create(chr,chr,_,_,"cmd_move_targ_here");
		return;
	}

	//called 'move loc
	if(!strcmp(__cmdParams[0],"loc"))
	{
		chr_message(chr,_,"Select an object to move to a location");
		target_create(chr,chr,_,_,"cmd_move_targ_loc");
		return;
	}

	//called with no params
	if(!strlen(__cmdParams[0]))
	{
		chr_message(chr,_,"Select an item to move");
		target_create(chr,_,_,_,"cmd_move_targ");
		return;
	}

	//READ PARAMETERS

	//-------------------  x y ------------------
	new x,y;
	if(!isStrInt(__cmdParams[0]) || !isStrInt(__cmdParams[1]))
	{
		chr_message(chr,_,"x and y must be numbers");
		return;
	}

	x = str2Int(__cmdParams[0]);
	y = str2Int(__cmdParams[1]);

	//---------------  mode  ------------------
	new mode = 1; //0:abs 1:rel

	if(strlen(__cmdParams[2]))
	{
		if(!strcmp(__cmdParams[2],"abs"))
			mode = 0;
		else 	if (!strcmp(__cmdParams[2],"rel"))
				mode = 1;

	
	}

	//check sign of x and y only in abs mode
	if((y < 0 || x < 0) && !mode)
	{
		chr_message(chr,_,"x and y must be positive numbers in abs mode");
		return;
	}
	new area = chr_getCmdArea(chr);

	//command areas only in "rel" mode without "target"
	if(area_isValid(area)  && mode)
	{
		new oldx,oldy,oldz,newx,newy,i;

		if(area_itemsIncluded(area))
			for(set_rewind(area_items(area)); !set_end(area_items(area));i++)
			{
				new itm = set_getItem(area_items(area));
				itm_getPosition(itm,oldx,oldy,oldz);
				newx = oldx + x;
				newy += oldy + y;
		
				itm_moveTo(itm,newx,newy,map_getZ(newx,newy));
		
				#if _CMD_DEBUG_
					printf("^tMoving item %d to %d %d %d^n",itm,newx,newy,map_getZ(newx,newy));
				#endif
			}
	

		if(area_charsIncluded(area))
			for(set_rewind(area_chars(area)); !set_end(area_chars(area));i++)
			{
				new chr2 = set_getChar(area_chars(area));
				chr_getPosition(chr2,oldx,oldy,oldz);
				newx = oldx + x;
				newy = oldy + y;
		
				chr_moveTo(chr2,newx,newy,map_getZ(newx,newy));
		
				#if _CMD_DEBUG_
					printf("^tMoving character %d to %d %d %d^n",chr2,newx,newy,map_getZ(newx,newy));
				#endif
			}
	
		chr_message(chr,_,"%d objects moved",i);
		area_refresh(area);
		area_useCommand(area);
		return;
	}

	//move by target
	if(mode)
		target_create(chr,(x << 16) + y,_,_,"cmd_move_targ_rel");
	else 
	{
		chr_message(chr,_,"Select an object to move");
		target_create(chr,(x << 16) + y,_,_,"cmd_move_targ_abs");
	}
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
		chr_message(chr,_,"You must select an object");
		return;
	}

	chr_message(chr,_,"Select the destination");
	target_create(chr,object,_,_,"cmd_move_targ_dst");
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
			chr_message(chr,_,"You must select an object");
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
		chr_message(chr,_,"You must select an object");
		return;
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
				else chr_message(chr,_,"That character does not have a valid backpack");
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
	chr_message(chr,_,"You must target a location or an object!");
}

/*!
\author Fax
\fn cmd_move_targ_rel(target, chr, object, x, y, z, unused, x)
\params all standard target callback params
\brief handles the destination targetting in 'move when called with "rel" param
*/
public cmd_move_targ_rel(target, chr, object, x, y, z, unused2, param)
{
	new deltax = param  >> 16;
	new deltay = param & 0xFFFF;

	if(isChar(object))
	{
		chr_getPosition(object,x,y,z);
		chr_moveTo(object,x + deltax,y + deltay,map_getZ(x + deltax, y + deltay));
		area_refresh(chr_getCmdArea(chr));
		return;
	}

	if(isItem(object))
	{
		itm_getPosition(object,x,y,z);
		itm_moveTo(object,x + deltax,y + deltay,map_getZ(x + deltax, y + deltay));
		area_refresh(chr_getCmdArea(chr));
		return;
	}

	chr_message(chr,_,"You must select an object!");
}

/*!
\author Fax
\fn cmd_move_targ_abs(target, chr, object, x, y, z, unused, x)
\params all standard target callback params
\brief handles the destination targetting in 'move when called with "abs" param
*/
public cmd_move_targ_abs(target, chr, object, x, y, z, unused2, param)
{
	new newx = param  >> 16;
	new newy = param & 0xFFFF;
	if(isChar(object))
	{
		chr_moveTo(object,newx,newy,map_getZ(newx,newy));
		area_refresh(chr_getCmdArea(chr));
		return;
	}

	if(isItem(object))
	{
		itm_moveTo(object,newx,newy,map_getZ(newx,newy));
		area_refresh(chr_getCmdArea(chr));
		return;
	}

	chr_message(chr,_,"You must select an object!");
}

/*! }@ */