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
\defgroup script_command_add_menu menu
\ingroup script_commands_add

@{
*/

static PBTN_UP;			//!< page buttons up gump
static PBTN_DOWN;		//!< page buttons down gump
static PBTNW;			//!< page button width

static BTN_UP;			//!< buttons up gump
static BTN_DOWN;		//!< buttons down gump
static BTNW;			//!< button width

static PICW;			//!< pics width
static L_MARG;			//!< left margin, in columns

//do not touch
#define INPUT_AMOUNT 0
#define INPUT_MATERIAL 1

#define CHK_ITEMSINBACKPACK 0;



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
	BTN_UP = 0x29F4;  	//!< buttons up gump
	BTN_DOWN = 0x29F6;	//!< buttons down gump
	
	PBTN_UP = 0x0827;	//!< page buttons up gump
	PBTN_DOWN = 0x0827;	//!< page buttons down gump
	
	L_MARG = 4*COL;		//!< left margin width, in columns
        
	PBTNW = 20;		//!< page button width, in pixels
	BTNW = 15;		//!< button width,in pixels
	PICW = 40;		//!< tile pics width, in pixels
	
	new  START_X = 0;	//!< start x, where the gump is created
	new  START_Y = 250;	//!< start y
	
	new i_row = ADD_MENU_ENTRIES/ADD_MENU_ROWS;
	new tab = (ADD_MENU_ENTRIES_L + 2 + PBTNW/COL);
	new COLS = 2 + i_row*tab;
	
	new  WIDTH =  COLS*COL;
	new  HEIGHT = (ADD_MENU_ROWS + 3)*ROW;
		
	#if _CMD_DEBUG_
	log_message("^t->drawing add menu");
	#endif
	
		
	new x,y;
	new menu = gui_create(START_X,START_Y,true,true,true,"addgui_cback");
	
	//draw menu frame
	gui_addResizeGump(menu,START_X,START_Y,RESIZEGUMP,WIDTH,HEIGHT );
	gui_addResizeGump(menu,START_X + COL ,START_Y + ROW/2,RESIZEGUMP1,WIDTH - 2*COL,HEIGHT - ROW);
	
	x = START_X+ L_MARG;
	y = START_Y + ROW/2 + ROW;
	
	for(new i = 1; i <= ADD_MENU_ENTRIES; i++)
	{
		gui_addButton(menu,x,y,PBTN_UP,PBTN_DOWN,i);
		gui_addText(menu,PBTNW + x,y,TXT_COLOR ,addMenuItems[i - 1][__addGuiText]);	
	
		x += tab*COL;
		if(i%i_row == 0 && i != 0) {x = START_X + L_MARG; y += ROW;}
	}
	
	gui_show(menu,chr);
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
	
	#if _CMD_DEBUG_
	log_message("^t->calling function: %s",addMenuItems[idx - 1][__addGuiFunc]);
	#endif
	
	new amount[10];
	gui_getProperty(menu,MP_UNI_TEXT,INPUT_AMOUNT,amount);
	addMenu(chr);
	
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
	
	new  START_X = 0;
	new  START_Y = 0;
	
	new i_row = MAGIC_MENU_ENTRIES/MAGIC_MENU_ROWS;
	new COLS = 3 + i_row*(MAGIC_MENU_ENTRIES_L + 1 + PBTNW/COL);
	
	new  WIDTH =  COLS*COL;
	new  HEIGHT1 = (MAGIC_MENU_ROWS + 5)*ROW;
	new HEIGHT2 = 15*ROW;
	
	new tab = (COLS - 2)/i_row;	
		
	new x,y;
	new menu = gui_create(START_X,START_Y,true,true,true,"addgui_magic_cback");
	
	//draw menu frame
	gui_addResizeGump(menu,START_X,START_Y,RESIZEGUMP,WIDTH,HEIGHT1 + HEIGHT2 + ROW );
	gui_addResizeGump(menu,START_X + COL ,START_Y + ROW/2,RESIZEGUMP1,WIDTH - 2*COL,HEIGHT1);
	gui_addResizeGump(menu,START_X + COL ,START_Y + ROW/2 + HEIGHT1,RESIZEGUMP1,WIDTH - 2*COL,HEIGHT2);
	
	
	x = START_X+ L_MARG;
	y = START_Y + ROW/2 + ROW;
	
	for(new p = 1; p <= MAGIC_MENU_ENTRIES; p++)
	{
		gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,p);
		gui_addText(menu,PBTNW + x,y,TXT_COLOR ,magicMenuTxt[p - 1]);	
	
		x += tab*COL;
		if(p%i_row == 0 && p != 0) {x = START_X + L_MARG; y += ROW;}
	}
	
	x = START_X + L_MARG;
	y += ROW;
	gui_addCheckbox(menu,x,y,BTN_UP,BTN_DOWN,itemsInBackpack,CHK_ITEMSINBACKPACK);
	gui_addText(menu,x + BTNW,y,TXT_COLOR,"create items in backpack")
	
	y += ROW;
	new amountstr[5];
	sprintf(amountstr,"%d",amount);
	gui_addText(menu,x,y,TXT_COLOR,"amount: ")
	gui_addInputField(menu,x + 10*COL,y,5*COL,ROW,INPUT_AMOUNT,TXT_COLOR,amountstr);
	
	
	tab *= 2;
	i_row = 11;

	for(new p = 1; p <= MAGIC_MENU_ENTRIES; p++)
	{
		gui_addPage(menu,p);
		
		x = L_MARG;
		y = HEIGHT1 + 2*ROW;
		new startRow = y;
		
		switch(p)
		{
			case P_REAGENTS:
			{
				for(new i = 0; i < NUM_REAGENTS; i++, y+= ROW)
				{
					if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__reagents[i][__def]));
					gui_addTilePic(menu,x + BTNW,y,__reagents[i][__ID]);
					gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__reagents[i][__name]);
				}
			}
		
			case P_REAGENTS2:
			{
				for(new i = 0; i < NUM_REAGENTS2; i++, y+= ROW)
				{
					if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__reagents2[i][__def]));
					gui_addTilePic(menu,x + BTNW,y,__reagents2[i][__ID]);
					gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__reagents2[i][__name]);
				}
			}
			
			case P_BOTTLES:
			{
				for(new i = 0; i < NUM_BOTTLES; i++, y+= ROW)
				{
					if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__bottles[i][__def]));
					gui_addTilePic(menu,x + BTNW,y,__bottles[i][__ID]);
					gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__bottles[i][__name]);
				}
			}
			
			case P_POTIONS:
			{
				for(new i = 0; i < NUM_POTIONS; i++, y+= ROW)
				{
					if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__potions[i][__def]));
					gui_addTilePic(menu,x + BTNW,y,__potions[i][__ID]);
					gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__potions[i][__name]);
				}
			}
			
			case P_WANDS:
			{
				for(new i = 0; i < NUM_WANDS; i++, y+= ROW)
				{
					if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__wands[i][__def]));
					gui_addTilePic(menu,x + BTNW,y,__wands[i][__ID]);
					gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__wands[i][__name]);
				}
			}
			
			case P_GATES:
			{
				for(new i = 0; i < NUM_GATES; i++, y+= 4*ROW)
				{
					if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__gates[i][__def]));
					gui_addTilePic(menu,x + BTNW,y,__gates[i][__ID]);
					gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__gates[i][__name]);
				}
			}
			
			case P_SCROLLS1..P_SCROLLS8:
			{
				new startscroll = (p - P_SCROLLS1)*SCROLLS_PER_CIRCLE;
				new endscroll = startscroll + SCROLLS_PER_CIRCLE; 
				for(new i = startscroll; i < endscroll; i++, y+= ROW)
				{
					if((i - startscroll)%i_row == 0 && i != startscroll) { x+= tab*COL; y = startRow; }
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__scrolls[i][__def]));
					gui_addTilePic(menu,x + BTNW,y,__scrolls[i][__ID]);
					gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__scrolls[i][__name]);
				}
			}
		}
	}

	gui_show(menu,chr);
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
		chr_setLocalIntVar(chr,CLV_CMDTEMP,n);
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
	
	new  START_X = 0;
	new  START_Y = 0;
	
	new i_row = COMBAT_MENU_ENTRIES/COMBAT_MENU_ROWS;
	new COLS = 3 + i_row*(COMBAT_MENU_ENTRIES_L + 1 + PBTNW/COL);
	
	new  WIDTH =  COLS*COL;
	new  HEIGHT1 = (COMBAT_MENU_ROWS + 5)*ROW;
	new HEIGHT2 = 15*ROW;
	
	new tab = (COLS - 2)/i_row;	
		
	new x,y;
	new menu = gui_create(START_X,START_Y,true,true,true,"addgui_combat_cback");
	
	//draw menu frame
	gui_addResizeGump(menu,START_X,START_Y,RESIZEGUMP,WIDTH,HEIGHT1 + HEIGHT2 + ROW );
	gui_addResizeGump(menu,START_X + COL ,START_Y + ROW/2,RESIZEGUMP1,WIDTH - 2*COL,HEIGHT1);
	gui_addResizeGump(menu,START_X + COL ,START_Y + ROW/2 + HEIGHT1,RESIZEGUMP1,WIDTH - 2*COL,HEIGHT2);
	
	
	x = START_X + L_MARG;
	y = START_Y + ROW/2 + ROW;
	
	for(new p = 1; p <= COMBAT_MENU_ENTRIES; p++)
	{
		gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,p);
		gui_addText(menu,PBTNW + x,y,TXT_COLOR ,combatMenuTxt[p - 1]);	
	
		x += tab*COL;
		if(p%i_row == 0 && p != 0) {x = START_X + L_MARG; y += ROW;}
	}
	
	
	x = START_X + L_MARG;
	y += ROW;
	gui_addCheckbox(menu,x,y,BTN_UP,BTN_DOWN,itemsInBackpack,CHK_ITEMSINBACKPACK);
	gui_addText(menu,x + BTNW,y,TXT_COLOR,"create items in backpack")
	
	y += ROW;
	new amountstr[5];
	sprintf(amountstr,"%d",amount);
	gui_addText(menu,x,y,TXT_COLOR,"amount: ")
	gui_addInputField(menu,x + 10*COL,y,5*COL,ROW,INPUT_AMOUNT,TXT_COLOR,amountstr);
	
	
	tab *= 2;
	i_row = 11;

	for(new p = 1; p <= COMBAT_MENU_ENTRIES; p++)
	{
		gui_addPage(menu,p);
		
		x = L_MARG;
		y = HEIGHT1 + 2*ROW;
		
		switch(p)
		{
			case P_PLATEMAIL..P_SHIELDS:
			{
				gui_addText(menu,x + tab*COL,y,TXT_COLOR,"Material:");
				new material[5] = "";
				if(p != P_LEATHER && p!= P_STUDDED && p != P_BONE) sprintf(material,"iron");
				gui_addInputField(menu,x + (tab + 10)*COL,y,15*COL,ROW,INPUT_MATERIAL + 10*p,TXT_COLOR,"%s",material);
				
				gui_addButtonFn(menu,x + tab*COL,y  + 2*ROW,BTN_UP,BTN_DOWN,p,true,"addgui_armor_cback");
				gui_addText(menu,x + BTNW + tab*COL,y + 2*ROW,TXT_COLOR,"create in backpack");
				
				gui_addButtonFn(menu,x + tab*COL,y + 3*ROW,BTN_UP,BTN_DOWN,p + 1000,true,"addgui_armor_cback");
				gui_addText(menu,x + BTNW + tab*COL,y + 3*ROW,TXT_COLOR,"Equip");
		
				gui_addButtonFn(menu,x + tab*COL,y + 4*ROW,BTN_UP,BTN_DOWN,p + 10000,true,"addgui_armor_cback");
				gui_addText(menu,x + BTNW + tab*COL,y + 4*ROW,TXT_COLOR,"Equip to character");
							
				new artype = p - P_PLATEMAIL;
				for(new i = 0; i < ARMOR_PARTS; i++)
				{
					if(__armor[artype*ARMOR_PARTS + i][__ID] == INVALID) continue;
					
					gui_addCheckbox(menu,x,y,BTN_UP,BTN_DOWN,false,p*10 + i);
					gui_addTilePic(menu,x + BTNW,y,__armor[artype*ARMOR_PARTS + i][__ID]);
					gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__armor[artype*ARMOR_PARTS + i][__name]);
					y += 2*ROW;
				}		
			}
			
			case P_AXES..P_FORKS:
			{
				
				gui_addText(menu,x + tab*COL,y,TXT_COLOR,"Material:");
				gui_addInputField(menu,x + (tab + 10)*COL,y,15*COL,ROW,INPUT_MATERIAL + 10*p,TXT_COLOR,"iron");
							
				new wpntype = p - P_AXES;
				for(new i = 0; i < WEAPONS_PER_GROUP; i++)
				{
					if(__weapons[wpntype*WEAPONS_PER_GROUP + i][__ID] == INVALID) continue;
					
					gui_addButtonFn(menu,x,y,BTN_UP,BTN_DOWN,wpntype*WEAPONS_PER_GROUP + i,true,"addgui_weapon_cback");
					gui_addTilePic(menu,x + BTNW,y,__weapons[wpntype*WEAPONS_PER_GROUP + i][__ID]);
					gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__weapons[wpntype*WEAPONS_PER_GROUP + i][__name]);
					y += (15*ROW)/10;
				}		
			}
		}
	}

	gui_show(menu,chr);
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
	
	new material[20];
	gui_getProperty(menu,MP_UNI_TEXT,INPUT_MATERIAL + 10*armor,material);
	if(strlen(material)) sprintf(material,"_%s",material);
	
	
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
		sprintf(def,"$item%s%s%s%s",material,gender,artype,arpart);
		
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
	
	new material[20];
	gui_getProperty(menu,MP_UNI_TEXT,INPUT_MATERIAL + 10*(weapongrp + P_AXES),material);
		
	new def[100];
	sprintf(def,"$item_%s_%s",material,__weapons[weapon][__name]);
		
	new item,scriptID = getIntFromDefine(def); 
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
	
	new  START_X = 0;
	new  START_Y = 0;
	
	new i_row = NPC_MENU_ENTRIES/NPC_MENU_ROWS;
	new COLS = 3 + i_row*(NPC_MENU_ENTRIES_L + 1 + PBTNW/COL);
	
	new  WIDTH =  COLS*COL;
	new  HEIGHT1 = (NPC_MENU_ROWS + 5)*ROW;
	new HEIGHT2 = 17*ROW;
	
	new tab = (COLS - 2)/i_row;	
		
	new x,y;
	new menu = gui_create(START_X,START_Y,true,true,true,"addgui_npc_cback");
	
	//draw menu frame
	gui_addResizeGump(menu,START_X,START_Y,RESIZEGUMP,WIDTH,HEIGHT1 + HEIGHT2 + ROW );
	gui_addResizeGump(menu,START_X + COL ,START_Y + ROW/2,RESIZEGUMP1,WIDTH - 2*COL,HEIGHT1);
	gui_addResizeGump(menu,START_X + COL ,START_Y + ROW/2 + HEIGHT1,RESIZEGUMP1,WIDTH - 2*COL,HEIGHT2);
	
	
	x = START_X + L_MARG;
	y = START_Y + ROW/2 + ROW;
	
	for(new p = 1; p <= NPC_MENU_ENTRIES; p++)
	{
		gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,p);
		gui_addText(menu,PBTNW + x,y,TXT_COLOR ,npcMenuTxt[p - 1]);	
	
		x += tab*COL;
		if(p%i_row == 0 && p != 0) {x = START_X + L_MARG; y += ROW;}
	}
	
	
	y += ROW;
	new amountstr[5];
	sprintf(amountstr,"%d",amount);
	gui_addText(menu,x,y,TXT_COLOR,"amount: ")
	gui_addInputField(menu,x + 10*COL,y,5*COL,ROW,INPUT_AMOUNT,TXT_COLOR,amountstr);
	
	
	tab = (15*tab)/10;
	i_row = 11;

	for(new p = 1; p <= NPC_MENU_ENTRIES; p++)
	{
		gui_addPage(menu,p);
		
		x = L_MARG;
		y = HEIGHT1 + 2*ROW;
		new startRow = y;
		
		switch(p)
		{
			case P_ANIMALS:
			{
				new picw = 0;
				for(new i = 0; i < NUM_ANIMALS; i++, y+= ROW)
				{
					if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__animals[i][__def]));
					//gui_addTilePic(menu,x + BTNW,y,__animals[i][__ID]);
					gui_addText(menu,x + BTNW + picw,y,TXT_COLOR,__animals[i][__name]);
				}		
			}
			
			case P_T2A_MONSTERS:
			{
				new picw = 0;
				for(new i = 0; i < NUM_T2A_MONSTERS; i++, y+= ROW)
				{
					if(i%15 == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__T2Amonsters[i][__def]) );
					//gui_addTilePic(menu,x + BTNW,y,__T2Amonsters[i][__ID]);
					gui_addText(menu,x + BTNW + picw,y,TXT_COLOR,__T2Amonsters[i][__name]);
				}		
			}
			
			case P_DEAMONS:
			{
				new picw = 0;
				for(new i = 0; i < NUM_DEAMONS; i++, y+= ROW)
				{
					if(i%15 == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__deamons[i][__def]) );
					//gui_addTilePic(menu,x + BTNW,y,__deamons[i][__ID]);
					gui_addText(menu,x + BTNW + picw,y,TXT_COLOR,__deamons[i][__name]);
				}		
			}
			
			case P_ELEMENTALS:
			{
				new picw = 0;
				for(new i = 0; i < NUM_ELEMENTALS; i++, y+= ROW)
				{
					if(i%15 == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__elementals[i][__def]) );
					//gui_addTilePic(menu,x + BTNW,y,__elementals[i][__ID]);
					gui_addText(menu,x + BTNW + picw,y,TXT_COLOR,__elementals[i][__name]);
				}		
			}
			
			case P_ORCS:
			{
				new picw = 0;
				for(new i = 0; i < NUM_ORCS; i++, y+= ROW)
				{
					if(i%15 == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__orcs[i][__def]) );
					//gui_addTilePic(menu,x + BTNW,y,__orcs[i][__ID]);
					gui_addText(menu,x + BTNW + picw,y,TXT_COLOR,__orcs[i][__name]);
				}		
			}
			
			case P_MONSTERS:
			{
				new picw = 0;
				for(new i = 0; i < NUM_MONSTERS; i++, y+= ROW)
				{
					if(i%15 == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__monsters[i][__def]) );
					//gui_addTilePic(menu,x + BTNW,y,__monsters[i][__ID]);
					gui_addText(menu,x + BTNW + picw,y,TXT_COLOR,__monsters[i][__name]);
				}		
			}
			
			case P_UNDEADS:
			{
				new picw = 0;
				for(new i = 0; i < NUM_UNDEADS; i++, y+= ROW)
				{
					if(i%15 == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__undeads[i][__def]) );
					//gui_addTilePic(menu,x + BTNW,y,__undeads[i][__ID]);
					gui_addText(menu,x + BTNW + picw,y,TXT_COLOR,__undeads[i][__name]);
				}		
			}
			
			case P_UNIQUE:
			{
				new picw = 0;
				for(new i = 0; i < NUM_UNIQUE; i++, y+= ROW)
				{
					if(i%15 == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__uniqueMonsters[i][__def]) );
					//gui_addTilePic(menu,x + BTNW,y,__uniqueMonsters[i][__ID]);
					gui_addText(menu,x + BTNW + picw,y,TXT_COLOR,__uniqueMonsters[i][__name]);
				}		
			}
			
			case P_FROST_STONE:
			{
				new picw = 0;
				for(new i = 0; i < NUM_FROST_STONE; i++, y+= ROW)
				{
					if(i%15 == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__frost_stone_monsters[i][__def]) );
					//gui_addTilePic(menu,x + BTNW,y,__frost_stone_monsters[i][__ID]);
					gui_addText(menu,x + BTNW + picw,y,TXT_COLOR,__frost_stone_monsters[i][__name]);
				}		
			}
			
			case P_DRAGONS:
			{
				new picw = 0;
				for(new i = 0; i < NUM_DRAGONS; i++, y+= ROW)
				{
					if(i%15 == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__dragons[i][__def]) );
					//gui_addTilePic(menu,x + BTNW,y,__dragons[i][__ID]);
					gui_addText(menu,x + BTNW + picw,y,TXT_COLOR,__dragons[i][__name]);
				}		
			}
			
			case P_PEOPLE_M:
			{
				new picw = 0;
				for(new i = 0; i < NUM_PEOPLE_M; i++, y+= ROW)
				{
					if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__people_male[i][__def]) );
					//gui_addTilePic(menu,x + BTNW,y,__people_male[i][__ID]);
					gui_addText(menu,x + BTNW + picw,y,TXT_COLOR,__people_male[i][__name]);
				}		
			}
			
			case P_PEOPLE_F:
			{
				new picw = 0;
				for(new i = 0; i < NUM_PEOPLE_F; i++, y+= ROW)
				{
					if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__people_female[i][__def]) );
					//gui_addTilePic(menu,x + BTNW,y,__people_female[i][__ID]);
					gui_addText(menu,x + BTNW + picw,y,TXT_COLOR,__people_female[i][__name]);
				}		
			}
			
			case P_MERCHANTS_M:
			{
				new picw = 0;
				for(new i = 0; i < NUM_MERCHANTS_M; i++, y+= ROW)
				{
					if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__merchants_male[i][__def]) );
					//gui_addTilePic(menu,x + BTNW,y,__merchants_male[i][__ID]);
					gui_addText(menu,x + BTNW + picw,y,TXT_COLOR,__merchants_male[i][__name]);
				}		
			}
			
			case P_MERCHANTS_F:		
			{
				new picw = 0;
				for(new i = 0; i < NUM_MERCHANTS_F; i++, y+= ROW)
				{
					if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__merchants_female[i][__def]) );
					//gui_addTilePic(menu,x + BTNW,y,__merchants_female[i][__ID]);
					gui_addText(menu,x + BTNW + picw,y,TXT_COLOR,__merchants_female[i][__name]);
				}		
			}
	
		}
	}

	gui_show(menu,chr);
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
	new amount[10],n;
	gui_getProperty(menu,MP_UNI_TEXT,INPUT_AMOUNT,amount);
	if(!isStrInt(amount))
		n = 1;
	else n = str2Int(amount);
	
	chr_setLocalIntVar(chr,CLV_CMDTEMP,n);
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
	
	new  START_X = 0;
	new  START_Y = 0;
	
	new i_row = SUPPLY_MENU_ENTRIES/SUPPLY_MENU_ROWS;
	new COLS = 3 + i_row*(SUPPLY_MENU_ENTRIES_L + 1 + PBTNW/COL);
	
	new  WIDTH =  COLS*COL;
	new  HEIGHT1 = (SUPPLY_MENU_ROWS + 5)*ROW;
	new HEIGHT2 = 17*ROW;
	
	new tab = (COLS - 2)/i_row;	
		
	new x,y;
	new menu = gui_create(START_X,START_Y,true,true,true,"addgui_supply_cback");
	
	//draw menu frame
	gui_addResizeGump(menu,START_X,START_Y,RESIZEGUMP,WIDTH,HEIGHT1 + HEIGHT2 + ROW );
	gui_addResizeGump(menu,START_X + COL ,START_Y + ROW/2,RESIZEGUMP1,WIDTH - 2*COL,HEIGHT1);
	gui_addResizeGump(menu,START_X + COL ,START_Y + ROW/2 + HEIGHT1,RESIZEGUMP1,WIDTH - 2*COL,HEIGHT2);
	
	
	x = START_X+ L_MARG;
	y = START_Y + ROW/2 + ROW;
	
	for(new p = 1; p <= SUPPLY_MENU_ENTRIES; p++)
	{
		gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,p);
		gui_addText(menu,PBTNW + x,y,TXT_COLOR ,supplyMenuTxt[p - 1]);	
	
		x += tab*COL;
		if(p%i_row == 0 && p != 0) {x = START_X + L_MARG; y += ROW;}
	}
	
	x = START_X + L_MARG;
	y += ROW;
	gui_addCheckbox(menu,x,y,BTN_UP,BTN_DOWN,itemsInBackpack,CHK_ITEMSINBACKPACK);
	gui_addText(menu,x + BTNW,y,TXT_COLOR,"create items in backpack")
	
	y += ROW;
	new amountstr[5];
	sprintf(amountstr,"%d",amount);
	gui_addText(menu,x,y,TXT_COLOR,"amount: ")
	gui_addInputField(menu,x + 10*COL,y,5*COL,ROW,INPUT_AMOUNT,TXT_COLOR,amountstr);
	
	
	tab *= 2;
	i_row = 11;

	for(new p = 1; p <= SUPPLY_MENU_ENTRIES; p++)
	{
		gui_addPage(menu,p);
		
		x = L_MARG;
		y = HEIGHT1 + 2*ROW;
		new startRow = y;
		
		switch(p)
		{
			case P_BEVERAGES:
			{
				i_row = 15;
				tab = 27;
				for(new i = 0; i < NUM_BEVERAGES; i++, y+= ROW)
				{
					if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__beverages[i][__def]));
					gui_addTilePic(menu,x + BTNW,y,__beverages[i][__ID]);
					gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__beverages[i][__name]);
				}
			}
			
			case P_BAKED:
			{
				i_row = 15;
				tab = 27;
				
				for(new i = 0; i < NUM_BAKED; i++, y+= ROW)
				{
					if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__bakedAndVeggys[i][__def]));
					gui_addTilePic(menu,x + BTNW,y,__bakedAndVeggys[i][__ID]);
					gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__bakedAndVeggys[i][__name]);
				}
			}
			
			case P_BOWLSMEATFRUIT:
			{	
				i_row = 15;
				tab = 27;
				for(new i = 0; i < NUM_BOWLSMEATFRUIT; i++, y+= ROW)
				{
					if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__bowlsMeatFruit[i][__def]));
					gui_addTilePic(menu,x + BTNW,y,__bowlsMeatFruit[i][__ID]);
					gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__bowlsMeatFruit[i][__name]);
				}
			}
			
			case P_PLANTS:
			{	
				i_row = 7;
				tab = 27;
				for(new i = 0; i < NUM_PLANTS; i++, y+= 2*ROW)
				{
					if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__plants[i][__def]));
					gui_addTilePic(menu,x + BTNW,y,__plants[i][__ID]);
					gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__plants[i][__name]);
				}
			}
			
			case P_DOORS:
			{	
				i_row = 6;
				tab = 7;
				for(new i = 0; i < NUM_DOORS; i++, y+= (25*ROW)/10)
				{
					if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__doors[i][__def]));
					gui_addTilePic(menu,x + BTNW,y - BTNW,__doors[i][__ID]);
					//gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__doors[i][__name]);
				}
			}
			
			case P_LIGHTS:
			{	
				i_row = 10;
				tab = 27;
				for(new i = 0; i < NUM_LIGHTS; i++, y+= (15*ROW)/10)
				{
					if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__lights[i][__def]));
					gui_addTilePic(menu,x + BTNW,y,__lights[i][__ID]);
					gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__lights[i][__name]);
				}
			}
			
			case P_SIGNS:
			{	
				i_row = 15;
				tab = 10;
				for(new i = 0; i < NUM_SIGNS; i++, y+= ROW)
				{
					if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
					
					gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__signs[i][__def]));
					gui_addTilePic(menu,x + BTNW,y - BTNW,__signs[i][__ID]);
					//gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__signs[i][__name]);
				}
			}
		}
	}

	gui_show(menu,chr);
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
		chr_setLocalIntVar(chr,CLV_CMDTEMP,n);
		chr_message(chr,_,"click to position the item");
		target_create(chr,btncode,_,_,"cmd_add_itm_targ");
	}
}


