/*!
\defgroup script_commands_respawn 'respawn
\ingroup script_commands

@{
*/

/*!
\author Fax
\since 0.82
\fn cmd_respawn(const chr)
\brief respawns regions

<b> syntax: </b> 'respawn [region] [n]
<UL>
<LI>region: region number, "this" or "all" (default= all)
<LI>n: amount, "max" or "rand" (default = max)
</UL>

respawns regions

*/
public cmd_respawn(const chr)
{
	readCommandParams(chr);
	
	new region = -1,mode = SPAWN_MAX, amount = 0;
	
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
		if(isStrInt(__cmdParams[1]))
		{
			amount = str2Int(__cmdParams[1]);
			if(amount < 0)
			{
				chr_message(chr,_,"Amount must be positive");
				return;
			}
		}
		else if(!strcmp(__cmdParams[1],"rand"))
			mode = SPAWN_RANDOM;
	
			
	if(region == -1)
	{
		for (new i = 0; i < 256; i++)
			rgn_respawn( i, mode, amount);
		chr_message(chr,_,"All regions respawned");
	}
	else
	{
		rgn_respawn( region, mode, amount);
		chr_message(chr,_,"Region respawned");
	}
}
/*! @}*/