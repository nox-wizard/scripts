/*!
\defgroup script_command_tile 'tile
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_tile(const chr)
\brief tiles an item

<B>syntax:<B> 'tile [nX nY] [nZ zScale]
<B>command params:</B>
<UL>
<LI> nX nY nZ:number of item tiles along the x y z axes, the last parameter is optional
<LI> zScale: distance between items along z axis
</UL>

Duplicates the item putting copies of the item at every tile along the x y z axes.<BR>
With this command you can easily build floors and walls.<br>
Passing no parameters will make the command ask for 2 map locations that will define the tiling rectangle.<br>
All parameters must be < 256.
*/
public cmd_tile(const chr)
{
	readCommandParams(chr);

	//call with no params -> ask for rectangle
	if(!strlen(__cmdParams[0]))
	{
		getRectangle(chr,"cmd_tile_rect");
		return;
	}

	if(!strlen(__cmdParams[1]))
	{
		chr_message(chr,_,"If you want to pass parameters you must pass at least nX and nY");
		return;
	}

	if(!isStrInt(__cmdParams[0]) || !isStrInt(__cmdParams[1]) || (strlen(__cmdParams[2]) && !isStrInt(__cmdParams[2])) || (strlen(__cmdParams[3]) && !isStrInt(__cmdParams[3])))
	{
		chr_message(chr,_,"x y z and z-scale must be integer numbers");
		return;
	}

	new nX = str2Int(__cmdParams[0]);
	new nY = str2Int(__cmdParams[1]);
	new nZ = isStrInt(__cmdParams[2]) ? str2Int(__cmdParams[2]) : 1;
	new zScale = isStrInt(__cmdParams[3]) ? str2Int(__cmdParams[3]) : 1;
	new nXnYnZzScale = (nX << 24) + (nY << 16) + (nZ << 8) + zScale;  
	 
	chr_message(chr,_,"Select an item to tile");
	target_create(chr,nXnYnZzScale,_,_,"cmd_tile_targ");
}

/*!
\author Fax
\fn cmd_tile_targ(target, chr, object, x, y, z, unused, freeze)
\params all standard target callback params
\brief handles parametrized tiling
*/
public cmd_tile_targ(target, chr, object, x, y, z, unused, nXnYnZzScale)
{
	if(!isItem(object))
	{
		chr_message(chr,_,"You must target an item");
		return;
	}
	itm_getPosition(object,x,y,z);
	 	 
	 new nX = (nXnYnZzScale >> 24) & 0xFF;
	 new nY = (nXnYnZzScale >> 16) & 0xFF;
	 new nZ = (nXnYnZzScale >> 8)& 0xFF;
	 new zScale = nXnYnZzScale & 0xFF;
	 
	 cmd_tile_copyItem(object,x,y,z,nX,nY,nZ,zScale);
}

public cmd_tile_rect(chr,x0,y0,x1,y1)
{
	new nX = x1 - x0 + 1;
	new nY = y1 - y0 + 1;
	new nXnY = (nX << 16) + nY;

	new xy = (x0 << 16) + y0;
	chr_setLocalIntVar(chr,CLV_CMDTEMP,xy);

	chr_message(chr,_,"Select an item to tile");
	target_create(chr,nXnY,_,_,"cmd_tile_targ1");
}

public cmd_tile_targ1(target, chr, object, x, y, z, unused, nXnY)
{
	if(!isItem(object))
	{
		chr_message(chr,_,"You must target an item");
		return;
	}
	 	 
	 new nX = nXnY >> 16;
	 new nY = nXnY & 0xFF;
	 
	 new xy = chr_getLocalIntVar(chr,CLV_CMDTEMP);
	 chr_setLocalIntVar(chr,CLV_CMDTEMP,INVALID);
	 
	 x = xy >> 16;
	 y = xy & 0xFFFF;
	 z = map_getZ(x,y);
	 
	 cmd_tile_copyItem(object,x,y,z,nX,nY,1,1);
}

static cmd_tile_copyItem(object,x,y,z,nX,nY,nZ,zScale)
{
	#if _CMD_DEBUG_
	 	log_message("^t->Tiling item %d in cube (%d %d %d) (%d %d %d)",object,x,y,z,x + nX - 1,y + nY - 1,z + nZ - 1);
	 #endif
	 
	 new item,iX,iY,iZ;
	 itm_getPosition(object,iX,iY,iZ);
	 for(new k = 0; k < nZ; k++)
	 {
	 	for(new i = 0; i < nX; i++)
	 	{
	 		for(new j = 0; j < nY; j++)
	 		{
	 			//skip item position
	 			if(x + i == iX && y + j == iY && z + k*zScale == iZ) continue;
	 	
	 			item = itm_copy(object);
	 			itm_moveTo(item,x + i,y + j,z + k*zScale);
	 		}
	 	}
	 }
}

/*! }@ */