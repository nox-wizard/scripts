// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts (menus.xss)                                      ||
// || Maintained by Xanathar and Kendra                                   ||
// || Last Update 27-nov-2001                                             ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || This script requires NoX-Wizard 0.70s or later                      ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#include "small-scripts/API/gui/defines.sma"
#include "small-scripts/commands/add/constants.sma"

static p;
enum
{
	P_GM_MENU = 1,
	
	P_MAGIC_MENU,
	P_REAGENTS,
	P_REAGENTS2,
	P_BOTTLES,
	P_POTIONS,
	P_WANDS,
	P_GATES,
	P_SCROLLS1,
	P_SCROLLS2,
	P_SCROLLS3,
	P_SCROLLS4,
	P_SCROLLS5,
	P_SCROLLS6,
	P_SCROLLS7,
	P_SCROLLS8,
	
	P_COMBAT_MENU,
	P_PLATEMAIL,
	P_CHAINMAIL,
	P_RINGMAIL,
	P_STUDDED,
	P_LEATHER,
	P_BONE,
	P_HELMS,
	P_SHIELDS,
	P_AXES,
	P_SWORDS,
	P_BLADES,
	P_FORKS,
	
	P_BUILDING_MENU,
	P_NPC_MENU,
	P_SPAWNER_MENU,
	P_GATE_MENU,
	P_SUPPLY_MENU,
	P_SKILLS_MENU,
	P_SPECIAL_MENU,
	P_SHARD_MENU,
	P_TREASURE_MENU,
};

#define MAGIC_MENU_ENTRIES 6
static magicMenuTxt[MAGIC_MENU_ENTRIES][20] =
{
	"reagents",
	"reagents 2",
	"bottles",
	"potions",
	"wands",
	"gates"	
}

#define COMBAT_MENU_ARMOR_ENTRIES 8
#define COMBAT_MENU_WEAPON_ENTRIES 4
#define COMBAT_MENU_ENTRIES COMBAT_MENU_ARMOR_ENTRIES + COMBAT_MENU_WEAPON_ENTRIES
static combatMenuTxt[COMBAT_MENU_ENTRIES][20] =
{
	"Platemail",
	"Chainmail",
	"Ringmail",
	"Studded",
	"Leather",
	"Bone",
	"Helms",
	"Shields",
	
	"Axes",
	"Blades",
	"Maces",
	"Forks"	
}

enum {AR_HELM,AR_GORGET,AR_CHEST,AR_ARMS,AR_GLOVES,AR_LEGS,AR_FEMALE}

static PBTN_UP;
static PBTN_DOWN;
static PBTNW;
static BTNW;
static PICW;

static BTN_UP;
static BTN_DOWN;
static L_MARG;

#define INPUT_AMOUNT 0
#define INPUT_MATERIAL 1

