/*!
\defgroup script_command_tile 'tile
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_tile(const chr)
\brief tiles an item

<B>syntax:<B> 'tile [item] [nX nY] [nZ zScale]
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

new itemStr[100];

public cmd_tile(const chr)
{
	readCommandParams(chr);

	new type[6];
	substring(__cmdParams[0],0,4,type,false);
	if(!strcmp(type,"$item")) //add an item
	{
		sprintf(itemStr, "%s", __cmdParams[0]); 
	}
	else
	{
		getRectangle(chr,"cmd_tile_rect");
		return;
	}
	
	//call with no further params -> ask for rectangle
	if(!strlen(__cmdParams[1]))
	{
		getRectangle(chr,"cmd_tile_rect");
		return;
	}

	if(!strlen(__cmdParams[2]))
	{
		chr_message(chr,_,msg_commandsDef[251]);
		return;
	}

	if(!isStrInt(__cmdParams[3]) || !isStrInt(__cmdParams[1]) || (strlen(__cmdParams[2]) && !isStrInt(__cmdParams[2])) || (strlen(__cmdParams[3]) && !isStrInt(__cmdParams[3])))
	{
		chr_message(chr,_,msg_commandsDef[252]);
		return;
	}

	new nX = str2Int(__cmdParams[1]);
	new nY = str2Int(__cmdParams[2]);
	new nZ = isStrInt(__cmdParams[3]) ? str2Int(__cmdParams[3]) : 1;
	new zScale = isStrInt(__cmdParams[4]) ? str2Int(__cmdParams[4]) : 1;
	new nXnYnZzScale = (nX << 24) + (nY << 16) + (nZ << 8) + zScale;  
	 
	chr_message(chr,_,msg_commandsDef[253]);
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
		chr_message(chr,_,msg_commandsDef[103]);
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
	chr_addLocalIntVar(chr,CLV_CMDTEMP,xy);

	//which item?
	if(!strlen(itemStr))
	{
		chr_message(chr,_,msg_commandsDef[253]);
		target_create(chr,nXnY,_,_,"cmd_tile_targ1");
		return;
	}
	else
		new x = xy >> 16;
		new y = xy & 0xFFFF;
		new z = map_getZ(x,y);
		new object = itm_createByDef(itemStr);
		cmd_tile_copyItem(object,x,y,z,nX,nY,1,1);
		itm_remove(object);
}

public cmd_tile_targ1(target, chr, object, x, y, z, unused, nXnY)
{
	if(!isItem(object))
	{
		chr_message(chr,_,msg_commandsDef[103]);
		return;
	}
	 	 
	 new nX = nXnY >> 16;
	 new nY = nXnY & 0xFF;
	 
	 new xy = chr_getLocalIntVar(chr,CLV_CMDTEMP);
	 chr_delLocalVar(chr,CLV_CMDTEMP);
	 
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