// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts (menus.xss)                                      ||
// || Maintained by Xanathar and Kendra                                   ||
// || Last Update 27-nov-2001                                             ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || This script requires NoX-Wizard 0.70s or later                      ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#include "small-scripts/commands/add/constants.sma"
#include "small-scripts/API/gui/defines.sma"
#include "small-scripts/commands/add/lists.sma"

/*!
\defgroup script_commands_add_menu menu
\ingroup script_commands_add

@{
*/


#define PICW 30
//do not touch
#define INPUT_AMOUNT 0
#define INPUT_MATERIAL 1
#define INPUT_MAGIC_SUFFIX 100

#define CHK_ITEMSINBACKPACK 0;

static error;
//==================================================================================//
//                            ADD MENU MAIN PAGE                                    //
//==================================================================================//
/*!
\author Fax
\fn addMenu(const chr)
\param chr: the character
\since 0.82
\brief main 'add menu function

This function shows the main add menu page, you can configure the page's contents and 
functions the functions that draw other pages by editing the contents of __addMenuItems[][] array
\return the menu serial
*/

public addMenu(const chr)
{	                  
	new i_row = ADD_MENU_ENTRIES/ADD_MENU_ROWS;
	new tab = (ADD_MENU_ENTRIES_L + 4);
	new COLS = 2 + i_row*tab;

	#if _CMD_DEBUG_
	log_message("^t->drawing add menu");
	#endif
	
	new menu = createFramedMenu(0,550,ADD_MENU_ROWS,0,COLS,"addgui_cback");
	cursor_setProperty(CRP_TAB,tab);
	for(new i = 1; i <= ADD_MENU_ENTRIES; i++)
	{
		menu_addLabeledButton(i,addMenuItems[i - 1][__addGuiText]);
		cursor_tab();
		
		if(i%i_row == 0 && i != 0) cursor_newline();
	}

	menu_show(chr);
	return menu;
}

/*!
\author Fax
\fn addgui_cback(menu,chr,weapon)
\param all: standard menu callback params
\since 0.82
\brief callback for weapon menu

Calls functions specified in addMenuItems[][] to craete gumps for the other sections
\return nothing
*/
public addgui_cback(menu,chr,idx)
{
	if(!idx) return;
	
	new amount[10];
	gui_getProperty(menu,MP_UNI_TEXT,INPUT_AMOUNT,amount);
	addMenu(chr);

#if _CMD_DEBUG_
	log_message("^t->calling function: %s",addMenuItems[idx - 1][__addGuiFunc]);
#endif
	callFunction3P(funcidx(addMenuItems[idx - 1][__addGuiFunc]),chr,false,1);
}

//==================================================================================//
//                              MAGIC ITEMS MENU                                    //
//==================================================================================//
/*!
\author Fax
\fn addgui_magic(chr,itemsInBackpack,amount)
\param chr: the character
\param itemsInBackpack: true if items are to be created in backpack
\amount:how many items we need
\since 0.82
\brief magic items page

\return nothing
*/
public addgui_magic(chr,itemsInBackpack,amount)
{
	if(!isChar(chr)) return;

#if _CMD_DEBUG_
	log_message("^t->drawing magic menu");
#endif
	
	new i_row = 4;
	new ROWS = 2 + MAGIC_MENU_ENTRIES/i_row + (MAGIC_MENU_ENTRIES%i_row > 0 ? 1 : 0)
	new COLS = i_row*(MAGIC_MENU_ENTRIES_L + 3);
	
	new tab = (COLS - 2)/i_row;
	cursor_setProperty(CRP_TAB,tab);
		
	createFramedMenu(0,0,ROWS,15,COLS,"addgui_magic_cback");
	for(new p = 1; p <= MAGIC_MENU_ENTRIES; p++)
	{
		menu_addLabeledPageButton(p,magicMenuTxt[p - 1]);
		cursor_tab();
		
		if(p%i_row == 0 && p != 0) cursor_newline();
	}
	
	cursor_newline();	
	addStdCheckBoxAndInputField(itemsInBackpack,amount);
	
	cursor_setProperty(CRP_TAB,2*tab);
	
	new idx = MAGIC_MENU_IDX,numentries;
	new starty = cursor_y()
	for(new p = 1; p <= MAGIC_MENU_ENTRIES; p++)
	{
		menu_addPage(p);
		cursor_newline();
		cursor_goto(cursor_x(),starty);
		numentries = __listAllocationMap[P_MAGICALITEMS + p - 1];
		if(addItemList(numentries,11,idx,true,true)) error = 1;
		idx += numentries;
	}

	menu_show(chr);
	handleError(chr);
}

/*!
\author Fax
\fn addgui_magic_cback(menu,chr,weapon)
\param all: standard menu callback params
\since 0.82
\brief callback for magic menu

Creates the items selected in the gump
\return nothing
*/
public addgui_magic_cback(menu,chr,btncode)
{
	if(!btncode)	return;

	new n,itemsInBackpack;
	getAmountAndChk(menu,n,itemsInBackpack);

	if(itemsInBackpack)
	{
		new item; 
		item = itm_createInBp(btncode,chr);
				
		if(itm_getProperty(item,IP_PILEABLE))
		{
			itm_createInBp(btncode,chr,n - 1);
			chr_message(chr,_,"Item %d created",item);
		}
		else
			for(new i = 0; i < n -1; i++)
			{
				item = itm_createInBp(btncode,chr);
				chr_message(chr,_,"Item %d created",item);
			}
	}

	else
	{
		chr_addLocalIntVar(chr,CLV_CMDTEMP,n);
		chr_message(chr,_,"click to position the item");
		target_create(chr,btncode,_,_,"cmd_add_itm_targ");
	}

	addgui_magic(chr,itemsInBackpack,n);
}