public addMenu(const chr)
{
	
	//BTN_UP = 0x09aa;
	//BTN_DOWN = 0x09a9;
	                  
	//BTN_UP = 0x0845;
	//BTN_DOWN = 0x0846;
	                  
	BTN_UP = 0x29F4;  
	BTN_DOWN = 0x29F6;
	
	PBTN_UP = 0x0827;
	PBTN_DOWN = 0x0827;
	
	L_MARG = 4*COL;
        
	PBTNW = 20;
	BTNW = 15;
	PICW = 40;
	
	new  START_X = 0;
	new  START_Y = 0;
	new  COLS = 60;
	new  ROWS = 24;
	new  WIDTH = COLS*COL;
	new  HEIGHT = ROWS*ROW;
	
	
	new tab = 13;
	
	p = 1;
	
	new t = 4;
	new x,y;
	new menu = gui_create(START_X,START_Y,true,true,true,"addmenu_cback");
	gui_addResizeGump(menu,START_X,START_Y,RESIZEGUMP,WIDTH,HEIGHT );
	gui_addResizeGump(menu,START_X + COL ,START_Y + COL,RESIZEGUMP1,WIDTH - 2*COL,6*ROW);
	gui_addResizeGump(menu,START_X + COL ,START_Y + 6*ROW,RESIZEGUMP1,WIDTH - 2*COL,HEIGHT - 6*ROW - COL);
        
        x = L_MARG + (t%4*tab)*COL;
	y = (t++/4)*ROW;
	gui_addText(menu,PBTNW + x,y,TXT_COLOR,"GM menu");
	gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,P_GM_MENU);
		
	x = L_MARG + (t%4*tab)*COL;
	y = (t++/4)*ROW;
	gui_addText(menu,PBTNW + x,y,TXT_COLOR,"Magic");
	gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,P_MAGIC_MENU);
		
	x = L_MARG + (t%4*tab)*COL;
	y = (t++/4)*ROW;
	gui_addText(menu,PBTNW + x,y,TXT_COLOR,"Combat");
	gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,P_COMBAT_MENU);
		
	x = L_MARG + (t%4*tab)*COL;
	y = (t++/4)*ROW;
	gui_addText(menu,PBTNW + x,y,TXT_COLOR,"Deeds");
	gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,P_BUILDING_MENU);
		
	x = L_MARG + (t%4*tab)*COL;
	y = (t++/4)*ROW;
	gui_addText(menu,PBTNW + x,y,TXT_COLOR,"NPCs");
	gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,P_NPC_MENU);
		
	x = L_MARG + (t%4*tab)*COL;
	y = (t++/4)*ROW;
	gui_addText(menu,PBTNW + x,y,TXT_COLOR,"Spawner");
	gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,P_SPAWNER_MENU);
		
	x = L_MARG + (t%4*tab)*COL;
	y = (t++/4)*ROW;
	gui_addText(menu,PBTNW + x,y,TXT_COLOR,"Gates");
	gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,P_GATE_MENU);
		
	x = L_MARG + (t%4*tab)*COL;
	y = (t++/4)*ROW;
	gui_addText(menu,PBTNW + x,y,TXT_COLOR,"Supply");
	gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,P_SUPPLY_MENU);
		
	x = L_MARG + (t%4*tab)*COL;
	y = (t++/4)*ROW;
	gui_addText(menu,PBTNW + x,y,TXT_COLOR,"Skills");
	gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,P_SKILLS_MENU);
		
	x = L_MARG + (t%4*tab)*COL;
	y = (t++/4)*ROW;
	gui_addText(menu,PBTNW + x,y,TXT_COLOR,"Special");
	gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,P_SPECIAL_MENU);
		
	x = L_MARG + (t%4*tab)*COL;
	y = (t++/4)*ROW;
	gui_addText(menu,PBTNW + x,y,TXT_COLOR,"Shard");
	gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,P_SHARD_MENU);
		
	x = L_MARG + (t%4*tab)*COL;
	y = (t++/4)*ROW;
	gui_addText(menu,PBTNW + x,y,TXT_COLOR,"Treasure");
	gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,p++);
	
	x = L_MARG;
	y += ROW;
	gui_addText(menu,x,y,TXT_COLOR,"Amount:");
	gui_addInputField(menu,x + 8*COL,y,5*COL,ROW,INPUT_AMOUNT,TXT_COLOR,"1");
	
	gui_addPage(menu,P_GM_MENU);
	drawPage(menu,P_GM_MENU);
	
	gui_addPage(menu,P_MAGIC_MENU);
	drawPage(menu,P_MAGIC_MENU);
	
	gui_addPage(menu,P_COMBAT_MENU);
	drawPage(menu,P_COMBAT_MENU);
	
	gui_addPage(menu,P_BUILDING_MENU);
	drawPage(menu,P_BUILDING_MENU);
	
	gui_addPage(menu,P_NPC_MENU);
	drawPage(menu,P_NPC_MENU);
	
	gui_addPage(menu,P_SPAWNER_MENU);
	drawPage(menu,P_SPAWNER_MENU);
	
	gui_addPage(menu,P_GATE_MENU);
	drawPage(menu,P_GATE_MENU);

	gui_addPage(menu,P_SUPPLY_MENU);
	drawPage(menu,P_SUPPLY_MENU);

	gui_addPage(menu,P_SKILLS_MENU);
	drawPage(menu,P_SKILLS_MENU);

	gui_addPage(menu,P_SPECIAL_MENU);
	drawPage(menu,P_SPECIAL_MENU);

	gui_addPage(menu,P_SHARD_MENU);
	drawPage(menu,P_SHARD_MENU);
	
	gui_show(menu,chr);

}