//==================================================================================//
//                                  ARCHITECTURE MENU                                      //
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
	
	new  START_X = 0;
	new  START_Y = 0;
	
	new COLS = 70;
	new ROWS = 20;
	
	new  WIDTH =  COLS*COL;
	new  HEIGHT = (ROWS + 2)*ROW;
	
	new tab = 12;	
		
	new x,y;
	new menu = gui_create(START_X,START_Y,true,true,true,"addgui_arch_cback");
	
	//draw menu frame
	gui_addResizeGump(menu,START_X,START_Y,RESIZEGUMP,WIDTH,HEIGHT + ROW );
	gui_addResizeGump(menu,START_X + COL ,START_Y + ROW/2,RESIZEGUMP1,WIDTH - 2*COL,HEIGHT);
		
	x = START_X + L_MARG;
	y = START_Y + ROW/2 + ROW;
	
	gui_addText(menu,x,y,TXT_COLOR,"Item type:");
	gui_addInputField(menu,x + tab*COL,y,10*COL,ROW,0,TXT_COLOR,"wall");
	y += ROW;
	
	gui_addText(menu,x,y,TXT_COLOR,"Material:");
	gui_addInputField(menu,x + tab*COL,y,10*COL,ROW,1,TXT_COLOR,"stone");
	y += ROW;
	
	gui_addText(menu,x,y,TXT_COLOR,"Subtype:");
	gui_addInputField(menu,x + tab*COL,y,10*COL,ROW,2,TXT_COLOR,"0");	
	y += ROW;
	
	gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,1);
	gui_addText(menu,x + BTNW,y,TXT_COLOR,"Open menu");
	
	y += ROW;
	gui_addText(menu,x,y,TXT_COLOR,"This menu will generate a list of items"); 			y += ROW;
	gui_addText(menu,x,y,TXT_COLOR,"basing on the informations provided above.");			y += 2*ROW;
	
	gui_addText(menu,x,y,TXT_COLOR,"'Item type' can be: wall, stairs, floor, roof");		y += 2*ROW;
	
	gui_addText(menu,x,y,TXT_COLOR,"'Material' depends on the itemtype:");				y += ROW;
	gui_addText(menu,x,y,TXT_COLOR,"wall: stone, brick, log, marble, rattan, hide, tent, ruined");	y += ROW;
	gui_addText(menu,x,y,TXT_COLOR,"      sandstone, wooden, bamboo, plaster, cave, dungeon");	y += ROW;
	gui_addText(menu,x,y,TXT_COLOR,"stairs: marble, stone, sandstone, wooden, carpeted, cave");	y += ROW;
	gui_addText(menu,x,y,TXT_COLOR,"floor: marble, sandstone, planks, boards, logs, bricks, tiles");y += ROW;
	gui_addText(menu,x,y,TXT_COLOR,"       flagstones, cobblestones, cave");			y += ROW;
	gui_addText(menu,x,y,TXT_COLOR,"roof: stone, slate, tiles, palm, logs, tent, thatch");		y += 2*ROW;
	
	gui_addText(menu,x,y,TXT_COLOR,"'subtype': a number 2,3,4 ...");
	
	gui_show(menu,chr);
}