//==================================================================================//
//                            COMBAT ITEMS MENU                                    //
//==================================================================================//
/*!
\author Fax
\fn addgui_combat(chr,itemsInBackpack,amount)
\param chr: the character
\param itemsInBackpack: true if items are to be created in backpack
\amount:how many items we need
\since 0.82
\brief combat items page

\return nothing
\todo Activate amount input box in combat menu
*/

public addgui_combat(chr,itemsInBackpack,amount)
{
	if(!isChar(chr)) return;

	#if _CMD_DEBUG_
	log_message("^t->drawing combat menu");
	#endif

	new i_row = 4;
	new ROWS = 2 + COMBAT_MENU_ENTRIES/i_row + (COMBAT_MENU_ENTRIES%i_row > 0 ? 1 : 0)
	new COLS = i_row*(COMBAT_MENU_ENTRIES_L + 3);

	new tab = (COLS - 2)/i_row;
	cursor_setProperty(CRP_TAB,tab);
		
	createFramedMenu(0,0,ROWS,15,COLS,"addgui_armor_cback");

	for(new p = 1; p <= COMBAT_MENU_ENTRIES; p++)
	{
		menu_addLabeledPageButton(p,combatMenuTxt[p - 1]);
		cursor_tab();
		
		if(p%i_row == 0 && p != 0) cursor_newline();
	}
	
	addStdCheckBoxAndInputField(itemsInBackpack,amount);
	cursor_setProperty(CRP_TAB,2*tab);
	
	new starty = cursor_y();
	for(new p = 1; p <= COMBAT_MENU_ENTRIES; p++)
	{
		menu_addPage(p);
		cursor_newline();
		cursor_goto(cursor_x(),starty);
		switch(p)
		{
			case P_PLATEMAIL..P_SHIELDS:
			{	
				new artype = p - P_PLATEMAIL;
				for(new i = 0; i < ARMOR_PARTS; i++)
				{
					if(__armor[artype*ARMOR_PARTS + i][__ID] == INVALID) continue;
			
					menu_addCheckBox(false,p*10 + i);
					menu_addLabeledTilePic(__armor[artype*ARMOR_PARTS + i][__ID],PICW,__armor[artype*ARMOR_PARTS + i][__name]);
					
					cursor_newline(); cursor_newline();
				}
				
				cursor_goto(cursor_x(),starty);
				cursor_tab();
				
				new material[5] = "";
				if(p != P_LEATHER && p!= P_STUDDED && p != P_BONE) sprintf(material,"iron");
				menu_addLabeledInputField(INPUT_MATERIAL + 10*p,material,15,"Material:");
				cursor_down();
				
				menu_addLabeledInputField(INPUT_MAGIC_SUFFIX + 10*p,"",15,"Magic suffix:");
				cursor_down(4);
				
				menu_addLabeledButtonFn(p,"addgui_armor_cback","create in backpack");
				cursor_down();
				
				menu_addLabeledButtonFn(p + 1000,"addgui_armor_cback","Equip");
				cursor_down();
				
				menu_addLabeledButtonFn(p + 10000,"addgui_armor_cback","Equip to character");
			}
	
			case P_AXES..P_OTHER:
			{
				cursor_setProperty(CRP_INTERLINE,15);
				new wpntype = p - P_AXES;
				for(new i = 0; i < WEAPONS_PER_GROUP; i++)
				{
					if(__weapons[wpntype*WEAPONS_PER_GROUP + i][__ID] == INVALID) continue;
					
					menu_addButtonFn(wpntype*WEAPONS_PER_GROUP + i,"addgui_weapon_cback");
					menu_addLabeledTilePic(__weapons[wpntype*WEAPONS_PER_GROUP + i][__ID],PICW,__weapons[wpntype*WEAPONS_PER_GROUP + i][__name]);
					
					cursor_newline();
				}
				
				cursor_setProperty(CRP_INTERLINE,10);
				
				cursor_goto(cursor_x(),starty);
				cursor_tab();
								
				menu_addLabeledInputField(INPUT_MATERIAL + 10*p,"iron",15,"Material:");
				cursor_down();
				
				menu_addLabeledInputField(INPUT_MAGIC_SUFFIX + 10*p,"",15,"Magic suffix:");
			}
		}
	}

	menu_show(chr);
}

