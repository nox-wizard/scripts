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
<LI> ID/scriptID: scriptID ($item_.../$npc_...) of the object, or ID of the item as exadecimal or integer number.
<LI> amount: how much objects you want (default = XSS value for items, 1 for npcs)
</UL>

If no params are specified the add menu is opened.<BR>
You can also pass a generic word as parameter, in that case you will be prompted to choose
between a list ofitems whose define is of the type: $item_<name><type>_<subtype>_<part>.<BR>
For example:<br>
'add forge<br>
will result in a menu where you will be able to choose between:<br>
$item_forge1<br>
$item_forge2_1_1<br>
$item_forge2_1_2<br>
$item_forge2_1_3<br>
$item_forge2_1_4<br>
$item_forge2_1_5<br>
$item_forge2_2_1<br>
$item_forge2_2_2<br>
$item_forge2_2_3<br>
$item_forge2_2_4<br>
$item_forge2_2_5<br>
<br>
'add stone_chair<br>
will result in a menu where you will be able to choose between:<br>
$item_stone_chair_1<br>
$item_stone_chair_2<br>
$item_stone_chair_3<br>
$item_stone_chair_4<br>
<br>
*/

#include "small-scripts/commands/add/addmenu.sma"

public cmd_add(const chr)
{
	readCommandParams(chr);
	
	new startx = 0, starty = 245;
	new type[6];
	new amount = 1;

	//if no parameters are given, show add menu
	if(!strlen(__cmdParams[0]))
	{
		addMenu(chr,startx,starty);
		return;
	}
	
	//show menu
	if(!strcmp(__cmdParams[0],"menu"))
	{
		addMenu(chr,str2Int(__cmdParams[1]),str2Int(__cmdParams[2]));
		return;
	}
	
	if(!strcmp(__cmdParams[0],"reload"))
	{
		loadAddMenu(chr);
		return;
	}

	if(!strcmp(__cmdParams[0],"lang"))
	{
		if(!isStrInt(__cmdParams[1]))
		{
			chr_message(chr,_,"invalid parameter - languages are 0:english 1:german 2:italian 3:french");
			return;	
		}
		
		currentAddmenuLanguage = str2Int(__cmdParams[1]);
		loadAddMenu(chr);
		return;
	}
	
	//set continous adding as default without add menu, esc stops it
	if(!chr_isaLocalVar(chr,CLV_CONTINUOUS_ADDING_MODE))
	{
		chr_addLocalIntVar(chr,CLV_CONTINUOUS_ADDING_MODE);
	}
		
	if(isStrInt(__cmdParams[1]))
		amount = str2Int(__cmdParams[1]);
	
	if(amount < 0)
	{
		chr_message(chr,_,"Amount must be a positive number");
		return;
	}

	chr_setTempIntVar(chr,CLV_CMDTEMP,amount);

	if(isStrInt(__cmdParams[0]))
	{
		chr_message(chr,_,"click to position the item");
		target_create(chr,str2Int(__cmdParams[0]),amount,_,"cmd_add_itm_targ");
		return;
	}
	
	//if the parameter is a generic word, show a list with matching items	
	if(__cmdParams[0][0]!='$')
	{
		showMatchingItemsList(chr);
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
	new amount = chr_getTempIntVar(chr,CLV_CMDTEMP);
	
	getMapLocation(object,x,y,z);

	for(new i = 0; i < amount; i++)
	{
		new npc = chr_addNPC(scriptID,x,y,z);
		chr_message(chr,_,"Character %d created",npc);
		#if _CMD_DEBUG_
			log_message("^tCharacter %d created",npc);
		#endif
	}
	
	//handle continuous adding mode
	if(chr_isaLocalVar(chr,CLV_CONTINUOUS_ADDING_MODE))
	{
		chr_setTempIntVar(chr,CLV_CMDTEMP,1);
		target_create(chr,scriptID,_,_,"cmd_add_npc_targ");
	}
}

/*!
\author Fax
\fn cmd_add_itm_targ(target, chr, object, x, y, z, unused1, scriptID)
\brief handles targetting
*/
public cmd_add_itm_targ(target, chr, object, x, y, z, unused1, scriptID)
{
	new amount = chr_getTempIntVar(chr,CLV_CMDTEMP);
	
	#if _CMD_DEBUG_
		log_message("^tadding %d items of type %d at: %d %d %d",amount,scriptID,x,y,z);
	#endif
	
	if(isChar(object))
		if(!chr_isNpc(object))
		{
			new item = itm_createInBp(scriptID,object);
			if(itm_getProperty(item,IP_PILEABLE))
			{
				itm_setProperty(item,IP_AMOUNT,_,amount);
				itm_refresh(item);
			}
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
	{
		itm_setProperty(itm,IP_AMOUNT,_,amount);
		itm_refresh(itm);
	}
	else
		for(new i = 0; i < amount - 1; i++)
		{
			itm = itm_create(scriptID);
			itm_moveTo(itm,x,y,z);
			itm_refresh(itm);
			chr_message(chr,_,"Item %d created",itm);
		}
	
	#if _CMD_DEBUG_
		log_message("^tItem %d created",itm);
	#endif
	
	//handle continuous adding mode
	if(chr_isaLocalVar(chr,CLV_CONTINUOUS_ADDING_MODE))
	{
		chr_setTempIntVar(chr,CLV_CMDTEMP,1);
		target_create(chr,scriptID,_,_,"cmd_add_itm_targ");
	}
}

static end;
static matchesFound;
static def[50];
static type = 0;
static subtype = 0;
static part = 0;

public showMatchingItemsList(chr)
{
	type = subtype = part = matchesFound = 0;
	end = false;
	new title[60],width = strlen(__cmdParams[0]) + 20;
	sprintf(title,"Matches for '%s'",__cmdParams[0]);
	cursor_setProperty(CRP_TAB,width + 10);
	createListMenu(0,0,15,width,200,title,"drawMatchingItemListLine","cmd_add_ilist_cback");
	if(matchesFound)
		menu_show(chr);
	else 
	{
		sprintf(title,"No matches found for '$item_%s'",__cmdParams[0]);
		popupMenu(chr,title,"This happens because:^n-The item does not exist^n- You didn't replace all blanks^n with undescores");
	}
}

public drawMatchingItemListLine(page,line,col,i)
{
	if(end)
	{
		cursor_up();
		return;
	}
	
	new scriptID = searchMatch();
	if(scriptID > 0)
	{
		menu_addLabeledButton(scriptID,def);
		matchesFound = true;
	}
	else 	end = true;
}

static searchMatch()
{
	sprintf(def,"$item_%s",__cmdParams[0]);
	//build definition
	if(type > 0)
		sprintf(def,"%s%d",def,type);
	
	if(subtype > 0)
	{
		sprintf(def,"%s_%d",def,subtype);
		if(part > 0)
			sprintf(def,"%s_%d",def,part);
	}
		
	new scriptID;
	scriptID = getIntFromDefine(def);
	if(scriptID > 0)
	{
		//increase last index
		if(subtype > 0)
			if(part > 0)
				part++
			else subtype++ 	
		else type++
		return scriptID;
	}

	if(part > 0)
		if(part == 1)
			if(subtype == 1 && type > 0)
			{
				end = true;
				return - 1;
			}
			else
			{
				part = 0;
				subtype = 0;
				type++;
				return searchMatch();
			}
		else
		{
			part = 0;
			subtype++;
			return searchMatch();
		}
	
	if(subtype > 0)
	{
		part++;
		return searchMatch();
	}
		
	subtype++;
	return searchMatch();
}

public cmd_add_ilist_cback(menu,chr,scriptID)
{
	if(!scriptID) return;
	chr_message(chr,_,"click to position the item");
	target_create(chr,scriptID,_,_,"cmd_add_itm_targ");
}
/*! }@ */