/*!
\author Fax
\fn cmd_move(const chr)
\brief moves objects

<B>syntax:<B> 'move [x][y]["abs"/"rel"]["target"] or 'move me

<B>command params:</B>
<UL>
<LI> me: if command is called as 'move me, the character is teleported in a targetted location
When using this option no other parameters are needed.<br>
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
\todo make this function work when commands are done in sources
*/
public cmd_move(const chr)
{
	new x,y,me;
	//if no params are passed, target both object and destination
	//TODO: better check when params will be available
	if(me)
	{
		chr_message(chr,_,"Select a location where to go");
		target_create(chr,chr,_,_,"cmd_move_targ_dst");
		return;
	}
	
	if(x == INVALID && y == INVALID)
	{
		chr_message(chr,_,"Select an item to move");
		target_create(chr,_,_,_,"cmd_move_targ");
		return;
	}
		
	new mode = 1; //0:abs 1:rel
	//TODO:set parameters properly

	new target = true;
	new area = chr_getCmdArea(chr);
	
	//command areas only in "rel" mode without "target"
	if(area_isValid(area) && !target && mode)
	{
		new oldx,oldy,oldz,i;
		for(set_rewind(area_items(area)); !set_end(area_items(area));i++)
			{
				new itm = set_getItem(area_items(area));
				itm_getPosition(itm,oldx,oldy,oldz);
				x += oldx;
				y += oldy;
				itm_moveTo(itm,x,y,map_getZ(x,y));	
			}
		chr_message(chr,_,"%d items moved",i);
		area_refresh(area);
		area_useCommand(area);
		return;
	}




if(mode)
	target_create(chr,x,y,_,"cmd_move_targ_rel");	
else 
	{
		if(x < 0 || y < 0)
		{
			chr_message(chr,_,"in abs mode x and y must be non-negative",i);	
			return;		
		}	
		target_create(chr,x,y,_,"cmd_move_targ_abs");
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
\fn cmd_move_targ_dst(target, chr, object, x, y, z, unused, param)
\params all standard target callback params
\brief handles the destination targetting in 'move when called without params
*/
public cmd_move_targ_dst(target, chr, unused, x, y, z, unused2, param)
{
	if(x != INVALID && y != INVALID && z != INVALID && param != INVALID)
	{
		if(isChar(param))
			chr_moveTo(param,x,y,z);
		if(isItem(param))
			itm_moveTo(param,x,y,z);
		area_refresh(chr_getCmdArea(chr));
		return;
	}
	chr_message(chr,_,"You must target a location!");	
}

/*!
\author Fax
\fn cmd_move_targ_rel(target, chr, object, x, y, z, unused, x)
\params all standard target callback params
\brief handles the destination targetting in 'move when called with "rel" param
*/
public cmd_move_targ_rel(target, chr, object, x, y, z, unused2, deltax)
{
	new deltay = target_getProperty(target,TP_BUFFER,1);
	if(isChar(object))
	{
		chr_getPosition(object,x,y,z);
		chr_moveTo(object,x + deltax,y + delaty,map_getZ(x + delatx, y + deltay));
		area_refresh(chr_getCmdArea(chr));
		return;	
	}
	
	if(isItem(object))
	{
		itm_getPosition(object,x,y,z);
		itm_moveTo(object,x + deltax,y + delaty,map_getZ(x + delatx, y + deltay));
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
public cmd_move_targ_abs(target, chr, object, x, y, z, unused2, newx)
{
	new newy = target_getProperty(target,TP_BUFFER,1);
	if(isChar(object))
	{
		chr_moveTo(object,mewx,newy,map_getZ(newx,newy));
		area_refresh(chr_getCmdArea(chr));
		return;	
	}
	
	if(isItem(object))
	{
		itm_moveTo(object,mewx,newy,map_getZ(newx,newy));
		area_refresh(chr_getCmdArea(chr));
		return;	
	}
	
	chr_message(chr,_,"You must select an object!");	
}