/*!
\author Fax
\fn addgui_armor_cback(menu,chr,armor)
\param menu,chr,armor: standard menu callback params
\since 0.82
\brief callback for armor menu

Looks at the values given in the armor menu and creates the XSS def of the items to create and creates them
\return nothing
*/
public addgui_armor_cback(menu,chr,armor)
{
	if(!armor)	return;

	new action;
	if(armor >= 10000) 
	{
		action = 0;
		armor -= 10000;
	}
	else 	if(armor >= 1000)
		{
			action = 1;
			armor -= 1000;
		}
		else action = 2;

	new material[20],suffix[30];
	gui_getProperty(menu,MP_UNI_TEXT,INPUT_MATERIAL + 10*armor,material);
	if(strlen(material)) sprintf(material,"_%s",material);

	gui_getProperty(menu,MP_UNI_TEXT,INPUT_MAGIC_SUFFIX + 10*armor,suffix);
	if(strlen(suffix)) sprintf(suffix,"_of_%s",suffix);

	new artype[20] = "";
	switch(armor)
	{
		case P_PLATEMAIL: sprintf(artype,"_plate");
		case P_CHAINMAIL: sprintf(artype,"_chain");
		case P_RINGMAIL:  sprintf(artype,"_ringmail");
		case P_STUDDED:   sprintf(artype,"_studded_leather");
		case P_LEATHER:	  sprintf(artype,"_leather");
		case P_BONE:	  sprintf(artype,"_bone");
	}

	new arpart[20] = "", gender[10] = "",r,buffer[ARMOR_PARTS];
	for(new i = 0; i < ARMOR_PARTS; i++)
	{
		r = gui_getProperty(menu,MP_CHECK,armor*10 + i); 
		if(r)
		{
			if(armor != P_HELMS && armor != P_SHIELDS)
			switch(i)
		 	{
		 		case AR_HELM:
		 		switch(armor)
		 		{
		 			case P_CHAINMAIL: sprintf(arpart,"_coif");
		 			case P_LEATHER: sprintf(arpart,"_cap");
		 			default: sprintf(arpart,"_helm");
		 		}
		 
		 		case AR_GORGET: sprintf(arpart,"_gorget");
		 
		 		case AR_CHEST: 
		 		switch(armor)
		 		{
		 			case P_PLATEMAIL: sprintf(arpart,"mail");
		 			case P_BONE: sprintf(arpart,"_chest");
		 			default: sprintf(arpart,"_tunic");
		 		}
		 
		 		case AR_FEMALE:
		 		{
		 			if(armor == P_LEATHER) sprintf(arpart,"_armor");
		 			sprintf(gender,"_female");
		 		}
		 
		 		case AR_ARMS: 
		 		switch(armor)
		 		{
		 			case P_BONE: sprintf(arpart,"_arms");
		 			default: sprintf(arpart,"_sleeves");
		 		}
		 
		 		case AR_GLOVES: sprintf(arpart,"_gloves");
		 
		 		case AR_LEGS: 
		 		switch(armor)
		 		{
		 			case P_BONE: sprintf(arpart,"_legs");
		 			default: sprintf(arpart,"_leggings");
		 		}
			}
			else sprintf(arpart,"_%s",__armor[(armor - P_PLATEMAIL)*ARMOR_PARTS + i][__name]);

		new def[100],itm;
		sprintf(def,"$item%s%s%s%s%s",material,gender,artype,arpart,suffix);

		switch(action)
		{
			case 0:
			{
				itm = itm_createByDef(def);
				buffer[i] = itm;
			}
	
			case 1:
			{
				itm = itm_createByDef(def);
				chr_equip(chr,itm);
			}
			case 2: itm_createInBpDef(def,chr);
		}

		}

	}

	if(action == 0)
	{
		chr_delLocalVar(chr,CLV_CMDTEMP);
		chr_addLocalIntVec(chr,CLV_CMDTEMP,6,INVALID);
		for(new i = 0; i < 6; i++)
			chr_setLocalIntVec(chr,CLV_CMDTEMP,i,buffer[i]);
		target_create(chr,menu,_,_,"equip2char_targ");
	}

	new n,itemsInBackpack;
	getAmountAndChk(menu,n,itemsInBackpack);
	addgui_combat(chr,itemsInBackpack,n);
}

/*!
\author Fax
\fn equip2char_targ(t,chr,obj,x,y,z,unused,menu)
\param all: standard target callback params
\since 0.82
\brief equips created items to a selected character
\return nothing
*/
public equip2char_targ(t,chr,obj,x,y,z,unused,menu)
{
	if(!isChar(obj))
	{
		chr_message(chr,_,"You must target a charatcer");
		return;
	}

	for(new i = 0; i < 6; i++)
		chr_equip(obj,chr_getLocalIntVec(chr,CLV_CMDTEMP,i));

	chr_delLocalVar(chr,CLV_CMDTEMP);
	chr_addLocalIntVar(chr,CLV_CMDTEMP,0);
}

/*!
\author Fax
\fn addgui_weapon_cback(menu,chr,weapon)
\param all: standard menu callback params
\since 0.82
\brief callback for weapon menu

looks the values given in the armor menu and creates the XSS def of the items to create and creates them
\return nothing
*/
public addgui_weapon_cback(menu,chr,weapon)
{
	new n,itemsInBackpack;
	getAmountAndChk(menu,n,itemsInBackpack);

	new weapongrp = weapon/WEAPONS_PER_GROUP;

	new material[20],suffix[30];
	gui_getProperty(menu,MP_UNI_TEXT,INPUT_MATERIAL + 10*(weapongrp + P_AXES),material);
	if(strlen(material)) sprintf(material,"_%s",material);

	gui_getProperty(menu,MP_UNI_TEXT,INPUT_MAGIC_SUFFIX + 10*(weapongrp + P_AXES),suffix);
	if(strlen(suffix)) sprintf(suffix,"_of_%s",suffix);

	new def[100];
	sprintf(def,"$item%s_%s%s",material,__weapons[weapon][__name],suffix);

	new item,scriptID = getIntFromDefine(def,false); 
			
	if(itemsInBackpack)
	{ 
		item = itm_createInBp(scriptID,chr);
				
		if(itm_getProperty(item,IP_PILEABLE))
		{
			itm_createInBp(scriptID,chr,n - 1);
			chr_message(chr,_,"Item %d created",item);
		}
		else
			for(new i = 0; i < n -1; i++)
			{
				item = itm_createInBp(scriptID,chr);
				chr_message(chr,_,"Item %d created",item);
			}
		
		addgui_combat(chr,itemsInBackpack,n);
	}

	else
	{
		chr_addLocalIntVar(chr,CLV_CMDTEMP,n);
		chr_message(chr,_,"click to position the item");
		target_create(chr,scriptID,_,_,"cmd_add_itm_targ");
	}
}

