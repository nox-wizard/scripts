/*!
\defgroup script_command_add 'add
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_add(const chr)
\brief adds objects to the world

<B>syntax:</B> 'add [ID/scriptID][amount]
<B>command params:</B>
<UL>
<LI> ID/scriptID: scriptID ($item_.../$npc_...) of the object, or ID of the item as exadecimal or integer number 
<LI> amount: how much objects you want (default = XSS value for items, 1 for npcs)
</UL>

If no params are specified the add menu is opened.<BR>
<br>
*/

#include "small-scripts/commands/add/addmenu.sma"
public cmd_add(const chr)
{
	new type[6];
	new amount = 1;
		
	//if no parameters are given, show add menu
	if(!strlen(__cmdParams[0]))
	{
		addMenu(chr);
		return;		
	}
	
	if(isStrInt(__cmdParams[1]))
		amount = str2Int(__cmdParams[1]);
	
	if(amount < 0)
	{
		chr_message(chr,_,"Amount must be a positive number");
		return;
	}
	
	if(isStrHex(__cmdParams[0]))
	{
		itm_createInBp(str2Hex(__cmdParams[0]),chr,amount);
		chr_message(chr,_,"item created in your backpack");
		return;
	}
	
	if(isStrInt(__cmdParams[0]))
	{
		itm_createInBp(str2Int(__cmdParams[0]),chr,amount);
		chr_message(chr,_,"item created in your backpack");
		return;
	}
		
	substring(__cmdParams[0],0,4,type,false);
	if(!strcmp(type,"$item")) //add an item
	{
		new item = itm_createInBpDef(__cmdParams[0],chr,amount);
		if(isItem(item))
			chr_message(chr,_,"Item %d created in your backpack",item);
		else chr_message(chr,_,"An error occurred while creating the item");
		return;
	}
	
	amount = 1;
	if(!strcmp(type,"$npc_"))  //add an NPC
	{
		chr_message(chr,_,"click to position the NPC");
		target_create(chr,getIntFromDefine(__cmdParams[0]),amount,_,"cmd_add_targ");
		return;
	}
	
	chr_message(chr,_,"%s is not a valid scriptID",__cmdParams[0]);
}

/*!
\author Fax
\fn cmd_add_targ(target, chr, object, x, y, z, unused1, scriptID)
\brief handles the area targetting
*/
public cmd_add_targ(target, chr, object, x, y, z, unused1, scriptID)
{
	#if _CMD_DEBUG_
		printf("^tadding npc at: %d %d %d ^n",x,y,z);
	#endif
	
	if(x != INVALID && y != INVALID)
	{
		new amount = 1;//target_getProperty(target,TP_BUFFER,1);
		for(new i = 0; i < amount; i++)
		{
			new npc = chr_addNPC(scriptID,x,y,z);
			chr_message(chr,_,"Character %d created",npc);
			#if _CMD_DEBUG_
				printf("^tCharacter %d created",npc);
			#endif
		}
		return;
	}
	chr_message(chr,_,"Invalid map location");
}

/*! }@ */