public drawPage(const menu, const page)
{
	
	new x,y,t,tab = 13,pag;
	
switch(page)
{	
case P_MAGIC_MENU:
{
	pag = P_REAGENTS;
	y = 7*ROW;
	
	for(t = 0; t < MAGIC_MENU_ENTRIES; t++)
	{
		x = L_MARG + (t%4*tab)*COL;
		if(t%4 == 0 && t != 0) y += ROW;
		
		gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,pag++);
		gui_addText(menu,PBTNW + x,y,TXT_COLOR ,magicMenuTxt[t]);	
	}
	
	x = L_MARG;
	y += 2*ROW;
	gui_addText(menu,x,y,TXT_COLOR ,"scrolls");
	
	y += ROW;
	
	for(t = 0; t < 8; t++)
	{
		x = L_MARG + (t%4*tab)*COL;
		if(t%4 == 0 && t != 0) y += ROW;
		
		gui_addText(menu,PBTNW + x,y,TXT_COLOR ,"circle %d",t+1);
		gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,pag++); 
	}
	
	x = L_MARG;
	y += 2*ROW;
	new startRow = y;	
	
	for(new i = 0; i < NUM_MAGICAL_ITEMS; i++)
	{
		gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(magicalItems[i][__def]));
		gui_addTilePic(menu,x + BTNW,y,magicalItems[i][__ID]);
		gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,magicalItems[i][__name]);
		
		y += ROW;
		if((i + 1)%10 == 0) { x+= tab*COL; y = startRow; }
		
	}
	
	for(new i = P_REAGENTS; i <= P_SCROLLS8; i++)
	{
		gui_addPage(menu,i);
		drawSubPage(menu,i);
	}
	
}//end of case P_MAGIC

case P_COMBAT_MENU:
{
	pag = P_PLATEMAIL;
	x = L_MARG + (t++*tab)*COL;
	y = 7*ROW;
	gui_addText(menu,PBTNW + x,y,TXT_COLOR ,"Armor:");
	y += ROW;
	
	for(t = 0; t < COMBAT_MENU_ARMOR_ENTRIES; t++)
	{
		x = L_MARG + (t%4*tab)*COL;
		if(t%4 == 0 && t != 0) y += ROW;
		
		gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,pag++);
		gui_addText(menu,PBTNW + x,y,TXT_COLOR ,combatMenuTxt[t]);	
	}
	
	y += 2*ROW;
	x = L_MARG;
	gui_addText(menu,PBTNW + x,y,TXT_COLOR ,"Weapons:");
	y += ROW;
		
	for(t = 0; t < COMBAT_MENU_WEAPON_ENTRIES; t++)
	{
		x = L_MARG + (t%4*tab)*COL;
		if(t%4 == 0 && t != 0) y += ROW;
		
		gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,pag++);
		gui_addText(menu,PBTNW + x,y,TXT_COLOR ,combatMenuTxt[t + COMBAT_MENU_ARMOR_ENTRIES]);	
	}
	
	
	for(new i = P_PLATEMAIL; i <= P_FORKS; i++)
	{
		gui_addPage(menu,i);
		drawSubPage(menu,i);
	}
	
   
}
	 
} //end of switch(page)
}