//==================================================================================//
//                                 NPC MENU                                         //
//==================================================================================//
/*!
\author Fax
\fn addgui_NPCs(chr,itemsInBackpack,amount)
\param chr: the character
\param itemsInBackpack: true if items are to be created in backpack
\amount:how many items we need
\since 0.82
\brief npc items page

\return nothing
\todo Activate amount input box in npc menu
*/
public addgui_NPCs(chr,itemsInBackpack,amount)
{
	if(!isChar(chr)) return;

	#if _CMD_DEBUG_
	log_message("^t->drawing npc menu");
	#endif
	
	new i_row = 4;
	new ROWS = 2 + NPC_MENU_ENTRIES/i_row + (NPC_MENU_ENTRIES%i_row > 0 ? 1 : 0)
	new COLS = i_row*(NPC_MENU_ENTRIES_L + 3);
	new tab = (COLS - 2)/i_row;
	cursor_setProperty(CRP_TAB,tab);
	
	createFramedMenu(0,0,ROWS,17,COLS,"addgui_npc_cback");

	for(new p = 1; p <= NPC_MENU_ENTRIES; p++)
	{
		menu_addLabeledPageButton(p,npcMenuTxt[p - 1]);
		cursor_tab();
		
		if(p%i_row == 0 && p != 0) cursor_newline();
	}
	
	cursor_newline()
	
	new amountstr[5];
	sprintf(amountstr,"%d",amount);
	menu_addLabeledInputField(INPUT_AMOUNT,amountstr,4,"Amount: ");
	
	cursor_down(4);
	
	cursor_setProperty(CRP_TAB,(15*tab)/10);

	new idx = NPC_MENU_IDX,numentries;
	new starty = cursor_y()
	for(new p = 1; p <= NPC_MENU_ENTRIES; p++)
	{
		menu_addPage(p);
		cursor_newline();
		cursor_goto(cursor_x(),starty);
		numentries = __listAllocationMap[P_ANIMALS + p - 1];
		if(addItemList(numentries,15,idx,false,true)) error = 1;
		idx += numentries;
	}
	
	menu_show(chr);
	handleError(chr);
}

/*!
\author Fax
\fn addgui_npc_cback(menu,chr,weapon)
\param all: standard menu callback params
\since 0.82
\brief callback for weapon menu

reads the npc's scriptID and then gets a target to position the npc
\return nothing
*/
public addgui_npc_cback(menu,chr,scriptID)
{
	if(!scriptID) return;
	
	new amount[10],n;
	gui_getProperty(menu,MP_UNI_TEXT,INPUT_AMOUNT,amount);
	if(!isStrInt(amount))
		n = 1;
	else n = str2Int(amount);

	chr_addLocalIntVar(chr,CLV_CMDTEMP,n);
	chr_message(chr,_,"click to position the NPC");
	target_create(chr,scriptID,_,_,"cmd_add_npc_targ");
}

//==================================================================================//
//                            SUPPLY ITEMS MENU                                    //
//==================================================================================//
/*!
\author Fax
\fn addgui_supply(chr,itemsInBackpack,amount)
\param chr: the character
\param itemsInBackpack: true if items are to be created in backpack
\amount:how many items we need
\since 0.82
\brief supply items page

\return nothing
*/

public addgui_supply(chr,itemsInBackpack,amount)
{
	if(!isChar(chr)) return;

	#if _CMD_DEBUG_
	log_message("^t->drawing supply menu");
	#endif
	
	new i_row = 3;
	new ROWS = 2 + SUPPLY_MENU_ENTRIES/i_row + (SUPPLY_MENU_ENTRIES%i_row > 0 ? 1 : 0)
	new COLS = i_row*(SUPPLY_MENU_ENTRIES_L + 3);
	new tab = (COLS - 2)/i_row;
	cursor_setProperty(CRP_TAB,tab);
	
	createFramedMenu(0,0,ROWS,25,COLS,"addgui_supply_cback");

	for(new p = 1; p <= SUPPLY_MENU_ENTRIES; p++)
	{
		menu_addLabeledPageButton(p,supplyMenuTxt[p - 1]);
		cursor_tab();
		
		if(p%i_row == 0 && p != 0) cursor_newline();
	}
	
	cursor_newline()
	
	addStdCheckBoxAndInputField(itemsInBackpack,amount);
	
	new idx = SUPPLY_MENU_IDX,numentries;
	new starty = cursor_y();
	
	for(new p = 1; p <= SUPPLY_MENU_ENTRIES; p++)
	{
		new i_col = 23,pic = 1,label = 1,interline = 10;
		tab = 29;
		
		//here you can set the appearance of every menu subsection
		switch(p + P_BEVERAGES - 1)
		{
			case P_BOWLSMEATFRUIT: {i_col = 15; interline = 15;}
			case P_PLANTS:{	i_col = 10; interline = 20;}
			case P_LIGHTS:{	i_col = 9; interline = 25;}
			case P_CONTAINERS:{ i_col = 10; interline = 23;}
			case P_STATUES_TROPHIES:{i_col = 6;tab = 12; label = 0; interline = 35;}
			case P_HAIR_BEARD: pic = 0;
			case P_RUGS:{tab = 10; label = 0; interline = 15; i_col = 15;}
			case P_CLOTHING:{i_col = 21; tab = 24; interline = 12;}
			case P_JEWELS: {tab = 23; interline = 12; i_col = 20;}
		}
		
		menu_addPage(p);
		cursor_goto(cursor_x(),starty);
		numentries = __listAllocationMap[P_BEVERAGES + p - 1];
		cursor_setProperty(CRP_TAB,tab);
		cursor_setProperty(CRP_INTERLINE,interline);
		if(addItemList(numentries,i_col,idx,pic,label)) error = 1;
		idx += numentries;
	}
	
	menu_show(chr);
	handleError(chr)
}