public addgui_arch_cback(menu,chr,btncode)
{
	if(!btncode) return;
	
	new def[100],basedef[100],type[20],material[20],subtype[2];
	if(menu != INVALID)
	{
		gui_getProperty(menu,MP_UNI_TEXT,0,type);
		gui_getProperty(menu,MP_UNI_TEXT,1,material);
		gui_getProperty(menu,MP_UNI_TEXT,2,subtype);
		
		sprintf(type,"_%s",type);
		if(strcmp(material,"")) sprintf(material,"_%s",material);
		if(!strcmp(subtype,"0") || !strcmp(subtype,"1")) sprintf(subtype,"");
			
		sprintf(basedef,"$item%s%s%s",material,type,subtype);
		
		
		chr_addLocalStrVar(chr,CLV_CMDADDTEMP,basedef);
	}
	else chr_getLocalStrVar(chr,CLV_CMDADDTEMP,basedef);

	sprintf(def,"%s_1",basedef);
		
	if(getIntFromDefine(def) <= 0)
	{
		chr_message(chr,_,"%s %s %s is not defined",material,type,subtype);
		return;
	}
	
	new  START_X = 0;
	new  START_Y = 0;
	
	new COLS = 39;
	new ROWS = 19;
	
	new  WIDTH =  COLS*COL;
	new  HEIGHT = (ROWS + 2)*ROW;
	
	new tabx = 10;	
	new taby = 7;
	
	if(isStrContainedInStr("floor",def) || isStrContainedInStr("roof",def))
	{
		tabx = 7;
		taby = 3;
	}
		
	new x,y;
	menu = gui_create(START_X,START_Y,true,true,true,"addgui_arch_cback2");
	
	//draw menu frame
	gui_addResizeGump(menu,START_X,START_Y,RESIZEGUMP,WIDTH,HEIGHT + ROW );
	gui_addResizeGump(menu,START_X + COL ,START_Y + ROW/2,RESIZEGUMP1,WIDTH - 2*COL,HEIGHT);
		
	x = START_X + L_MARG;
	y = START_Y + ROW/2 + ROW;
	
	new scriptID = 0,itm,ID,i=1,p=1;
	
	gui_addPage(menu,p);
	
	while(getIntFromDefine(def) != 0)
	{
		if(y >= START_Y + HEIGHT)
		{
			y = START_Y + ROW/2 + ROW;
			++p;
			gui_addText(menu,(START_X + WIDTH)/2 + 2*BTNW,START_Y + HEIGHT,TXT_COLOR,"next");
			gui_addPageButton(menu,(START_X + WIDTH)/2 + BTNW,START_Y + HEIGHT,BTN_UP,BTN_DOWN,p);
			gui_addPage(menu,p);
			gui_addText(menu,(START_X + WIDTH)/2 - 6*COL,START_Y + HEIGHT,TXT_COLOR,"prev");
			gui_addPageButton(menu,(START_X + WIDTH)/2 - BTNW,START_Y + HEIGHT,BTN_UP,BTN_DOWN,p - 1);
		}
		
		scriptID = getIntFromDefine(def);
		itm = itm_create(scriptID);
		ID = itm_getProperty(itm,IP_ID);
		itm_remove(itm);
		
		gui_addTilePic(menu,x,y,ID);
		gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,scriptID);
		
		
		x += tabx*COL;
		if(x >= START_X + WIDTH) 
		{ 
			x = START_X + L_MARG; 
			y += taby*ROW;
		}
		
		sprintf(def,"%s_%d",basedef,++i);	
	}
	
	gui_show(menu,chr);
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
//                                  FLOORS MENU                                      //
//==================================================================================//
/*!
\author Fax
\fn addgui_floors(chr,itemsInBackpack,amount)
\param chr: the character
\param itemsInBackpack: true if items are to be created in backpack
\amount:how many items we need
\since 0.82
\brief supply items page

\return nothing
*/

