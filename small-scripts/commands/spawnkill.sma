/*!
\defgroup script_commands_spawnkill 'spawnkill
\ingroup script_commands

@{
*/

/*!
\author Fax
\since 0.82
\fn cmd_spawnkill(const chr)
\brief spawnkills regions

<b> syntax: </b> 'spawnkill [region] [type]
<UL>
<LI>region: region number, "this" or "all" (default= all)
<LI>type: type of spawner to kill, "stat"(static) "dyn"(dynamic) "all"(all)(default = a)
</UL>

spawnkills regions

*/
public cmd_spawnkill(const chr)
{
	readCommandParams(chr);
	
	new region = -1,type = SPAWN_ALL;
	
	//read region
	if(strlen(__cmdParams[0]))
		if(isStrInt(__cmdParams[0]))
		{
			region = str2Int(__cmdParams[0]);
			if(!rgn_isValid(region))
			{
				chr_message(chr,_,"%d is not a valid region",region);
				return;
			}
		}
		else if(!strcmp(__cmdParams[0],"this"))
			region = chr_getProperty(chr,CP_REGION);
	
	//read amount/mode
	if(strlen(__cmdParams[1]))
		if(!strcmp(__cmdParams[1],"stat"))
			type = SPAWN_STATIC;
		else 	if(!strcmp(__cmdParams[1],"dyn"))
				type = SPAWN_DYNAMIC;
	
			
	if(region == -1)
	{
		for (new i = 0; i < 256; i++)
			rgn_clearSpawn( i, type);
		chr_message(chr,_,"Spawners cleared in all regions");
	}
	else
	{
		rgn_clearSpawn( region, type);
		new name[50];
		rgn_getName(region,name);
		chr_message(chr,_,"Spawners cleared in %s",name);
	}
}
/*! @}*/