/*!
\author Fax
\fn addgui_supply_cback(menu,chr,weapon)
\param all: standard menu callback params
\since 0.82
\brief callback for supply menu

Creates the item selected in the gump
\return nothing
*/
public addgui_supply_cback(menu,chr,btncode)
{
	if(!btncode)	return;

	new n,itemsInBackpack;
	getAmountAndChk(menu,n,itemsInBackpack);

	if(itemsInBackpack)
	{
		new item; 
		item = itm_createInBp(btncode,chr);
				
		if(itm_getProperty(item,IP_PILEABLE))
		{
			itm_createInBp(btncode,chr,n - 1);
			chr_message(chr,_,"Item %d created",item);
		}
		else
			for(new i = 0; i < n -1; i++)
			{
				item = itm_createInBp(btncode,chr);
				chr_message(chr,_,"Item %d created",item);
			}

		addgui_supply(chr,true,n);
	}

	else
	{
		chr_addLocalIntVar(chr,CLV_CMDTEMP,n);
		chr_message(chr,_,"click to position the item");
		target_create(chr,btncode,_,_,"cmd_add_itm_targ");
	}
}

//==================================================================================//
//                                  SIGNS MENU                                      //
//==================================================================================//
/*!
\author Fax
\fn addgui_signs(chr,unused,unused2)
\param chr: the character
\param itemsInBackpack: true if items are to be created in backpack
\amount:how many items we need
\since 0.82
\brief signs page

\return nothing
*/
public addgui_signs(chr,unused,unused2)
{
	if(!isChar(chr)) return;

	#if _CMD_DEBUG_
	log_message("^t->drawing SIGNS menu");
	#endif
	
	new i_row = 4;
	new ROWS = SIGNS_MENU_ENTRIES/i_row + (SIGNS_MENU_ENTRIES%i_row > 0 ? 1 : 0)
	new COLS = i_row*(SIGNS_MENU_ENTRIES_L + 3);
	new tab = (COLS - 2)/i_row;
	cursor_setProperty(CRP_TAB,tab);
	
	createFramedMenu(0,0,ROWS,27,COLS,"addgui_signs_cback");

	for(new p = 1; p <= SIGNS_MENU_ENTRIES; p++)
	{
		menu_addLabeledPageButton(p,signsMenuTxt[p - 1]);
		cursor_tab();
		
		if(p%i_row == 0 && p != 0) cursor_newline();
	}
	
	cursor_newline(3);
	
	new idx = SIGNS_MENU_IDX,numentries;
	new starty = cursor_y();
	new i_col = 14;
	
	cursor_setProperty(CRP_TAB,(15*tab)/10);
	cursor_setProperty(CRP_INTERLINE,INTERLINE_DOUBLE);
	for(new p = 1; p <= SIGNS_MENU_ENTRIES; p++)
	{
		menu_addPage(p);
		cursor_goto(cursor_x(),starty);
		numentries = __listAllocationMap[P_WORKER + p - 1];
		if(addItemList(numentries,i_col,idx,1,1)) error = 1;
		idx += numentries;
	}
	
	menu_show(chr);
	handleError(chr);
}

public addgui_signs_cback(menu,chr,btncode)
{
	if(!btncode)	return;

	chr_message(chr,_,"click to position the item");
	target_create(chr,btncode,_,_,"cmd_add_itm_targ");
	addgui_signs(chr,INVALID,INVALID)

}

//==================================================================================//
//                                  ARCHITECTURE MENU                               //
//==================================================================================//
/*!
\author Fax
\fn addgui_architecture(chr,itemsInBackpack,amount)
\param chr: the character
\param itemsInBackpack: true if items are to be created in backpack
\amount:how many items we need
\since 0.82
\brief architecture page

\return nothing
*/