public addgui_floors(chr,itemsInBackpack,amount)
{
	if(!isChar(chr)) return;
	
	#if _CMD_DEBUG_
	log_message("^t->drawing floors menu");
	#endif
	
	new  START_X = 0;
	new  START_Y = 0;
	
	new h = 3,w = 8;
	new i_row = 6;
	new i_col = 7;
	new COLS = i_row*w;
	
	new  WIDTH =  COLS*COL;
	new  HEIGHT1 = 4*ROW;
	new HEIGHT2 = i_col*h*ROW;
	
	new x,y;
	new menu = gui_create(START_X,START_Y,true,true,true,"addgui_floors_cback");
	
	//draw menu frame
	gui_addResizeGump(menu,START_X,START_Y,RESIZEGUMP,WIDTH,HEIGHT1 + HEIGHT2 + ROW );
	gui_addResizeGump(menu,START_X + COL ,START_Y + ROW/2,RESIZEGUMP1,WIDTH - 2*COL,HEIGHT1);
	gui_addResizeGump(menu,START_X + COL ,START_Y + ROW/2 + HEIGHT1,RESIZEGUMP1,WIDTH - 2*COL,HEIGHT2);
	
	
	x = (START_X + WIDTH)/2;
	y = START_Y + HEIGHT1 + HEIGHT2 - 2*ROW;
	
	new idx,npag = 1 + NUM_FLOORS/(i_row*i_col);
	
	for(new p = 1; p <= npag && idx < NUM_FLOORS; p++)
	{
		gui_addPage(menu,p);
		//next button
		if(p < npag) gui_addPageButton(menu,x + COL,y,PBTN_UP,PBTN_DOWN,p + 1);
		if(p > 1) gui_addPageButton(menu,x - COL,y,PBTN_UP,PBTN_DOWN,p - 1);	
		
		for(new i = 0; i< i_row && idx < NUM_FLOORS; i++)
			for(new j = 0; j < i_col && idx < NUM_FLOORS; j++)
			{
				gui_addTilePic(menu,START_X + L_MARG + i*w*COL,START_Y + HEIGHT1 + j*h*ROW,__floors[idx][__ID]);
				gui_addButton(menu,START_X + L_MARG + i*w*COL,START_Y + HEIGHT1 + j*h*ROW,BTN_UP,BTN_DOWN,getIntFromDefine(__floors[idx++][__def]));
			}
	}
	
	gui_show(menu,chr);
}

/*!
\author Fax
\fn addgui_floors_cback(menu,chr,btncode)
\param all: standard menu callback params
\since 0.82
\brief callback for floors menu

Creates the item selected in the gump
\return nothing
*/
public addgui_floors_cback(menu,chr,btncode)
{
	if(!btncode)	return;
	
	chr_message(chr,_,"click to position the item");
	target_create(chr,btncode,_,_,"cmd_add_itm_targ");
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
/*! }@ */