public drawSubPage(menu,page)
{
	
new x = L_MARG;
new y = 7*ROW;
new startRow = y;
new tab = 20;
new i_row = 10;

switch(page)
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
		new startscroll = (page - P_SCROLLS1)*SCROLLS_PER_CIRCLE;
		new endscroll = startscroll + SCROLLS_PER_CIRCLE; 
		for(new i = startscroll; i < endscroll; i++, y+= ROW)
		{
			if((i - startscroll)%i_row == 0 && i != startscroll) { x+= tab*COL; y = startRow; }
			gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__scrolls[i][__def]));
			gui_addTilePic(menu,x + BTNW,y,__scrolls[i][__ID]);
			gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__scrolls[i][__name]);
		}
	}
	
	case P_PLATEMAIL..P_SHIELDS:
	{
		gui_addText(menu,x + tab*COL,y,TXT_COLOR,"Material:");
		new material[5] = "";
		if(page != P_LEATHER && page!= P_STUDDED && page != P_BONE) sprintf(material,"iron");
		gui_addInputField(menu,x + (tab + 10)*COL,y,15*COL,ROW,INPUT_MATERIAL + 10*page,TXT_COLOR,"%s",material);
		
		gui_addButtonFn(menu,x + tab*COL,y  + 2*ROW,BTN_UP,BTN_DOWN,page,true,"addmenu_armor");
		gui_addText(menu,x + BTNW + tab*COL,y + 2*ROW,TXT_COLOR,"create in backpack");
		
		gui_addButtonFn(menu,x + tab*COL,y + 3*ROW,BTN_UP,BTN_DOWN,page + 1000,true,"addmenu_armor");
		gui_addText(menu,x + BTNW + tab*COL,y + 3*ROW,TXT_COLOR,"Equip");

		gui_addButtonFn(menu,x + tab*COL,y + 4*ROW,BTN_UP,BTN_DOWN,page + 10000,true,"addmenu_armor");
		gui_addText(menu,x + BTNW + tab*COL,y + 4*ROW,TXT_COLOR,"Equip to character");
					
		new artype = page - P_PLATEMAIL;
		for(new i = 0; i < ARMOR_PARTS; i++)
		{
			if(__armor[artype*ARMOR_PARTS + i][__ID] == INVALID) continue;
			
			gui_addCheckbox(menu,x,y,BTN_UP,BTN_DOWN,false,page*10 + i);
			gui_addTilePic(menu,x + BTNW,y,__armor[artype*ARMOR_PARTS + i][__ID]);
			gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__armor[artype*ARMOR_PARTS + i][__name]);
			y += 2*ROW;
		}		
	}
	
	case P_AXES..P_FORKS:
	{
		
		gui_addText(menu,x + tab*COL,y,TXT_COLOR,"Material:");
		gui_addInputField(menu,x + (tab + 10)*COL,y,15*COL,ROW,INPUT_MATERIAL + 10*page,TXT_COLOR,"iron");
					
		new wpntype = page - P_AXES;
		for(new i = 0; i < WEAPONS_PER_GROUP; i++)
		{
			if(__weapons[wpntype*WEAPONS_PER_GROUP + i][__ID] == INVALID) continue;
			
			gui_addButtonFn(menu,x,y,BTN_UP,BTN_DOWN,wpntype*WEAPONS_PER_GROUP + i,true,"addmenu_weapons");
			gui_addTilePic(menu,x + BTNW,y,__weapons[wpntype*WEAPONS_PER_GROUP + i][__ID]);
			gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__weapons[wpntype*WEAPONS_PER_GROUP + i][__name]);
			y += 2*ROW;
		}		
	}		
}//end of switch(page)

}


public addmenu_cback(menu,chr,btncode)
{
	if(!btncode)	return;
	
	new amount[10],n;
	gui_getProperty(menu,MP_UNI_TEXT,INPUT_AMOUNT,amount);
	if(!isStrInt(amount))
		n = 1;
	else n = str2Int(amount);
	
	new item; 
	item = itm_createInBp(btncode,chr);
	
	if(itm_getProperty(item,IP_PILEABLE))
	{
		itm_setProperty(item,IP_AMOUNT,_,n);
		chr_message(chr,_,"Item %d created",item);
	}
	else
		for(new i = 0; i < n -1; i++)
		{
			item = itm_createInBp(btncode,chr);
			chr_message(chr,_,"Item %d created",item);		
		}
	
	addMenu(chr);
}

public addmenu_armor(menu,chr,armor)
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
		target_create(chr,_,_,_,"equip2char_targ");
	}
	else addMenu(chr);
}

public equip2char_targ(t,chr,obj)
{
	if(!isChar(obj))
	{
		chr_message(chr,_,"You must target a charatcer");
		addMenu(chr);
		return;
	}
	
	for(new i = 0; i < 6; i++)
		chr_equip(obj,chr_getLocalIntVec(chr,CLV_CMDTEMP,i));
	
	chr_delLocalVar(chr,CLV_CMDTEMP);
	chr_addLocalIntVar(chr,CLV_CMDTEMP);
		
	addMenu(chr);
}


public addmenu_weapons(menu,chr,weapon)
{
	new weapongrp = weapon/WEAPONS_PER_GROUP;
	
	new material[20];
	gui_getProperty(menu,MP_UNI_TEXT,INPUT_MATERIAL + 10*(weapongrp + P_AXES),material);
		
	new def[100];
	sprintf(def,"$item_%s_%s",material,__weapons[weapon][__name]);
		
	addmenu_cback(menu,chr,getIntFromDefine(def));
}