public addgui_architecture(chr,itemsInBackpack,amount)
{
	if(!isChar(chr)) return;

	#if _CMD_DEBUG_
	log_message("^t->drawing architecture menu");
	#endif

	createFramedMenu(0,0,4,20,70,"addgui_arch_cback");

	menu_addLabeledInputField(0,"wall",10,"Item type: ");
	cursor_newline();
	
	menu_addLabeledInputField(1,"stone",10,"Material: ");
	cursor_newline();
	
	menu_addLabeledInputField(2,"1",10,"Subtype: ");
	cursor_newline();
	
	menu_addLabeledButton(1,"Open menu");

	cursor_down(3);
	
	menu_addText("This menu will generate a list of items^n");
	menu_addText("basing on the informations provided above.^n^n");
	
	menu_addText("'Item type' can be: wall, stairs, floor, roof, door, gate^n^n");	
	
	menu_addText("'Material' depends on the itemtype:^n");				
	menu_addText("wall: stone, brick, log, marble, rattan, hide, tent, ruined^n");	
	menu_addText("      sandstone, wooden, bamboo, plaster, cave, dungeon^n");	
	menu_addText("stairs: marble, stone, sandstone, wooden, carpeted, cave^n");	
	menu_addText("floor: alchemical, marble, sandstone, planks, boards, logs, bricks^n");
	menu_addText("       tiles, flagstones, cobblestones, cave^n");			
	menu_addText("roof: stone, slate, tiles, palm, logs, tent, thatch^n");		
	menu_addText("door: metal, wooden, rattan^n");					
	menu_addText("gate: iron, wooden^n^n");						
	
	menu_addText("'subtype': a number 2,3,4 ...");

	menu_show(chr);
}

public addgui_arch_cback(menu,chr,btncode)
{
	if(!btncode) return;
	
	new title[50],def[100],basedef[100],type[20],material[20],subtype[2];
	if(menu != INVALID)
	{
		gui_getProperty(menu,MP_UNI_TEXT,0,type);
		gui_getProperty(menu,MP_UNI_TEXT,1,material);
		gui_getProperty(menu,MP_UNI_TEXT,2,subtype);
	
		sprintf(title,"%s %s %s",material,type,subtype);
		sprintf(type,"_%s",type);
		if(strcmp(material,"")) sprintf(material,"_%s",material);
		if(!strcmp(subtype,"0")) sprintf(subtype,"");
	
		sprintf(basedef,"$item%s%s%s",material,type,subtype);

		chr_addLocalStrVar(chr,CLV_CMDADDTEMP,basedef);
	}
	else chr_getLocalStrVar(chr,CLV_CMDADDTEMP,basedef);

	sprintf(def,"%s_1",basedef);
	
	if(getIntFromDefine(def,false) <= 0)
	{
		chr_message(chr,_,"%s is not defined",def);
		return;
	}

	new tabx = 10;
	new taby = 7;

	if(isStrContainedInStr("floor",def) || isStrContainedInStr("roof",def))
	{
		tabx = 7;
		taby = 3;
	}

	cursor_setProperty(CRP_TAB,tabx);
	
	new scriptID = 0,itm,ID,i=1,p=1;
	new cols = 39;
	new rows = 19;
	createFramedMenu(0,0,2,rows,cols,"addgui_arch_cback2");
	cursor_right(cols/2 - strlen(title)/2);
	menu_addTitle(title);
	cursor_newline();
	cursor_setProperty(CRP_START_Y,cursor_y());
	cursor_newline(3);
	
	menu_addPage(p);
	
	while(getIntFromDefine(def,false) != 0)
	{
		scriptID = getIntFromDefine(def,false);
		itm = itm_create(scriptID);
		ID = itm_getProperty(itm,IP_ID);
		itm_remove(itm);

		menu_addTilePic(ID);
		menu_addButton(scriptID);

		sprintf(def,"%s_%d",basedef,++i);
		cursor_down(taby);
		
		if(cursor_down())
		{
			cursor_top();
			
			if(cursor_tab())
			{	
				cursor_back();
				cursor_right(cols/2 + 2);
				++p;
				menu_addLabeledPageButton(p,"next");
				
				cursor_left(10);
				menu_addPage(p);
				menu_addLabeledPageButton(p - 1,"prev");
				
				cursor_back();
			}
			cursor_down(3);
		}
	}

	menu_show(chr);
	cursor_setProperty(CRP_TAB,10);
	cursor_setProperty(CRP_GRID_Y,18);
	
}

public addgui_arch_cback2(menu,chr,btncode)
{
	if(!btncode)
	{
		chr_delLocalVar(chr,CLV_CMDADDTEMP);
		return;
	}

	chr_message(chr,_,"click to position the item");
	target_create(chr,btncode,_,_,"cmd_add_itm_targ");
	addgui_arch_cback(INVALID,chr,1)

}

//==================================================================================//
//                                FURNITURE MENU                                    //
//==================================================================================//
/*!
\author Fax
\fn addgui_furniture(chr,itemsInBackpack,amount)
\param chr: the character
\param itemsInBackpack: true if items are to be created in backpack
\amount:how many items we need
\since 0.82
\brief furniture page

\return nothing
*/

