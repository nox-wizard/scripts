/*!
\defgroup script_commands_add 'add
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
	readCommandParams(chr);
	
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
	
	//if(isStrHex(__cmdParams[0]))
	//{
	//	itm_createInBp(str2Hex(__cmdParams[0]),chr,amount);
	//	chr_message(chr,_,"item created in your backpack");
	//	return;
	//}
	
	chr_setLocalIntVar(chr,CLV_CMDTEMP,amount);
	
	if(isStrInt(__cmdParams[0]))
	{
		chr_message(chr,_,"click to position the item");
		target_create(chr,str2Int(__cmdParams[0]),amount,_,"cmd_add_itm_targ");
		return;
	}
		
	substring(__cmdParams[0],0,4,type,false);
	if(!strcmp(type,"$item")) //add an item
	{
		chr_message(chr,_,"click to position the item");
		target_create(chr,getIntFromDefine(__cmdParams[0]),amount,_,"cmd_add_itm_targ");
		return;
	}
	
	amount = 1;
	if(!strcmp(type,"$npc_"))  //add an NPC
	{
		chr_message(chr,_,"click to position the NPC");
		target_create(chr,getIntFromDefine(__cmdParams[0]),amount,_,"cmd_add_npc_targ");
		return;
	}
	
	chr_message(chr,_,"%s is not a valid scriptID",__cmdParams[0]);
}

/*!
\author Fax
\fn cmd_add_npc_targ(target, chr, object, x, y, z, unused1, scriptID)
\brief handles targetting
*/
public cmd_add_npc_targ(target, chr, object, x, y, z, unused1, scriptID)
{
	#if _CMD_DEBUG_
		log_message("^tadding npc at: %d %d %d ^n",x,y,z);
	#endif
	new amount = chr_getLocalIntVar(chr,CLV_CMDTEMP);
	
	if(isChar(object))
		chr_getPosition(object,x,y,z);
	else 	if(isItem(object))
			itm_getPosition(object,x,y,z);
		else 	if(x == INVALID || y == INVALID)
			{
				chr_message(chr,_,"Invalid map location %d %d",x,y);
				log_error("Target returned invalid map location %d %d %d",x,y,z);
				return;	
			}
	
	for(new i = 0; i < amount; i++)
	{
		new npc = chr_addNPC(scriptID,x,y,z);
		chr_message(chr,_,"Character %d created",npc);
		#if _CMD_DEBUG_
			log_message("^tCharacter %d created",npc);
		#endif
	}
}

/*!
\author Fax
\fn cmd_add_itm_targ(target, chr, object, x, y, z, unused1, scriptID)
\brief handles targetting
*/
public cmd_add_itm_targ(target, chr, object, x, y, z, unused1, scriptID)
{
	#if _CMD_DEBUG_
		log_message("^tadding item at: %d %d %d ^n",x,y,z);
	#endif
	new amount = chr_getLocalIntVar(chr,CLV_CMDTEMP);
	
	if(isChar(object))
		if(!chr_isNpc(object))
		{
			new item = itm_createInBp(scriptID,object);
			if(itm_getProperty(item,IP_PILEABLE))
				itm_setProperty(item,IP_AMOUNT,_,amount);
			else
				for(new i = 0; i < amount - 1; i++)
					itm_createInBp(scriptID,object);
			chr_message(chr,_,"item %d created in backpack",item,object);
			return;
		}
		else chr_getPosition(object,x,y,z);
		
	else 	if(isItem(object))
			itm_getPosition(object,x,y,z);
		else 	if(x == INVALID || y == INVALID)
			{
				chr_message(chr,_,"Invalid map location %d %d",x,y);
				log_error("Target returned invalid map location %d %d %d",x,y,z);
				return;	
			}
	
	new itm = itm_create(scriptID);
	itm_moveTo(itm,x,y,z);
	itm_refresh(itm);
	chr_message(chr,_,"Item %d created",itm);
			
	if(itm_getProperty(itm,IP_PILEABLE))
		itm_setProperty(itm,IP_AMOUNT,_,amount);
	else
		for(new i = 0; i < amount - 1; i++)
		{
			itm = itm_create(scriptID);
			itm_moveTo(itm,x,y,z);
			itm_refresh(itm);
			chr_message(chr,_,"Item %d created",itm);
		}
			
	#if _CMD_DEBUG_
		log_message("^tItem %d created^n",itm);
	#endif
}

/*! }@ */