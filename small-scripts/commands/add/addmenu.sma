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


static PBTN_UP;
static PBTN_DOWN;
static PBTNW;
static BTNW;
static PICW;

static BTN_UP;
static BTN_DOWN;
static L_MARG;

public addMenu(const chr)
{
	//BTN_UP = 0x09aa;
	//BTN_DOWN = 0x09a9;
	
	BTN_UP = 0x0845;
	BTN_DOWN = 0x0846;
	
	PBTN_UP = 0x0827;
	PBTN_DOWN = 0x0827;
	
	L_MARG = 4*COL;

	PBTNW = 20;
	BTNW = 10;
	PICW = 40;
	
	new  START_X = 0;
	new  START_Y = 0;
	new  COLS = 55;
	new  ROWS = 22;
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
	gui_addInputField(menu,x + 8*COL,y,5*COL,ROW,1,TXT_COLOR,"1");
	
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



//=========================================================================//
//============================  MAGICAL ITEMS  ============================//
//=========================================================================//
public drawPage(const menu, const page)
{
	
	new x,y,t,tab = 15,pag = P_REAGENTS;
	
switch(page)
{	
case P_MAGIC_MENU:
{
	x = L_MARG + (t++*tab)*COL;
	y = 7*ROW;
	gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,pag++);
	gui_addText(menu,PBTNW + x,y,TXT_COLOR ,"reagents");
	
	x = L_MARG + (t++*tab)*COL;
	gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,pag++);
	gui_addText(menu,PBTNW + x,y,TXT_COLOR ,"reagents 2");
	
	x = L_MARG + (t++*tab)*COL;
	gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,pag++);
	gui_addText(menu,PBTNW + x,y,TXT_COLOR ,"bottles");
	
	t = 0;
	y += ROW;
	x = L_MARG + (t++*tab)*COL;
	gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,pag++);
	gui_addText(menu,PBTNW + x,y,TXT_COLOR ,"potions");
	
	x = L_MARG + (t++*tab)*COL;
	gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,pag++);
	gui_addText(menu,PBTNW + x,y,TXT_COLOR ,"wands");
	
	x = L_MARG + (t++*tab)*COL;
	gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,pag++);
	gui_addText(menu,PBTNW + x,y,TXT_COLOR ,"gates");
	
	x = L_MARG;
	y += 2*ROW;
	gui_addText(menu,x,y,TXT_COLOR ,"scrolls");
	
	y += ROW;
	tab = 12;
	
	for(t = 0; t < 8; t++)
	{
		x = L_MARG + (t%4*tab)*COL;
		y = t%4 == 0 && t ? y + ROW : y;
		gui_addText(menu,PBTNW + x,y,TXT_COLOR ,"circle %d",t+1);
		gui_addPageButton(menu,x,y,PBTN_UP,PBTN_DOWN,pag++); 
	}
	
	x = L_MARG;
	y += 2*ROW;
	new startRow = y;	
	
	for(new i = 0; i < NUM_MAGICAL_ITEMS; i++)
	{
		gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(magicalItemsDefs[i]));
		gui_addTilePic(menu,x + BTNW,y,magicalItems[i][__ID]);
		gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,magicalItems[i][__name]);
		
		y += ROW;
		if((i + 1)%10 == 0) { x+= tab*COL; y = startRow; }
		
	}
	
	gui_addPage(menu,P_REAGENTS);
	drawSubPage(menu,P_REAGENTS);
	
	gui_addPage(menu,P_REAGENTS2);
	drawSubPage(menu,P_REAGENTS2);
	
	gui_addPage(menu,P_BOTTLES);
	drawSubPage(menu,P_BOTTLES);
	
	gui_addPage(menu,P_POTIONS);
	drawSubPage(menu,P_POTIONS);
	
	gui_addPage(menu,P_WANDS);
	drawSubPage(menu,P_WANDS);
	
	gui_addPage(menu,P_GATES);
	drawSubPage(menu,P_GATES);
	
	gui_addPage(menu,P_SCROLLS1);
	drawSubPage(menu,P_SCROLLS1);
	
	gui_addPage(menu,P_SCROLLS2);
	drawSubPage(menu,P_SCROLLS2);
	
	gui_addPage(menu,P_SCROLLS3);
	drawSubPage(menu,P_SCROLLS3);
	
	gui_addPage(menu,P_SCROLLS4);
	drawSubPage(menu,P_SCROLLS4);
	
	gui_addPage(menu,P_SCROLLS5);
	drawSubPage(menu,P_SCROLLS5);
	
	gui_addPage(menu,P_SCROLLS6);
	drawSubPage(menu,P_SCROLLS6);
	
	gui_addPage(menu,P_SCROLLS7);
	drawSubPage(menu,P_SCROLLS7);
	
	gui_addPage(menu,P_SCROLLS8);
	drawSubPage(menu,P_SCROLLS8);
}//end of case P_MAGIC

	 
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
			
			gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__reagentsDefs[i]));
			gui_addTilePic(menu,x + BTNW,y,__reagents[i][__ID]);
			gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__reagents[i][__name]);
		}
	}

	case P_REAGENTS2:
	{
		for(new i = 0; i < NUM_REAGENTS2; i++, y+= ROW)
		{
			if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
			
			gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__reagents2Defs[i]));
			gui_addTilePic(menu,x + BTNW,y,__reagents2[i][__ID]);
			gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__reagents2[i][__name]);
		}
	}
	
	case P_BOTTLES:
	{
		for(new i = 0; i < NUM_BOTTLES; i++, y+= ROW)
		{
			if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
			
			gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__bottlesDefs[i]));
			gui_addTilePic(menu,x + BTNW,y,__bottles[i][__ID]);
			gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__bottles[i][__name]);
		}
	}
	
	case P_POTIONS:
	{
		for(new i = 0; i < NUM_POTIONS; i++, y+= ROW)
		{
			if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
			
			gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__potionsDefs[i]));
			gui_addTilePic(menu,x + BTNW,y,__potions[i][__ID]);
			gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__potions[i][__name]);
		}
	}
	
	case P_WANDS:
	{
		for(new i = 0; i < NUM_WANDS; i++, y+= ROW)
		{
			if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
			
			gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__wandsDefs[i]));
			gui_addTilePic(menu,x + BTNW,y,__wands[i][__ID]);
			gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__wands[i][__name]);
		}
	}
	
	case P_GATES:
	{
		for(new i = 0; i < NUM_GATES; i++, y+= 4*ROW)
		{
			if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
			
			gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__gatesDefs[i]));
			gui_addTilePic(menu,x + BTNW,y,__gates[i][__ID]);
			gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__gates[i][__name]);
		}
	}
	
	case P_SCROLLS1:
	{
		for(new i = 0; i < NUM_SCROLLS1; i++, y+= ROW)
		{
			if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
			
			gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__scrolls1Defs[i]));
			gui_addTilePic(menu,x + BTNW,y,__scrolls1[i][__ID]);
			gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__scrolls1[i][__name]);
		}
	}
	
	case P_SCROLLS2:
	{
		for(new i = 0; i < NUM_SCROLLS2; i++, y+= ROW)
		{
			if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
			
			gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__scrolls2Defs[i]));
			gui_addTilePic(menu,x + BTNW,y,__scrolls2[i][__ID]);
			gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__scrolls2[i][__name]);
		}
	}
	
	case P_SCROLLS3:
	{
		for(new i = 0; i < NUM_SCROLLS3; i++, y+= ROW)
		{
			if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
			
			gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__scrolls3Defs[i]));
			gui_addTilePic(menu,x + BTNW,y,__scrolls3[i][__ID]);
			gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__scrolls3[i][__name]);
		}
	}
	
	case P_SCROLLS4:
	{
		for(new i = 0; i < NUM_SCROLLS4; i++, y+= ROW)
		{
			if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
			
			gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__scrolls4Defs[i]));
			gui_addTilePic(menu,x + BTNW,y,__scrolls4[i][__ID]);
			gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__scrolls4[i][__name]);
		}
	}
	
	case P_SCROLLS5:
	{
		for(new i = 0; i < NUM_SCROLLS5; i++, y+= ROW)
		{
			if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
			
			gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__scrolls5Defs[i]));
			gui_addTilePic(menu,x + BTNW,y,__scrolls5[i][__ID]);
			gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__scrolls5[i][__name]);
		}
	}
	
	case P_SCROLLS6:
	{
		for(new i = 0; i < NUM_SCROLLS6; i++, y+= ROW)
		{
			if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
			
			gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__scrolls6Defs[i]));
			gui_addTilePic(menu,x + BTNW,y,__scrolls6[i][__ID]);
			gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__scrolls6[i][__name]);
		}
	}
	
	case P_SCROLLS7:
	{
		for(new i = 0; i < NUM_SCROLLS7; i++, y+= ROW)
		{
			if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
			
			gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__scrolls7Defs[i]));
			gui_addTilePic(menu,x + BTNW,y,__scrolls7[i][__ID]);
			gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__scrolls7[i][__name]);
		}
	}
	
	case P_SCROLLS8:
	{
		for(new i = 0; i < NUM_SCROLLS1; i++, y+= ROW)
		{
			if(i%i_row == 0 && i != 0) { x+= tab*COL; y = startRow; }
			
			gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,getIntFromDefine(__scrolls8Defs[i]));
			gui_addTilePic(menu,x + BTNW,y,__scrolls8[i][__ID]);
			gui_addText(menu,x + BTNW + PICW,y,TXT_COLOR,__scrolls8[i][__name]);
		}
	}
	
}//end of switch(page)

}
/*
SECTION_MENU ,"hairs
{
    Hairs
    2046 Curly
    ADDITEM $item_buns hair
    203C Long Hair
    ADDITEM $item_long hair
    2044 Mohawk
    ADDITEM $item_mohawk
    2045 Pageboy
    ADDITEM $item_pageboy
    203D Pony Tail
    ADDITEM $item_pony tail
    2048 Receding
    ADDITEM $item_receding hair
    203B Short Hair
    ADDITEM $item_short hair
    2049 2 Tails
    ADDITEM $item_2 pig tails
    204A Topknot
    ADDITEM $item_krisna hair
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"hairs 1
}

SECTION_MENU ,"beards
{
    Beards
    2040 Goatee
    ADDITEM $item_goatee
    204D Goatee/Moustache
    ADDITEM $item_vandyke
    2041 Moustache
    ADDITEM $item_mustache
    203E Long Beard
    ADDITEM $item_long beard
    204C Long/Moustache
    ADDITEM $item_med short beard 1
    203F Short Beard
    ADDITEM $item_short beard
    204B Short/Moustache
    ADDITEM $item_med short beard
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"hairs 1
}

SECTION_MENU ,"shields
{
    Shields
    1B72 Bronze Shield
    ADDITEM $item_iron bronze shield
    1B73 Buckler
    ADDITEM $item_iron buckler
    1BC3 Chaos Shield
    ADDITEM $item_iron chaos shield
    1B76 Heater
    ADDITEM $item_iron heater
    1B74 Kite Shield (Metal)
    ADDITEM $item_iron metal kite shield
    1B7B Metal Shield
    ADDITEM $item_iron metal shield
    1BC4 Order Shield
    ADDITEM $item_iron order shield
    1B78 Kite Shield (Wooden)
    ADDITEM $item_iron wooden kite shield
    1B7A Wooden Shield
    ADDITEM $item_wooden shield
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
}

SECTION_MENU ,"quest items
{
    Quest Items
    1870 Compassion
    ADDITEM $item_stone of compassion
    1C12 Courage
    ADDITEM $item_bell of courage
    186A Honesty
    ADDITEM $item_stone of honesty
    186D Honor
    ADDITEM $item_stone of honor
    1869 Humility
    ADDITEM $item_stone of humility
    186B Justice
    ADDITEM $item_stone of justice
    1C14 Love
    ADDITEM $item_candle of love
    186C Sacrifice
    ADDITEM $item_stone of sacrifice
    186F Spirituality
    ADDITEM $item_stone of spirituality
    186E Valor
    ADDITEM $item_stone of valor
    1C13 Truth
    ADDITEM $item_book of truth
    1870 Gem of Immortality
    ADDITEM $item_gem of immortality
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"equipment
}

SECTION_MENU ,"decoration
{
    Decoration/Furniture
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"supply_MENU
    1E0F Plants
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"plants_MENU
    06A5 Doors
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"doors
    0B1D Light Sources
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"light sources
    0BB9 Signs
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"signs
    1E60 Interior Design
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"interior design
    01D3 Architecture
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"architecture
    129F Statues
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"statues
    0002 Misc
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"misc
}

SECTION_MENU ,"combat_MENU
{
    Combat_MENU
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"nox-wizard gm_MENU
    < Armor/Weapons/Shields
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
    < Enchanted Weapons
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"enchanted weapons
    < Enchanted Weapons 2
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"enchanted weapons 2
}

SECTION_MENU ,"plate mail
{
    Plate Mail
    1416 Breastplate
    ADDITEM $item_iron platemail
    1c04 Female Plate
    ADDITEM $item_iron female plate
    1413 Plate Gorget
    ADDITEM $item_iron plate gorget
    1414 Plate Gloves
    ADDITEM $item_iron plate gloves
    1412 Plate Helm
    ADDITEM $item_iron plate helm
    141A Plate Legs
    ADDITEM $item_iron plate leggings
    1410 Plate Sleeves
    ADDITEM $item_iron plate sleeves
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
}

SECTION_MENU ,"bone armor
{
    Bone Armor
    144F Bone Chestplate
    ADDITEM $item_bone chest
    144E Bone Sleeves
    ADDITEM $item_bone arms
    1450 Bone Gloves
    ADDITEM $item_bone gloves
    1451 Bone Helmet
    ADDITEM $item_bone helm
    1452 Bone Legs
    ADDITEM $item_bone legs
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
}

SECTION_MENU ,"chain mail
{
    Chain Mail
    13C4 Chain Tunic
    ADDITEM $item_iron chain tunic
    13C3 Chain Legs
    ADDITEM $item_iron chain leggings
    13BB Chain Coif
    ADDITEM $item_iron chain coif
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
}

SECTION_MENU ,"ring mail
{
    Ring Mail
    13ED Ring Chest
    ADDITEM $item_iron ringmail tunic
    13EF Ring Arms
    ADDITEM $item_iron ringmail sleeves
    13F1 Ring Legs
    ADDITEM $item_iron ringmail leggings
    13F2 Ring Gloves
    ADDITEM $item_iron ringmail gloves
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
}

SECTION_MENU ,"armor
{
    Armor
    13D6 Studded Leather Gorget
    ADDITEM $item_studded leather gorget
    13DD Studded Leather Gloves
    ADDITEM $item_studded leather gloves
    13D4 Studded Leather Arms
    ADDITEM $item_studded leather sleeves
    13E1 Studded Leather Legs
    ADDITEM $item_studded leather leggings
    13E2 Studded Leather Chest
    ADDITEM $item_studded leather tunic
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
}

SECTION_MENU ,"leather armor
{
    Leather Armor
    13CD Leather Arms
    ADDITEM $item_leather sleeves
    13D2 Leather Legs
    ADDITEM $item_leather leggings
    13D3 Leather Chest
    ADDITEM $item_leather tunic
    1DBA Leather Cap
    ADDITEM $item_leather cap
    13CE Leather Gloves
    ADDITEM $item_leather gloves
    13C7 Leather Gorget
    ADDITEM $item_a_leather gorget
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
}

SECTION_MENU ,"miscellaneous helms
{
    Miscellaneous Helms
    1408 Closed Helmet
    ADDITEM $item_iron close helm
    140A Helmet
    ADDITEM $item_iron helmet
    140C Bascinet
    ADDITEM $item_iron bascinet
    140E Nose Helm
    ADDITEM $item_iron nose helm
    141C Orc Helm
    ADDITEM $item_orc mask
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
}

SECTION_MENU ,"female armor
{
    Female Armor
    1C00 Female Leather Shorts
    ADDITEM $item_leather shorts
    1C02 Female Studded Leather
    ADDITEM $item_female studded leather
    1C06 Female Leather Armor
    ADDITEM $item_female leather armor
    1C08 Leather Skirt
    ADDITEM $item_leather skirt
    1C0A Leather Bustier
    ADDITEM $item_leather bustier
    1C0C Studded Bustier
    ADDITEM $item_studded leather bustier
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
}

SECTION_MENU ,"weapons
{
    Weapons
    13B2 Bows
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"bows
    13BA Swords
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"swords
    0F47 Axes
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"axes
    0EC4 Knives & Daggers
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"knives and daggers
    0F5C Maces & Hammers
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"maces  hammers
    1405 Spears & Forks
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"spears  forks
    1563 Pole Arms
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"pole arms
    0E8A Staves
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"staffs
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
}

SECTION_MENU ,"axes
{
    Axes
    0F43 Hatchet
    ADDITEM $item_hatchet
    0F45 Executioner's Axe
    ADDITEM $item_iron executioners axe
    0F49 Axe
    ADDITEM $item_iron axe
    0F4B Double Axe
    ADDITEM $item_iron double axe
    0F47 Battle Axe
    ADDITEM $item_iron battle axe
    13FB Large Battle Axe
    ADDITEM $item_iron large battle axe
    0E85 Pick Axe
    ADDITEM $item_pickaxe
    13B0 War Axe
    ADDITEM $item_iron war axe
    1442 Two-handed Axe
    ADDITEM $item_iron two-handed axe
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"weapons
}

SECTION_MENU ,"knives and daggers
{
    Knives and Daggers
    13F7 Butcher's Knife
    ADDITEM $item_butcher knife
    0EC4 Skinning Knife
    ADDITEM $item_skinning knife
    0EC2 Cleaver
    ADDITEM $item_meat cleaver
    0F51 Dagger
    ADDITEM $item_iron dagger
    1400 Kryss
    ADDITEM $item_iron kryss
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"weapons
}

SECTION_MENU ,"maces  hammers
{
    Maces & Hammers
    13B4 Club
    ADDITEM $item_club
    143C Hammer Pick
    ADDITEM $item_iron hammer pick
    0F5C Mace
    ADDITEM $item_iron mace
    143A Maul
    ADDITEM $item_iron maul
    13E4 Smithy Hammer
    ADDITEM $item_smithy hammer
    1438 War Hammer
    ADDITEM $item_iron war hammer
    1406 War Mace
    ADDITEM $item_iron war mace
    0FB4 Sledge Hammer
    ADDITEM $item_sledge hammer 1
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"weapons
}

SECTION_MENU ,"pole arms
{
    Pole Arms
    0F4D Bardiche
    ADDITEM $item_iron bardiche
    143E Halberd
    ADDITEM $item_iron halberd
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"weapons
}

SECTION_MENU ,"staffs
{
    Staffs
    0DF0 Black Staff
    ADDITEM $item_black staff
    13F9 Gnarled Staff
    ADDITEM $item_gnarled staff
    0E8A Quarterstaff
    ADDITEM $item_quarter staff
    0E81 Shepherd's Crook
    ADDITEM $item_sheperds crook
    0DF2 Sceptre
    ADDITEM $item_scepter
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"weapons
}

SECTION_MENU ,"swords
{
    Swords
    13B6 Scimitar
    ADDITEM $item_iron scimitar
    13B8 Long Sword
    ADDITEM $item_iron long sword
    13BA Viking Sword
    ADDITEM $item_iron viking sword
    0F5E Broad Sword
    ADDITEM $item_iron broadsword
    1440 Cutlass
    ADDITEM $item_iron cutlass
    13FF Katana
    ADDITEM $item_iron katana
    13B8 Human sword of destruction
    ADDITEM 
    < Elf Gate
    ADDITEM 
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"weapons
}

SECTION_MENU ,"spears  forks
{
    Spears & Forks
    0E87 Pitchfork
    ADDITEM $item_pitchfork
    0F62 Spear
    ADDITEM $item_iron spear
    1403 Short Spear
    ADDITEM $item_iron short spear
    1405 War Fork
    ADDITEM $item_iron war fork
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"weapons
}

SECTION_MENU ,"bows
{
    Bows
    13B2 Bow
    ADDITEM $item_bow
    0F4F Crossbow
    ADDITEM $item_crossbow
    13FD Heavy Crossbow
    ADDITEM $item_heavy crossbow
    0F3F Arrow
    ADDITEM $item_arrow
    1BFB Bolt
    ADDITEM $item_crossbow bolt
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"weapons
}

SECTION_MENU ,"misc
{
    Misc
    181D Alchemical Symbols
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"alchemical symbols
    0002 Ankh Left
    ADDITEM $item_ankh
    0003 Ankh Right
    ADDITEM $item_ankh 1
    1D97 Blood Ankh Left
    ADDITEM $item_ankh of sacrifice
    1D98 Blood Ankh Right
    ADDITEM $item_ankh of sacrifice 1
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"decoration
}

SECTION_MENU ,"floor tiles
{
    Floor Tiles
    049B Marble 1
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"marble 1
    049B Marble 2
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"marble 2
    049D Sandstone Pavers
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"sandstone pavers
    04A1 Wooden Planks
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wooden planks
    04A5 Wooden Boards 1
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wooden boards 1
    04A5 Wooden Boards 2
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wooden boards 2
    04E2 Bricks
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"bricks
    04FC Cobblestones & Flagstones
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"cobble  flagstones
    04C5 Wooden Logs
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wooden logs
    0519 Stone Pavers
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"stone pavers
    04EA Blue & Red Tiles
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"red  blue tiles
    0525 Sandstone Floor
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"sandstone floors
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"architecture
}

SECTION_MENU ,"marble 1
{
    Marble 1
    0491 Marble
    ADDITEM $item_floor tile
    0492 Marble
    ADDITEM $item_floor tile 1
    0493 Marble
    ADDITEM $item_floor tile 2
    0494 Marble
    ADDITEM $item_floor tile 3
    0495 Marble
    ADDITEM $item_marble floor
    0496 Marble
    ADDITEM $item_marble floor 1
    0497 Marble
    ADDITEM $item_marble floor 2
    0498 Marble
    ADDITEM $item_marble floor 3
    049B Marble
    ADDITEM $item_floor tile 4
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"floor tiles
}

SECTION_MENU ,"sandstone pavers
{
    Sandstone Pavers
    049D Sandstone Pavers
    ADDITEM $item_sandstone floor
    049E Sandstone Pavers
    ADDITEM $item_sandstone floor 1
    049F Sandstone Pavers
    ADDITEM $item_sandstone floor 2
    04A0 Sandstone Pavers
    ADDITEM $item_sandstone floor 3
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"floor tiles
}

SECTION_MENU ,"wooden planks
{
    Wooden Planks
    04A1 Wooden Planks
    ADDITEM $item_wooden planks
    04A2 Wooden Planks
    ADDITEM $item_wooden planks 1
    04A3 Wooden Planks
    ADDITEM $item_wooden planks 2
    04A4 Wooden Planks
    ADDITEM $item_wooden planks 3
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"floor tiles
}

SECTION_MENU ,"wooden boards 1
{
    Wooden Boards 1
    04A5 Wooden Boards
    ADDITEM $item_wooden boards
    04A6 Wooden Boards
    ADDITEM $item_wooden boards 1
    04A7 Wooden Boards
    ADDITEM $item_wooden boards 2
    04A8 Wooden Boards
    ADDITEM $item_wooden boards 3
    04A9 Wooden Boards
    ADDITEM $item_wooden boards 4
    04AA Wooden Boards
    ADDITEM $item_wooden boards 5
    04AB Wooden Boards
    ADDITEM $item_wooden boards 6
    04AC Wooden Boards
    ADDITEM $item_wooden boards 7
    04AD Wooden Boards
    ADDITEM $item_wooden boards 8
    04AE Wooden Boards
    ADDITEM $item_wooden boards 9
    04AF Wooden Boards
    ADDITEM $item_wooden boards A
    04B0 Wooden Boards
    ADDITEM $item_wooden boards B
    04B1 Wooden Boards
    ADDITEM $item_wooden boards C
    04B2 Wooden Boards
    ADDITEM $item_wooden boards D
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"floor tiles
}

SECTION_MENU ,"bricks
{
    Bricks
    04E2 Bricks
    ADDITEM $item_bricks
    04E3 Bricks
    ADDITEM $item_bricks 1
    04E4 Bricks
    ADDITEM $item_bricks 2
    04E5 Bricks
    ADDITEM $item_bricks 3
    04E6 Bricks
    ADDITEM $item_bricks 4
    04E7 Bricks
    ADDITEM $item_bricks 5
    04E8 Bricks
    ADDITEM $item_bricks 6
    04E9 Bricks
    ADDITEM $item_bricks 7
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"floor tiles
}

SECTION_MENU ,"cobble  flagstones
{
    Cobble & Flagstones
    04FC Flagstones
    ADDITEM $item_flagstones
    04FD Flagstones
    ADDITEM $item_flagstones 1
    04FE Flagstones
    ADDITEM $item_flagstones 2
    04FF Flagstones
    ADDITEM $item_flagstones 3
    0515 Cobblestones
    ADDITEM $item_cobblestones
    0516 Cobblestones
    ADDITEM $item_cobblestones 1
    0517 Cobblestones
    ADDITEM $item_cobblestones 2
    0518 Cobblestones
    ADDITEM $item_cobblestones 3
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"floor tiles
}

SECTION_MENU ,"wooden logs
{
    Wooden Logs
    04C1 Wooden Logs
    ADDITEM $item_wooden logs
    04C2 Wooden Logs
    ADDITEM $item_wooden logs 1
    04C3 Wooden Logs
    ADDITEM $item_wooden logs 2
    04C4 Wooden Logs
    ADDITEM $item_wooden logs 3
    04C5 Wooden Logs
    ADDITEM $item_wooden logs 4
    0504 Wooden Logs
    ADDITEM $item_wooden logs 5
    0505 Wooden Logs
    ADDITEM $item_wooden logs 6
    0506 Wooden Logs
    ADDITEM $item_wooden logs 7
    0507 Wooden Logs
    ADDITEM $item_wooden logs 8
    0508 Wooden Logs
    ADDITEM $item_wooden logs 9
    0509 Wooden Logs
    ADDITEM $item_wooden logs A
    050A Wooden Logs
    ADDITEM $item_wooden logs B
    050B Wooden Logs
    ADDITEM $item_wooden logs C
    050C Wooden Logs
    ADDITEM $item_wooden logs D
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"floor tiles
}

SECTION_MENU ,"stone pavers
{
    Stone Pavers
    0519 Stone Pavers
    ADDITEM $item_stone floor
    051A Stone Pavers
    ADDITEM $item_stone floor 1
    051B Stone Pavers
    ADDITEM $item_stone floor 2
    051C Stone Pavers
    ADDITEM $item_stone floor 3
    051D Stone Pavers
    ADDITEM $item_stone floor 4
    051E Stone Pavers
    ADDITEM $item_stone floor 5
    051F Stone Pavers
    ADDITEM $item_stone floor 6
    0520 Stone Pavers
    ADDITEM $item_stone floor 7
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"floor tiles
}

SECTION_MENU ,"red  blue tiles
{
    Red & Blue Tiles
    04EA Blue Tile
    ADDITEM $item_blue tiles
    04EB Blue Tile
    ADDITEM $item_blue tiles 1
    04EC Blue Tile
    ADDITEM $item_blue tiles 3
    04ED Blue Tile
    ADDITEM $item_blue tiles 4
    04EE Blue Tile
    ADDITEM $item_blue tiles 5
    04EF Blue Tile
    ADDITEM $item_blue tiles 6
    04F0 Blue Tile
    ADDITEM $item_blue tiles 7
    04F1 Blue Tile
    ADDITEM $item_blue tiles 8
    04F2 Blue Tile
    ADDITEM $item_red tiles
    04F3 Blue Tile
    ADDITEM $item_red tiles 1
    04F4 Red Tile
    ADDITEM $item_red tiles 2
    04F5 Red Tile
    ADDITEM $item_red tiles 3
    04F6 Red Tile
    ADDITEM $item_red tiles 4
    04F7 Red Tile
    ADDITEM $item_red tiles 5
    04F8 Red Tile
    ADDITEM $item_red tiles 6
    04F9 Red Tile
    ADDITEM $item_red tiles 7
    04FA Red Tile
    ADDITEM $item_red tiles 8
    04FB Red Tile
    ADDITEM $item_flagstone
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"floor tiles
}

SECTION_MENU ,"sandstone floors
{
    Sandstone Floors
    0525 Sandstone Floor
    ADDITEM 
    0526 Sandstone Floor
    ADDITEM $item_sandstone floor 4
    0527 Sandstone Floor
    ADDITEM $item_sandstone floor 5
    0528 Sandstone Floor
    ADDITEM $item_sandstone floor 6
    0529 Sandstone Floor
    ADDITEM $item_sandstone floor 7
    052A Sandstone Floor
    ADDITEM $item_sandstone floor 8
    052B Sandstone Floor
    ADDITEM $item_sandstone floor 9
    052C Sandstone Floor
    ADDITEM $item_sandstone floor A
    052F Sandstone Floor
    ADDITEM $item_sandstone floor B
    0530 Sandstone Floor
    ADDITEM $item_sandstone floor C
    0531 Sandstone Floor
    ADDITEM $item_sandstone floor D
    0532 Sandstone Floor
    ADDITEM $item_sandstone floor E
    0533 Sandstone Floor
    ADDITEM $item_sandstone floor F
    0534 Sandstone Floor
    ADDITEM $item_sandstone floor G
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"floor tiles
}

SECTION_MENU ,"building_MENU
{
    Building_MENU
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"nox-wizard gm_MENU
    < Misc Deeds
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"misc deeds
    < Old Houses
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"old house deeds
    < New Houses
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"new houses
    < Boats
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"boat deeds
    < Lord Binary's Deeds
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"lord binarys deeds
}

SECTION_MENU ,"red rug
{
    Red Rug
    0AA9 Red Rug
    ADDITEM $item_rug
    0AAA Red Rug
    ADDITEM $item_rug 1
    0AAB Red Rug
    ADDITEM $item_rug 2
    0AAC Red Rug
    ADDITEM $item_rug 3
    0AAD Red Rug
    ADDITEM $item_rug 4
    0AAE Red Rug
    ADDITEM $item_rug 5
    0AAF Red Rug
    ADDITEM $item_rug 6
    0AB0 Red Rug
    ADDITEM $item_rug 7
    0AB1 Red Rug
    ADDITEM $item_rug 8
    0AB2 Red Rug
    ADDITEM $item_rug 9
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"rugs
}

SECTION_MENU ,"greenish rug
{
    Greenish Rug
    0AB3 Greenish Rug
    ADDITEM $item_rug A
    0AB4 Greenish Rug
    ADDITEM $item_rug B
    0AB5 Greenish Rug
    ADDITEM $item_rug C
    0AB6 Greenish Rug
    ADDITEM $item_rug D
    0AB7 Greenish Rug
    ADDITEM $item_rug E
    0AB8 Greenish Rug
    ADDITEM $item_rug F
    0AB9 Greenish Rug
    ADDITEM $item_rug G
    0ABA Greenish Rug
    ADDITEM $item_rug H
    0ABB Greenish Rug
    ADDITEM $item_rug I
    0ABC Greenish Rug
    ADDITEM $item_rug J
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"rugs
}

SECTION_MENU ,"fancy blue rug
{
    Fancy Blue Rug
    0ABD Fancy Blue Rug
    ADDITEM $item_carpet
    0ABE Fancy Blue Rug
    ADDITEM $item_carpet 1
    0ABF Fancy Blue Rug
    ADDITEM $item_carpet 2
    0AC0 Fancy Blue Rug
    ADDITEM $item_carpet 3
    0AC1 Fancy Blue Rug
    ADDITEM $item_carpet 4
    0AC2 Fancy Blue Rug
    ADDITEM $item_carpet 5
    0AC3 Fancy Blue Rug
    ADDITEM $item_carpet 6
    0AC4 Fancy Blue Rug
    ADDITEM $item_carpet 7
    0AC5 Fancy Blue Rug
    ADDITEM $item_carpet 8
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"rugs
}

SECTION_MENU ,"fancy red rug
{
    Fancy Red Rug
    0AC6 Fancy Red Rug
    ADDITEM $item_carpet 9
    0AC7 Fancy Red Rug
    ADDITEM $item_carpet A
    0AC8 Fancy Red Rug
    ADDITEM $item_carpet B
    0AC9 Fancy Red Rug
    ADDITEM $item_carpet C
    0ACA Fancy Red Rug
    ADDITEM $item_carpet D
    0ACB Fancy Red Rug
    ADDITEM $item_carpet E
    0ACC Fancy Red Rug
    ADDITEM $item_carpet F
    0ACD Fancy Red Rug
    ADDITEM $item_carpet G
    0ACE Fancy Red Rug
    ADDITEM $item_carpet H
    0ACF Fancy Red Rug
    ADDITEM $item_carpet I
    0AD0 Fancy Red Rug
    ADDITEM $item_carpet J
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"rugs
}

SECTION_MENU ,"fancy blue
{
    Fancy Blue/Gold Rug
    0AD1 Fancy Blue/Gold Rug
    ADDITEM $item_carpet K
    0AD2 Fancy Blue/Gold Rug
    ADDITEM $item_carpet L
    0AD3 Fancy Blue/Gold Rug
    ADDITEM $item_carpet M
    0AD4 Fancy Blue/Gold Rug
    ADDITEM $item_carpet N
    0AD5 Fancy Blue/Gold Rug
    ADDITEM $item_carpet O
    0AD6 Fancy Blue/Gold Rug
    ADDITEM $item_carpet P
    0AD7 Fancy Blue/Gold Rug
    ADDITEM $item_carpet Q
    0AD8 Fancy Blue/Gold Rug
    ADDITEM $item_carpet R
    0AD9 Fancy Blue/Gold Rug
    ADDITEM $item_carpet S
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"rugs
}

SECTION_MENU ,"fancy golden rug
{
    Fancy Golden Rug
    0ADA Fancy Golden Rug
    ADDITEM $item_carpet T
    0ADB Fancy Golden Rug
    ADDITEM $item_carpet U
    0ADC Fancy Golden Rug
    ADDITEM $item_carpet V
    0ADD Fancy Golden Rug
    ADDITEM $item_carpet W
    0ADE Fancy Golden Rug
    ADDITEM $item_carpet X
    0ADF Fancy Golden Rug
    ADDITEM $item_carpet Y
    0AE0 Fancy Golden Rug
    ADDITEM $item_carpet Z
    0AE1 Fancy Golden Rug
    ADDITEM $item_carpet Z1
    0AE2 Fancy Golden Rug
    ADDITEM $item_carpet Z2
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"rugs
}

SECTION_MENU ,"fancy pink rug
{
    Fancy Pink Rug
    0AE3 Fancy Pink Rug
    ADDITEM $item_carpet Z3
    0AE4 Fancy Pink Rug
    ADDITEM $item_carpet Z4
    0AE5 Fancy Pink Rug
    ADDITEM $item_carpet Z5
    0AE6 Fancy Pink Rug
    ADDITEM $item_carpet Z6
    0AE7 Fancy Pink Rug
    ADDITEM $item_carpet Z7
    0AE8 Fancy Pink Rug
    ADDITEM $item_carpet Z8
    0AE9 Fancy Pink Rug
    ADDITEM $item_carpet Z9
    0AEA Fancy Pink Rug
    ADDITEM $item_carpet ZA
    0AEB Fancy Pink Rug
    ADDITEM $item_carpet ZB
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"rugs
}

SECTION_MENU ,"fancy pink  blue rug
{
    Fancy Pink & Blue Rug
    0AEC Fancy Pink & Blue Rug
    ADDITEM $item_carpet ZC
    0AED Fancy Pink & Blue Rug
    ADDITEM $item_carpet ZD
    0AEE Fancy Pink & Blue Rug
    ADDITEM $item_carpet ZE
    0AEF Fancy Pink & Blue Rug
    ADDITEM $item_carpet ZF
    0AF0 Fancy Pink & Blue Rug
    ADDITEM $item_carpet ZG
    0AF1 Fancy Pink & Blue Rug
    ADDITEM $item_carpet ZH
    0AF2 Fancy Pink & Blue Rug
    ADDITEM $item_carpet ZI
    0AF3 Fancy Pink & Blue Rug
    ADDITEM $item_carpet ZJ
    0AF4 Fancy Pink & Blue Rug
    ADDITEM $item_carpet ZK
    0AF5 Fancy Pink & Blue Rug
    ADDITEM $item_carpet ZL
    0AFA Fancy Pink & Blue Rug
    ADDITEM $item_carpet ZM
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"rugs
}

SECTION_MENU ,"merchants
{
    Merchants/People/Custom Race
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"npc_MENU
    < Register of names (invul)
    ADDITEM $item_register of names
    < Custom Race
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"custom race
    < People
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"people
    < Merchants - Males - A-G
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"merchants - males - a-g
    < Merchants - Males - H-Z
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"merchants - males - h-z
    < Merchants - Females - A-G
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"merchants - females - a-g
    < Merchants - Females - H-Z
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"merchants - females - h-z
}

SECTION_MENU ,"hairs 1
{
    Hairs/Beards
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"gm_MENU
    203E Beards
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"beards
    203C Hairs
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"hairs
}

SECTION_MENU ,"equipment
{
    Equipment/Items
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"supply_MENU
    < Misc Items
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"misc items
    < Cannon Ball
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"cannon ball
    < Non-Combat Equipment
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"non-combat equipment
    < Coins Gems Jewelry
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"coins gems jewelry
    < Unique Items
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"unique items
    < Quest Items
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"quest items
    < Keys
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"keys
}

SECTION_MENU ,"non-combat equipment
{
    Non-Combat Equipment
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"equipment
    1EFD Clothes and Dyes
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"clothes  footwear
    0E75 Containers
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"containers
    0FF1 Books
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"books
    0DC0 Fishing Pole
    ADDITEM $item_a_fishing pole
    14EB Map
    ADDITEM $item_a_map
}

SECTION_MENU ,"containers
{
    Containers
    0E75 Backpack
    ADDITEM $item_backpack
    0E76 Leather Bag
    ADDITEM $item_leather bag
    0E78 Round Basket
    ADDITEM $item_round basket
    0E79 Pouch
    ADDITEM $item_pouch
    0E7A Square Basket
    ADDITEM $item_square basket
    0E42 Wooden Chest
    ADDITEM $item_wooden chest1
    0E7C Silver Chest
    ADDITEM $item_silver chest
    0E40 Metal Chest
    ADDITEM $item_metal chest
    0E7D Wooden Box
    ADDITEM $item_wooden box
    0E7E Small Wooden Crate
    ADDITEM $item_small wooden crate
    0E3E Medium Wooden Crate
    ADDITEM $item_medium wooden crate1
    0E3C Large Wooden Crate
    ADDITEM $item_large wooden crate
    0E7F Wooden Keg
    ADDITEM $item_open wooden keg
    0E83 Tub
    ADDITEM $item_tub
    0E77 Barrel
    ADDITEM $item_barrel with lid
    0E80 Brass Box
    ADDITEM $item_brass box
    0A4D Armorie Cherry
    ADDITEM $item_pine armoire1 2
    0A4F Armorie Brown
    ADDITEM $item_pine armoire2 2
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"non-combat equipment
}

SECTION_MENU ,"keys
{
    Keys
    100F Gold Key
    ADDITEM $item_gold key
    1010 Iron Key
    ADDITEM $item_iron key
    1012 Magic Key
    ADDITEM $item_magic key
    1013 Bronze Key
    ADDITEM $item_bronze key
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"equipment
}

SECTION_MENU ,"places to sit
{
    Places to Sit
    0459 Benches
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"benches
    0B32 Chairs
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"chairs
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"furnitures
}

SECTION_MENU ,"benches
{
    Benches
    0459 Marble Bench
    ADDITEM $item_marble bench
    045A Marble bench A 2
    ADDITEM $item_marble bench 1
    1DCF Marble bench A 3
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"marble bench 3
    045B Stone Bench
    ADDITEM $item_stone bench
    045C Stone bench A 2
    ADDITEM $item_marble bench 2
    1DC9 Sandstone Bench
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"sandstone bench
    0B2C Wooden Bench
    ADDITEM $item_pine wooden bench D1
    0B2D Wooden bench A 2
    ADDITEM $item_pine wooden bench D2
    0B67 Other Wooden Benches
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"other wooden benches
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"places to sit
}

SECTION_MENU ,"other wooden benches
{
    Other wooden benches
    0B67 Wooden bench A 1
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wooden bench 1
    0B60 Wooden bench A 2
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wooden bench 2
    0B64 Wooden bench A 3
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wooden bench 3
    0B6A Wooden bench A 4
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wooden bench 4
    0B92 Wooden bench A 5
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wooden bench 5
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"benches
}

SECTION_MENU ,"wooden bench 1
{
    Wooden bench A 1
    0B66 Wooden Bench
    ADDITEM $item_pine bench A2 2
    0B68 Wooden Bench
    ADDITEM $item_pine bench B2 3
    0B67 Wooden Bench
    ADDITEM $item_pine bench A2 3
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"other wooden benches
}

SECTION_MENU ,"wooden bench 2
{
    Wooden bench A 2
    0B5F Wooden bench A1 1
    ADDITEM $item_pine bench A1 1
    0B61 Wooden bench A1 2
    ADDITEM $item_pine bench A1 2
    0B60 Wooden bench A1 3
    ADDITEM $item_pine bench A1 3
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"other wooden benches
}

SECTION_MENU ,"wooden bench 3
{
    Wooden bench B 1 1
    0B62 Wooden bench B1 1
    ADDITEM $item_pine bench B1 1
    0B64 Wooden bench B1 2
    ADDITEM $item_pine bench B1 2
    0B63 Wooden bench B1 3
    ADDITEM $item_pine bench B1 3
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"other wooden benches
}

SECTION_MENU ,"wooden bench 4
{
    Wooden bench A 4
    0B69 Wooden bench B2 1
    ADDITEM $item_pine bench B2 1
    0B68 Wooden bench B2 3
    ADDITEM $item_pine bench B2 3
    0B6A Wooden bench B2 2
    ADDITEM $item_pine bench B2 2
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"other wooden benches
}

SECTION_MENU ,"polymorph section_MENU
{
    Polymorph SECTION_MENU
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"gm_MENU
    20CD Male
    POLY 0190
    20CE Female
    POLY 0191
    20CF Animals
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"animals
    20D3 Monsters
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"monsters
    20CD Game Master
    POLY 03DB
}

SECTION_MENU ,"wooden bench 5
{
    Wooden bench A 5
    0B92 Wooden Bench
    ADDITEM $item_pine bench C1 1
    0B91 Wooden Bench
    ADDITEM $item_pine bench C1 2
    0B93 Wooden Bench
    ADDITEM $item_pine bench C2 1
    0B94 Wooden Bench
    ADDITEM $item_pine bench C2 2
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"other wooden benches
}

SECTION_MENU ,"chairs
{
    Chairs
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"places to sit
    0B32 Throne
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"throne
    0B2E Wooden Chair
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wooden chair
    0B4E Chair 1
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"chair 1
    0B52 Chair 2
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"chair 2
    0B56 Chair 3
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"chair 3
    0B5A Chair 4
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"chair 4
    1218 Stone Throne
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"stone throne
    0A2A Stool
    ADDITEM $item_pine stool2
    0A2B Stool
    ADDITEM $item_pine stool1
}

SECTION_MENU ,"throne
{
    Throne
    0B32 Throne
    ADDITEM $item_pine throne1
    0B33 Throne
    ADDITEM $item_pine throne2
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"chairs
}

SECTION_MENU ,"wooden chair
{
    Wooden Chair
    0B2E Wooden Chair
    ADDITEM $item_pine wooden chair1 1
    0B2F Wooden Chair
    ADDITEM $item_pine wooden chair1 2
    0B30 Wooden Chair
    ADDITEM $item_pine wooden chair1 3
    0B31 Wooden Chair
    ADDITEM $item_pine wooden chair1 4
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"chairs
}

SECTION_MENU ,"chair 1
{
    Chair 1
    0B4E Chair 1
    ADDITEM $item_pine fancy chair1 4
    0B4F Chair 1
    ADDITEM $item_pine fancy chair1 1
    0B50 Chair 1
    ADDITEM $item_pine fancy chair1 2
    0B51 Chair 1
    ADDITEM $item_pine fancy chair1 3
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"chairs
}

SECTION_MENU ,"chair 2
{
    Chair 2
    0B52 Chair 2
    ADDITEM $item_pine fancy chair2 1
    0B53 Chair 2
    ADDITEM $item_pine fancy chair2 2
    0B54 Chair 2
    ADDITEM $item_pine fancy chair2 3
    0B55 Chair 2
    ADDITEM $item_pine fancy chair2 4
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"chairs
}

SECTION_MENU ,"chair 3
{
    Chair 3
    0B56 Chair 3
    ADDITEM $item_pine wooden chair2 1
    0B57 Chair 3
    ADDITEM $item_pine wooden chair2 2
    0B58 Chair 3
    ADDITEM $item_pine wooden chair2 3
    0B59 Chair 3
    ADDITEM $item_pine wooden chair2 4
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"chairs
}

SECTION_MENU ,"chair 4
{
    Chair 4
    0B5A Chair 4
    ADDITEM $item_pine straw chair1 1
    0B5B Chair 4
    ADDITEM $item_pine straw chair1 2
    0B5C Chair 4
    ADDITEM $item_pine straw chair1 3
    0B5D Chair 4
    ADDITEM $item_pine straw chair1 4
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"chairs
}

SECTION_MENU ,"marble bench 3
{
    Marble bench A 3
    1DCD Marble Bench
    ADDITEM $item_marble bench 3
    1DCF Marble Bench
    ADDITEM $item_marble bench 4
    1DCE Marble Bench
    ADDITEM $item_marble bench 5
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"benches
}

SECTION_MENU ,"sandstone bench
{
    Sandstone Bench
    1DC7 Sandstone Bench
    ADDITEM $item_sandstone bench
    1DC9 Sandstone Bench
    ADDITEM $item_sandstone bench 1
    1DC8 Sandstone Bench
    ADDITEM $item_sandstone bench 2
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"benches
}

SECTION_MENU ,"animals
{
    Animals
    20CF Brown Bear
    POLY 00D3
    20D0 Large Rat
    POLY 00D7
    20D1 Chicken
    POLY 00D0
    20D4 Large Deer
    POLY 00EA
    20D4 Deer
    POLY 00ED
    20D5 Dog
    POLY 00D9
    20DA Alligator
    POLY 00CA
    20DB Grizzly Bear
    POLY 00D4
    20DD Horse (Brown)
    POLY 00CC
    20DD Horse (White)
    POLY 00C8
    20E1 Polar Bear
    POLY 00D5
    20E2 Rabbit
    POLY 00CD
    20E5 Serpent
    POLY 0034
    20E6 Sheep
    POLY 00CF
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"polymorph section_MENU
}

SECTION_MENU ,"monsters
{
    Monsters
    20D3 Daemon
    POLY 000A
    20D3 Demon With out Sword
    POLY 0009
    20EC Zombie
    POLY 0003
    20DF Ogre
    POLY 0001
    20D8 Ettin
    POLY 0002
    20D9 Gargoyle
    POLY 0004
    20D2 Corpser
    POLY 0008
    20D6 Green Dragon
    POLY 000c
    20ED Air Elemental
    POLY 000d
    20D7 Earth Elemental
    POLY 000e
    20F3 Fire Elemental
    POLY 000f
    210B Water Elemental
    POLY 0010
    20F4 Gazer
    POLY 0016
    20F8 Lich
    POLY 0018
    2109 Spectre
    POLY 001a
    20FD Giant Spider
    POLY 001c
    20DC Harpy
    POLY 001e
    210A Headless One
    POLY 001f
    20DE Lizardman
    POLY 0021
    20E3 Ratman
    POLY 002a
    20FA Reaper
    POLY 002f
    20E4 Giant Scorpian
    POLY 0030
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"polymorph section_MENU
}

SECTION_MENU ,"stone throne
{
    Stone Throne
    1218 Stone Throne
    ADDITEM $item_stone chair
    1219 Stone Throne
    ADDITEM $item_stone chair 1
    121A Stone Throne
    ADDITEM $item_stone chair 2
    121B Stone Throne
    ADDITEM $item_stone chair 3
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"chairs
}

SECTION_MENU ,"statues
{
    Statues
    12A1 Statue 1 Left
    ADDITEM $item_statue
    129F Statue 1 Center
    ADDITEM $item_statue 1
    12A0 Statue 1 Right
    ADDITEM $item_statue 2
    12A4 Statue 2 Left
    ADDITEM $item_statue 3
    12A2 Statue 2 Center
    ADDITEM $item_statue 4
    12A3 Statue 2 Right
    ADDITEM $item_statue 5
    12D7 Statue 3 Left
    ADDITEM $item_statue 7
    12D5 Statue 3 Center
    ADDITEM $item_statue 8
    12D6 Statue 3 Right
    ADDITEM $item_statue 9
    12A3 Unfinished Statue
    ADDITEM $item_statue 6
    1224 Statue
    ADDITEM $item_statue A
    1225 Statue
    ADDITEM $item_statue B
    1226 Statue
    ADDITEM $item_statue C
    1227 Statue
    ADDITEM $item_statue D
    1228 Statue
    ADDITEM $item_statue E
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"decoration
}

SECTION_MENU ,"alchemical symbols
{
    Alchemical Symbols
    181D Alchemical Symbol
    ADDITEM $item_alchemical symbol
    181E Alchemical Symbol
    ADDITEM $item_alchemical symbol 1
    181F Alchemical Symbol
    ADDITEM $item_alchemical symbol 2
    1820 Alchemical Symbol
    ADDITEM $item_alchemical symbol 3
    1821 Alchemical Symbol
    ADDITEM $item_alchemical symbol 4
    1822 Alchemical Symbol
    ADDITEM $item_alchemical symbol 5
    1823 Alchemical Symbol
    ADDITEM $item_alchemical symbol 6
    1824 Alchemical Symbol
    ADDITEM $item_alchemical symbol 7
    1825 Alchemical Symbol
    ADDITEM $item_alchemical symbol 8
    1826 Alchemical Symbol
    ADDITEM $item_alchemical symbol 9
    1827 Alchemical Symbol
    ADDITEM $item_alchemical symbol A
    1828 Alchemical Symbol
    ADDITEM $item_alchemical symbol B
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"interior design
}

SECTION_MENU ,"reagents
{
    Reagents
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic
    0F85 common Reagents
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"common reagents
    0F82 un-common reagents
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"uncommon reagents
}

SECTION_MENU ,"animals i
{
    Animals I
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"animals 1
    2120 Horse 1
    NPC $npc a horse
    211F Horse 2
    NPC $npc a horse 1
    2124 Horse 3
    NPC $npc a horse 2
    2121 Horse 4
    NPC $npc a horse 3
    20DB a grizzly bear
    NPC $npc a grizzly bear
    20F5 a gorilla
    NPC $npc a gorilla
    20CF a brown bear
    NPC $npc a black bear
    20D1 a chicken
    NPC $npc a chicken
    20D4 a deer
    NPC $npc a great hart
    20D5 a dog
    NPC $npc a dog
    20DA an alligator
    NPC $npc an alligator
    20E1 a polar bear
    NPC $npc a polar bear
    < Vera Bear
    NPC $npc a vera bear
    < Cave Bear
    NPC $npc a cave bear
}

SECTION_MENU ,"clothes  footwear
{
    Clothes & Footwear
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"non-combat equipment
    0FA9 Dyes
    ADDITEM $item_dyes
    0FAB Dye Vat
    ADDITEM $item_a_dying tub
    170B Boots
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"boots
    1713 Hats
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"hats
    1515 Shirts & Robes
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"shirts  robes
    152E Pants
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"pants
    153B Misc
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"misc
    1547 Masks
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"masks
}

SECTION_MENU ,"boots
{
    Boots
    170B Boots
    ADDITEM $item_boots
    170D Sandals
    ADDITEM $item_sandles
    170F Shoes
    ADDITEM $item_shoes
    1711 Thigh boots
    ADDITEM $item_thigh boots
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"clothes  footwear
}

SECTION_MENU ,"hats
{
    Hats
    1713 Floppy hat
    ADDITEM $item_floopy hat
    1714 Wide-brim hat
    ADDITEM $item_wide brim hat
    1715 Cap
    ADDITEM $item_cap
    1716 Tall straw hat
    ADDITEM $item_a_tall straw hat
    1717 Straw hat
    ADDITEM $item_straw hat
    1718 Wizard's hat
    ADDITEM $item_a_wizards hat
    1718 a Magical Wizard`s hat
    ADDITEM $item_a_magical wizard`s hat
    1719 Bonnet
    ADDITEM $item_bonnet
    171A Feathered hat
    ADDITEM $item_feathered hat
    171B Tricorne hat
    ADDITEM $item_tricorne hat
    171C Jester hat
    ADDITEM $item_jester hat
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"clothes  footwear
}

SECTION_MENU ,"shirts  robes
{
    Shirts & Robes
    1515 Cape
    ADDITEM $item_cloak
    1EFD Fancy shirt
    ADDITEM $item_fancy shirt
    1517 Plain shirt
    ADDITEM $item_shirt
    1FFD Surcoat
    ADDITEM $item_a_surcoat
    1FA1 Tunic
    ADDITEM $item_a_tunic
    1F03 Robe
    ADDITEM $item_a_robe
    1F9F Fancy suit
    ADDITEM $item_a_jesters suit
    1F7B Doublet
    ADDITEM $item_a_doublet
    1EFF Fancy Dress
    ADDITEM $item_a_fancy dress
    1F01 Plain Dress
    ADDITEM $item_a_plain dress
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"clothes  footwear
}

SECTION_MENU ,"pants
{
    Pants
    1516 Skirt
    ADDITEM $item_a_skirt
    152E Short pants
    ADDITEM $item_short pants
    1537 Kilt
    ADDITEM $item_a_kilt
    1539 Long pants
    ADDITEM $item_long pants
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"clothes  footwear
}

SECTION_MENU ,"misc
{
    Misc
    153B Half apron
    ADDITEM $item_a_half apron
    153D Full apron
    ADDITEM $item_a_full apron
    1540 Bandana
    ADDITEM $item_a_bandana
    1541 Body sash
    ADDITEM $item_a_body sash
    1544 Skullcap
    ADDITEM $item_a_skullcap
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"clothes  footwear
}

SECTION_MENU ,"masks
{
    Masks
    1547 Deer mask
    ADDITEM $item_a_deer mask
    1545 Bear mask
    ADDITEM $item_a_bear mask
    1F0B Orc helm
    ADDITEM $item_a_orc helm
    141C Orc mask
    ADDITEM $item_a_orc mask
    1549 Tribal mask
    ADDITEM $item_a_tribal mask
    154B Voodoo mask
    ADDITEM $item_a_tribal mask 1
    1546 Polar bear mask
    ADDITEM $item_polar bear mask
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"clothes  footwear
}

SECTION_MENU ,"food items
{
    Food Items
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"supply_MENU
    099E Bottled Beverages
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"bottled beverages
    09EE Non-Bottled Beverages
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"non-bottled beverages
    09E9 Baked and Veggys
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"baked and veggys
    099E Baked and Veggys 2
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"baked and veggys 2
    1606 Bowls
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"bowls
    09C9 Meat
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"meat
    0993 Fruit
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"fruit
}

SECTION_MENU ,"display case bottom
{
    Display Case Bottom
    0B0F Center
    ADDITEM $item_display case 1
    0B17 North
    ADDITEM $item_display case 1
    0B13 Northeast
    ADDITEM $item_display case 2
    0B14 East
    ADDITEM $item_display case 3
    0B11 Southeast
    ADDITEM $item_display case 4
    0B15 South
    ADDITEM $item_display case 5
    0B12 Southwest
    ADDITEM $item_display case 6
    0B16 West
    ADDITEM $item_display case 7
    0B10 Northwest
    ADDITEM $item_display case 8
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"display cases
}

SECTION_MENU ,"display case top
{
    Display Case Top
    0AA2 North
    ADDITEM $item_display case 9
    0AA4 Northeast
    ADDITEM $item_display case 1
    0A9F East
    ADDITEM $item_display case 2
    0B18 Southeast
    ADDITEM $item_display case 3
    0AA0 South
    ADDITEM $item_display case 4
    0AA5 Southwest
    ADDITEM $item_display case 5
    0AA1 West
    ADDITEM $item_display case 6
    0AA3 Northwest
    ADDITEM $item_display case 7
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"display cases
}

SECTION_MENU ,"trophies
{
    Trophies
    1E60 Trophy
    ADDITEM $item_trophy
    1E61 Trophy
    ADDITEM $item_trophy 1
    1E62 Trophy
    ADDITEM $item_trophy 2
    1E63 Trophy
    ADDITEM $item_trophy 3
    1E64 Trophy
    ADDITEM $item_trophy 4
    1E65 Trophy
    ADDITEM $item_trophy 5
    1E66 Trophy
    ADDITEM $item_trophy 6
    1E67 Trophy
    ADDITEM $item_trophy 7
    1E68 Trophy
    ADDITEM $item_trophy 8
    1E69 Trophy
    ADDITEM $item_trophy 9
    1E6A Trophy
    ADDITEM $item_trophy A
    1E6B Trophy
    ADDITEM $item_trophy B
    1E6C Trophy
    ADDITEM $item_trophy C
    1E6D Trophy
    ADDITEM $item_trophy D
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"interior design
}

SECTION_MENU ,"light sources
{
    Light Sources
    0A0F Hand Light Sources
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"hand lights sources
    0A08 N/S Wall Torch ID
    ADDITEM $item_wall torch
    0A0E E/W Wall Torch ID
    ADDITEM $item_wall torch 1
    0E31 Brazier
    ADDITEM $item_a_brazier
    0B1A Candle
    ADDITEM $item_candle
    0B1D Candelabra
    ADDITEM $item_candelabra
    0B25 Dark LamP_post
    ADDITEM $item_lamP_post 4
    0B23 Fancy Dim Post
    ADDITEM $item_lamP_post 2
    0B22 Fancy Lit Post
    ADDITEM $item_lamP_post 1
    0B24 Lit LamP_Post
    ADDITEM $item_lamP_post 3
    0B20 Standard Lit Post
    ADDITEM $item_lamP_post
    0B21 Standard Off Post
    ADDITEM $item_an_unlit lamppost
    0B26 Tall Candelabra
    ADDITEM $item_a_candelabra
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"decoration
}

SECTION_MENU ,"doors
{
    Doors
    0675 Metal Door 1
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"metal door 1
    0685 Barred Metal Door
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"barred metal door
    084C Iron Gate
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"iron gate
    06C5 Metal Door 2
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"metal door 2
    0695 Rattan Door
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"rattan door
    06A5 Wooden Door 1
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wooden door 1
    06B5 Wooden Door 2
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wooden door 2
    06D5 Wooden Door 3
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wooden door 3
    06E5 Wooden Door 4
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wooden door 4
    0839 Wooden Gate 1
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wooden gate 1
    0866 Wooden Gate 2
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wooden gate 2
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"decoration
}

SECTION_MENU ,"metal door 1
{
    Metal Door 1
    0675 West Door
    ADDITEM $item_a_metal door
    0677 East Door
    ADDITEM $item_a_metal door 1
    067D South Door
    ADDITEM $item_a_metal door 2
    067F North Door
    ADDITEM $item_a_metal door 3
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"doors
}

SECTION_MENU ,"barred metal door
{
    Barred Metal Door
    0685 West Door
    ADDITEM $item_a_barred metal door
    0687 East Door
    ADDITEM $item_barred metal door
    068D South Door
    ADDITEM $item_barred metal door 1
    068F North Door
    ADDITEM $item_barred metal door 2
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"doors
}

SECTION_MENU ,"rattan door
{
    Rattan Door
    0695 West Door
    ADDITEM $item_rattan door
    0697 East Door
    ADDITEM $item_rattan door 1
    069D South Door
    ADDITEM $item_rattan door 2
    069F North Door
    ADDITEM $item_rattan door 3
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"doors
}

SECTION_MENU ,"wooden door 1
{
    Wooden Door 1
    06A5 West Door
    ADDITEM $item_wooden door
    06A7 East Door
    ADDITEM $item_wooden door 1
    06AD South Door
    ADDITEM $item_wooden door 2
    06AF North Door
    ADDITEM $item_wooden door 3
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"doors
}

SECTION_MENU ,"wooden door 2
{
    Wooden Door 2
    06B5 West Door
    ADDITEM $item_wooden door 4
    06B7 East Door
    ADDITEM $item_wooden door 5
    06BD South Door
    ADDITEM $item_wooden door 6
    06BF North Door
    ADDITEM $item_wooden door 7
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"doors
}

SECTION_MENU ,"metal door 2
{
    Metal Door 2
    06C5 West Door
    ADDITEM $item_metal door
    06C7 East Door
    ADDITEM $item_metal door 1
    06CD South Door
    ADDITEM $item_metal door 2
    06CF North Door
    ADDITEM $item_metal door 3
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"doors
}

SECTION_MENU ,"wooden door 3
{
    Wooden Door 3
    06D5 West Door
    ADDITEM $item_wooden door 8
    06D7 East Door
    ADDITEM $item_wooden door 9
    06DD South Door
    ADDITEM $item_wooden door A
    06DF North Door
    ADDITEM $item_wooden door B
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"doors
}

SECTION_MENU ,"wooden door 4
{
    Wooden Door 4
    06E5 West Door
    ADDITEM $item_wooden door C
    06E7 East Door
    ADDITEM $item_wooden door D
    06ED South Door
    ADDITEM $item_wooden door E
    06EF North Door
    ADDITEM $item_wooden door F
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"doors
}

SECTION_MENU ,"wooden gate 1
{
    Wooden Gate 1
    0839 West Door
    ADDITEM $item_wooden gate
    083B East Door
    ADDITEM $item_wooden gate 1
    0841 South Door
    ADDITEM $item_wooden gate 2
    0843 North Door
    ADDITEM $item_wooden gate 3
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"doors
}

SECTION_MENU ,"iron gate
{
    Iron Gate
    084C West Door
    ADDITEM $item_iron gate
    084E East Door
    ADDITEM $item_iron gate 1
    0854 South Door
    ADDITEM $item_iron gate 2
    0856 North Door
    ADDITEM $item_iron gate 3
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"doors
}

SECTION_MENU ,"wooden gate 2
{
    Wooden Gate 2
    0866 West Door
    ADDITEM $item_wooden gate 4
    0868 East Door
    ADDITEM $item_wooden gate 5
    086E South Door
    ADDITEM $item_wooden gate 6
    0870 North Door
    ADDITEM $item_wooden gate 7
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"doors
}

SECTION_MENU ,"npc_MENU
{
    NPC_MENU
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"nox-wizard gm_MENU
    < Quest Npc`s
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"quest npc`s
    < Monsters/Animals
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"monsters 1
    < Merchants/People/Custom Race
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"merchants
    < Chaos/Order Guards
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"chaos
}

SECTION_MENU ,"spawner_MENU
{
    Spawner_MENU
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"nox-wizard gm_MENU
    < Escort Spawners
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"escort spawners
    < Spawning Chest
    ADDITEM $item_a_wooden chest
    < Shopkeeper Spawners 1 (invul)
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"shopkeeper spawners 1 invul 
    < Shopkeeper Spawners 2 (invul)
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"shopkeeper spawners 2 invul 
    < Shopkeeper Spawners 3 (invul)
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"shopkeeper spawner 3 invul 
    < Shopkeeper Spawners 4 (invul)
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"shopkeeper spawners 4 invul 
    < Cocoons and Cocoon Spawner
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"cocoons and cocoon spawner
    < Orc Fort Spawners
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"cove orc fort
    < Other Spawners
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"other spawners
    < Random Spawners
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"random spawners
    < Area Spawners 1
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"area spawners 1
    < Area Spawners 2
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"area spawners 2
    < Regents Spawners
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"regents spawners
}

SECTION_MENU ,"gate_MENU
{
    Gate_MENU
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"nox-wizard gm_MENU
    < Advancement Gates
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"advancement gates
    < Multi Advancement Gates
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"multi advancement gates
    < Monster Gates
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"monster gates
}

SECTION_MENU ,"supply_MENU
{
    Supply_MENU
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"nox-wizard gm_MENU
    < Food Items
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"food items
    < Decoration/Furniture
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"decoration
    < Equipment/Items
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"equipment
}

SECTION_MENU ,"common reagents
{
    
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"reagents
}

SECTION_MENU ,"uncommon reagents
{
    uncommon Reagents
    0F78 Bat Wing
    ADDITEM $item_batwing
    0F79 Blackmoor
    ADDITEM $item_blackmoor
    0F7C Bloodspawn
    ADDITEM $item_bloodspawn
    0F7D Vial of Blood
    ADDITEM $item_vial of blood
    0F7E Bone
    ADDITEM $item_bone
    0F7F Brimstone
    ADDITEM $item_brimstone
    0F80 Daemon Bone
    ADDITEM $item_daemon bone
    0F81 Fertile Dirt
    ADDITEM $item_fertile dirt
    0F82 Dragon Blood
    ADDITEM $item_dragon blood
    0F83 Executioner's Cap
    ADDITEM $item_executioners cap
    0F87 Eye of Newt
    ADDITEM $item_eye of newt
    0F89 Obsidian
    ADDITEM $item_obsidian
    0F8A Pig Iron
    ADDITEM $item_pig iron
    0F8B Pumice
    ADDITEM $item_pumice
    0F8E Serpent Scales
    ADDITEM $item_serpents scale
    0F8F Volcanic Ash
    ADDITEM $item_volcanic ash
    0F90 Dead Wood
    ADDITEM $item_dead wood
    0F91 Worms Heart
    ADDITEM $item_wyrms heart
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"reagents
}

SECTION_MENU ,"boat deeds
{
    Boat Deeds
    < Prev_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"building_MENU
    < Small Boat
    ADDITEM $item_deed small ship
    < Small Dragon Ship
    ADDITEM $item_deed small dragon ship
    < Medium Boat
    ADDITEM $item_deed medium ship
    < Medium Dragon Ship
    ADDITEM $item_deed medium dragon ship
    < Large Boat
    ADDITEM $item_deed large ship
    < Large Dragon Ship
    ADDITEM $item_deed large dragon ship
}


SECTION_MENU ,"old house deeds
{
    Old House Deeds
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"building_MENU
    14F0 Small Stone & Plaster House
    ADDITEM $item_small stone  plaster house deed
    14F0 Small Stone House
    ADDITEM $item_small stone house deed
    14F0 Small Brick House
    ADDITEM $item_small brick house deed
    14F0 Small Wood House
    ADDITEM $item_small wood house deed
    14F0 Small Wood & Plaster House
    ADDITEM $item_small wood  plaster house deed
    14F0 Small Wood House (Straw Roof)
    ADDITEM $item_small wood house with straw roof deed
    14F0 Blue Tent
    ADDITEM $item_blue tent deed
    14F0 Green Tent
    ADDITEM $item_green tent deed
    14F0 3 Room Brick House
    ADDITEM $item_3 room brick house deed
    14F0 2 Story Wood & Plaster House
    ADDITEM $item_2 story wood  plaster house deed
    14F0 2 Story Stone & Plaster House
    ADDITEM $item_2 story stone  plaster house deed
    14F0 Stone Tower
    ADDITEM $item_tower deed
    14F0 Stone Keep
    ADDITEM $item_keeP_deed
    14F0 Castle
    ADDITEM $item_castle deed
    14F0 Large Smithy
    ADDITEM $item_large smithy deed
}

SECTION_MENU ,"misc deeds
{
    Misc Deeds
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"building_MENU
    14F0 Pickpocket Deed (Faceing South)
    ADDITEM $item_a_pickpocket diP_deed facing south 
    14F0 Pickpocket Deed (Faceing East)
    ADDITEM $item_a_pickpocket diP_deed facing east 
    14F0 Training dummy Deed (Faceing South)
    ADDITEM $item_a_training dummy deed facing south 
    14F0 Training dummy Deed (Faceing East)
    ADDITEM $item_a_training dummy deed facing east 
    14F0 Employment Deed
    ADDITEM $item_employment deed
    14F0 Guildstone Deed
    ADDITEM $item_guildstone deed
    14f0 Townstone Deed
    ADDITEM $item_townstone deed
    14f0 Pentagram Deed
    ADDITEM $item_pentagram deed
    1061 Loom-south Deed
    ADDITEM $item_loom-south deed
    105F Loom-east Deed
    ADDITEM $item_loom-east deed
    0937 Fireplace-brick-east Deed
    ADDITEM $item_fireplace-east deed
    0945 Fireplace-brick-south Deed
    ADDITEM $item_fireplace-south deed
    0A5D Bed- east Deed
    ADDITEM $item_pine bed-east deed
    0A63 Bed- south Deed
    ADDITEM $item_pine bed-south deed
    0A63 xmas tree Deed
    ADDITEM $item_christmas tree deed
}

SECTION_MENU ,"magic bows and crossbows
{
    Magic Bows and Crossbows
    13B2 magic bows
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic bows
    0F4F magic crossbows
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic crossbows
    13FD magic heavy crossbows
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic heavy crossbows
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magical weapons
}

SECTION_MENU ,"magic bows
{
    Magic Bows
    13B2 magic bow of ruin
    ADDITEM $item_iron bow of ruin
    13B2 magic bow of might
    ADDITEM $item_iron bow of might
    13B2 magic bow of force
    ADDITEM $item_iron bow of force
    13B2 magic bow of power
    ADDITEM $item_iron bow of power
    13B2 magic bow of vanquishing
    ADDITEM $item_iron bow of vanquishing
    13B2 Dante Deluxe
    ADDITEM 
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic bows and crossbows
}

SECTION_MENU ,"magic crossbows
{
    Magic Crossbows
    0F4F magic crossbow of ruin
    ADDITEM $item_iron crossbow of ruin
    0F4F magic crossbow of might
    ADDITEM $item_iron crossbow of might
    0F4F magic crossbow of force
    ADDITEM $item_iron crossbow of force
    0F4F magic crossbow of power
    ADDITEM $item_iron crossbow of power
    0F4F magic crossbow of vanquishing
    ADDITEM $item_iron crossbow of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic bows and crossbows
}

SECTION_MENU ,"magic heavy crossbows
{
    Magic Heavy Crossbows
    13FD magic heavy crossbow of ruin
    ADDITEM $item_iron heavy crossbow of ruin
    13FD magic heavy crossbow of might
    ADDITEM $item_iron heavy crossbow of might
    13FD magic heavy crossbow of force
    ADDITEM $item_iron heavy crossbow of force
    13FD magic heavy crossbow of power
    ADDITEM $item_iron heavy crossbow of power
    13FD magic heavy crossbow of vanquishing
    ADDITEM $item_iron heavy crossbow of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic bows and crossbows
}

SECTION_MENU ,"walls and blocks
{
    Walls and Blocks
    0034 Brick Walls
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"brick walls
    0423 Palisade Walls
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"palisade walls 
    001C Stone Walls
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"stone walls
    0007 Wooden Walls
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wooden walls
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"architecture
}

SECTION_MENU ,"wooden walls i
{
    Wooden Walls I
    0006 SE Corner
    ADDITEM $item_wooden wall
    0010 SE Corner Small
    ADDITEM $item_wooden wall 7
    0014 SE Corner Really Small
    ADDITEM $item_wooden wall A
    0007 E-W Wall
    ADDITEM $item_wooden wall 1
    000a E-W Wall
    ADDITEM $item_wooden wall 3
    000c E-W Wall
    ADDITEM $item_wooden wall 5
    000e E-W Wall with Window
    ADDITEM $item_window
    0012 E-W Small Wall
    ADDITEM $item_wooden wall 9
    0016 E-W Really Small Wall
    ADDITEM $item_wooden wall C
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wooden walls
}

SECTION_MENU ,"stone walls i
{
    Stone Walls I
    001A SE Corner
    ADDITEM $item_stone wall
    0024 SE Small Corner
    ADDITEM $item_stone wall 8
    002D Really Small SE Corner
    ADDITEM $item_stone wall C
    001C E-W Wall
    ADDITEM $item_stone wall 2
    001E E-W Wall with Wood
    ADDITEM $item_stone wall 4
    0021 E-W Wall with Wood
    ADDITEM $item_stone wall 7
    0022 E-W Wall with Window
    ADDITEM $item_window 2
    002F Really Small E-W Wall
    ADDITEM $item_stone wall E
    0031 Really Small E-W Wall 2
    ADDITEM $item_stone wall G
    0025 E-W Small Wall
    ADDITEM $item_stone wall 9
    001B N-S Wall
    ADDITEM $item_stone wall 1
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"stone walls
}

SECTION_MENU ,"brick walls i
{
    Brick Walls I
    0033 SE Corner
    ADDITEM $item_brick wall
    0034 E-W Wall
    ADDITEM $item_brick wall 1
    0035 N-S Wall
    ADDITEM $item_brick wall 2
    0036 Brick Post
    ADDITEM $item_brick wall 3
    0037 E-W Wall with Wood
    ADDITEM $item_brick wall 4
    0038 N-S Wall with Wood
    ADDITEM $item_brick wall 5
    0039 E-W Wall with Wood
    ADDITEM $item_brick wall 6
    003A N-S Wall with Wood
    ADDITEM $item_brick wall 7
    003B E-W Wall with Window
    ADDITEM $item_window 4
    003C N-S Wall with Window
    ADDITEM $item_window 5
    003D SE Corner Small
    ADDITEM $item_brick wall 8
    003E E-W Wall Small
    ADDITEM $item_brick wall 9
    003F N-S Wall Small
    ADDITEM $item_brick wall A
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"brick walls
}

SECTION_MENU ,"brick walls ii
{
    Brick Walls II
    0040 Small Brick Post
    ADDITEM $item_brick wall B
    0041 SE Corner
    ADDITEM $item_brick wall C
    0042 E-W Wall Really Small
    ADDITEM $item_brick wall D
    0043 N-S Wall Really Small
    ADDITEM $item_brick wall E
    0044 Really Small Post
    ADDITEM $item_brick arch
    0045 SE Corner Arch
    ADDITEM $item_brick arch
    0046 N-S Arch
    ADDITEM $item_brick arch 1
    0047 E-W Arch
    ADDITEM $item_brick arch 2
    0048 E-W Arch
    ADDITEM $item_brick arch 3
    0049 N-S Arch
    ADDITEM $item_brick arch 4
    004A E-W Arched ToP_Wall
    ADDITEM $item_brick wall F
    004B N-S Arched ToP_Wall
    ADDITEM $item_brick wall G
    004C N-S Arched ToP_Wall
    ADDITEM $item_brick wall H
    004D E-W Arched ToP_Wall
    ADDITEM $item_brick wall I
    004E E-W ToP_Arch End
    ADDITEM $item_brick wall J
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"brick walls
}

SECTION_MENU ,"brick walls iii
{
    Brick Walls III
    004F N-S ToP_Arch End
    ADDITEM $item_brick wall K
    0050 E-W ToP_Arch Middle
    ADDITEM $item_brick wall L
    0051 N-S ToP_Arch Middle
    ADDITEM $item_brick wall M
    0052 SE Corner Blocks
    ADDITEM $item_brick wall N
    0053 E-W Blocks
    ADDITEM $item_brick wall O
    0054 N-S Blocks
    ADDITEM $item_brick wall P
    0055 E-W Blocks
    ADDITEM $item_brick wall Q
    0056 N-S Blocks
    ADDITEM $item_brick wall R
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"brick walls
}

SECTION_MENU ,"brick walls
{
    Brick Walls
    0041 Brick Walls I
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"brick walls i
    003B Brick Walls II
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"brick walls ii
    0046 Brick Walls III
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"brick walls iii
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"walls and blocks
}

SECTION_MENU ,"wooden walls ii
{
    Wooden Walls II
    0018 E-W Really Small Wall
    ADDITEM $item_wooden wall D
    0008 N-S Wall
    ADDITEM $item_wooden wall 2
    000b N-S Wall
    ADDITEM $item_wooden wall 4
    000d N-S Wall
    ADDITEM $item_wooden wall 6
    000f N-S Wall with Window
    ADDITEM $item_window 1
    0011 N-S Small Wall
    ADDITEM $item_wooden wall 8
    0015 N-S Really Small Wall
    ADDITEM $item_wooden wall B
    0019 N-S Really Small Wall
    ADDITEM $item_wooden wall E
    0009 Wooden Post
    ADDITEM $item_wooden post
    0013 Wooden Post
    ADDITEM $item_wooden post 1
    0017 Small Corner Post
    ADDITEM $item_wooden post 2
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wooden walls
}

SECTION_MENU ,"wooden walls
{
    Wooden Walls
    000f Wooden Walls I
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wooden walls i
    0016 Wooden Walls II
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wooden walls ii
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"walls and blocks
}

SECTION_MENU ,"stone walls ii
{
    Stone Walls II
    001F N-S Wall with Wood
    ADDITEM $item_stone wall 5
    0020 N-S Wall with Wood
    ADDITEM $item_stone wall 6
    0023 N-S Wall with Window
    ADDITEM $item_window 3
    0026 N-S Small Wall
    ADDITEM $item_stone wall A
    002E Really Small N-S Wall
    ADDITEM $item_stone wall D
    0032 Really Small N-S Wall 2
    ADDITEM $item_stone wall H
    0030 Really Small Stone Post
    ADDITEM $item_stone wall F
    001D Stone Post
    ADDITEM $item_stone wall 3
    0027 Small Stone Post
    ADDITEM $item_stone wall B
    0028 SE Arch
    ADDITEM $item_stone arch
    0029 E-W Arch
    ADDITEM $item_stone arch 1
    002A N-S Arch
    ADDITEM $item_stone arch 2
    002B N-S Arch
    ADDITEM $item_stone arch 3
    002C E-W Arch
    ADDITEM $item_stone arch 4
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"stone walls
}

SECTION_MENU ,"stone walls
{
    Stone Walls
    001D Stone Walls I
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"stone walls i
    0021 Stone Walls II
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"stone walls ii
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"walls and blocks
}

SECTION_MENU ,"walls
{
    Walls
    0229 Corner Pole
    ADDITEM $item_wooden post 3
    0223 Palisade Corner
    ADDITEM $item_palisade B
    0221 Palisade N-S
    ADDITEM $item_palisade B
    0222 Palisade E-W
    ADDITEM $item_palisade B
    0421 Palisade Skull N-S
    ADDITEM $item_palisade 2
    0422 Palisade Skull E-W 1
    ADDITEM $item_palisade 4
    0431 Palisade Skull E-W 2
    ADDITEM $item_palisade 6
    0430 Palisade Skull E-W 3
    ADDITEM $item_palisade 5
    0425 Small Palisade Corner
    ADDITEM $item_palisade
    0424 Small Palisade N-S
    ADDITEM $item_palisade 1
    0423 Small Palisade E-W
    ADDITEM $item_palisade 3
    021E Small Palisade Slant N-S 1
    ADDITEM $item_palisade 7
    0220 Small Palisade Slant N-S 2
    ADDITEM $item_palisade 8
    021D Small Palisade Slant E-W 1
    ADDITEM $item_palisade 9
    021F Small Palisade Slant E-W 2
    ADDITEM $item_palisade A
    0226 Un-spiked Palisade Corner
    ADDITEM $item_wooden wall F
    0227 Un-spiked Palisade N-S
    ADDITEM $item_wooden wall G
    022B Un-spiked Palisade N-S
    ADDITEM $item_wooden wall H
    0228 Un-spiked Palisade E-W
    ADDITEM $item_wooden wall I
    022A Un-spiked Palisade E-W
    ADDITEM $item_wooden wall J
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"palisade walls 
}

SECTION_MENU ,"palisade walls 
{
    Palisade Walls / Blocks
    14F0 Open Faster /gui_addText(menu,PPBTNW + x,y,TXT_COLOR 212
    ADDITEM 
    042A Banners/Curtains/Standards
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"banners
    0432 Walls
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"walls
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"walls and blocks
}

SECTION_MENU ,"banners
{
    Banners/Curtains/Standards
    042A Banner Tattered N-S 1
    ADDITEM $item_tattered banner
    042B Banner Tattered N-S 2
    ADDITEM $item_tattered banner 1
    042E Banner Tattered N-S 3
    ADDITEM $item_tattered banner 2
    042F Banner Tattered N-S 4
    ADDITEM $item_tattered banner 3
    0426 Banner Tattered E-W 1
    ADDITEM $item_tattered banner 4
    0427 Banner Tattered E-W 2
    ADDITEM $item_tattered banner 5
    042C Banner Tattered E-W 3
    ADDITEM $item_tattered banner 6
    042D Banner Tattered E-W 4
    ADDITEM $item_tattered banner 7
    0432 Curtain N-S 1
    ADDITEM $item_curtain
    022F Curtain N-S 2
    ADDITEM $item_door 1
    022E Curtain S-N
    ADDITEM $item_door
    0433 Curtain Rod N-S
    ADDITEM $item_curtain rod
    0435 Curtain E-W 1
    ADDITEM $item_curtain 1
    022C Curtain E-W 2
    ADDITEM $item_door 2
    022D Curtain W-E
    ADDITEM $item_door 3
    0434 Curtain Rod E-W
    ADDITEM $item_curtain rod 1
    0420 Standard Shield N-S
    ADDITEM $item_gruesome standard
    0429 Standard Shield E-W
    ADDITEM $item_gruesome standard 1
    041F Standard Skull N-S
    ADDITEM $item_gruesome standard 2
    0428 Standard Skull E-W
    ADDITEM $item_gruesome standard 3
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"palisade walls 
}

SECTION_MENU ,"fruit
{
    Fruit
    0994 Pear
    ADDITEM $item_pears
    09D0 Apple
    ADDITEM $item_apples
    09D1 Grape Bunch
    ADDITEM $item_grape bunches
    09D2 Peach
    ADDITEM $item_peaches
    0993 Fruit Basket
    ADDITEM $item_fruit basket
    1726 Coconut
    ADDITEM $item_coconuts
    1720 Banana
    ADDITEM $item_banana
    1721 Bananas
    ADDITEM $item_banana
    1727 Dates
    ADDITEM $item_bunches of dates
    1728 Lemon
    ADDITEM $item_lemons
    1729 Lemons
    ADDITEM $item_lemons 1
    172A Lime
    ADDITEM $item_limes
    172B Limes
    ADDITEM $item_limes 1
    0C74 Honeydew Melon
    ADDITEM $item_honeydew melons1
    0C79 Canteloupe
    ADDITEM $item_canteloupes
    0C5D Water Melon
    ADDITEM $item_watermelons
    0F36 Sheaf of Hay
    ADDITEM $item_sheaf of hay1
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"food items
}

SECTION_MENU ,"magic swords
{
    Magic Swords
    13B8 magic longswords
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic longswords
    13BA magic viking swords
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic viking swords
    0F5E magic broad swords
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic broad swords
    13B6 magic scimitar
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic scimitars
    1440 magic cutlasses
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic cutlass
    13FF magic katana
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic katanas
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magical weapons
}

SECTION_MENU ,"magic longswords
{
    Magic Longswords
    13b8 magic longsword of ruin
    ADDITEM $item_iron long sword of ruin
    13b8 magic longsword of might
    ADDITEM $item_iron long sword of might
    13b8 magic longsword of force
    ADDITEM $item_iron long sword of force
    13b8 magic longsword of power
    ADDITEM $item_iron long sword of power
    13b8 magic longsword of vanquishing
    ADDITEM $item_iron long sword of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic swords
}

SECTION_MENU ,"magic viking swords
{
    Magic Viking Swords
    13BA magic viking sword of ruin
    ADDITEM $item_iron viking sword of ruin
    13BA magic viking sword of might
    ADDITEM $item_iron viking sword of might
    13BA magic viking sword of force
    ADDITEM $item_iron viking sword of force
    13BA magic viking sword of power
    ADDITEM $item_iron viking sword of power
    13BA magic viking sword of vanquishing
    ADDITEM $item_iron viking sword of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic swords
}

SECTION_MENU ,"magic broad swords
{
    Magic Broad Swords
    0F5E magic broad sword of ruin
    ADDITEM $item_iron broad sword of ruin
    0F5E magic broad sword of might
    ADDITEM $item_iron broad sword of might
    0F5E magic broad sword of force
    ADDITEM $item_iron broad sword of force
    0F5E magic broad sword of power
    ADDITEM $item_iron broad sword of power
    0F5E magic broad sword of vanquishing
    ADDITEM $item_iron broad sword of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic swords
}

SECTION_MENU ,"magic scimitars
{
    Magic Scimitars
    13B6 magic scimitar of ruin
    ADDITEM $item_iron scimitar of ruin
    13B6 magic scimitar of might
    ADDITEM $item_iron scimitar of might
    13B6 magic scimitar of force
    ADDITEM $item_iron scimitar of force
    13B6 magic scimitar of power
    ADDITEM $item_iron scimitar of power
    13B6 magic scimitar of vanquishing
    ADDITEM $item_iron scimitar of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic swords
}

SECTION_MENU ,"magic cutlass
{
    Magic Cutlass
    1440 magic cutlass of ruin
    ADDITEM $item_iron cutlass of ruin
    1440 magic cutlass of might
    ADDITEM $item_iron cutlass of might
    1440 magic cutlass of force
    ADDITEM $item_iron cutlass of force
    1440 magic cutlass of power
    ADDITEM $item_iron cutlass of power
    1440 magic cutlass of vanquishing
    ADDITEM $item_iron cutlass of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic swords
}

SECTION_MENU ,"magic katanas
{
    Magic Katanas
    13FF magic katana of ruin
    ADDITEM $item_iron katana of ruin
    13FF magic katana of might
    ADDITEM $item_iron katana of might
    13FF magic katana of force
    ADDITEM $item_iron katana of force
    13FF magic katana of power
    ADDITEM $item_iron katana of power
    13FF magic katana of vanquishing
    ADDITEM $item_iron katana of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic swords
}

SECTION_MENU ,"magic axes
{
    Magic Axes
    0F47 magic hatchets
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic hatchets
    0F45 magic executionner's axes
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic executionners axes
    0F49 magic axes
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic axes 1
    0F4B magic double axes
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic double axes
    13FB magic large battle axes
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic large battle axes
    0E85 magic pick axes
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic pick axes
    13B0 magic war axes
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic war axes
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magical weapons
}

SECTION_MENU ,"magic hatchets
{
    Magic Hatchets
    0F47 magic hatchets of ruin
    ADDITEM $item_iron hatchet of ruin
    0F47 magic hatchets of might
    ADDITEM $item_iron hatchet of might
    0F47 magic hatchets of force
    ADDITEM $item_iron hatchet of force
    0F47 magic hatchets of power
    ADDITEM $item_iron hatchet of power
    0F47 magic hatchets of vanquishing
    ADDITEM $item_iron hatchet of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic axes
}

SECTION_MENU ,"magic executionners axes
{
    Magic Executionner's Axes
    0F45 magic executionner's axe of ruin
    ADDITEM $item_iron executionners axe of ruin
    0F45 magic executionner's axe of might
    ADDITEM $item_iron executionners axe of might
    0F45 magic executionner's axe of force
    ADDITEM $item_iron executionners axe of force
    0F45 magic executionner's axe of power
    ADDITEM $item_iron executionners axe of power
    0F45 magic executionner's axe of vanquishing
    ADDITEM $item_iron executionners axe of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic axes
}

SECTION_MENU ,"magic axes 1
{
    Magic Axes
    0F49 magic axe of ruin
    ADDITEM $item_iron axe of ruin
    0F49 magic axe of might
    ADDITEM $item_iron axe of might
    0F49 magic axe of force
    ADDITEM $item_iron axe of force
    0F49 magic axe of power
    ADDITEM $item_iron axe of power
    0F49 magic axe of vanquishing
    ADDITEM $item_iron axe of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic axes
}

SECTION_MENU ,"magic double axes
{
    Magic Double Axes
    0F4B magic double axe of ruin
    ADDITEM $item_iron double axe of ruin
    0F4B magic double axe of might
    ADDITEM $item_iron double axe of might
    0F4B magic double axe of force
    ADDITEM $item_iron double axe of force
    0F4B magic double axe of power
    ADDITEM $item_iron double axe of power
    0F4B magic double axe of vanquishing
    ADDITEM $item_iron double axe of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic axes
}

SECTION_MENU ,"magic large battle axes
{
    Magic Large Battle Axes
    13FB magic large battle axe of ruin
    ADDITEM $item_iron large battle axe of ruin
    13FB magic large battle axe of might
    ADDITEM $item_iron large battle axe of might
    13FB magic large battle axe of force
    ADDITEM $item_iron large battle axe of force
    13FB magic large battle axe of power
    ADDITEM $item_iron large battle axe of power
    13FB magic large battle axe of vanquishing
    ADDITEM $item_iron large battle axe of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic axes
}

SECTION_MENU ,"magic pick axes
{
    Magic Pick Axes
    0E85 magic pick axe of ruin
    ADDITEM $item_iron pick axe of ruin
    0E85 magic pick axe of might
    ADDITEM $item_iron pick axe of might
    0E85 magic pick axe of force
    ADDITEM $item_iron pick axe of force
    0E85 magic pick axe of power
    ADDITEM $item_iron pick axe of power
    0E85 magic pick axe of vanquishing
    ADDITEM $item_iron pick axe of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic axes
}

SECTION_MENU ,"magic war axes
{
    Magic War Axes
    13B0 magic war axe of ruin
    ADDITEM $item_iron war axe of ruin
    13B0 magic war axe of might
    ADDITEM $item_iron war axe of might
    13B0 magic war axe of force
    ADDITEM $item_iron war axe of force
    13B0 magic war axe of power
    ADDITEM $item_iron war axe of power
    13B0 magic war axe of vanquishing
    ADDITEM $item_iron war axe of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic axes
}

SECTION_MENU ,"magic knives  daggers
{
    Magic Knives & Daggers
    13F7 magic butcher's knives
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic butchers knives
    0EC4 magic skinning knives
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic skinning knives
    0EC2 magic cleavers
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic cleavers
    0F51 magic daggers
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic daggers
    1400 magic kryss
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic kryss
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magical weapons
}

SECTION_MENU ,"magic butchers knives
{
    Magic Butcher's Knives
    13F7 magic butcher knife of ruin
    ADDITEM $item_iron butcher knife of ruin
    13F7 magic butcher knife of might
    ADDITEM $item_iron butcher knife of might
    13F7 magic butcher knife of force
    ADDITEM $item_iron butcher knife of force
    13F7 magic butcher knife of power
    ADDITEM $item_iron butcher knife of power
    13F7 magic butcher knife of vanquishing
    ADDITEM $item_iron butcher knife of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic knives  daggers
}

SECTION_MENU ,"magic skinning knives
{
    Magic Skinning Knives
    0EC4 magic skinning knife of ruin
    ADDITEM $item_iron skinning knife of ruin
    0EC4 magic skinning knife of might
    ADDITEM $item_iron skinning knife of might
    0EC4 magic skinning knife of force
    ADDITEM $item_iron skinning knife of force
    0EC4 magic skinning knife of power
    ADDITEM $item_iron skinning knife of power
    0EC4 magic skinning knife of vanquishing
    ADDITEM $item_iron skinning knife of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic knives  daggers
}

SECTION_MENU ,"magic cleavers
{
    Magic Cleavers
    0EC2 magic cleaver of ruin
    ADDITEM $item_iron cleaver of ruin
    0EC2 magic cleaver of might
    ADDITEM $item_iron cleaver of might
    0EC2 magic cleaver of force
    ADDITEM $item_iron cleaver of force
    0EC2 magic cleaver of power
    ADDITEM $item_iron cleaver of power
    0EC2 magic cleaver of vanquishing
    ADDITEM $item_iron cleaver of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic knives  daggers
}

SECTION_MENU ,"magic plate mail
{
    Magic Plate Mail
    1416 Plate of Defence
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"plate mail of defence
    1416 Plate of Guarding
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"plate mail of guarding
    1416 Plate of Hardening
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"plate mail of hardening
    1416 Plate of Fortification
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"plate mail of fortification
    1416 Plate of Invulnerability
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"plate mail of invulnerability
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic armor
}

SECTION_MENU ,"magic chain mail
{
    Magic Chain Mail
    13C4 Chain of Defence
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"chain of defence
    13C4 Chain of Guarding
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic chain of guarding
    13C4 Chain of Hardening
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic chain of hardening
    13C4 Chain of Fortification
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic chain of fortification
    13C4 Chain of Invulnerability
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic chain of invulnerability
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic armor
}

SECTION_MENU ,"plate mail of defence
{
    Plate Mail of Defence
    1416 Breastplate
    ADDITEM $item_iron platemail of defence
    1c04 Female Plate
    ADDITEM $item_iron plate of defense
    1413 Plate Gorget
    ADDITEM $item_iron plate gorget of defence
    1414 Plate Gloves
    ADDITEM $item_iron plate gloves of defence
    1412 Plate Helm
    ADDITEM $item_iron plate helm of defence
    141A Plate Legs
    ADDITEM $item_iron plate leggings of defence
    1410 Plate Sleeves
    ADDITEM $item_iron plate sleeves of defence
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic plate mail
}

SECTION_MENU ,"plate mail of guarding
{
    Plate Mail of Guarding
    1416 Breastplate
    ADDITEM $item_iron platemail of guarding
    1c04 Female Plate
    ADDITEM $item_iron plate of guarding
    1413 Plate Gorget
    ADDITEM $item_iron plate gorget of guarding
    1414 Plate Gloves
    ADDITEM $item_iron plate gloves of guarding
    1412 Plate Helm
    ADDITEM $item_iron plate helm of guarding
    141A Plate Legs
    ADDITEM $item_iron plate leggings of guarding
    1410 Plate Sleeves
    ADDITEM $item_iron plate sleeves of guarding
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic plate mail
}

SECTION_MENU ,"plate mail of hardening
{
    Plate Mail of Hardening
    1416 Breastplate
    ADDITEM $item_iron plate of hardening
    1c04 Female Plate
    ADDITEM $item_iron plate of hardening
    1413 Plate Gorget
    ADDITEM $item_iron plate gorget of hardening
    1414 Plate Gloves
    ADDITEM $item_iron plate gloves of hardening
    1412 Plate Helm
    ADDITEM $item_iron plate helm of hardening
    141A Plate Legs
    ADDITEM $item_iron plate leggings of hardening
    1410 Plate Sleeves
    ADDITEM $item_iron plate sleeves of hardening
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic plate mail
}

SECTION_MENU ,"plate mail of fortification
{
    Plate Mail of Fortification
    1416 Breastplate
    ADDITEM $item_iron platemail of fortification
    1c04 Female Plate
    ADDITEM $item_iron plate of fortification
    1413 Plate Gorget
    ADDITEM $item_iron plate gorget of fortification
    1414 Plate Gloves
    ADDITEM $item_iron plate gloves of fortification
    1412 Plate Helm
    ADDITEM $item_iron plate helm of fortification
    141A Plate Legs
    ADDITEM $item_iron plate leggings of fortification
    1410 Plate Sleeves
    ADDITEM $item_iron plate sleeves of fortification
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic plate mail
}

SECTION_MENU ,"plate mail of invulnerability
{
    Plate Mail of Invulnerability
    1416 Breastplate
    ADDITEM $item_iron platemail of invulnerability
    1c04 Female Plate
    ADDITEM $item_iron plate of invulnerability
    1413 Plate Gorget
    ADDITEM $item_iron plate gorget of invulnerability
    1414 Plate Gloves
    ADDITEM $item_iron plate gloves of invulnerability
    1412 Plate Helm
    ADDITEM $item_iron plate helm of invulnerability
    141A Plate Legs
    ADDITEM $item_iron plate leggings of invulnerability
    1410 Plate Sleeves
    ADDITEM $item_iron plate sleeves of invulnerability
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic plate mail
}

SECTION_MENU ,"carpentry items
{
    Carpentry Items
    10E4 Draw Knife
    ADDITEM $item_draw knife
    1028 Dovetail Saw
    ADDITEM $item_dovetail saw
    1034 Saw
    ADDITEM $item_saw
    102A Carpenter's Hammer
    ADDITEM $item_hammer
    1030 Jointing Plane
    ADDITEM $item_jointing plane
    1032 Smoothing Plane
    ADDITEM $item_smoothing plane
    10E7 Scorp
    ADDITEM $item_scorp
    10E6 Inshave
    ADDITEM $item_inshave
    102C Moulding Plane
    ADDITEM $item_moulding planes
    102E Nails
    ADDITEM $item_nails
    10E5 Froe
    ADDITEM $item_froe
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"skills related_MENU
}

SECTION_MENU ,"magic spears  forks
{
    Magic Spears & Forks
    0E87 magic pitch forks
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic pitch forks
    0F62 magic spears
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic spears
    1405 magic war forks
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic war forks
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magical weapons
}

SECTION_MENU ,"magic pitch forks
{
    Magic Pitch Forks
    0E87 magic pitch fork of ruin
    ADDITEM $item_iron pitch fork of ruin
    0E87 magic pitch fork of might
    ADDITEM $item_iron pitch fork of might
    0E87 magic pitch fork of force
    ADDITEM $item_iron pitch fork of force
    0E87 magic pitch fork of power
    ADDITEM $item_iron pitch fork of power
    0E87 magic pitch fork of vanquishing
    ADDITEM $item_iron pitch fork of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic spears  forks
}

SECTION_MENU ,"magic spears
{
    Magic Spears
    0F62 magic spear of ruin
    ADDITEM $item_iron spear of ruin
    0F62 magic spear of might
    ADDITEM $item_iron spear of might
    0F62 magic spear of force
    ADDITEM $item_iron spear of force
    0F62 magic spear of power
    ADDITEM $item_iron spear of power
    0F62 magic spear of vanquishing
    ADDITEM $item_iron spear of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic spears  forks
}

SECTION_MENU ,"magic war forks
{
    Magic War Forks
    1405 magic war fork of ruin
    ADDITEM $item_iron war fork of ruin
    1405 magic war fork of might
    ADDITEM $item_iron war fork of might
    1405 magic war fork of force
    ADDITEM $item_iron war fork of force
    1405 magic war fork of power
    ADDITEM $item_iron war fork of power
    1405 magic war fork of vanquishing
    ADDITEM $item_iron war fork of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic spears  forks
}

SECTION_MENU ,"magic pole arms
{
    Magic Pole Arms
    0F4D magic bardiches
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic bardiches
    143E magic halberds
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic halberds
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magical weapons
}

SECTION_MENU ,"magic bardiches
{
    Magic Bardiches
    0F4D magic bardiche of ruin
    ADDITEM $item_iron bardiche of ruin
    0F4D magic bardiche of might
    ADDITEM $item_iron bardiche of might
    0F4D magic bardiche of force
    ADDITEM $item_iron bardiche of force
    0F4D magic bardiche of power
    ADDITEM $item_iron bardiche of power
    0F4D magic bardiche of vanquishing
    ADDITEM $item_iron bardiche of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic pole arms
}

SECTION_MENU ,"magic halberds
{
    Magic Halberds
    143E magic halberd of ruin
    ADDITEM $item_iron halberd of ruin
    143E magic halberd of might
    ADDITEM $item_iron halberd of might
    143E magic halberd of force
    ADDITEM $item_iron halberd of force
    143E magic halberd of power
    ADDITEM $item_iron halberd of power
    143E magic halberd of vanquishing
    ADDITEM $item_iron halberd of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic pole arms
}

SECTION_MENU ,"magic maces and hammers
{
    Magic Maces and Hammers
    13B4 magic clubs
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic clubs
    143C magic hammer picks
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic hammer picks
    0F5C magic maces
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic maces
    143A magic mauls
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic mauls
    13E4 magic smith's hammers
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic smiths hammers
    1438 magic war hammers
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic war hammers
    1406 magic war maces
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic war maces
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magical weapons
}

SECTION_MENU ,"magic clubs
{
    Magic Clubs
    13B4 magic club of ruin
    ADDITEM $item_iron club of ruin
    13B4 magic club of might
    ADDITEM $item_iron club of might
    13B4 magic club of force
    ADDITEM $item_iron club of force
    13B4 magic club of power
    ADDITEM $item_iron club of power
    13B4 magic club of vanquishing
    ADDITEM $item_iron club of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic maces and hammers
}

SECTION_MENU ,"magic hammer picks
{
    Magic Hammer Picks
    143C magic hammer pick of ruin
    ADDITEM $item_iron hammer pick of ruin
    143C magic hammer pick of might
    ADDITEM $item_iron hammer pick of might
    143C magic hammer pick of force
    ADDITEM $item_iron hammer pick of force
    143C magic hammer pick of power
    ADDITEM $item_iron hammer pick of power
    143C magic hammer pick of vanquishing
    ADDITEM $item_iron hammer pick of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic maces and hammers
}

SECTION_MENU ,"magic maces
{
    Magic Maces
    0F5C magic mace of ruin
    ADDITEM $item_iron mace of ruin
    0F5C magic mace of might
    ADDITEM $item_iron mace of might
    0F5C magic mace of force
    ADDITEM $item_iron mace of force
    0F5C magic mace of power
    ADDITEM $item_iron mace of power
    0F5C magic mace of vanquishing
    ADDITEM $item_iron mace of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic maces and hammers
}

SECTION_MENU ,"magic mauls
{
    Magic Mauls
    143A magic maul of ruin
    ADDITEM $item_iron maul of ruin
    143A magic maul of might
    ADDITEM $item_iron maul of might
    143A magic maul of force
    ADDITEM $item_iron maul of force
    143A magic maul of power
    ADDITEM $item_iron maul of power
    143A magic maul of vanquishing
    ADDITEM $item_iron maul of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic maces and hammers
}

SECTION_MENU ,"magic smiths hammers
{
    Magic Smith's Hammers
    13E4 magic smith's hammer of ruin
    ADDITEM $item_iron smiths hammer of ruin
    13E4 magic smith's hammer of might
    ADDITEM $item_iron smiths hammer of might
    13E4 magic smith's hammer of force
    ADDITEM $item_iron smiths hammer of force
    13E4 magic smith's hammer of power
    ADDITEM $item_iron smiths hammer of power
    13E4 magic smith's hammer of vanquishing
    ADDITEM $item_iron smiths hammer of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic maces and hammers
}

SECTION_MENU ,"magic war hammers
{
    Magic War Hammers
    1438 magic war hammer of ruin
    ADDITEM $item_iron war hammer of ruin
    1438 magic war hammer of might
    ADDITEM $item_iron war hammer of might
    1438 magic war hammer of force
    ADDITEM $item_iron war hammer of force
    1438 magic war hammer of power
    ADDITEM $item_iron war hammer of power
    1438 magic war hammer of vanquishing
    ADDITEM $item_iron war hammer of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic maces and hammers
}

SECTION_MENU ,"magic war maces
{
    Magic War Maces
    1406 magic war mace of ruin
    ADDITEM $item_iron war mace of ruin
    1406 magic war mace of might
    ADDITEM $item_iron war mace of might
    1406 magic war mace of force
    ADDITEM $item_iron war mace of force
    1406 magic war mace of power
    ADDITEM $item_iron war mace of power
    1406 magic war mace of vanquishing
    ADDITEM $item_iron war mace of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic maces and hammers
}

SECTION_MENU ,"first circle scrolls
{
    First Circle Scrolls
    1F2D Reactive Armor Scroll
    ADDITEM $item_a_reactive armor scroll
    1F2E Clumsy Scroll
    ADDITEM $item_a_clumsy scroll
    1F2F Create Food Scroll
    ADDITEM $item_a_create food scroll
    1F30 Feeblemind Scroll
    ADDITEM $item_a_feeblemind scroll
    1F31 Heal Scroll
    ADDITEM $item_a_heal scroll
    1F32 Magic Arrow Scroll
    ADDITEM $item_magic arrow scroll
    1F33 Night Sight Scroll
    ADDITEM $item_a_night sight scroll
    1F34 Weaken Scroll
    ADDITEM $item_a_weaken scroll
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic
}

SECTION_MENU ,"rugs
{
    Rugs
    0AA9 Red Rug
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"red rug
    0AB3 Greenish Rug
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"greenish rug
    0ABD Fancy Blue Rug
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"fancy blue rug
    0AC6 Fancy Red Rug
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"fancy red rug
    0AD1 Fancy Blue/Gold Rug
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"fancy blue
    0ADA Fancy Gold Rug
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"fancy golden rug
    0AEB Fancy Pink Rug
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"fancy pink rug
    0AEC Fancy Pink/Blue Rug
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"fancy pink  blue rug
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"interior design
}







SECTION_MENU ,"people - male - h-z
{
    People - Male - H-Z
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"nox-wizard gm_MENU
    2011 Jailor
    NPC $npc jailor m
    2106 Mondain
    NPC $npc mondain
    2009 Noble
    NPC $npc noble m
    < a Necromancer Mage
    NPC $npc archmage
    2008 Peasant
    NPC $npc peasant m
    2015 Pirate
    NPC $npc pirate m
    < PK
    NPC $npc murderer
    < PK Mage
    NPC $npc akbaar
    < PK Archer
    NPC $npc kindor aedrat
    2017 Sailor
    NPC $npc sailor m
    2106 Seeker of Adventure
    NPC $npc adventurer m
    2018 Shipwright
    NPC $npc shipwright m
    201C Thief
    NPC $npc thief m
    2026 Town Crier
    NPC $npc towncrier m
    2037 Veterinarian
    NPC $npc veterinarian m
}

SECTION_MENU ,"merchants - females - h-z
{
    Merchants - Females - H-Z
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"merchants
    200F Healer (wandering)
    NPC $npc wandering healer f
    200F Healer
    NPC $npc healer f
    2034 Herbalist
    NPC $npc herbalist f
    2010 Innkeeper
    NPC $npc innkeeper f
    2012 Jeweler
    NPC $npc jeweler f
    2013 Leather Worker
    NPC $npc leather worker f
    2014 Mage
    NPC $npc mage f
    202D Miner
    NPC $npc miner f
    2016 Provisoner
    NPC $npc provisioner f
    201A Spinner
    NPC $npc spinner f
    2019 Tailor
    NPC $npc tailor f
    2021 Tinker
    NPC $npc tinker f
    < Veterinarian
    NPC
    201F Weaponsmith
    NPC $npc weaponsmith f
}

SECTION_MENU ,"merchants - males - h-z
{
    Merchants - Males - H-Z
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"merchants
    200F Healer (wandering)
    NPC $npc wandering healer m
    200F Healer
    NPC $npc healer m
    2034 Herbalist
    NPC $npc herbalist m
    2010 Innkeeper
    NPC $npc innkeeper m
    2012 Jeweler
    NPC $npc jeweler m
    2013 Leather Worker
    NPC $npc leather worker m
    2014 Mage
    NPC $npc mage m
    202D Miner
    NPC $npc miner m
    < Necromancer
    NPC $npc necromancer
    2016 Provisioner
    NPC $npc provisioner m
    201A Spinner
    NPC $npc spinner m
    2019 Tailor
    NPC $npc tailor m
    2021 Tinker
    NPC $npc tinker m
    < Veterinarian
    NPC $npc veterinarian m
    201F Weaponsmith
    NPC $npc weaponsmith m
}

SECTION_MENU ,"shoP_signs 2
{
    ShoP_Signs 2
    0BAD Magic
    ADDITEM $item_magic shop
    0BAE Magic
    ADDITEM $item_magic shoP_1
    0BAF Carpenter
    ADDITEM $item_carpenter
    0BB0 Carpenter
    ADDITEM $item_carpenter 1
    0BB1 Shipwright
    ADDITEM $item_shipwright
    0BB2 Shipwright
    ADDITEM $item_shipwright 1
    0BB3 Inn
    ADDITEM $item_inn
    0BB4 Inn
    ADDITEM $item_inn 1
    0BB5 Harbor Master
    ADDITEM $item_harbor master
    0BB6 Harbor Master
    ADDITEM $item_harbor master 1
    0BB7 Stables
    ADDITEM $item_stables
    0BB8 Stables
    ADDITEM $item_stables 1
    0BB9 Barber
    ADDITEM $item_barber
    0BBA Barber
    ADDITEM $item_barber 1
    0BD1 Plain
    ADDITEM $item_brass sign 2
    0BD2 Plain
    ADDITEM $item_brass sign 3
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"signs
}

SECTION_MENU ,"people
{
    People
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"merchants
    < Deacon Jones (for Quest)
    NPC
    2106 People - Males - A-G
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"people - males - a-g
    2106 People - Males - H-Z
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"people - male - h-z
    2107 People - Female - A-G
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"people - female - a-g
    2107 People - Female - H-Z
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"people - female - h-z
}

SECTION_MENU ,"shoP_signs 4
{
    ShoP_Signs 4
    0BC9 Artist
    ADDITEM $item_artist
    0BCA Artist
    ADDITEM $item_artist 1
    0BCB Provisioner
    ADDITEM $item_provisioner
    0BCC Provisioner
    ADDITEM $item_provisioner 1
    0BCD Bowyer
    ADDITEM $item_bowyer
    0BCE Bowyer
    ADDITEM $item_bowyer 1
    0C0B Bank
    ADDITEM $item_bank
    0C0C Bank
    ADDITEM $item_bank 1
    0C0D Theater
    ADDITEM $item_theater
    0C0E Theater
    ADDITEM $item_theater 1
    0C43 Beekeeper
    ADDITEM $item_beekeeper
    0C44 Beekeeper
    ADDITEM $item_beekeeper 1
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"signs
}

// ***********************************************************************
// * SECTION_MENU 530 531 and 532 FOR SHARD SPECIFIC ITEMS !!!!!!!              *
// ***********************************************************************
SECTION_MENU ,"shard specific_MENU
{
    Shard Specific_MENU
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"nox-wizard gm_MENU
    0edc Shard_MENU I
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"shard_MENU i
    0edc Shard_MENU II
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"shard_MENU ii
}

SECTION_MENU ,"shard_MENU i
{
    Shard_MENU I
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"shard specific_MENU
}

SECTION_MENU ,"shard_MENU ii
{
    Shard_MENU II
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"shard specific_MENU
}

SECTION_MENU ,"magic armor
{
    Magic Armor
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
    1416 Magic Plate Mail
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic plate mail
    13C4 Magic Chain Mail
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic chain mail
}

SECTION_MENU ,"magical weapons
{
    Magical Weapons
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
    13FD Magical Bows
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic bows and crossbows
    13BA Magical Swords
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic swords
    0F47 Magical Axes
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic axes
    0EC4 Magical Knives & Daggers
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic knives  daggers
    0F5C Magical Maces & Hammers
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic maces and hammers
    1405 Magical Spears & Forks
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic spears  forks
    1563 Magical Pole Arms
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic pole arms
}

SECTION_MENU ,"unique items
{
    Unique Items
    1086 Bracelet of Crom
    ADDITEM 
    1B76 Dragon's Shield
    ADDITEM 
    140E Falcon's Helmet
    ADDITEM 
    143E Lizard Killer
    ADDITEM 
    1B7B Orcish Shield
    ADDITEM 
    0F2B Shiva's Rubi
    ADDITEM 
    13B8 Sword of Heavens
    ADDITEM 
    1F03 Undead's Robe
    ADDITEM 
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"equipment
}

SECTION_MENU ,"jail cells
{
    Jail Cells
    <- Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"gm locations
    <- Jail Cell 1
    GOPLACE 1
    <- Jail Cell 2
    GOPLACE 2
    <- Jail Cell 3
    GOPLACE 3
    <- Jail Cell 4
    GOPLACE 4
    <- Jail Cell 5
    GOPLACE 5
    <- Jail Cell 6
    GOPLACE 6
    <- Jail Cell 7
    GOPLACE 7
    <- Jail Cell 8
    GOPLACE 8
    <- Jail Cell 9
    GOPLACE 9
    <- Jail Cell 10
    GOPLACE 10
}

SECTION_MENU ,"architecture
{
    Architecture
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"decoration
    01D3 Walls and Blocks
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"walls and blocks
    049B Floor Tiles
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"floor tiles
}

SECTION_MENU ,"monsters 1
{
    Monsters/Animals
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"npc_MENU
    20D1 Animals
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"animals 1
    2134 T2A Monsters
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"t2a monster_MENU
    20D3 Deamon/Elementals
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"deamon
    20E0 Orc Kin
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"orc kin
    20E4 Other Monsters A-L
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"other monsters a-l
    20E4 Other Monsters M-Z
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"other monsters m-z
    20F8 Undead Mythical
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"undead mythical
    20D3 Unique Other Monsters
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"unique other monsters
    2109 New Undead Creatures
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"new undead creatures
    20E8 IceFrost and Stone
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"icefrost and stone
    20D7 Colored Elementals
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"colored elementals
    20D6 Dragon-Kin
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"dragon-kin
    < New Monsters
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"new monsters
}

SECTION_MENU ,"animals 1
{
    Animals
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"nox-wizard gm_MENU
    2120 Animals I
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"animals i
    20D1 Animals II
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"animals ii
}

SECTION_MENU ,"merchants - males - a-g
{
    Merchants - Males - A-G
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"merchants
    2023 Alchemist
    NPC $npc alchemist m
    2035 Animal Trainer
    NPC $npc animal trainer m
    2031 Architect
    NPC $npc architect m
    200A Armorer
    NPC $npc armorer m
    200B Baker
    NPC $npc baker m
    0C0B Banker
    NPC $npc banker m
    2106 Bard
    NPC $npc bard m
    < The BeeKeeper
    NPC $npc beekeeper m
    2106 Blacksmith
    NPC $npc blacksmith m
    200C Bowyer
    NPC $npc bowyer m
    200D Butcher
    NPC $npc butcher m
    2020 Carpenter
    NPC $npc carpenter m
    202A Cobbler
    NPC $npc cobbler m
    0190 Cook
    NPC $npc cook m
    < the Engineer
    NPC $npc que 1
    2022 Farmer
    NPC $npc farmer m
    8414 Fisherman
    NPC $npc fisherman
}

SECTION_MENU ,"interior design
{
    Interior Design
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"decoration
    0A2C Furnitures
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"furnitures
    1E60 Trophies
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"trophies
    0AA9 Rugs
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"rugs
}

SECTION_MENU ,"merchants - females - a-g
{
    Merchants - Females - A-G
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"merchants
    2023 Alchemist
    NPC $npc alchemist f
    2036 Animal Trainer
    NPC $npc animal trainer f
    2031 Architect
    NPC $npc architect f
    200A Armorer
    NPC $npc armorer f
    200B Baker
    NPC $npc baker f
    2107 Banker
    NPC $npc banker f
    2107 Bard
    NPC $npc bard f
    < The Beekeeper
    NPC $npc beekeper f
    2107 Blacksmith
    NPC $npc blacksmith f
    200C Bowyer
    NPC $npc bowyer f
    200D Butcher
    NPC $npc butcher f
    2020 Carpenter
    NPC $npc carpenter f
    202A Cobbler
    NPC $npc cobbler f
    0191 Cook
    NPC $npc cook f
    < the Engineer
    NPC $npc jessie
    2024 Farmer
    NPC $npc farmer f
    8415 Fisherlady
    NPC $npc fisherlady
}

SECTION_MENU ,"furnitures
{
    Furnitures
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"interior design
    0A2C Cabinets
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"cabinets
    0A2A Places to sit
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"places to sit
    0B0A Display Cases
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"display cases
    1DAB Tables
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"tables
}

SECTION_MENU ,"hand lights sources
{
    Hand Lights Sources
    0A15 Lantern
    ADDITEM $item_lantern
    0A12 Torch
    ADDITEM $item_torch
    0A0F Candle
    ADDITEM $item_candle 3
    1854 Skull candle
    ADDITEM $item_skull candle
    09FF Wall Candle
    ADDITEM $item_wall sconce 1
    0A00 Wall Candle
    ADDITEM $item_wall sconce 2
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"light sources
}

SECTION_MENU ,"books
{
    Books
    0FF1 Books 1-8
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"books 1-8
    0FF1 Books 9-16
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"books 9-16
    0FF1 Books 17-24
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"books 17-24
    0FF1 Books 25-32
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"books 25-32
    0FF1 Empty Book
    ADDITEM $item_a_book
    1E5E Bulletin Board
    ADDITEM $item_a_bulletin board
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"non-combat equipment
}

SECTION_MENU ,"books 1-8
{
    Books 1-8
    0FF1 The first UOX book
    ADDITEM $item_the first uox book
    0FF1 A Grammer of Orchish
    ADDITEM $item_a_grammer of orchish
    0FF1 The bold stranger
    ADDITEM $item_the bold stranger
    0FF1 Birds of Brittannia
    ADDITEM $item_birds of brittannia
    0FF1 Reguarding Llamas
    ADDITEM $item_reguarding llamas
    0FF1 Talking to Wisps
    ADDITEM $item_talking to wisps
    0FF1 Taming Dragons
    ADDITEM $item_taming dragons
    0FF1 A politic call to anarchy
    ADDITEM $item_a_politic call to anarchy
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"books
}

SECTION_MENU ,"books 17-24
{
    Books 17-24
    0FF1 Classic tales of Vesper vol1
    ADDITEM $item_classic tales of vesper vol1
    0FF1 A tale of three tribes
    ADDITEM $item_a_tale of three tribes
    0FF1 Deceit: A Dungeon of horrors
    ADDITEM $item_deceit a dungeon of horrors
    0FF1 The life of a travelling minstrel
    ADDITEM $item_the life of a travelling minstrel
    0FF1 The wild girl in the forest
    ADDITEM $item_the wild girl in the forest
    0FF1 A primer on arms and weopons
    ADDITEM $item_a_primer on arms and weopons
    0FF1 Beltrans guide to guilds
    ADDITEM $item_beltrans guide to guilds
    0FF1 Brittannian flora
    ADDITEM $item_brittannian flora
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"books
}

SECTION_MENU ,"people - female - h-z
{
    People - Female - H-Z
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"nox-wizard gm_MENU
    2011 Jailor
    NPC $npc jailor f
    2009 Noble
    NPC $npc noble f
    2008 Peasant
    NPC $npc peasant f
    2015 Pirate
    NPC $npc pirate f
    2107 PK
    NPC $npc len ikbaan
    2017 Sailor
    NPC $npc sailor f
    2107 Seeker of Adventure
    NPC $npc adventurer f
    2018 Shipwright
    NPC $npc shipwright f
    201C Thief
    NPC $npc thief f
    2027 Town Crier
    NPC $npc towncrier f
    2038 Veterinarian
    NPC $npc veterinarian f
}

SECTION_MENU ,"other monsters m-z
{
    Other Monsters M-Z
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"monsters 1
    20F9 a mongbat
    NPC $npc a mongbat
    20E3 a ratman
    NPC
    20E3 a ratman with club
    NPC $npc ratman axe
    20E3 a ratman with sword
    NPC $npc ratman
    20FA a reaper
    NPC $npc a reaper
    2123 a sewer rat
    NPC $npc a sewer rat
    20E8 a slime
    NPC $npc a slime
    20FC a snake
    NPC $npc a snake
}

SECTION_MENU ,"guild signs 2
{
    Guild Signs 2
    0BE1 Traders Guild
    ADDITEM $item_traders guild
    0BE2 Traders Guild
    ADDITEM $item_traders guild 1
    0BE3 Cooks Guild
    ADDITEM $item_cooks guild
    0BE4 Cooks Guild
    ADDITEM $item_cooks guild 1
    0BE5 Healers Guild
    ADDITEM $item_healers guild
    0BE6 Healers Guild
    ADDITEM $item_healers guild 1
    0BE7 Mages Guild
    ADDITEM $item_mages guild
    0BE8 Mages Guild
    ADDITEM $item_mages guild 1
    0BE9 Sorcerers Guild
    ADDITEM $item_sorcerers guild
    0BEA Sorcerers Guild
    ADDITEM $item_sorcerers guild 1
    0BEB Illusionists Guild
    ADDITEM $item_illusionists guild
    0BEC Illusionists Guild
    ADDITEM $item_illusionists guild 1
    0BED Miners Guild
    ADDITEM $item_miners guild
    0BEE Miners Guild
    ADDITEM $item_miners guild 1
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"signs
}

SECTION_MENU ,"guild signs 4
{
    Guild Signs 4
    0BFD Rouges Guild
    ADDITEM $item_rouges guild
    0BFE Rouges Guild
    ADDITEM $item_rouges guild 1
    0BFF Assassins Guild
    ADDITEM $item_assassins guild
    0C00 Assassins Guild
    ADDITEM $item_assassins guild 1
    0C01 Tinkers Guild
    ADDITEM $item_tinkers guild
    0C02 Tinkers Guild
    ADDITEM $item_tinkers guild 1
    0C03 Warriors Guild
    ADDITEM $item_warriors guild
    0C04 Warriors Guild
    ADDITEM $item_warriors guild 1
    0C05 Cavalry Guild
    ADDITEM $item_cavalry guild
    0C06 Cavalry Guild
    ADDITEM $item_cavalry guild 1
    0C07 Fighters Guild
    ADDITEM $item_fighters guild
    0C08 Fighters Guild
    ADDITEM $item_fighters guild 1
    0C09 Merchants Guild
    ADDITEM $item_merchants guild
    0C0A Merchants Guild
    ADDITEM $item_merchants guild 1
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"signs
}

SECTION_MENU ,"marble 2
{
    Marble 2
    049C Marble
    ADDITEM $item_grey slate tile
    050D Marble
    ADDITEM $item_marble floor 4
    050E Marble
    ADDITEM $item_white marble
    050F Marble
    ADDITEM $item_green marble floor
    0510 Marble
    ADDITEM $item_green marble floor 1
    0511 Marble
    ADDITEM $item_marble floor 5
    0512 Marble
    ADDITEM $item_marble floor 6
    0513 Marble
    ADDITEM $item_marble floor 7
    0514 Marble
    ADDITEM $item_marble floor 8
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"floor tiles
}

SECTION_MENU ,"wooden boards 2
{
    Wooden Boards 2
    04B3 Wooden Boards
    ADDITEM $item_wooden boards E
    04B4 Wooden Boards
    ADDITEM $item_wooden boards F
    04B5 Wooden Boards
    ADDITEM $item_wooden boards G
    04B6 Wooden Boards
    ADDITEM $item_wooden boards H
    04B7 Wooden Boards
    ADDITEM $item_wooden boards I
    04B8 Wooden Boards
    ADDITEM $item_wooden boards J
    04B9 Wooden Boards
    ADDITEM $item_wooden boards K
    04BA Wooden Boards
    ADDITEM $item_wooden boards L
    04BB Wooden Boards
    ADDITEM $item_wooden boards M
    04BC Wooden Boards
    ADDITEM $item_wooden boards N
    04BD Wooden Boards
    ADDITEM $item_wooden boards O
    04BE Wooden Boards
    ADDITEM $item_wooden boards P
    04BF Wooden Boards
    ADDITEM $item_wooden boards Q
    04C0 Wooden Boards
    ADDITEM $item_wooden boards R
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"floor tiles
}

SECTION_MENU ,"books 9-16
{
    Books 9-16
    0FF1 Ethical Hedonism: An introduction
    ADDITEM $item_ethical hedonism an introduction
    0FF1 On the diversity of our lands
    ADDITEM $item_on the diversity of our lands
    0FF1 Virtue
    ADDITEM $item_virtue
    0FF1 My story
    ADDITEM $item_my story
    0FF1 The burning of Trinsic
    ADDITEM $item_the burning of trinsic
    0FF1 The fight
    ADDITEM $item_the fight
    0FF1 A song of Samlethe
    ADDITEM $item_a_song of samlethe
    0FF1 Classic childrens tales vol2
    ADDITEM $item_classic childrens tales vol2
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"books
}

SECTION_MENU ,"books 25-32
{
    Books 25-32
    0FF1 Demensional travel: a monagraph
    ADDITEM $item_demensional travel a monagraph
    0FF1 The major trade associations
    ADDITEM $item_the major trade associations
    0FF1 The rankings of trades
    ADDITEM $item_the rankings of trades
    0FF1 Treatise on alchemy
    ADDITEM $item_treatise on alchemy
    0FF1 UOX3 Story: Chapter 1 - Death
    ADDITEM $item_uox3 story chapter 1 - death
    0FF1 UOX3 Story: Chapter 2 - End of the World
    ADDITEM $item_uox3 story chapter 2 - end of the world
    0FF1 UOX3 Story: Chapter 3- Th22e lost Splinter
    ADDITEM $item_uox3 story chapter 3- the lost splinter
    0FF1 My personal book
    ADDITEM $item_my personal book
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"books
}

SECTION_MENU ,"cannon ball
{
    Cannon Ball
    0E73 Cannon Ball
    ADDITEM $item_a_cannon ball
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"equipment
}

SECTION_MENU ,"holiday gifts
{
    Holiday gifts
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"nox-wizard gm_MENU
    14F0 Seasons Greetings
    ADDITEM $item_seasons greetings
    0DF2 fireworks wand
    ADDITEM $item_fireworks wand
}

SECTION_MENU ,"phoenix armor
{
    Phoenix Armor
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
    13E2 Phoenix Tunic
    ADDITEM $item_phoenix tunic
    13D6 Phoenix Gorget
    ADDITEM $item_phoenix gorget
    13DD Phoenix Gloves
    ADDITEM $item_phoenix gloves
    13D4 Phoenix Sleeves
    ADDITEM $item_phoenix sleeves
    13E1 Phoenix Leggings
    ADDITEM $item_phoenix leggings
    140F Phoenix helm
    ADDITEM $item_phoenix helm
}

SECTION_MENU ,"blacksmithing items
{
    Blacksmithing Items
    1BF2 5 Iron Ingots
    ADDITEM $item_iron ingots
    0FB1 Forge
    ADDITEM $item_forge
    197A Partial Forge
    ADDITEM $item_bellows
    197E Partial Forge
    ADDITEM $item_forge
    1982 Partial Forge
    ADDITEM $item_forge 2
    0E85 Pick Axe
    ADDITEM $item_pickaxe
    0FAF Anvil
    ADDITEM $item_anvil
    0FB0 Anvil
    ADDITEM $item_anvil 1
    0FBC Tongs
    ADDITEM $item_tongs
    0F39 Shovel
    ADDITEM $item_shovel
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"skills related_MENU
}



SECTION_MENU ,"travel_MENU
{
    Travel_MENU
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"gm_MENU
    xe35 Sommon Zombie Scroll
    ADDITEM $item_a_summon zombie scroll
    xe35 Sommon Wraith Scroll
    ADDITEM $item_a_summon wraith scroll
    xe35 Sommon spectre Scroll
    ADDITEM $item_a_summon spectre scroll
    xe35 Sommon skeleton Scroll
    ADDITEM $item_a_summon skeleton scroll
    xe35 Sommon lich Scroll
    ADDITEM $item_a_summon lich scroll
    xe35 Sommon lich lord Scroll
    ADDITEM $item_a_summon lich lord scroll
    xe35 Sommon Bone Knight Scroll
    ADDITEM $item_a_summon bone knight scroll
    xe35 Sommon Bone Mage Scroll
    ADDITEM $item_a_summon bone mage scroll
}

SECTION_MENU ,"travel_MENU 1
{
    Travel_MENU
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"gm_MENU
    2093 Dungeons
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"dungeons
    20A2 GM Locations
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"gm locations
    20BA Shrines
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"go to shrines
    2085 Towns
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"towns
}

SECTION_MENU ,"wands
{
    Wands
    0DF2 Greater Heal Wand 20 charges
    ADDITEM $item_a_wand of greater heal
    0DF3 Summon Daemon Wand 5 charges
    ADDITEM $item_a_wand of summon daemon
    0DF4 Magic Arrow Wand 100 charges
    ADDITEM $item_a_wand of healing
    0DF5 Resurrect Wand 1 charge
    ADDITEM $item_a_wand of resurrection
    0F5C Fireball Mace 5000 charges
    ADDITEM $item_fire mace
    0F5C greater healing wand
    ADDITEM $item_a_wand of greater healing
    0F5C energy vortex wand
    ADDITEM $item_a_wand of energy vortex
    0F5C magic arrow wand
    ADDITEM $item_a_wand of magic arrow
    0F5C ressurection wand
    ADDITEM $item_a_wand of ressurection
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic
}

SECTION_MENU ,"coins gems jewelry
{
    Coins Gems Jewelry
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"equipment
    0EEF Coins
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"coins
    0F28 Gems
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"gems
    1089 Jewelry
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"jewelry
}

SECTION_MENU ,"coins
{
    Coins
    0EED Gold Single
    ADDITEM $item_gold coin 1
    0EEE Gold Few
    ADDITEM $item_gold coin 3
    0EEF Gold Pile
    ADDITEM $item_gold coin 6
    0EF0 Silver Single
    ADDITEM $item_silver coin
    0EF1 Silver Few
    ADDITEM $item_silver coin 3
    0EF2 Silver Pile
    ADDITEM $item_silver coin 6
    0EEA Copper Single
    ADDITEM $item_copper coin
    0EEB Copper Few
    ADDITEM $item_silver coin 3
    0EEC Copper Pile
    ADDITEM $item_silver coin 6
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"coins gems jewelry
}

SECTION_MENU ,"gems
{
    Gems
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"coins gems jewelry
    0F26 Cut Gems
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"cut gems
    0F29 Un-Cut Gems
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"uncut gems
}

SECTION_MENU ,"jewelry
{
    Jewelry
    108B Beads
    ADDITEM $item_beads
    1086 Bracelet
    ADDITEM $item_bracelet
    1087 Earrings
    ADDITEM $item_earrings
    1085 Necklace
    ADDITEM $item_necklace
    1088 Necklace
    ADDITEM $item_necklace 1
    1089 Necklace
    ADDITEM $item_necklace 2
    108A Ring
    ADDITEM $item_ring
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"coins gems jewelry
}

SECTION_MENU ,"cut gems
{
    Cut Gems
    0F16 Amethyst
    ADDITEM $item_amethysts
    0F17 Amethyst
    ADDITEM $item_amethysts 1
    0F15 Citrine
    ADDITEM $item_citrines
    0F26 Diamond
    ADDITEM $item_diamonds 4
    0F10 Emerald
    ADDITEM $item_emeralds
    0F13 Ruby
    ADDITEM $item_rubies
    0F14 Ruby
    ADDITEM $item_rubies 1
    0F1A Ruby
    ADDITEM $item_rubies 2
    0F1C Ruby
    ADDITEM $item_rubies 3
    0F1D Ruby
    ADDITEM $item_rubies 4
    0F11 Sapphire
    ADDITEM $item_sapphires
    0F12 Sapphire
    ADDITEM $item_sapphires 1
    0F19 Sapphire
    ADDITEM $item_sapphires 2
    0F1F Sapphire
    ADDITEM $item_sapphires 3
    0F0F Sapphire Star
    ADDITEM $item_star sapphires
    0F1B Sapphire Star
    ADDITEM $item_star sapphires 1
    0F18 Tourmaline
    ADDITEM $item_tourmalines
    0F1E Tourmaline
    ADDITEM $item_tourmalines 1
    0F20 Tourmaline
    ADDITEM $item_tourmalines 2
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"gems
}

SECTION_MENU ,"uncut gems
{
    UnCut Gems
    0F25 Amber
    ADDITEM $item_pieces of amber
    0F22 Amethyst
    ADDITEM $item_amethysts 2
    0F2E Amethyst
    ADDITEM $item_amethysts 3
    0F23 Citrine
    ADDITEM $item_citrines 1
    0F24 Citrine
    ADDITEM $item_citrines 2
    0F2C Citrine
    ADDITEM $item_citrines 3
    0F27 Diamond
    ADDITEM $item_diamonds
    0F28 Diamond
    ADDITEM $item_diamonds 1
    0F29 Diamond
    ADDITEM $item_diamonds 2
    0F30 Diamond
    ADDITEM $item_diamonds 3
    0F2F Emerald
    ADDITEM $item_emeralds 1
    0F2A Ruby
    ADDITEM $item_rubies 5
    0F2B Ruby
    ADDITEM $item_rubies 6
    0F21 Sapphire Star
    ADDITEM $item_star sapphires 2
    0F2D Tourmaline
    ADDITEM $item_tourmalines 3
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"gems
}


SECTION_MENU ,"lord binarys deeds
{
    Lord Binarys Deeds
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"building_MENU
    14f0 Treasure deed 1
    ADDITEM $item_treasure deed
    14f0 Treasure deed 2
    ADDITEM $item_treasure deed 1
    14f0 Treasure deed 3
    ADDITEM $item_treasure deed 2
    14f0 Treasure deed 4
    ADDITEM $item_treasure deed 3
    14f0 Lighthouse deed
    ADDITEM $item_lighthouse deed
    14f0 Telescope deed
    ADDITEM $item_telescope deed
    14f0 Arbitoir deed
    ADDITEM $item_arbitoir deed
}


SECTION_MENU ,"magic daggers
{
    Magic Daggers
    0F51 magic dagger of ruin
    ADDITEM $item_iron dagger of ruin
    0F51 magic dagger of might
    ADDITEM $item_iron dagger of might
    0F51 magic dagger of force
    ADDITEM $item_iron dagger of force
    0F51 magic dagger of power
    ADDITEM $item_iron dagger of power
    0F51 magic dagger of vanquishing
    ADDITEM $item_iron dagger of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic knives  daggers
}

SECTION_MENU ,"magic kryss
{
    Magic Kryss
    1400 magic kryss of ruin
    ADDITEM $item_iron kryss of ruin
    1400 magic kryss of might
    ADDITEM $item_iron kryss of might
    1400 magic kryss of force
    ADDITEM $item_iron kryss of force
    1400 magic kryss of power
    ADDITEM $item_iron kryss of power
    1400 magic kryss of vanquishing
    ADDITEM $item_iron kryss of vanquishing
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic knives  daggers
}

SECTION_MENU ,"second circle scrolls
{
    Second Circle Scrolls
    1F35 Agility Scroll
    ADDITEM $item_a_agility scroll
    1F36 Cunning Scroll
    ADDITEM $item_a_cunning scroll
    1F37 Cure Scroll
    ADDITEM $item_a_cure scroll
    1F38 Harm Scroll
    ADDITEM $item_a_harm scroll
    1F39 Magic TraP_Scroll
    ADDITEM $item_magic traP_scroll
    1F3A Magic UntraP_Scroll
    ADDITEM $item_magic untraP_scroll
    1F3B Protection Scroll
    ADDITEM $item_a_protection scroll
    1F3C Strength Scroll
    ADDITEM $item_a_strength scroll
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic
}

SECTION_MENU ,"third circle scrolls
{
    Third Circle Scrolls
    1F3D Bless Scroll
    ADDITEM $item_a_bless scroll
    1F3E Fireball Scroll
    ADDITEM $item_a_fireball scroll
    1F3F Magic Lock Scroll
    ADDITEM $item_magic lock scroll
    1F40 Poison Scroll
    ADDITEM $item_a_poison scroll
    1F41 Telekinesis Scroll
    ADDITEM $item_a_telekinesis scroll
    1F42 Teleport Scroll
    ADDITEM $item_a_teleport scroll
    1F43 Unlock Scroll
    ADDITEM $item_an_unlock scroll
    1F44 Wall of Stone Scroll
    ADDITEM $item_a_wall of stone scroll
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic
}

SECTION_MENU ,"fourth circle scrolls
{
    Fourth Circle Scrolls
    1F45 Archcure Scroll
    ADDITEM $item_an_archcure scroll
    1F46 Arch Protection Scroll
    ADDITEM $item_an_arch protection scroll
    1F47 Curse Scroll
    ADDITEM $item_a_curse scroll
    1F48 Fire Field Scroll
    ADDITEM $item_a_fire field scroll
    1F49 Greater Heal Scroll
    ADDITEM $item_a_greater heal scroll
    1F4A Lightning Scroll
    ADDITEM $item_a_lightning scroll
    1F4B ManaDrain Scroll
    ADDITEM $item_a_mana drain scroll
    1F4C Recall Scroll
    ADDITEM $item_a_recall scroll
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic
}

SECTION_MENU ,"fifth circle scrolls
{
    Fifth Circle Scrolls
    1F4D Blade Spirits Scroll
    ADDITEM $item_a_blade spirits scroll
    1F4E Dispel Field Scroll
    ADDITEM $item_a_dispel field scroll
    1F4F Incognito Scroll
    ADDITEM $item_an_incognito scroll
    1F50 Magic Reflection Scroll
    ADDITEM $item_magic reflection scroll
    1F51 Mind Blast Scroll
    ADDITEM $item_a_mind blast scroll
    1F52 Paralyze Scroll
    ADDITEM $item_a_paralyze scroll
    1F53 Poison Field Scroll
    ADDITEM $item_a_poison field scroll
    1F54 Summon Creature Scroll
    ADDITEM $item_a_summon creature scroll
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic
}

SECTION_MENU ,"sixth circle scrolls
{
    Sixth Circle Scrolls
    1F55 Dispel Scroll
    ADDITEM $item_a_dispel scroll
    1F56 Energy Bolt Scroll
    ADDITEM $item_an_energy bolt scroll
    1F57 Explosion Scroll
    ADDITEM $item_an_explosion scroll
    1F58 Invisibility Scroll
    ADDITEM $item_an_invisibility scroll
    1F59 Mark Scroll
    ADDITEM $item_a_mark scroll
    1F5A Mass Curse Scroll
    ADDITEM $item_a_mass curse scroll
    1F5B Paralyze Field Scroll
    ADDITEM $item_a_paralyze field scroll
    1F5C Reveal Scroll
    ADDITEM $item_a_reveal scroll
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic
}

SECTION_MENU ,"seventh circle scrolls
{
    Seventh Circle Scrolls
    1F5D Chain Lightning Scroll
    ADDITEM $item_a_chain lightning scroll
    1F5E Energy Field Scroll
    ADDITEM $item_an_energy field scroll
    1F5F Flamestrike Scroll
    ADDITEM $item_a_flamestrike scroll
    1F60 Gate Travel Scroll
    ADDITEM $item_a_gate travel scroll
    1F61 Mana Vampire Scroll
    ADDITEM $item_a_mana vampire scroll
    1F62 Mass Dispel Scroll
    ADDITEM $item_a_mass dispel scroll
    1F63 Meteor Storm Scroll
    ADDITEM $item_a_meteor swarm scroll
    1F64 Polymorph Scroll
    ADDITEM $item_a_polymorph scroll
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic
}

SECTION_MENU ,"eighth circle scrolls
{
    Eighth Circle Scrolls
    1F65 Earthquake Scroll
    ADDITEM $item_a_earthquake scroll
    1F66 Energy Vortex Scroll
    ADDITEM $item_a_energy vortex scroll
    1F67 Resurrection Scroll
    ADDITEM $item_a_resurrection scroll
    1F68 Summon Air Elemental Scroll
    ADDITEM $item_a_summon air elemental scroll
    1F69 Summon Daemon Scroll
    ADDITEM $item_a_summon daemon scroll
    1F6A Summon Earth Elemental Scroll
    ADDITEM $item_a_summon earth elemental scroll
    1F6B Summon Fire Elemental Scroll
    ADDITEM $item_a_summon fire elemental scroll
    1F6C Summon Water Elemental Scroll
    ADDITEM $item_a_summon water elemental scroll
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic
}

SECTION_MENU ,"orc kin
{
    Orc Kin
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"monsters 1
    20D8 an ettin
    NPC $npc an ettin
    20D8 an ettin with axe
    NPC $npc an ettin 1
    20D8 a trolloc
    NPC
    20E0 an orc
    NPC $npc orc
    20E0 an orc with club
    NPC $npc orc mace
    20E0 an orcish mage
    NPC $npc an orcish mage
    20E0 an orcish captian
    NPC $npc orc 2 hand axe
    20E0 an orcish lord
    NPC $npc an orcish lord
    20DF an ogre
    NPC $npc an ogre
    20DF an ogre lord
    NPC $npc an ogre lord
    20E9 a troll
    NPC $npc a troll
    20E9 a troll 2
    NPC $npc a troll 1
    20E9 a troll 3
    NPC $npc a troll 2
}

SECTION_MENU ,"signs
{
    Signs
    129C Roadsigns
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"roadsigns
    0BBF ShoP_Signs 1
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"shoP_signs 1
    0BBF ShoP_Signs 2
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"shoP_signs 2
    0BBF ShoP_Signs 3
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"shoP_signs 3
    0BBF ShoP_Signs 4
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"shoP_signs 4
    0BD3 Guild Signs 1
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"guild signs 1
    0BD3 Guild Signs 2
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"guild signs 2
    0BD3 Guild Signs 3
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"guild signs 3
    0BD3 Guild Signs 4
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"guild signs 4
    0BCF Misc Signs
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"misc signs
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"decoration
}

SECTION_MENU ,"roadsigns
{
    Roadsigns
    1297 Roadsign
    ADDITEM $item_roadsign
    1298 Roadsign
    ADDITEM $item_roadsign 1
    1299 Roadsign
    ADDITEM $item_roadsign 2
    129A Roadsign
    ADDITEM $item_roadsign 3
    129B Roadsign
    ADDITEM $item_roadsign 4
    129C Roadsign
    ADDITEM $item_roadsign 5
    129D Roadsign
    ADDITEM $item_roadsign 6
    129E Roadsign
    ADDITEM $item_roadsign 7
    1296 Signpost
    ADDITEM $item_signpost
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"signs
}

SECTION_MENU ,"shoP_signs 1
{
    ShoP_Signs 1
    0B95 Library
    ADDITEM $item_library
    0B96 Library
    ADDITEM $item_library 1
    0BA3 Bakery
    ADDITEM $item_bakery
    0BA4 Bakery
    ADDITEM $item_bakery 1
    0BA5 Tailor
    ADDITEM $item_tailor
    0BA6 Tailor
    ADDITEM $item_tailor 1
    0BA7 Tinker
    ADDITEM $item_tinker
    0BA8 Tinker
    ADDITEM $item_tinker 1
    0BA9 Butcher
    ADDITEM $item_butcher
    0BAA Butcher
    ADDITEM $item_butcher 1
    0BAB Healer
    ADDITEM $item_healer
    0BAC Healer
    ADDITEM $item_healer 1
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"signs
}

SECTION_MENU ,"shoP_signs 3
{
    ShoP_Signs 3
    0BBB Mucician
    ADDITEM $item_musician
    0BBC Mucician
    ADDITEM $item_musician 1
    0BBD Archery
    ADDITEM $item_archer 1
    0BBE Archery
    ADDITEM $item_archer 2
    0BBF Blacksmith
    ADDITEM $item_blacksmith
    0BC0 Blacksmith
    ADDITEM $item_blacksmith 1
    0BC1 Jewler
    ADDITEM $item_jewler
    0BC2 Jewler
    ADDITEM $item_jewler 1
    0BC3 Tavern
    ADDITEM $item_tavern
    0BC4 Tavern
    ADDITEM $item_tavern 1
    0BC5 Alchemist
    ADDITEM $item_alchemist
    0BC6 Alchemist
    ADDITEM $item_alchemist 1
    0BC7 Armorer
    ADDITEM $item_armorer
    0BC8 Armorer
    ADDITEM $item_armorer 1
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"signs
}

SECTION_MENU ,"guild signs 1
{
    Guild Signs 1
    0BD3 Armaments Guild
    ADDITEM $item_armaments guild
    0BD4 Armaments Guild
    ADDITEM $item_armaments guild 1
    0BD5 Armorers Guild
    ADDITEM $item_armorers guild
    0BD6 Armorers Guild
    ADDITEM $item_armorers guild 1
    0BD7 Blacksmiths Guild
    ADDITEM $item_blacksmiths guild
    0BD8 Blacksmiths Guild
    ADDITEM $item_blacksmiths guild 1
    0BD9 Weapons Guild
    ADDITEM $item_weapons guild
    0BDA Weapons Guild
    ADDITEM $item_weapons guild 1
    0BDB Bardic Guild
    ADDITEM $item_bardic guild
    0BDC Bardic Guild
    ADDITEM $item_bardic guild 1
    0BDD Barders Guild
    ADDITEM $item_barders guild
    0BDE Barders Guild
    ADDITEM $item_barders guild 1
    0BDF Provisioners Guild
    ADDITEM $item_provisioners guild
    0BE0 Provisioners Guild
    ADDITEM $item_provisioners guild 1
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"signs
}

SECTION_MENU ,"guild signs 3
{
    Guild Signs 3
    0BEF Archers Guild
    ADDITEM $item_archers guild
    0BF0 Archers Guild
    ADDITEM $item_archers guild 1
    0BF1 Seamans Guild
    ADDITEM $item_seamans guild
    0BF2 Seamans Guild
    ADDITEM $item_seamans guild 1
    0BF3 Fishermans Guild
    ADDITEM $item_fishermans guild
    0BF4 Fishermans Guild
    ADDITEM $item_fishermans guild 1
    0BF5 Sailors Guild
    ADDITEM $item_sailors guild
    0BF6 Sailors Guild
    ADDITEM $item_sailors guild 1
    0BF7 Shipwrights Guild
    ADDITEM $item_shipwrights guild
    0BF8 Shipwrights Guild
    ADDITEM $item_shipwrights guild 1
    0BF9 Tailors Guild
    ADDITEM $item_tailors guild
    0BFA Tailors Guild
    ADDITEM $item_tailors guild 1
    0BFB Thieves Guild
    ADDITEM $item_thieves guild
    0BFC Thieves Guild
    ADDITEM $item_thieves guild 1
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"signs
}

SECTION_MENU ,"misc signs
{
    Misc Signs
    0BCF Wooden Sign
    ADDITEM $item_wooden sign
    0BD0 Wooden Sign
    ADDITEM $item_wooden sign 1
    0BD1 Brass Sign
    ADDITEM $item_brass sign
    0BD2 Brass Sign
    ADDITEM $item_brass sign 1
    1F29 Sign
    ADDITEM $item_sign
    1F28 Sign
    ADDITEM $item_sign 1
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"signs
}

SECTION_MENU ,"other monsters a-l
{
    Other Monsters A-L
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"monsters 1
    20D2 a corpser
    NPC $npc a corpser
    20d0 a giant rat
    NPC $npc a giant rat
    20E4 a giant scorpion
    NPC $npc a giant scorpion
    20FE a giant serpent
    NPC $npc a giant serpent
    0096 a giant sea serpent
    NPC $npc a sea serpent
    20FD a giant spider
    NPC $npc a giant spider
    20FD a dark spider
    NPC $npc a dark spider
    20DE a lizardman
    NPC $npc lizardman short sword
    20DE a lizardman with spear
    NPC $npc lizardman fencer
    20DE a lizardman with hammer
    NPC $npc lizardman macefighter
}

SECTION_MENU ,"animals ii
{
    Animals II
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"animals 1
    20E2 a rabbit
    NPC $npc a rabbit
    20EB a sheep
    NPC $npc a sheep
    20EE a bird
    NPC $npc forest bird
    211D an eagle
    NPC $npc an eagle
    20F6 a llama
    NPC $npc a rideable llama
    2101 a pig
    NPC $npc a pig
    2102 a panther
    NPC $npc a panther
    2103 a cow
    NPC $npc a cow
    2108 a goat
    NPC $npc a goat
    211B a cat
    NPC $npc a cat
    2126 a pack horse
    NPC $npc a pack horse
    2127 a pack llama
    NPC $npc a pack llama
    2128 a mountain goat
    NPC
    2129 a black sheep
    NPC
}

SECTION_MENU ,"undead mythical
{
    Undead Mythical
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"monsters 1
    20F4 a gazer
    NPC $npc a gazer
    210A a headless
    NPC $npc a headless
    20F8 a lich
    NPC $npc a lich
    20DC a harpy
    NPC $npc a harpy
    20E7 a skeletal knight
    NPC $npc a bone knight
    20E7 a skeletal mage
    NPC $npc a bone magi
    20E7 a skeleton
    NPC $npc a skeleton
    20E7 a skeleton with axe
    NPC $npc a skeleton 1
    2109 a spectre
    NPC $npc a spectre
    2100 a wisp
    NPC $npc a wisp
    20EC a zombie
    NPC $npc a zombie
}

SECTION_MENU ,"bottles  alchemy
{
    Bottles & Alchemy
    0E9B Mortar And Pestal
    ADDITEM $item_mortar and pestal
    0F0E Bottle
    ADDITEM $item_bottle A
    0E24 a empty vial
    ADDITEM $item_empty vials
    0E25 Bottle
    ADDITEM $item_bottle
    0E26 Bottle
    ADDITEM $item_bottle 1
    0E27 Bottle
    ADDITEM $item_bottle 2
    0E28 Bottle
    ADDITEM $item_bottle 3
    0E29 Bottle
    ADDITEM $item_bottle 4
    0E2A Bottle
    ADDITEM $item_bottle 5
    0E2B Bottle
    ADDITEM $item_bottle 6
    0E2C Bottle
    ADDITEM $item_bottle 7
    0EFB Bottle
    ADDITEM $item_bottle 8
    0EFC Bottle
    ADDITEM $item_bottle 9
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic
}

SECTION_MENU ,"potions
{
    Potions
    0E9B Mortar And Pestal
    ADDITEM $item_mortar and pestal
    0F06 Night Sight Potion
    ADDITEM $item_night sight potion
    0F07 Cure Potion
    ADDITEM $item_cure potion
    0F08 Agility Potion
    ADDITEM $item_agility potion
    0F09 Strength Potion
    ADDITEM $item_strength potion
    0F0A Poison Potion
    ADDITEM $item_poison potion
    0F0B Resurrection Potion
    ADDITEM $item_energy potion
    0F0C Lesser Heal Potion
    ADDITEM $item_lesser heal potion
    0F0C Greater Heal Potion
    ADDITEM $item_greater heal potion
    0F0D Lesser Explosion Potion
    ADDITEM $item_lesser explosion potion
    0F0D Explosion Potion
    ADDITEM $item_explosion potion
    0F0D Greater Explosion Potion
    ADDITEM $item_greater explosion potion
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic
}

SECTION_MENU ,"gates
{
    Gates
    0F6C A Blue Moongate
    ADDITEM $item_a_blue moongate
    0DDA A Red Moongate
    ADDITEM $item_a_red moongate
    1FD4 A Black Moongate
    ADDITEM $item_a_black moongate
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic
}

SECTION_MENU ,"bottled beverages
{
    Bottled Beverages
    099F Bottle of Ale
    ADDITEM $item_bottle of ale
    09A0 Bottles of Ale
    ADDITEM $item_bottles of ale
    09A1 Bottles of Ale
    ADDITEM $item_bottles of ale 1
    09A2 Bottles of Ale
    ADDITEM $item_bottles of ale 2
    099B Bottle of Liquor
    ADDITEM $item_bottle of liquor
    099C Bottles of Liquor
    ADDITEM $item_bottles of liquor
    099D Bottles of Liquor
    ADDITEM $item_bottles of liquor 1
    099E Bottles of Liquor
    ADDITEM $item_bottles of liquor 2
    09C7 Bottle of Wine
    ADDITEM $item_bottle of wine
    09C6 Bottles of Wine
    ADDITEM $item_bottles of wine
    09C5 Bottles of Wine
    ADDITEM $item_bottles of wine
    09C4 Bottles of Wine
    ADDITEM $item_bottles of wine 2
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"food items
}

SECTION_MENU ,"baked and veggys
{
    Baked and Veggys
    1041 Baked Pie
    ADDITEM $item_baked pie
    1042 Unbaked Pie
    ADDITEM $item_unbaked pie
    09E9 Cake
    ADDITEM $item_cake
    097C Wedge of Cheese
    ADDITEM $item_wedges of cheese
    097D Cut Cheese
    ADDITEM $item_wedges of cheese 1
    097E Wheel of Cheese
    ADDITEM $item_wheels of cheese
    098C French Bread
    ADDITEM $item_french bread
    09EA Muffin
    ADDITEM $item_muffins
    09FA Muffins
    ADDITEM $item_muffins 1
    09EB Muffins
    ADDITEM $item_muffins 2
    103C Loaf of Bread
    ADDITEM $item_bread loaves
    1040 Pizza
    ADDITEM $item_pizzas
    1083 Unbaked Pizza
    ADDITEM $item_uncooked pizza
    160B Pan of Cookies
    ADDITEM $item_pan of cookies
    160C Plate of Cookies
    ADDITEM $item_plate of cookies
    09B4 Eggshells
    ADDITEM $item_eggshells
    09B5 Eggs
    ADDITEM $item_eggs
    09B6 Fried Eggs
    ADDITEM $item_fried eggs
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"food items
}

SECTION_MENU ,"towns
{
    Towns
    <- Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"travel_MENU 1
    0BD1 Britain
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"britain
    0BD1 Buccaneer's Den
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"buccaneers den
    0BD1 Cove
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"cove
    0BD1 Jhelom
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"jhelom
    0BD1 Magincia
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magincia
    0BD1 Minoc
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"minoc
    0BD1 Moonglow
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"moonglow
    0BD1 Nujelm
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"nujelm
    0BD1 Ocllo
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"ocllo
    0BD1 Serpents Hold
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"serpents hold
    0BD1 Skara Brae
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"skara brae
    0BD1 Trinsic
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"trinsic
    0BD1 Vesper
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"vesper
    0BD1 Wind
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wind
    0BD1 Yew
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"yew
    < Papua - T2A
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"papua
    < Delucia - T2A
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"delucia
}

SECTION_MENU ,"dungeons
{
    Dungeons
    <- Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"travel_MENU 1
    <- Covetous
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"covetous
    <- Deceit
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"deciet
    <- Despise
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"despise
    <- Destard
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"destard
    <- Hyloth
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"hyloth
    <- Shame
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"shame
    <- Wrong
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"wrong
    <- Hythloth Firepit
    GOPLACE 300
    <- Yew/Britain Brigand Camp
    GOPLACE 301
    <- Yew Fort of the Damned
    GOPLACE 302
    <- Ice Dungeon
    GOPLACE 306
}

SECTION_MENU ,"people - males - a-g
{
    People - Males - A-G
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"nox-wizard gm_MENU
    < Afrika
    NPC $npc murderer
    2022 Artist
    NPC $npc artist m
    20CD Basic Male
    NPC
    202B Beggar
    NPC $npc beggar m
    < Boy
    NPC $npc sammy
    2106 Boy 2
    NPC $npc billy
    2030 Brigand
    NPC $npc brigand m
    < Cobbler
    NPC $npc cobbler m
    2106 Cultist
    NPC $npc cultist m
    2106 Fighter
    NPC $npc fighter m
    < Game Master
    NPC
    200E Guard
    NPC $npc guard
    200E Guard Personal
    NPC $npc dark knight
    2033 Gypsy
    NPC $npc gypsy m
}

SECTION_MENU ,"go to shrines
{
    Go To Shrines
    <- Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"travel_MENU 1
    <- Chaos Shrine
    GOPLACE 170
    <- Compassion Shrine
    GOPLACE 171
    <- Honesty Shrine
    GOPLACE 172
    <- Honor Shrine
    GOPLACE 173
    <- Humility Shrine
    GOPLACE 174
    <- Justice Shrine
    GOPLACE 175
    <- Sacrifice Shrine
    GOPLACE 176
    <- Spirituality Shrine
    GOPLACE 177
    <- Valor Shrine
    GOPLACE 178
}

SECTION_MENU ,"people - female - a-g
{
    People - Female - A-G
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"nox-wizard gm_MENU
    2022 Artist
    NPC $npc artist f
    20CE Basic Female
    NPC
    202B Beggar
    NPC $npc beggar f
    2030 Brigand
    NPC $npc brigand f
    2107 Cultist
    NPC $npc cultist f
    2107 Fighter
    NPC $npc fighter f
    2107 Girl
    NPC $npc cassandra
    2107 Girl
    NPC $npc isabel
    200E Guard
    NPC $npc guard f
    2033 Gypsy
    NPC $npc gypsy f
}

SECTION_MENU ,"unique other monsters
{
    Unique Other Monsters
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"monsters 1
    210B a blood elemental
    NPC $npc a blood elemental
    20D3 the Collector of Souls
    NPC $npc the collector of souls
    20DC a harpy hen
    NPC $npc a harpy hen
    20F8 a lich lord
    NPC $npc a lich lord
    20D3 the Lord of the Abyss
    NPC $npc lord of the abyss
    20ED a poison elemental
    NPC $npc a poison elemental
    20D3 the Slayer
    NPC $npc slayer
    20F4 Xanathar
    NPC $npc xanathar
}

SECTION_MENU ,"deamon
{
    Deamon/Elementals
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"monsters 1
    20ED an air elemental
    NPC $npc an air elemental
    20D3 a daemon
    NPC $npc deamon unarmed
    20D3 a daemon W/Sword
    NPC $npc a daemon
    20D7 an earth elemental
    NPC $npc an earth elemental
    20F3 a fire elemental
    NPC $npc a fire elemental
    20D9 a gargoyle
    NPC $npc a gargoyle
    210B a water elemental
    NPC $npc a water elemental
}

SECTION_MENU ,"meat
{
    Meat
    09B7 Cooked Bird
    ADDITEM $item_cooked birds
    09BB Roast Pig
    ADDITEM $item_roast pigs
    09C0 Sausages
    ADDITEM $item_sausages
    09C9 Ham
    ADDITEM $item_hams
    09F2 Ribs
    ADDITEM $item_cuts of ribs
    097B Fish Steak
    ADDITEM $item_fish steaks
    0976 Slabs of Bacon
    ADDITEM $item_slabs of bacon
    0978 Slice of Bacon
    ADDITEM $item_slices of bacon
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"food items
}

SECTION_MENU ,"display cases
{
    Display Cases
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"furnitures
    0B11 Display Case Bottom
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"display case bottom
    0B18 Display Case Top
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"display case top
}

SECTION_MENU ,"cabinets
{
    Cabinets
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"furnitures
    0A2C Type I
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"cabinets - type i
    0A30 Type II
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"cabinets - type ii
    0A97 Book Shelfs
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"book shelfs
}

SECTION_MENU ,"non-bottled beverages
{
    Non-Bottled Beverages
    0FFA Bucket of Water
    ADDITEM $item_bucket of water
    09EE Glass of Ale
    ADDITEM $item_mug of ale
    1F7D Glass of Cider
    ADDITEM $item_glass of cider
    1F85 Glass of Liquor
    ADDITEM $item_glass of liquor
    1F89 Glass of Milk
    ADDITEM $item_glass of milk
    1F91 Glass of Water
    ADDITEM $item_glass of water
    1F8D Glass of Wine
    ADDITEM $item_glass of wine
    098E Jugs of Cider
    ADDITEM $item_jugs of cider
    098D Jugs of Cider
    ADDITEM $item_jugs of cider 1
    1F95 Pitcher of Ale
    ADDITEM $item_pitcher of ale
    1F97 Pitcher of Cider
    ADDITEM $item_pitcher of cider
    1F99 Pitcher of Liquor
    ADDITEM $item_pitcher of liquor
    09AD Pitcher of Milk
    ADDITEM $item_pitcher of milk
    0FF9 Pitcher of Water
    ADDITEM $item_pitcher of water
    1F9B Pitcher of Wine
    ADDITEM $item_pitcher of wine
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"food items
}

SECTION_MENU ,"tables
{
    Tables
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"furnitures
    0B34 Type 1
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"type 1
    0B3F Type 2
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"type 2
    0B6B Type 3
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"type 3
    0B6E Type 4
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"type 4
    0B70 Type 5
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"type 5
    0B75 Type 6
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"type 6
    0B77 Type 7
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"type 7
    0B8F Others
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"others
}

SECTION_MENU ,"cabinets - type i
{
    Cabinets - Type I
    0A2C Cabinet 1
    ADDITEM $item_pine dresser1 1
    0A34 Cabinet 2
    ADDITEM $item_pine dresser1 2
    0A4F Cabinet 3
    ADDITEM $item_pine armoire2 2
    0A53 Cabinet 4
    ADDITEM $item_pine armoire2 1
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"cabinets
}

SECTION_MENU ,"cabinets - type ii
{
    Cabinets - Type II
    0A30 Chest of Drawers cherry facing south
    ADDITEM $item_pine dresser2 2
    0A38 Chest of Drawers cherry facing east
    ADDITEM $item_pine dresser2 1
    0A4D Armorie cherry facing east
    ADDITEM $item_pine armoire1 2
    0A51 Armorie cherry facing south
    ADDITEM $item_pine armoire1 1
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"cabinets
}

SECTION_MENU ,"book shelfs
{
    Book Shelfs
    0A97 Book Shelf 1
    ADDITEM $item_pine bookcase1 1
    0A98 Book Shelf 2
    ADDITEM $item_pine bookcase2 1
    0A99 Book Shelf 3
    ADDITEM $item_pine bookcase1 2
    0A9A Book Shelf 4
    ADDITEM $item_pine bookcase2 2
    0A9B Book Shelf 5
    ADDITEM $item_pine bookcase1 3
    0A9C Book Shelf 6
    ADDITEM $item_pine bookcase2 3
    0A9D Empty Shelf 1
    ADDITEM $item_pine wooden shelf1
    0A9E Empty Shelf 2
    ADDITEM $item_pine wooden shelf2
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"cabinets
}

SECTION_MENU ,"type 1
{
    Type 1
    0B34 Item 1
    ADDITEM $item_pine table G1 1
    0B37 Item 2
    ADDITEM $item_pine table G1 2
    0B35 Item 3
    ADDITEM $item_pine table G2 1
    0B38 Item 4
    ADDITEM $item_pine table G2 2
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"tables
}

SECTION_MENU ,"type 2
{
    Type 2
    0B3F Item 1
    ADDITEM $item_pine counter1 1
    0B3D Item 2
    ADDITEM $item_pine counter1 2
    0B40 Item 3
    ADDITEM $item_pine counter2 1
    0B3E Item 4
    ADDITEM $item_pine counter2 2
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"tables
}

SECTION_MENU ,"type 3
{
    Type 3
    0B6B Item 1
    ADDITEM $item_pine table H1 1
    0B6D Item 2
    ADDITEM $item_pine table H1 2
    0B6C Item 3
    ADDITEM $item_pine table H1 3
    0B7F Item 4
    ADDITEM $item_pine table H2 1
    0B80 Item 5
    ADDITEM $item_pine table H2 2
    0B7E Item 6
    ADDITEM $item_pine table H2 3
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"tables
}

SECTION_MENU ,"type 4
{
    Type 4
    0B6E Item 1
    ADDITEM $item_pine table A1 1
    0B6F Item 2
    ADDITEM $item_pine table A1 2
    0B82 Item 3
    ADDITEM $item_pine table A2 1
    0B81 Item 4
    ADDITEM $item_pine table A2 2
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"tables
}

SECTION_MENU ,"type 5
{
    Type 5
    0B70 Item 1
    ADDITEM $item_pine table B1 1
    0B71 Item 2
    ADDITEM $item_pine table B1 2
    0B72 Item 3
    ADDITEM $item_pine table B1 3
    0B73 Item 4
    ADDITEM $item_pine table B1 4
    0B74 Item 5
    ADDITEM $item_pine table B1 5
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"tables
}

SECTION_MENU ,"type 6
{
    Type 6
    0B75 Item 1
    ADDITEM $item_pine table C1 1
    0B76 Item 2
    ADDITEM $item_pine table C1 2
    0B89 Item 3
    ADDITEM $item_pine table C2 1
    0B88 Item 4
    ADDITEM $item_pine table C2 2
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"tables
}

SECTION_MENU ,"type 7
{
    Type 7
    0B77 Item 1
    ADDITEM $item_pine table D1 1
    0B78 Item 2
    ADDITEM $item_pine table D1 2
    0B79 Item 3
    ADDITEM $item_pine table D1 3
    0B7A Item 4
    ADDITEM $item_pine table D1 4
    0B7B Item 5
    ADDITEM $item_pine table D1 5
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"tables
}

SECTION_MENU ,"cove orc fort
{
    Cove Orc Fort
    < Random Cove Orc Spawn
    ADDITEM $item_random orc spawn
    1F14 Orc Lord Spawner
    ADDITEM $item_orc lord spawner
    1F14 Orc Spawner
    ADDITEM $item_orc spawner
    1F14 Orc Mage Spawner
    ADDITEM $item_orc mage spawner
    1F14 Ettin Spawner
    ADDITEM $item_ettin spawner
    20E0 an orc lord
    NPC $npc an orcish lord
    20E0 an orc
    NPC $npc orc
    20E0 an orc mage
    NPC $npc an orcish mage
    20D8 an ettin
    NPC $npc an ettin
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"spawner_MENU
}

SECTION_MENU ,"others
{
    Others
    0B8F Item 1
    ADDITEM $item_pine table G1 1
    0B7C Item 2
    ADDITEM $item_pine table E1
    0B90 Item 3
    ADDITEM $item_pine table F2
    0B7D Item 4
    ADDITEM $item_pine table F1
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"tables
}

SECTION_MENU ,"characters and robes
{ //Characters and Robes
    Characters and Robes
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"gm_MENU
    2042 Lord British Armor
    ADDITEM $item_lord british armor
    2043 Blackthorne Robe
    ADDITEM $item_blackthorne robe
    < Dupre the fighter
    ADDITEM $item_dupre
    204E Death Shroud
    ADDITEM $item_death shroud
    204F GM Robe (undyed)
    ADDITEM $item_gm robe undyed
    204F GM Robe (red)
    ADDITEM $item_gm robe red 
    204F GM Robe (green)
    ADDITEM $item_gm robe green 
    204F GM Robe (blue)
    ADDITEM $item_gm robe blue 
}

SECTION_MENU ,"game master special items
{
    Game Master Special Items
    1F14 Teleport Rune
    ADDITEM $item_a_teleport rune
    1012 Master Shard Key
    ADDITEM $item_a_master shard key
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"gm_MENU
}

SECTION_MENU ,"advancement gates
{
    Advancement Gates
    < Black Smith
    ADDITEM $item_black smith
    < Swordsman
    ADDITEM $item_swordsman
    < Archer
    ADDITEM $item_archer
    < Mage
    ADDITEM $item_mage
    < Armsman
    ADDITEM $item_armsman
    < Fencer
    ADDITEM $item_fencer
    < Thief
    ADDITEM $item_thief
    < Bard
    ADDITEM $item_bard
    < Ranger
    ADDITEM $item_ranger
    < Assassin
    ADDITEM $item_assassin
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"gate_MENU
}

SECTION_MENU ,"other spawners
{
    Other Spawners
    < Goat Spawn
    ADDITEM $item_goat spawner
    < Harpy Spawn
    ADDITEM $item_harpy spawner
    < Random Lizard Spawn
    ADDITEM $item_random lizard spawn
    < Random Ratmen Spawn
    ADDITEM $item_random ratmen rpawn
    < Random Dragon and Drake
    ADDITEM $item_random dragon and drake
    < Random Cows Horses etc
    ADDITEM $item_random cows horses etc
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"spawner_MENU
}

SECTION_MENU ,"papua
{
    Papua
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"towns
    < Mage Shop
    GOPLACE 304
}

SECTION_MENU ,"delucia
{
    Delucia
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"towns
    < Center
    GOPLACE 305
}

SECTION_MENU ,"new undead creatures
{
    New Undead Creatures
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"monsters 1
    < a wraith
    NPC $npc a wraith
    < a dracula
    NPC
    < a zombie elder
    NPC $npc a zombie elder
    < a headless mage
    NPC
    < a liche elder
    NPC $npc a lich elder
    < a vampire (he)
    NPC
    < a vampire (she)
    NPC
    < a frankenstein
    NPC
}

SECTION_MENU ,"icefrost and stone
{
    IceFrost and Stone
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"monsters 1
    < ice snake
    NPC $npc an ice serpent
    < ice fiend
    NPC $npc an ice fiend
    < ice elemental
    NPC $npc an ice elemental
    < ice serpent
    NPC $npc a giant ice serpent
    < ice giant
    NPC $npc an ice giant
    < frost troll
    NPC $npc a frost troll
    < frost Ooze
    NPC $npc a frost ooze
    < frost spider
    NPC $npc a frost spider
    < stone harpy
    NPC $npc a stone harpy
    < stone gargoyle
    NPC $npc a stone gargoyle
    < stone elemental
    NPC $npc lizardman spear
}

SECTION_MENU ,"colored elementals
{
    Colored Elementals
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"monsters 1
    < Snow
    NPC $npc a snow elemental
    < Mud
    NPC $npc ice lizardman
    < Metal
    NPC $npc lava lizardman spear
    < Wood
    NPC $npc lava lizardman mace
    < Flesh
    NPC
    < Diamond
    NPC
    < Ruby
    NPC
    < Emerald
    NPC
    < Amber
    NPC
    < Sapphire
    NPC
    < Tourmaline
    NPC
    < Gold
    NPC
    < Silver
    NPC
    < Magna
    NPC
}

SECTION_MENU ,"dragon-kin
{
    Dragon-Kin
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"monsters 1
    < a Wyvern (brown)
    NPC $npc a wyvern
    < a Drake (red)
    NPC $npc a drake
    < a Drake (brown)
    NPC $npc a drake 1
    < a Dragon (brown)
    NPC $npc a dragon
    < a Dragon (red)
    NPC $npc a dragon 2
    < an ancient Wyrm (brown)
    NPC $npc an ancient wyrm
    < an ancient Wyrm (brown)
    NPC $npc an ancient wyrm 2
    < an ancient Wyrm (red)
    NPC $npc an ancient wyrm 1
    < a white wyrm
    NPC $npc a white wyrm 1
    < a pure white wyrm
    NPC $npc a white wyrm
    < a Dragon (brown)
    NPC $npc a dragon 1
    < a Drake (brown)
    NPC $npc a drake 2
    < a fire wyrm
    NPC $npc a fire wyrm
}


SECTION_MENU ,"baked and veggys 2
{
    Baked and Veggys 2
    103F Cookie Mix
    ADDITEM $item_cookie mix
    0C70 Lettuce
    ADDITEM $item_lettuce1
    0C72 Squash
    ADDITEM $item_squash1
    0C76 Carrots
    ADDITEM $item_carrots
    0C7B Cabbage
    ADDITEM $item_heads of cabbage
    0C7F Ear of Corn
    ADDITEM $item_ears of corn1 4
    1AD3 Donuts
    ADDITEM $item_donuts
    09EC Jar of Honey
    ADDITEM $item_jars of honey
    0C61 Turnip
    ADDITEM $item_turnip1
    0C68 Sprouts
    ADDITEM $item_sprouts
    0C6A Pumpkin
    ADDITEM $item_pumpkin1
    0C6D Onion
    ADDITEM $item_onions
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"food items
}

SECTION_MENU ,"bowls
{
    Bowls
    10E3 Dough
    ADDITEM $item_dough bowl
    15FE Carrots
    ADDITEM $item_bowl of carrots
    15FF Corn
    ADDITEM $item_bowl of corn
    1600 Lettuce
    ADDITEM $item_bowl of lettuce
    1601 Peas
    ADDITEM $item_bowl of peas
    1602 Potatoes
    ADDITEM $item_bowl of potatoes
    1604 Stew
    ADDITEM $item_bowl of stew
    1606 Tomato Soup
    ADDITEM $item_tomato soup
    15FD Pewter
    ADDITEM $item_pewter bowl
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"food items
}

SECTION_MENU ,"skills related_MENU
{
    Skills Related_MENU
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"nox-wizard gm_MENU
    0FAF Blacksmithing Items
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"blacksmithing items
    1034 Carpentry Items
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"carpentry items
    175D Tailoring Items
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"tailoring_MENU
    13FD Archery Items
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"archery items_MENU
    1E1A Fishing Items
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"fishing items
    < Musical Items
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"musical items
}

SECTION_MENU ,"tailoring_MENU
{
    Tailoring_MENU
    10A4 Spinning Wheel - not animated
    ADDITEM $item_spinning wheel 1
    10A5 Spinning Wheel - animated
    ADDITEM $item_spinning wheel 2
    1061 Upright Loom - 1st part South
    ADDITEM $item_upright loom
    1062 Upright Loom - 2nd part South
    ADDITEM $item_upright loom 1
    105F Upright Loom - 1st part East
    ADDITEM $item_upright loom 2
    1060 Upright Loom - 2nd part East
    ADDITEM $item_upright loom 3
    0DF8 Unspun Wool
    ADDITEM $item_piles of wool 1
    0E1D Ball of Yarn
    ADDITEM $item_balls of yarn
    175D Folded Cloth
    ADDITEM $item_cut cloth
    0F9D Sewing Kit
    ADDITEM $item_sewing kit
    0F9E Scissors
    ADDITEM $item_scissors
    0F95 Bolt of Cloth
    ADDITEM $item_bolts of cloth
    0F96 Bolt of Cloth
    ADDITEM $item_bolts of cloth 1
    0F97 Bolt of Cloth
    ADDITEM $item_bolts of cloth 2
    0F98 Bolt of Cloth
    ADDITEM $item_bolts of cloth 3
    0F99 Bolt of Cloth
    ADDITEM $item_bolts of cloth 4
    0F9A Bolt of Cloth
    ADDITEM $item_bolts of cloth 5
    0F9B Bolt of Cloth
    ADDITEM $item_bolts of cloth 6
    0F9C Bolt of Cloth
    ADDITEM $item_bolts of cloth 7
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"skills related_MENU
}

SECTION_MENU ,"plants_MENU
{
    Plants_MENU
    14f0 potted tree
    ADDITEM $item_potted tree
    14f0 potted tree
    ADDITEM $item_potted plant
    1E0F Potted Cactus w/flowers
    ADDITEM $item_potted cactus3
    1E10 Potted Cactus
    ADDITEM $item_potted cactus1
    1E11 Potted Cactus w/bush
    ADDITEM $item_potted cactus2
    1E12 Potted Branched Cactus
    ADDITEM $item_potted cactus4
    0C83 Campion Flowers
    ADDITEM $item_campion flowers
    0C84 Foxglove Flowers
    ADDITEM $item_potted foxglove
    0C85 Orfluer Flowers
    ADDITEM $item_potted orfluer
    0C86 Red Poppies
    ADDITEM $item_red poppies1
    0C88 Snow Drops
    ADDITEM $item_snow drops
    0C8F Hedge
    ADDITEM $item_hedge1
    0C93 Blade Plant
    ADDITEM $item_blade plant
    0CA1 Large Fern
    ADDITEM $item_large fern
    0CA5 Pampas Grass
    ADDITEM $item_pampas grass1
    0CC9 Spider Tree
    ADDITEM $item_spider tree
    0CC8 Juniper Bush
    ADDITEM $item_juniper bush
    0CC7 Weed
    ADDITEM $item_weed
    0D38 Yucca
    ADDITEM $item_yucca
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"decoration
}

SECTION_MENU ,"archery items_MENU
{
    Archery Items_MENU
    100A Archery Butte - East
    ADDITEM $item_archery butte
    100B Archery Butte - South
    ADDITEM $item_archery butte 1
    1BD1 5 Feathers
    ADDITEM $item_feathers
    1BD4 5 Shafts
    ADDITEM $item_shafts 5
    1020 Decorative Feathers
    ADDITEM $item_feathers 1
    1021 Decorative Feathers
    ADDITEM $item_feathers 2
    1022 Decorative Arrow Fletching
    ADDITEM $item_arrow fletching
    1023 Decorative Arrow Fletching
    ADDITEM $item_arrow fletching 1
    1024 Decorative Arrow Shafts
    ADDITEM $item_arrow shafts
    1025 Decorative Arrow Shafts
    ADDITEM $item_arrow shafts 1
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"skills related_MENU
}

SECTION_MENU ,"t2a monster_MENU
{
    T2A Monster_MENU
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"nox-wizard gm_MENU
    20DF T2A List 1
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"t2a monster list 1
    20DF T2A List 2
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"t2a monster list 2
    20DF T2A List 3
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"t2a monster list 3
}

SECTION_MENU ,"t2a monster list 1
{
    T2A Monster List 1
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"t2a monster_MENU
    005F Kraken
    NPC $npc a kraken
    004B Titan
    NPC $npc a titan
    0050 Giant Toad
    NPC $npc a giant toad
    0051 Bullfrog
    NPC $npc a bullfrog
    004C Cyclopedian Warrior
    NPC $npc a cyclopedian warrior
    0003 Mummy
    NPC $npc a mummy
    000D Snow Elemental
    NPC $npc a snow elemental
    0034 Ice Snake
    NPC $npc an ice serpent
    0035 Frost Troll
    NPC $npc a frost troll
    0008 SwamP_Tentacle
    NPC $npc a swamP_tentacle
    0047 Terathen Drone
    NPC $npc a terathan drone
    0048 Terathen Warrior
    NPC $npc a terathan warrior
    0048 Terathen Avenger
    NPC $npc a terathan avenger
    0046 Terathen Matriarche
    NPC $npc a terathan matriarch
    0047 Terathen Newt
    NPC $npc banker f
    001E Stone Harpy
    NPC $npc a stone harpy
    0004 Stone Gargoyle
    NPC $npc a stone gargoyle
}

SECTION_MENU ,"t2a monster list 2
{
    T2A Monster List 2
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"t2a monster_MENU
    0027 Imp
    NPC $npc an imp
    0009 Ice Fiend
    NPC $npc an ice fiend
    0027 Mirt Imp
    NPC 
    0056 Ophidian Warrior
    NPC $npc an ophidian warrior
    0056 Ophidian Enforcer
    NPC $npc an ophidian enforcer
    0056 Ophidian Avenger
    NPC $npc an ophidian avenger
    0055 Ophidian Apprentice
    NPC $npc an ophidian apprentice mage
    0055 Ophidian Shaman
    NPC $npc an ophidian shaman
    0057 Ophidian Matriarche
    NPC $npc an ophidian matriarch
    00CE Lava Lizard
    NPC $npc a lava lizard
    00CC A Nightmare
    NPC $npc a nightmare
    00DA Frenzied Ostard
    NPC $npc a frenzied ostard
    00DB Forest Ostard
    NPC $npc a forest ostard
    00D2 Desert Ostard
    NPC $npc a desert ostard
    000D Efreet
    NPC $npc an efreet
    0033 Frost Ooze
    NPC $npc a frost ooze
}

SECTION_MENU ,"t2a monster list 3
{
    T2A Monster List 3
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"t2a monster_MENU
    0016 Gazer Chief
    NPC $npc an elder gazer
    00C9 Hellcat
    NPC $npc a hellcat
    00D6 Hellcat Predator
    NPC $npc a hellcat predator
    000E Ice Elemental
    NPC $npc an ice elemental
    0056 Ophidian Knight
    NPC $npc an ophidian knight-errant
    0005 Phoenix
    NPC $npc a phoenix
    0015 Ice Serpent
    NPC $npc a giant ice serpent
    0015 Lava Serpent
    NPC $npc a giant lava serpent
    001C Frost Spider
    NPC $npc a frost spider
}

//Shadow Plate Armor
SECTION_MENU ,"shadow plate armor_MENU
{
    Shadow Plate Armor_MENU
    1416 Shadow Plate Tunic
    ADDITEM $item_shadow platemail
    1c04 Shadow Female Plate
    ADDITEM $item_shadow female plate
    1413 Shadow Plate Gorget
    ADDITEM $item_shadow plate gorget
    1414 Shadow Plate Gloves
    ADDITEM $item_shadow plate gloves
    140d Shadow Bascinet Helm
    ADDITEM $item_shadow bascinet
    140F Shadow Nose Helm
    ADDITEM $item_shadow nose helm
    1409 Shadow Close Helm
    ADDITEM $item_shadow close helm
    1412 Shadow Plate Helm
    ADDITEM $item_shadow plate helm
    141A Shadow Plate Legs
    ADDITEM $item_shadow plate leggings
    1410 Shadow Plate Sleeves
    ADDITEM $item_shadow plate sleeves
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
}

SECTION_MENU ,"golden plate armor_MENU
{
    Golden Plate Armor_MENU
    1416 Golden Plate Tunic
    ADDITEM $item_golden platemail
    1c04 Golden Female Plate
    ADDITEM $item_golden female plate
    1413 Golden Plate Gorget
    ADDITEM $item_golden plate gorget
    1414 Golden Plate Gloves
    ADDITEM $item_golden plate gloves
    140d Golden Bascinet Helm
    ADDITEM $item_golden bascinet
    140F Golden Nose Helm
    ADDITEM $item_iron nose helm 1
    1409 Golden Close Helm
    ADDITEM $item_golden close helm
    1412 Golden Plate Helm
    ADDITEM $item_golden plate helm
    141A Golden Plate Legs
    ADDITEM $item_golden plate leggings
    1410 Golden Plate Sleeves
    ADDITEM $item_golden plate sleeves
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
}

SECTION_MENU ,"fishing items
{
    Fishing items
    0DBF Fishing Pole
    ADDITEM $item_a_fishing pole
    097B Fish Steak
    ADDITEM $item_fish steaks
    1E1A Fish Head
    ADDITEM $item_fish head
    09CC A fish
    ADDITEM $item_fish
    1E17 Raw Fish
    ADDITEM $item_raw fish
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"skills related_MENU
}

SECTION_MENU ,"merkite plate armor_MENU
{
    Merkite Plate Armor_MENU
    1416 Merkite Plate Tunic
    ADDITEM $item_merkite platemail
    1c04 Merkite Female Plate
    ADDITEM $item_merkite female plate
    1413 Merkite Plate Gorget
    ADDITEM $item_merkite plate gorget
    1414 Merkite Plate Gloves
    ADDITEM $item_merkite plate gloves
    141A Merkite Plate Legs
    ADDITEM $item_merkite plate leggings
    1410 Merkite Plate Sleeves
    ADDITEM $item_merkite plate sleeves
    1412 Merkite Plate Helm
    ADDITEM $item_merkite plate helm
    140F Merkite Nose Helm
    ADDITEM $item_valorite nose helm
    1409 Merkite Close Helm
    ADDITEM $item_merkite close helm
    140f Merkite Bascinet Helm
    ADDITEM 
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
}

SECTION_MENU ,"musical items
{
    Musical Items
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"skills related_MENU
    < Drum
    ADDITEM $item_drum
    < Tamberine
    ADDITEM $item_tambourine
    < Tamberine with ribbon
    ADDITEM $item_tambourine 1
    < Standing Harp
    ADDITEM $item_standing harp
    < Harp
    ADDITEM $item_laP_harp
    < Lute
    ADDITEM $item_lute
    < Lute
    ADDITEM $item_lute 1
}

SECTION_MENU ,"multi advancement gates
{
    Multi Advancement Gates
    < Black Smith
    ADDITEM $item_black smith 1
    < Swordsman
    ADDITEM $item_swordsman 1
    < Archer
    ADDITEM $item_archer 3
    < Mage
    ADDITEM $item_mage 1
    < Armsman
    ADDITEM $item_armsman 1
    < Fencer
    ADDITEM $item_fencer 1
    < Thief
    ADDITEM $item_thief 1
    < Bard
    ADDITEM $item_bard 1
    < Ranger
    ADDITEM $item_ranger 1
    < Assassin
    ADDITEM $item_assassin 1
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"gate_MENU
}

SECTION_MENU ,"monster gates
{
    Monster Gates
    < Orc
    ADDITEM $item_orc
    < Ettin
    ADDITEM $item_ettin
    < Troll
    ADDITEM $item_troll
    < Skeleton
    ADDITEM $item_skeleton
    < Lich
    ADDITEM $item_liche
    < Daemon
    ADDITEM $item_daemon
    < Dragon
    ADDITEM $item_dragon
    < Drake
    ADDITEM $item_drake
    < Male Human
    ADDITEM $item_male human
    < Female Human
    ADDITEM $item_female human
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"gate_MENU
}

SECTION_MENU ,"verite plate armor_MENU
{
    Verite Plate Armor_MENU
    1416 Verite Plate Tunic
    ADDITEM $item_verite platemail
    1c04 Verite Female Plate
    ADDITEM $item_verite female plate
    1413 Verite Plate Gorget
    ADDITEM $item_verite plate gorget
    1414 Verite Plate Gloves
    ADDITEM $item_verite plate gloves
    141A Verite Plate Legs
    ADDITEM $item_verite plate leggings
    1410 Verite Plate Sleeves
    ADDITEM $item_verite plate sleeves
    1412 Verite Plate Helm
    ADDITEM $item_verite plate helm
    140F Verite Nose Helm
    ADDITEM $item_verite nose helm
    1409 Verite Close Helm
    ADDITEM $item_verite close helm
    140B Verite Helm
    ADDITEM $item_verite helmet
    140D Verite Bascinet
    ADDITEM $item_verite bascinet
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
}

SECTION_MENU ,"valorite plate armor_MENU
{
    Valorite Plate Armor_MENU
    1416 Valorite Plate Tunic
    ADDITEM $item_valorite platemail
    1413 Valorite Plate Gorget
    ADDITEM $item_valorite plate gorget
    1414 Valorite Plate Gloves
    ADDITEM $item_valorite plate gloves
    141A Valorite Plate Legs
    ADDITEM $item_valorite plate leggings
    1410 Valorite Plate Sleeves
    ADDITEM $item_valorite plate sleeves
    1412 Valorite Plate Helm
    ADDITEM $item_valorite plate helm
    140F Valorite Nose Helm
    ADDITEM $item_valorite nose helm
    1409 Valorite Close Helm
    ADDITEM $item_valorite close helm
    140B Valorite Helm
    ADDITEM $item_valorite helmet
    140D Valorite Bascinet
    ADDITEM $item_valorite bascinet
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
}

SECTION_MENU ,"bronze plate armor_MENU
{
    Bronze Plate Armor_MENU
    1416 Bronze Plate Tunic
    ADDITEM $item_bronze platemail
    1c04 Bronze Female Plate
    ADDITEM $item_bronze female plate
    1413 Bronze Plate Gorget
    ADDITEM $item_bronze plate gorget
    1414 Bronze Plate Gloves
    ADDITEM $item_bronze plate gloves
    141A Bronze Plate Legs
    ADDITEM $item_bronze plate leggings
    1410 Bronze Plate Sleeves
    ADDITEM $item_bronze plate sleeves
    1412 Bronze Plate Helm
    ADDITEM $item_bronze plate helm
    140F Bronze Nose Helm
    ADDITEM $item_bronze nose helm
    1409 Bronze Close Helm
    ADDITEM $item_bronze close helm
    140B Bronze Helm
    ADDITEM $item_bronze helmet
    140D Bronze Bascinet
    ADDITEM $item_bronze bascinet
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
}

SECTION_MENU ,"armor 1
{
    Armor/Weapons/Shields
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"combat_MENU
    1416 Colored Plate Mail
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"colored plate
    13C4 Colored Chain Mail
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"colored chain mail
    13E2 Phoenix Armor
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"phoenix armor
    1416 Plate Mail
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"plate mail
    1416 Ranger Armor
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"ranger armor
    1454 Bone Mail
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"bone armor
    13C4 Chain Mail
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"chain mail
    13ED Ring Mail
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"ring mail
    13E2 Studded Leather Armor
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor
    13D3 Leather Armor
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"leather armor
    140C Miscellaneous Helms
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"miscellaneous helms
    1C00 Female Armor
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"female armor
    13d9 Magical Armor
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic armor
    13BA Weapons
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"weapons
    13B8 Magical Weapons
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magical weapons
    1BC3 Shields
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"shields
    1BC3 Magical Shields
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic sheilds
}

SECTION_MENU ,"ranger armor
{
    Ranger Armor
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
    < Ranger Tunic
    ADDITEM $item_ranger tunic
    < Ranger Gorget
    ADDITEM $item_ranger gorget
    < Ranger Gloves
    ADDITEM $item_ranger gloves
    < Ranger Sleeves
    ADDITEM $item_ranger sleeves
    < Ranger Leggings
    ADDITEM $item_ranger leggings
}

SECTION_MENU ,"magic sheilds
{
    Magic Sheilds
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
    < magic bronze shield
    ADDITEM $item_iron bronze shield of defence
    < magic bronze shield
    ADDITEM $item_iron bronze shield of guarding
    < magic bronze shield
    ADDITEM $item_iron bronze shield of hardening
    < magic bronze shield
    ADDITEM $item_iron bronze shield of fortification
    < magic bronze shield
    ADDITEM $item_iron bronze shield of invulnerablity
    < magic buckler
    ADDITEM $item_iron buckler of defence
    < magic buckler
    ADDITEM $item_iron buckler of guarding
    < magic buckler
    ADDITEM $item_iron buckler of hardening
    < magic buckler
    ADDITEM $item_iron buckler of fortification
    < magic buckler
    ADDITEM $item_iron buckler of invulnerablity
    1BC3 Next
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic sheilds 1
}

SECTION_MENU ,"magic sheilds 1
{
    Magic Sheilds
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic sheilds
    < magic kite shield
    ADDITEM $item_iron kite shield of defence
    < magic kite shield
    ADDITEM $item_iron kite shield of guarding
    < magic kite shield
    ADDITEM $item_iron kite shield of hardening
    < magic kite shield
    ADDITEM $item_iron kite shield of fortification
    < magic kite shield
    ADDITEM $item_iron kite shield of invulnerablity
    < magic metal shield
    ADDITEM $item_iron metal shield of defence
    < magic metal shield
    ADDITEM $item_iron metal shield of guarding
    < magic metal shield
    ADDITEM $item_iron metal shield of hardening
    < magic metal shield
    ADDITEM $item_iron metal shield of fortification
    < magic metal shield
    ADDITEM $item_iron metal shield of invulnerablity
    < magic wooden kite shield
    ADDITEM $item_iron wooden kite shield of defence
    1BC3 Next
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic sheilds 2
}

SECTION_MENU ,"magic sheilds 2
{
    Magic Sheilds
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic sheilds 1
    < magic wooden kite shield
    ADDITEM $item_iron wooden kite shield of guarding
    < magic wooden kite shield
    ADDITEM $item_iron wooden kite shield of hardening
    < magic wooden kite shield
    ADDITEM $item_iron wooden kite shield of fortification
    < magic wooden kite shield
    ADDITEM $item_iron wooden kite shield of invulnerablity
    < magic wooden shield
    ADDITEM $item_iron wooden shield of defence
    < magic wooden shield
    ADDITEM $item_iron wooden shield of guarding
    < magic wooden shield
    ADDITEM $item_iron wooden shield of hardening
    < magic wooden shield
    ADDITEM $item_iron wooden shield of fortification
    < magic wooden shield
    ADDITEM $item_iron wooden shield of invulnerablity
    < magic heater
    ADDITEM $item_iron heater sheild of defence
    < magic heater
    ADDITEM $item_iron heater sheild of guarding
    < magic heater
    ADDITEM $item_iron heater sheild of hardening
    < magic heater
    ADDITEM $item_iron heater sheild of fortification
    < magic heater
    ADDITEM $item_iron heater sheild of invulnerablity
}

SECTION_MENU ,"colored chain mail
{
    Colored Chain Mail
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
    < Black Chain
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"shadow chain
    < Gold Chain
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"gold chain
    < Merkite Chain
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"merkite chain
    < Verite Chain
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"verite chain
    < Mythril Chain
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"mythril chain
    < Bronze Chain
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"bronze chain
    < Agapite Chain
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"agapite chain
}

SECTION_MENU ,"colored plate
{
    Colored Plate
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
    1416 Shadow Plate
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"shadow plate armor_MENU
    1416 Gold Plate
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"golden plate armor_MENU
    1416 Merkite Plate
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"merkite plate armor_MENU
    1416 Verite Plate
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"verite plate armor_MENU
    1416 Valorite Plate
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"valorite plate armor_MENU
    1416 Bronze Plate
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"bronze plate armor_MENU
    1416 Agapite Plate
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"agapite plate armor_MENU
    1416 Copper Plate
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"copper plate armor_MENU
}

SECTION_MENU ,"shadow chain
{
    Shadow Chain
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"colored chain mail
    < Shadow Chain Tunic
    ADDITEM $item_shadow chain tunic
    < Shadow Chain Legs
    ADDITEM $item_shadow chain leggings
    < Shadow Chain Coif
    ADDITEM $item_shadow chain coif
}

SECTION_MENU ,"gold chain
{
    Gold Chain
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"colored chain mail
    < Gold Chain Tunic
    ADDITEM $item_golden chain tunic
    < Gold Chain Legs
    ADDITEM $item_golden chain leggings
    < Gold Chain Coif
    ADDITEM $item_golden chain coif
}

SECTION_MENU ,"merkite chain
{
    Merkite Chain
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"colored chain mail
    < Merkite Chain Tunic
    ADDITEM $item_merkite chain tunic
    < Merkite Chain Legs
    ADDITEM $item_merkite chain leggings
    < Merkite Chain Coif
    ADDITEM $item_merkite chain coif
}

SECTION_MENU ,"verite chain
{
    Verite Chain
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"colored chain mail
    < Verite Chain Tunic
    ADDITEM $item_verite chain tunic
    < Verite Chain Legs
    ADDITEM $item_verite chain leggings
    < Verite Chain Coif
    ADDITEM $item_verite chain coif
}

SECTION_MENU ,"mythril chain
{
    Mythril Chain
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"colored chain mail
    < Mythril Chain Tunic
    ADDITEM $item_valorite chain tunic
    < Mythril Chain Legs
    ADDITEM $item_valorite chain leggings
    < Mythril Chain Coif
    ADDITEM $item_valorite chain coif
}

SECTION_MENU ,"custom race
{
    Custom Race
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"merchants
    < The Elven Female
    NPC $npc elf f
    < The Elven Male
    NPC $npc elf m
    < The High Elf
    NPC $npc high elf m
    < The High Elves
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"the high elves
    < The Wood Elves
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"the wood elves
    < The Drow Elves
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"the drow elves
}

SECTION_MENU ,"new monsters
{
    New Monsters
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"monsters 1
    < New Monsters 1
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"new monsters 1
    < New Monsters 2
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"new monsters 2
    < New Monsters 3
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"new monsters 3
    < New Monsters 4
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"new monsters 4
    < New Monsters 5
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"new monsters 5
}

SECTION_MENU ,"new monsters 1
{
    New Monsters 1
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"new monsters
    < Lizzardman Archer
    NPC $npc lizardman archer
    < Orcish Raider
    NPC $npc orc captain
    < Troll Stalker
    NPC 
    < Ratman Mage
    NPC 
}

SECTION_MENU ,"new monsters 2
{
    New Monsters 2
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"new monsters
    < an Oghre
    NPC
    < a Fallen One
    NPC
    < a Burning One
    NPC $npc a burning skeleton
    < a Rotting Corpse
    NPC
}

SECTION_MENU ,"new monsters 3
{
    New Monsters 3
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"new monsters
    < a Ghost
    NPC $npc a ghost
    < a Demon Dog
    NPC $npc a fire wyrm
    < Nebron
    NPC $npc land lord
    < a Fire Lord
    NPC $npc a fire lord
}

SECTION_MENU ,"quest npc`s
{
    Quest NPC`s
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"npc_MENU
    < Gromph BaenreDrow ArchMage
    NPC $npc gromph
    < JeremyThe Knight
    NPC $npc knight 2
    < JasonThe Knight
    NPC $npc knight 3
    < Quest Knight
    NPC $npc quest knight m
    < a Converted Quest Knight
    NPC $npc converted quest knight
}

SECTION_MENU ,"area spawners 1
{
    Area Spawners 1
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"spawner_MENU
    < Random Dog & Cat
    ADDITEM $item_town area spawner
    < Random SwamP_Creatures
    ADDITEM $item_swamP_area spawner
    < Random Jungle Creatures
    ADDITEM $item_jungle area spawner
    < Random CowsHorsesect
    ADDITEM $item_random cowshorsesect
    < Random Birds
    ADDITEM $item_random birds
    < Random All Animals
    ADDITEM $item_random all animals
    < Random Small Animals
    ADDITEM $item_random small animals
    < Random Productive Animals
    ADDITEM $item_random productive animals
    < Random Bears
    ADDITEM $item_random bears
    < Random Strong Undead
    ADDITEM $item_random strong undead
    < Random Weak Undead
    ADDITEM $item_random weak undead
    < Random All Undead
    ADDITEM $item_random all undead
}
SECTION_MENU ,"area spawners 2
{
    Area Spawners 2
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"spawner_MENU
    < Random Orcs
    ADDITEM $item_random orcs
    < Random EttinsOgres and Trolls
    ADDITEM $item_random ettinsogres and trolls
    < Random Med Orcs
    ADDITEM $item_random med orcs
    < Random Weaker Orcs
    ADDITEM $item_random weaker orcs
    < Random Orc-Kin
    ADDITEM $item_random crc-kin
    < Random Dragons and Drakes
    ADDITEM $item_random dragon and drake 1
    < Random Daemons
    ADDITEM $item_random daemons
    < Random Elementals
    ADDITEM $item_random elementals
    < Random Elementals and Daemons
    ADDITEM $item_random elementals and daemons
    < Random Ratmen
    ADDITEM $item_random ratmen
    < Random Lizzardmen
    ADDITEM $item_random lizzardmen
    < Random Overworld Monsters
    ADDITEM $item_random overworld monsters
}

SECTION_MENU ,"bronze chain
{
    Bronze Chain
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"colored chain mail
    < Bronze Chain Tunic
    ADDITEM $item_bronze chain tunic
    < Bronze Chain Legs
    ADDITEM $item_bronze chain leggings
    < Bronze Chain Coif
    ADDITEM $item_bronze chain coif
}

SECTION_MENU ,"the drow elves
{
    The Drow Elves
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"custom race
    < The Drow Weapon Lord
    NPC $npc drow weapon lord
    < The Dark Elf Assassin
    NPC $npc drow assassin
    < The Matron Mistress
    NPC $npc drow mistress
    < The Drow Warrior
    NPC $npc drow warrior
    < The Drow Priestess
    NPC $npc drow drow priestess
    < The Drow High Priestess
    NPC $npc drow high priestess
    < The Dark Elf Archer
    NPC $npc drow archer
    < The Drow Wizard
    NPC $npc drow wizard
}

SECTION_MENU ,"enchanted weapons
{
    Enchanted Weapons
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"combat_MENU
    < Staff Of Summoning Demon
    ADDITEM $item_staff of summoning demon
    < Staff Of Summoning Hero
    ADDITEM $item_staff of summoning hero
    < Viking Of Flamestrike
    ADDITEM $item_iron viking sword of flamestrike
    < Viking Of Feeblemind
    ADDITEM $item_iron viking sword of feeblemind
    < Viking Of Mana Drain
    ADDITEM $item_iron viking sword of mana drain
    < Viking Of Lightning
    ADDITEM $item_iron viking sword of lightning
    < Viking Of Energy Bolt
    ADDITEM $item_iron viking sword of energy bolt
    < Viking Of Invisibility
    ADDITEM $item_iron viking sword of invisibility
    < Viking Of Resurrection
    ADDITEM $item_iron viking sword of resurrection
    < Long Sword Of Flamestrike
    ADDITEM $item_iron long sword of flamestrike
    < Long Sword Of Feeblemind
    ADDITEM $item_iron long sword of feeblemind
    < Long Sword Of Mana Drain
    ADDITEM $item_iron long sword of mana drain
    < Long Sword Of Lightning
    ADDITEM $item_iron long sword of lightning
    < Long Sword Of Energy Bolt
    ADDITEM $item_iron long sword of energy bolt
    < Long Sword Of Invisibility
    ADDITEM $item_iron long sword of invisibility
    < Long Sword Of Resurrection
    ADDITEM $item_iron long sword of resurrection
}

SECTION_MENU ,"the high elves
{
    The High Elves
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"custom race
    < High Elven King
    NPC $npc high elf king
    < High Elven Prince
    NPC $npc high elf prince
    < High Elven Mage
    NPC $npc high elf mage
    < High Elven Enchantress
    NPC $npc high elf enchantress
}

SECTION_MENU ,"the wood elves
{
    The Wood Elves
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"custom race
    < Basic Elven Male
    NPC $npc wood elf male
    < Basic Elven Female
    NPC $npc wood elf female
    < Wood Elf King
    NPC $npc wood elf king
    < Wood Elf Queen
    NPC $npc wood elf queen
    < Wood Elf Archer (Male)
    NPC $npc wood elf archer m
    < Wood Elf Archer (Female)
    NPC $npc wood elf archer f
    < Wood Elf Wizard
    NPC $npc wood elf wizard
    < Wood Elf Enchantress
    NPC $npc wood elf enchantress
    < Wood Elf Priest
    NPC $npc wood elf priest
    < Wood Elf Priestess
    NPC $npc wood elf priestess
}

SECTION_MENU ,"agapite chain
{
    Agapite Chain
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"colored chain mail
    < Agapite Chain Tunic
    ADDITEM $item_agapite chain tunic
    < Agapite Chain Legs
    ADDITEM $item_agapite chain leggings
    < Agapite Chain Coif
    ADDITEM $item_agapite chain coif
}

SECTION_MENU ,"random spawners
{
    Random Spawners
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"spawner_MENU
    < Arctic Spawns
    ADDITEM $item_random arctic spawner
    < Cave Spawns
    ADDITEM $item_random cave spawner
    < Desert Spawns
    ADDITEM $item_random desert spawner
    < Dungeon Spawns
    ADDITEM $item_random dungeon spawner
    < Eerie Spawns
    ADDITEM $item_random eerie place spawner
    < Farm Spawns
    ADDITEM $item_random farm spawner
    < Forest Spawns
    ADDITEM $item_random forest spawner
    < Jungle Spawns
    ADDITEM $item_random jungle spawner
    < Mountain Spawns
    ADDITEM $item_random mountain spawner
    < Ocean Spawns
    ADDITEM $item_random ocean spawner
    < SwamP_Spawns
    ADDITEM $item_random swamP_spawner
    < Town Spawns
    ADDITEM $item_random town spawner
    < Volcanic Spawns
    ADDITEM $item_random volcanic spawner
    < Drow Spawns
    ADDITEM $item_random drow spawner
    < Diablo Spawns
    ADDITEM $item_random diablo spawner
    < Wood Elves Spawns
    ADDITEM $item_random wood elves spawner
    < High Elves Spawns
    ADDITEM $item_random high elves spawner
}

SECTION_MENU ,"new monsters 4
{
    New Monsters 4
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"new monsters
    < a Ice Titan
    NPC $npc an ice titan
    < a Giant Slime
    NPC $npc a giant slime
    < a Savage
    NPC $npc a savage
    < a Savage
    NPC $npc a savage 1
    < a Savage Shaman
    NPC $npc a savage shaman
    < a Savage Chief
    NPC $npc a savage chief
    < a Dragoon
    NPC 
}

SECTION_MENU ,"new monsters 5
{
    New Monsters 5
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"new monsters
    < Cottonmouth Dread
    NPC $npc a cottonmouth dread
    < Cottonmouth Piercer
    NPC $npc a cottonmouth piercer
    < Cottonmouth Fanger
    NPC $npc a cottonmouth fanger
    < Cottonmouth Newt
    NPC $npc a cottonmouth newt
    < Cottonmouth Nagi
    NPC $npc a cottonmouth nagi
    < Cottonmouth Layer
    NPC $npc a cottonmouth layer
}

SECTION_MENU ,"enchanted weapons 2
{
    Enchanted Weapons 2
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"combat_MENU
    < Scimitar Of Flamestrike
    ADDITEM $item_iron scimitar of flamestrike
    < Scimitar Of Feeblemind
    ADDITEM $item_iron scimitar of feeblemind
    < Scimitar Of Mana Drain
    ADDITEM $item_iron scimitar of mana drain
    < Scimitar Of Lightning
    ADDITEM $item_iron scimitar of lightning
    < Scimitar Of Energy Bolt
    ADDITEM $item_iron scimitar of energy bolt
    < Scimitar Of Invisibility
    ADDITEM $item_iron scimitar of invisibility
    < Scimitar Of Resurrection
    ADDITEM $item_iron scimitar of resurrection
    < Broad Sword Of Flamestrike
    ADDITEM $item_iron broad sword of flamestrike
    < Broad Sword Of Feeblemind
    ADDITEM $item_iron broad sword of feeblemind
    < Broad Sword Of Mana Drain
    ADDITEM $item_iron broad sword of mana drain
    < Broad Sword Of Lightning
    ADDITEM $item_iron broad sword of lightning
    < Broad Sword Of Energy Bolt
    ADDITEM $item_iron broad sword of energy bolt
    < Broad Sword Of Invisibility
    ADDITEM $item_iron broad sword of invisibility
    < Broad Sword Of Resurrection
    ADDITEM $item_iron broad sword of resurrection
}

SECTION_MENU ,"misc items
{
    Misc Items
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"equipment
    < A Goblet
    ADDITEM $item_a_goblet
    < A Golden Goblet
    ADDITEM $item_a_golden goblet
    < A Pewter Mug
    ADDITEM $item_a_pewter mug
    < A Vase
    ADDITEM $item_a_vase
    < Jars
    ADDITEM $item_jars
    < A Boat Model
    ADDITEM $item_a_boat model
    < A Set of Vials
    ADDITEM $item_a_set of vials
    < A skull
    ADDITEM $item_a_skull
    < A skull candle deed
    ADDITEM $item_a_skull candle deed
}

SECTION_MENU ,"cocoons and cocoon spawner
{
    Cocoons and Cocoon Spawner
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"spawner_MENU
    < Cocoon 1
    ADDITEM $item_strange cocoon
    < Cocoon 2
    ADDITEM $item_strange cocoon 1
    < Cocoon Spawner
    ADDITEM $item_cocoon spawner
    < Silk Fluxing Tool
    ADDITEM $item_silk fluxing tool
}

SECTION_MENU ,"agapite plate armor_MENU
{
    Agapite Plate Armor_MENU
    1416 Agapite Plate Tunic
    ADDITEM $item_agapite platemail
    1413 Agapite Plate Gorget
    ADDITEM $item_agapite plate gorget
    1414 Agapite Plate Gloves
    ADDITEM $item_agapite plate gloves
    141A Agapite Plate Legs
    ADDITEM $item_agapite plate leggings
    1410 Agapite Plate Sleeves
    ADDITEM $item_agapite plate sleeves
    1412 Agapite Plate Helm
    ADDITEM $item_agapite plate helm
    140F Agapite Nose Helm
    ADDITEM $item_agapite nose helm
    1409 Agapite Close Helm
    ADDITEM $item_agapite close helm
    140D Agapite Bascinet
    ADDITEM $item_agapite bascinet
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
}

SECTION_MENU ,"copper plate armor_MENU
{
    Copper Plate Armor_MENU
    1416 Copper Plate Tunic
    ADDITEM $item_copper platemail
    1413 Copper Plate Gorget
    ADDITEM $item_copper plate gorget
    1414 Copper Plate Gloves
    ADDITEM $item_copper plate gloves
    141A Copper Plate Legs
    ADDITEM $item_copper plate leggings
    1410 Copper Plate Sleeves
    ADDITEM $item_copper plate sleeves
    1412 Copper Plate Helm
    ADDITEM $item_copper plate helm
    140F Copper Nose Helm
    ADDITEM $item_copper nose helm
    1409 Copper Close Helm
    ADDITEM $item_copper close helm
    140D Copper Bascinet
    ADDITEM $item_copper bascinet
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"armor 1
}

SECTION_MENU ,"chain of defence
{
    Chain of Defence
    13C4 Magic Chain Tunic
    ADDITEM $item_iron chainmail of defence
    13C3 Magic Chain Legs
    ADDITEM $item_iron chain legs of defence
    13BB Magic Chain Coif
    ADDITEM $item_iron chain coif of defence
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic chain mail
}

SECTION_MENU ,"magic chain of guarding
{
    Magic Chain of Guarding
    13C4 Magic Chain Tunic of Guarding
    ADDITEM $item_iron chainmail of guarding
    13C3 Magic Chain Legs of Guarding
    ADDITEM $item_iron chain legs of guarding
    13BB Magic Chain Coif of Guarding
    ADDITEM $item_iron chain coif of guarding
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic chain mail
}

SECTION_MENU ,"magic chain of hardening
{
    Magic Chain of Hardening
    13C4 Magic Chain Tunic of Hardening
    ADDITEM $item_iron chainmail of hardening
    13C3 Magic Chain Legs of Hardening
    ADDITEM $item_iron chain legs of hardening
    13BB Magic Chain Coif of Hardening
    ADDITEM $item_iron chain coif of hardening
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic chain mail
}

SECTION_MENU ,"magic chain of fortification
{
    Magic Chain of Fortification
    13C4 Magic Chain Tunic of Fortification
    ADDITEM $item_iron chainmail of fortification
    13C3 Magic Chain Legs of Fortification
    ADDITEM $item_iron chain legs of fortification
    13BB Magic Chain Coif of Fortification
    ADDITEM $item_iron chain coif of fortification
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic chain mail
}

SECTION_MENU ,"magic chain of invulnerability
{
    Magic Chain of Invulnerability
    13C4 Magic Chain Tunic of Invulnerability
    ADDITEM $item_iron chainmail of invulnerability
    13C3 Magic Chain Legs of Invulnerability
    ADDITEM $item_iron chain legs of invulnerability
    13BB Magic Chain Coif of Invulnerability
    ADDITEM $item_iron chain coif of invulnerability
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"magic chain mail
}

SECTION_MENU ,"choose a magic formula
{
    Choose a magic formula
    0F08 a agility potion
    GRINDPOTION 11
    0F08 a greater agility potion
    GRINDPOTION 12
}

SECTION_MENU ,"choose a magic formula 1
{
    Choose a magic formula
    0F07 a  lesser cure potion
    GRINDPOTION 21
    0F07 a cure potion
    GRINDPOTION 22
    0F07 a greater cure potion
    GRINDPOTION 23
}

SECTION_MENU ,"choose a magic formula 2
{
    Choose a magic formula
    0F0D a lesser explosion potion
    GRINDPOTION 31
    0F0D a explosion potion
    GRINDPOTION 32
    0F0D a greater explosion potion
    GRINDPOTION 33
}

SECTION_MENU ,"choose a magic formula 3
{
    Choose a magic formula
    0F0C a lesser heal potion
    GRINDPOTION 41
    0F0C a heal potion
    GRINDPOTION 42
    0F0C a greater heal potion
    GRINDPOTION 43
}

SECTION_MENU ,"choose a magic formula 4
{
    Choose a magic formula
    0F06 a nightsight potion
    GRINDPOTION 51
}

SECTION_MENU ,"choose a magic formula 5
{
    Choose a magic formula
    0F0A a lesser poison potion
    GRINDPOTION 61
    0F0A a poison potion
    GRINDPOTION 62
    0F0A a greater poison potion
    GRINDPOTION 63
    0F0A a deadly poison potion
    GRINDPOTION 64
}

SECTION_MENU ,"choose a magic formula 6
{
    Choose a magic formula
    0F0B a refresh potion
    GRINDPOTION 71
    0F0B a greater refresh potion
    GRINDPOTION 72
}

SECTION_MENU ,"choose a magic formula 7
{
    Choose a magic formula
    0F09 a strength potion
    GRINDPOTION 81
    0F09 a greater strength potion
    GRINDPOTION 82
}

SECTION_MENU ,"pot of wax
{
    Pot of Wax
    142a Pot of Wax
    ADDITEM $item_pots of wax
}
SECTION_MENU ,"waxwork- candles
{
    Waxwork- Candles
    1428 Dipping Stick
    ADDITEM $item_dipping stick
    1433 One Candle
    ADDITEM $item_candle 1
}
SECTION_MENU ,"candles
{
    Candles
    0a26 small Candelabra
    ADDITEM $item_candle 2
    0a27 Candelabra
    ADDITEM $item_candlabra
    0a29 large Candelabra
    ADDITEM $item_candalabra
    0a28 Candles
    ADDITEM 
}
SECTION_MENU ,"flax
{
    Flax
    1a99 flax
    ADDITEM $item_flax1
    1a9a flax
    ADDITEM $item_flax1 2
    1a9b flax
    ADDITEM $item_flax1 3
}
SECTION_MENU ,"books 1
{
    Books
    1e24 books
    ADDITEM $item_books
    1e25 books
    ADDITEM $item_books 1
}

SECTION_MENU ,"shopkeeper spawners 1 invul 
{
    Shopkeeper Spawners 1 (INVUL)
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"spawner_MENU
    < Banker-M
    ADDITEM $item_banker spawner-m
    < Banker-F
    ADDITEM $item_banker spawner-f
    < Bard-M
    ADDITEM $item_bard spawner-f
    < Bard-F
    ADDITEM $item_bard spawner-m
    < Miner-M
    ADDITEM $item_miner spawner-m
    < Miner-F
    ADDITEM $item_miner spawner-f
    < Weaponsmith-M
    ADDITEM $item_weaponsmith spawner-m
    < Weaponsmith-F
    ADDITEM $item_weaponsmith spawner-f
    < Baker-M
    ADDITEM $item_baker spawner-m
    < Baker-F
    ADDITEM $item_baker spawner-f
    < Provisioner-M
    ADDITEM $item_provisioner spawner-m
    < Provisioner-F
    ADDITEM $item_provisioner spawner-f
    < Cobbler-M
    ADDITEM $item_cobbler spawner-m
    < Cobbler-F
    ADDITEM $item_cobbler spawner-f
    < Town Crier-M
    ADDITEM $item_town crier spawner-m
    < Town Crier-F
    ADDITEM $item_town crier spawner-f
}

SECTION_MENU ,"shopkeeper spawners 2 invul 
{
    Shopkeeper Spawners 2 (invul)
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"spawner_MENU
    < Innkeeper-M
    ADDITEM $item_innkeeper spawner-m
    < Innkeeper-F
    ADDITEM $item_innkeeper spawner-f
    < Mage-M
    ADDITEM $item_mage spawner-m
    < Mage-F
    ADDITEM $item_mage spawner-f
    < Herbalist-M
    ADDITEM $item_herbalist spawner-m
    < Herbalist-F
    ADDITEM $item_herbalist spawner-f
    < Butcher-M
    ADDITEM $item_butcher spawner-m
    < Butcher-F
    ADDITEM $item_butcher spawner-f
    < Tailor-M
    ADDITEM $item_tailor spawner-m
    < Tailor-F
    ADDITEM $item_tailor spawner-f
    < Bowyer-M
    ADDITEM $item_bowyer spawner-m
    < Bowyer-F
    ADDITEM $item_bowyer spawner-f
    < Jewler-M
    ADDITEM $item_jewler spawner-m
    < Jewler-F
    ADDITEM $item_jewler spawner-f
}

SECTION_MENU ,"shopkeeper spawner 3 invul 
{
    Shopkeeper Spawner 3 (invul)
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"spawner_MENU
    < Leather Worker-M
    ADDITEM $item_leather worker spawner-m
    < Leather Worker-F
    ADDITEM $item_leather worker spawner-f
    < Shipwright-M
    ADDITEM $item_shipwright spawner-m
    < Shipwright-F
    ADDITEM $item_shipwright spawner-f
    < Spinner-M
    ADDITEM $item_spinner spawner-m
    < Spinner-F
    ADDITEM $item_spinner spawner-f
    < Armorer-M
    ADDITEM $item_armorer spawner-m
    < Armorer-F
    ADDITEM $item_armorer spawner-f
    < Blacksmith-M
    ADDITEM $item_blacksmith spawner-m
    < Blacksmith-F
    ADDITEM $item_blacksmith spawner-f
    < Architect-M
    ADDITEM $item_architect spawner-m
    < Architect-F
    ADDITEM $item_architect spawner-f
    < Carpentry-M
    ADDITEM $item_carpenter spawner-m
    < Carpentry-F
    ADDITEM $item_carpenter spawner-f
}

SECTION_MENU ,"shopkeeper spawners 4 invul 
{
    Shopkeeper Spawners 4 (invul)
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"spawner_MENU
    < Farmer-M
    ADDITEM $item_farmer spawner-m
    < Farmer-F
    ADDITEM $item_farmer spawner-f
    < Cook-M
    ADDITEM $item_cook spawner-m
    < Cook-F
    ADDITEM $item_cook spawner-f
    < Animal Trainer-M
    ADDITEM $item_animal trainer spawner-m
    < Animal Trainer-F
    ADDITEM $item_animal trainer spawner-f
    < Fisherman
    ADDITEM $item_fisherman spawner
    < Fisherlady
    ADDITEM $item_fisherlady spawner
    < Alchemist-M
    ADDITEM $item_alchemist spawner-m
    < Alchemist-F
    ADDITEM $item_alchemist spawner-f
    < Tinker-M
    ADDITEM $item_tinker spawner-m
    < Tinker-F
    ADDITEM $item_tinker spawner-f
    < Engineer-M
    ADDITEM $item_engineer spawner-m
    < Engineer-F
    ADDITEM $item_engineer spawner-f
}
SECTION_MENU ,"treasure maps
{
    Treasure Maps
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"nox-wizard gm_MENU
    < Treasure MaP_[lv 1]
    ADDITEM $item_a_treasure maP_lv1 
    < Treasure MaP_[lv 2]
    ADDITEM $item_a_treasure maP_lv2 
    < Treasure MaP_[lv 3]
    ADDITEM $item_a_treasure maP_lv3 
    < Treasure MaP_[lv 4]
    ADDITEM $item_a_treasure maP_lv 4 
    < Treasure MaP_[lv 5]
    ADDITEM $item_a_treasure maP_lv5 
    < Slotmachine
    ADDITEM $item_slotmachine 5gP_
}

SECTION_MENU ,"escort spawners
{
    Escort Spawners
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"spawner_MENU
    1f14 Noble-escort-m
    ADDITEM $item_noble escort-m
    1f14 Noble-escort-f
    ADDITEM $item_noble escort-f
}

SECTION_MENU ,"new houses
{
    New Houses
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"building_MENU
    14F0 Small Tower
    ADDITEM $item_small tower deed
    14F0 2-Story Marble Shop
    ADDITEM $item_small marble shoP_deed
    14F0 farm house
    ADDITEM $item_farm house deed
    14F0 2-Story Stone Shop
    ADDITEM $item_small stone shoP_deed
    14F0 2-story Villa
    ADDITEM $item_2-story villa deed
    14F0 Sandstone Patio House
    ADDITEM $item_sandstone patio house deed
    14F0 2-Story Log Cabin
    ADDITEM $item_2-story log cabin deed
    14F0 Large Marble Patio house
    ADDITEM $item_large marble patio house deed
}

SECTION_MENU ,"chaos
{
    Chaos/Order Guards
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"npc_MENU
    < Chaos Guard female
    NPC $npc chaos guard f
    < Chaos Guard male
    NPC $npc chaos guard m
    < Order Guard female
    NPC $npc order guard f
    < Order Guard male
    NPC $npc order guard m
}

SECTION_MENU ,"regents spawners
{
    Regents Spawners
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"spawner_MENU
    < Black Pearl
    ADDITEM $item_black pearl spawner
    < Mandrake Root
    ADDITEM $item_mandrake root spawner
    < Bloodmoss
    ADDITEM $item_bloodmoss spawner
    < Gensing
    ADDITEM $item_gensing spawner
    < Garlic
    ADDITEM $item_garlic spawner
    < Nightshade
    ADDITEM $item_nightshade spawner
    < Sulfuric Ash
    ADDITEM $item_sulfuric ash spawner
    < Spider Silk
    ADDITEM $item_spidersilk spawner
}

SECTION_MENU ,"nox-wizard special items
{
    NoX-Wizard Special Items
    < Previous_MENU
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"nox-wizard gm_MENU
    < Holiday gifts
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"holiday gifts
    < Empty Jar (to milk)
    ADDITEM $item_jar for milk
    < Jar full of milk
    ADDITEM $item_a_jar full of milk
    < Cristall Ball of Reputation
    ADDITEM $item_a_cristall ball of reputation
}


SECTION_MENU ,"inscription
{
    Inscription
    20c0 First Circle
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"inscription first circle
    20c1 Second Circle
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"inscription second circle
    20c2 Third Circle
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"inscription third circle
    20c3 Fourth Circle
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"inscription fourth circle
    20c4 Fifth Circle
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"inscription fifth circle
    20c5 Sixth Circle
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"inscription sixth circle
    20c6 Seventh Circle
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"inscription seventh circle
    20c7 Eight Circle
    gui_addText(menu,PPBTNW + x,y,TXT_COLOR ,"inscription eight circle
}

SECTION_MENU ,"inscription first circle
{
    Inscription First Circle
    2080 Clumsy
    WRITESCROLL $item_a_clumsy scroll
    2081 Create Food
    WRITESCROLL $item_a_create food scroll
    2082 Feeblemind
    WRITESCROLL $item_a_feeblemind scroll
    2083 Heal
    WRITESCROLL $item_a_heal scroll
    2084 Magic Arrow
    WRITESCROLL $item_magic arrow scroll
    2085 Night Sight
    WRITESCROLL $item_a_night sight scroll
    2086 Reactive Armor
    WRITESCROLL $item_a_reactive armor scroll
    2087 Weaken
    WRITESCROLL $item_a_weaken scroll
}

SECTION_MENU ,"inscription second circle
{
    Inscription Second Circle
    2088 Agility
    WRITESCROLL $item_a_agility scroll
    2089 Cunning
    WRITESCROLL $item_a_cunning scroll
    208a Cure
    WRITESCROLL $item_a_cure scroll
    208b Harm
    WRITESCROLL $item_a_harm scroll
    208c Magic Trap
    WRITESCROLL $item_magic traP_scroll
    208d Magic Untrap
    WRITESCROLL $item_magic untraP_scroll
    208e Protection
    WRITESCROLL $item_a_protection scroll
    208f Strength
    WRITESCROLL $item_a_strength scroll
}

SECTION_MENU ,"inscription third circle
{
    Inscription Third Circle
    2090 Bless
    WRITESCROLL $item_a_bless scroll
    2091 Fireball
    WRITESCROLL $item_a_fireball scroll
    2092 Magic Lock
    WRITESCROLL $item_magic lock scroll
    2093 Poison
    WRITESCROLL $item_a_poison scroll
    2094 Telekinesis
    WRITESCROLL $item_a_telekinesis scroll
    2095 Teleport
    WRITESCROLL $item_a_teleport scroll
    2096 Unlock
    WRITESCROLL $item_an_unlock scroll
    2097 Wall of Stone
    WRITESCROLL $item_a_wall of stone scroll
}

SECTION_MENU ,"inscription fourth circle
{
    Inscription Fourth Circle
    2098 Arch Cure
    WRITESCROLL $item_an_archcure scroll
    2099 Arch Protection
    WRITESCROLL $item_an_arch protection scroll
    209a Curse
    WRITESCROLL $item_a_curse scroll
    209b Fire Field
    WRITESCROLL $item_a_fire field scroll
    209c Greater Heal
    WRITESCROLL $item_a_greater heal scroll
    209d Lightning
    WRITESCROLL $item_a_lightning scroll
    209e Mana Drain
    WRITESCROLL $item_a_mana drain scroll
    209f Recall
    WRITESCROLL $item_a_recall scroll
}

SECTION_MENU ,"inscription fifth circle
{
    Inscription Fifth Circle
    20a0 Blade Spirits
    WRITESCROLL $item_a_blade spirits scroll
    20a1 Dispel Field
    WRITESCROLL $item_a_dispel field scroll
    20a2 Incognito
    WRITESCROLL $item_an_incognito scroll
    20a3 Magic Reflection
    WRITESCROLL $item_magic reflection scroll
    20a4 Mind Blast
    WRITESCROLL $item_a_mind blast scroll
    20a5 Paralyze
    WRITESCROLL $item_a_paralyze scroll
    20a6 Poison Field
    WRITESCROLL $item_a_poison field scroll
    20a7 Summon Creature
    WRITESCROLL $item_a_summon creature scroll
}

SECTION_MENU ,"inscription sixth circle
{
    Inscription Sixth Circle
    20a8 Dispel
    WRITESCROLL $item_a_dispel scroll
    20a9 Energy Bolt
    WRITESCROLL $item_an_energy bolt scroll
    20aa Explosion
    WRITESCROLL $item_an_explosion scroll
    20ab Invisibility
    WRITESCROLL $item_an_invisibility scroll
    20ac Mark
    WRITESCROLL $item_a_mark scroll
    20ad Mass Curse
    WRITESCROLL $item_a_mass curse scroll
    20ae Paralyze Field
    WRITESCROLL $item_a_paralyze field scroll
    20af Reveal
    WRITESCROLL $item_a_reveal scroll
}

SECTION_MENU ,"inscription seventh circle
{
    Inscription Seventh Circle
    20b0 Chain Lightning
    WRITESCROLL $item_a_chain lightning scroll
    20b1 Energy Field
    WRITESCROLL $item_an_energy field scroll
    20b2 Flame Strike
    WRITESCROLL $item_a_flamestrike scroll
    20b3 Gate Travel
    WRITESCROLL $item_a_gate travel scroll
    20b4 Mana Vampire
    WRITESCROLL $item_a_mana vampire scroll
    20b5 Mass Dispel
    WRITESCROLL $item_a_mass dispel scroll
    20b6 Meteor Swarm
    WRITESCROLL $item_a_meteor swarm scroll
    20b7 Polymorph
    WRITESCROLL $item_a_polymorph scroll
}

SECTION_MENU ,"inscription eight circle
{
    Inscription Eight Circle
    20b8 Earthquake
    WRITESCROLL $item_a_earthquake scroll
    20b9 Energy Vortex
    WRITESCROLL $item_a_energy vortex scroll
    20ba Resurrection
    WRITESCROLL $item_a_resurrection scroll
    20bb Summon Air Elemental
    WRITESCROLL $item_a_summon air elemental scroll
    20bc Summon Daemon
    WRITESCROLL $item_a_summon daemon scroll
    20bd Summon Earth Elemental
    WRITESCROLL $item_a_summon earth elemental scroll
    20be Summon Fire Elemental
    WRITESCROLL $item_a_summon fire elemental scroll
    20bf Summon Water Elemental
    WRITESCROLL $item_a_summon water elemental scroll
}
*/
public addmenu_cback(menu,chr,btncode)
{
	if(!btncode)	return;
	
	new amount[10],n;
	gui_getProperty(menu,MP_UNI_TEXT,1,amount);
	if(!isStrInt(amount))
		n = 1;
	else n = str2Int(amount);
	
	new item; 
	item = itm_createInBp(btncode,chr);
	if(itm_getProperty(item,IP_PILEABLE))
	{
		itm_setProperty(item,IP_AMOUNT,n);
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