public addgui_furniture(chr,itemsInBackpack,amount)
{
	if(!isChar(chr)) return;

	#if _CMD_DEBUG_
	log_message("^t->drawing FURNITURE menu");
	#endif
	
	new i_row = 5;
	new ROWS = 1 + FURNITURE_MENU_ENTRIES/i_row + (FURNITURE_MENU_ENTRIES%i_row > 0 ? 1 : 0)
	new COLS = i_row*(FURNITURE_MENU_ENTRIES_L + 1);
	new tab = (COLS - 2)/i_row;
	cursor_setProperty(CRP_TAB,tab);
	
	createFramedMenu(0,0,ROWS,25,COLS,"addgui_furniture_cback");

	for(new p = 1; p <= FURNITURE_MENU_ENTRIES; p++)
	{
		menu_addLabeledPageButton(p,furnitureMenuTxt[p - 1]);
		cursor_tab();
		
		if(p%i_row == 0 && p != 0) cursor_newline();
	}

	menu_addLabeledInputField(INPUT_MATERIAL,"pine",10,"Material: ");
	cursor_down(3);
	
	new idx = FURNITURE_MENU_IDX,numentries;
	new starty = cursor_y();
	
	
	tab = 12;
	cursor_setProperty(CRP_TAB,tab);
	
	for(new p = 1; p <= FURNITURE_MENU_ENTRIES; p++)
	{
		new i_col = 12,interline = 10;
		switch(p + P_FURNITURE - 1)
		{
			case P_FURNITURE: {i_col = 7; interline = 30;}
			case P_TABLES:{	i_col = 11; interline = 24;}
			case P_CHAIRS:{	i_col = 9; interline = 25;}
			case P_BEDS:{ i_col = 7; interline = 35;}
			case P_BIGBEDS:{ i_col = 8; interline = 30;}
		}
		cursor_setProperty(CRP_INTERLINE,interline);
		menu_addPage(p);
		cursor_goto(cursor_x(),starty);
		cursor_back();
		numentries = __listAllocationMap[P_FURNITURE + p - 1];
		new startRow = cursor_y();
		for(new i = 0; i < numentries; i++, cursor_down())
		{
			if(i%i_col == 0 && i != 0) 
			{ 
				cursor_tab(); 
				cursor_goto(cursor_x(),startRow); 
			}
			
			menu_addButton(idx + i + 1);
			
			cursor_move(menu_getProperty(MP_BUTTON_WIDTH),0);
			menu_addTilePic(__addMenuList[idx + i][__ID]);
			cursor_move(-1*menu_getProperty(MP_BUTTON_WIDTH),0);	
		}
	
		idx += numentries;
	}
	
	menu_show(chr);
}

/*!
\author Fax
\fn addgui_furniture_cback(menu,chr,armor)
\param menu,chr,armor: standard menu callback params
\since 0.82
\brief callback for furniture menu

Looks at the values given in the furniture menu and creates the XSS def of the items to create and creates them
\return nothing
*/
public addgui_furniture_cback(menu,chr,idx)
{
	if(!idx)	return;
	idx--;

	new material[20];
	gui_getProperty(menu,MP_UNI_TEXT,INPUT_MATERIAL,material);
	if(strlen(material)) sprintf(material,"%s",material);

	new def[100];
	sprintf(def,"$item_%s_%s",material,__addMenuList[idx][__def]);
	target_create(chr,getIntFromDefine(def,false),_,_,"cmd_add_itm_targ");
	addgui_furniture(chr,false,1);

}

//==================================================================================//
//                            TOOLS ITEMS MENU                                    //
//==================================================================================//
/*!
\author Fax
\fn addgui_tools(chr,itemsInBackpack,amount)
\param chr: the character
\param itemsInBackpack: true if items are to be created in backpack
\amount:how many items we need
\since 0.82
\brief tools items page

\return nothing
*/

public addgui_tools(chr,itemsInBackpack,amount)
{
	if(!isChar(chr)) return;

	#if _CMD_DEBUG_
	log_message("^t->drawing tools menu");
	#endif
	
	new i_row = 4;
	new ROWS = 2 + TOOLS_MENU_ENTRIES/i_row + (TOOLS_MENU_ENTRIES%i_row > 0 ? 1 : 0)
	new COLS = i_row*(TOOLS_MENU_ENTRIES_L + 3);
	new tab = (COLS - 2)/i_row;
	cursor_setProperty(CRP_TAB,tab);
	
	createFramedMenu(0,0,ROWS,25,COLS,"addgui_tools_cback");

	for(new p = 1; p <= TOOLS_MENU_ENTRIES; p++)
	{
		menu_addLabeledPageButton(p,toolsMenuTxt[p - 1]);
		cursor_tab();
		
		if(p%i_row == 0 && p != 0) cursor_newline();
	}
	
	cursor_newline()
	
	addStdCheckBoxAndInputField(itemsInBackpack,amount);
	
	new idx = TOOLS_MENU_IDX,numentries;
	new starty = cursor_y();
	
	for(new p = 1; p <= TOOLS_MENU_ENTRIES; p++)
	{
		new i_col = 23,pic = 1,label = 1,interline = 10;
		tab = 29;
		
		//here you can set the appearance of every menu subsection
		switch(p + P_CARPENTER1 - 1)
		{
			case P_CARPENTER1: {i_col = 13; interline = 20; tab = 25;}
			case P_CARPENTER2:{i_col = 12; interline = 20; tab = 10; label = 0;}
			case P_TAILOR:{	i_col = 9; interline = 25;}
			case P_BLACKSMITH:{ i_col = 7; interline = 33; tab = 25;}
			case P_MUSICIAN:{i_col = 6; interline = 35;}
			case P_TINKER: {interline = 20;}
			case P_BOWYER:{i_col = 5; interline = 35;}
		}
		
		menu_addPage(p);
		cursor_goto(cursor_x(),starty);
		numentries = __listAllocationMap[P_CARPENTER1 + p - 1];
		cursor_setProperty(CRP_TAB,tab);
		cursor_setProperty(CRP_INTERLINE,interline);
		if(addItemList(numentries,i_col,idx,pic,label)) error = 1;
		idx += numentries;
	}
	
	menu_show(chr);
	handleError(chr)
}

/*!
\author Fax
\fn addgui_tools_cback(menu,chr,weapon)
\param all: standard menu callback params
\since 0.82
\brief callback for tools menu

Creates the item selected in the gump
\return nothing
*/
public addgui_tools_cback(menu,chr,btncode)
{
	if(!btncode)	return;

	new n,itemsInBackpack;
	getAmountAndChk(menu,n,itemsInBackpack);

	if(itemsInBackpack)
	{
		new item; 
		item = itm_createInBp(btncode,chr);
				
		if(itm_getProperty(item,IP_PILEABLE))
		{
			itm_createInBp(btncode,chr,n - 1);
			chr_message(chr,_,"Item %d created",item);
		}
		else
			for(new i = 0; i < n -1; i++)
			{
				item = itm_createInBp(btncode,chr);
				chr_message(chr,_,"Item %d created",item);
			}

		addgui_tools(chr,true,n);
	}

	else
	{
		chr_addLocalIntVar(chr,CLV_CMDTEMP,n);
		chr_message(chr,_,"click to position the item");
		target_create(chr,btncode,_,_,"cmd_add_itm_targ");
	}
}

//==================================================================================//
//                                  SPAWNERS MENU                                      //
//==================================================================================//
/*!
\author Fax
\fn addgui_spawners(chr,unused,unused2)
\param chr: the character
\param itemsInBackpack: true if items are to be created in backpack
\amount:how many items we need
\since 0.82
\brief SPAWNERS page

\return nothing
*/
public addgui_spawner(chr,unused,unused2)
{
	cursor_setProperty(CRP_TAB,55);
	createListMenu(0,0,30,40,NUM_SPAWNERS,"Spawners","drawSpawnersLine","addgui_spawners_cback");
	menu_show(chr);
}

public drawSpawnersLine(page,line,col,i)
{
	i += IDX_SPAWNERS;
	menu_addLabeledButton(getIntFromDefine(__addMenuList[i][__def],false),__addMenuList[i][__name]);
}
public addgui_spawners_cback(menu,chr,btncode)
{
	if(!btncode)	return;

	chr_addLocalIntVar(chr,CLV_CMDTEMP,1);
	chr_message(chr,_,"click to position the item");
	target_create(chr,btncode,_,_,"cmd_add_itm_targ");
	addgui_spawner(chr,INVALID,INVALID)

}

//==================================================================================//
//                                  DEEDS MENU                                      //
//==================================================================================//
/*!
\author Fax
\fn addgui_deeds(chr,unused,unused2)
\param chr: the character
\param itemsInBackpack: true if items are to be created in backpack
\amount:how many items we need
\since 0.82
\brief SPAWNERS page

\return nothing
*/
public addgui_deeds(chr,unused,unused2)
{
	popupMenu(chr,"Work in progress","Deeds menu is not yet available");
}

public addgui_deeds_cback(menu,chr,btncode)
{
	if(!btncode)	return;

	itm_createInBp(btncode,chr);
	addgui_spawner(chr,INVALID,INVALID)

}

public addgui_special(chr,unused,unused2)
{
	popupMenu(chr,"Work in progress","Special items menu is not yet^navailable");
}

public addgui_shard(chr,unused,unused2)
{
	popupMenu(chr,"Shard section","This section is for your shard's items,^nyou have to build it by yourself");
}

public addgui_treasure(chr,unused,unused2)
{
	popupMenu(chr,"Work in progress","Treasure items menu is not yet^navailable");
}

static getAmountAndChk(menu,&n,&chk)
{
	new amount[10];
	gui_getProperty(menu,MP_UNI_TEXT,INPUT_AMOUNT,amount);

	if(!isStrInt(amount))
		n = 1
	else n = str2Int(amount);
	chk = gui_getProperty(menu,MP_CHECK,CHK_ITEMSINBACKPACK);
}

static addItemList(n,i_col,offset,pic,label)
{
	new startRow = cursor_y(),scriptID,error;
	for(new i = 0; i < n; i++, cursor_down())
	{
		if(i%i_col == 0 && i != 0) 
		{ 
			cursor_tab(); 
			cursor_goto(cursor_x(),startRow); 
		}
		
		scriptID = getIntFromDefine(__addMenuList[offset + i][__def],false);
		if(scriptID > 0) 
			menu_addButton(scriptID);
		else 
		{
			menu_addText("x");
			error = 1;
		}

		cursor_move(menu_getProperty(MP_BUTTON_WIDTH),0);
		if(pic)
			if(label)
				menu_addLabeledTilePic(__addMenuList[offset + i][__ID],PICW,__addMenuList[offset + i][__name]);
			else
				menu_addTilePic(__addMenuList[offset + i][__ID]);
		else
			menu_addText(__addMenuList[offset + i][__name]);
		cursor_move(-1*menu_getProperty(MP_BUTTON_WIDTH),0);	
	}
	
	cursor_newline();
	cursor_goto(cursor_x(),startRow);
	return error;
}

static addStdCheckBoxAndInputField(itemsInBackpack,amount)
{
	menu_addLabeledCheckbox(itemsInBackpack,CHK_ITEMSINBACKPACK,"create items in backpack");
	cursor_newline();
		
	new amountstr[5];
	sprintf(amountstr,"%d",amount);
	menu_addLabeledInputField(INPUT_AMOUNT,amountstr,5,"Amount: ");
	
	cursor_newline();
	cursor_newline();
	cursor_newline();
}

static handleError(chr)
{
	if(error) 
	{	
		popupMenu(chr,"WARNING","Some items couldn't be loaded^ncheck items definitions");
		log_error("addemenu.sma - Some items couldn't be loaded check items definitions");
	}
	error = 0;
}
/*! }@ */