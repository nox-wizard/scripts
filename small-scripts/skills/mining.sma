// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts (mining.sma -> override.amx)                     ||
// || Maintained by Luxor   	                                          ||
// || Last Update (18-feb-03)                                             ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This file contains NoX-Wizard functions to support mining skill     ||
// || If you want a different mining system, change this.                 ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 

/*************************************************************************************
 AUTHOR:	Luxor
 DESCRIPTION:	In this file you can change the mining system, add new ores and so on.
 ************************************************************************************/




/*----------------------------------------------------------------------------------------*\
Begin Customizable Metals
\*----------------------------------------------------------------------------------------*/

enum {
	IRON = 0, SHADOW, MERKITE, COPPER, SILVER, BRONZE, GOLD, AGAPITE, VERITE, MYTHRIL
};

//How many ores have we got?
const NUM_ORES = 10;

//Weight of ores
static oreWeight[] = {
700, //Iron
700, //Shadow
700, //Merkite
700, //Copper
700, //Silver
700, //Bronze
700, //Gold
700, //Agapite
700, //Verite
700  //Mythril
};

//Skill value required to find an ore
static oreSkill[] = {
0,   //Iron
650, //Shadow
700, //Merkite
750, //Copper
790, //Silver
800, //Bronze
850, //Gold
900, //Agapite
950, //Verite
990  //Mythril
};

//Chance to find an ore
static oreChance[] = {
100, //Iron
60,  //Shadow
55,  //Merkite
50,  //Copper
45,  //Silver
40,  //Bronze
35,  //Gold
30,  //Agapite
25,  //Verite
20  //Mythril
};

//Colors of ores
//Remember that you can't have two ores with the same color
static oreColor[] = {
0x0000, //Iron
0x0386, //Shadow
0x02C3, //Merkite
0x046E, //Copper
0x0961, //Silver
0x02E7, //Bronze
0x0466, //Gold
0x0150, //Agapite
0x022F, //Verite
0x0191  //Mythril
};

//Blacksmithing make menu for that ore
static oreMakeMenu[] = {
1,   //Iron
800, //Shadow
804, //Merkite
814, //Copper
813, //Silver
801, //Bronze
50,  //Gold
806, //Agapite
802, //Verite
803  //Mythril
};

//Ores names
static oreName[NUM_ORES][] = {
"Iron", "Shadow", "Merkite", "Copper", "Silver", "Bronze", "Golden", "Agapite", "Verite", "Mythril"
};

/*----------------------------------------------------------------------------------------*\
End Customizable Metals
\*----------------------------------------------------------------------------------------*/
  
/*----------------------------------------------------------------------------------------*\
Begin Customizable Regions
\*----------------------------------------------------------------------------------------*/
                                                                                        
static ENABLE_REGIONS = 0;	//This must be 1 if you want region mining to be activated
const NUM_REGIONS = 2;

static oreRegions[NUM_REGIONS][4] = {
//Syntax: {x1,y1,x2,y2}
{0,0,100,100}, //Region 1
{200,200,400,400}  //Region 2
};

static regionChance[NUM_REGIONS][NUM_ORES] = {
{100, 100, 50, 50, 100, 20, 20, 20, 20, 20}, //Region 1
{100, 0, 40, 40, 0, 0, 100, 60, 60, 50}      //Region 2
};

/*----------------------------------------------------------------------------------------*\
End Customizable Regions
\*----------------------------------------------------------------------------------------*/


/*****************************************************************************************
 FUNCTION :	__nxw_sk_mining
 AUTHOR   :	Luxor
 PURPOSE  :	This function is called by Nox-Wizard engine after land and skill control,
 		it chooses the picked up ore and put it in backpack.
 ****************************************************************************************/
public __nxw_sk_mining(const s)
{
	if (s < 0) {
		printf ("WARNING: SOCKET PASSED TO __nxw_sk_mining IS INVALID");
		return;
	}
	new oreFound = IRON;	//Ore found if nothing else will be found by the miner.
	new oreAmount = 1;
	new index = 0;
	new cc = getCharFromSocket(s);
	new skill = chr_getSkill(cc, SK_MINING);
	new region = -1;
	if (ENABLE_REGIONS == 1) {
		new x = chr_getProperty(cc, CP_POSITION, CP2_X);
		new y = chr_getProperty(cc, CP_POSITION, CP2_Y);
		for (index = 0; index < NUM_REGIONS; index++) {
			if ((x >= oreRegions[index][0] && x <= oreRegions[index][2]) && (y >= oreRegions[index][1] && y <= oreRegions[index][3])) {
				region = index;
			}
		}
	}

	for (index = 0; index < NUM_ORES; index++) {
		if (ENABLE_REGIONS == 1 && region < 0) break;
		if (skill > oreSkill[index] && random(100) < oreChance[index]) {
			if (ENABLE_REGIONS == 1 && region > -1) {
				if (random(100) < regionChance[region][index])
					oreFound = index;
			} else
				oreFound = index;
		}
	}
	if (ENABLE_REGIONS == 1 && region < 0) oreFound = IRON;

        oreAmount = random(100);
	if (oreAmount > 8) {
		oreAmount = 1;
	}
	/*if (skill >= 850 && random(99) >= 92) {
		itm_spawnNecroItem(s, 1, "999");
		ntprintf(s, "You place a gem in your pack.");
		return;
	}*/
	new str[50];	//Adjust the size if you create new ores with long names!
	sprintf(str, "%s ore", oreName[oreFound]);
	
	new bp = chr_getBackpack( cc, true );
	new ore = itm_createByDef( "$item_iron_ore" );
	itm_setProperty( ore, IP_AMOUNT, _, oreAmount );
	itm_setProperty( ore, IP_STR_NAME, 0, str );
	itm_setProperty( ore, IP_COLOR, _, oreColor[oreFound] );
	itm_setContSerial( ore, bp );
	itm_setProperty( ore, IP_WEIGHT, _, 100 );
	
	itm_setProperty(ore, IP_WEIGHT, _, oreWeight[oreFound]);
	ntprintf(s, "You place some %s in your pack.", str);
	itm_contPileItem( bp, ore );
}


public __nxw_smeltOre2(const s, const ore, const minskill, const id1, const id2, const col1, const col2, const orename[])
{
    if (s < 0) {
        printf("ERROR RUNNING __nxw_smeltOre2");
        return;
    }
    new cc = getCharFromSocket(s);
    new skill = chr_getSkill(cc, SK_MINING);
    if (skill < minskill) {
        ntprintf(s, "You have no idea what to do with this strange ore");
        return;
    }

    new ore_amount = itm_getProperty(ore, IP_AMOUNT);
    if (!chr_checkSkill(cc, SK_MINING, 0, 1000, 1)) {
        if (ore_amount == 1) {
            ntprintf(s, "Your hand slips and the last of your materials are destroyed.");
            itm_remove(ore);
        } else {
            ntprintf(s, "Your hand slips and some of your materials are destroyed.");
            itm_setProperty(ore, IP_AMOUNT, _, ore_amount/2);
            itm_refresh(ore);                   // tell the client item has been changed
        }
    } else {
        new numingots=ore_amount*2;         // one ore gives two ingots
	new bp = chr_getBackpack( cc, true );
    new ingot = itm_createByDef( "$item_iron_ingots" );
	itm_setProperty( ingot, IP_AMOUNT, _, numingots );
	itm_setProperty( ingot, IP_STR_NAME, 0, orename );
	new color = (col1<<8) + col2;
	itm_setProperty( ingot, IP_COLOR, _, color );
	itm_setContSerial( ingot, bp );
	itm_setProperty( ingot, IP_WEIGHT, _, 100 );

        ntprintf(s, "You have smelted your ore");
        ntprintf(s, "You place some %s in your pack.",orename);
	itm_contPileItem( bp, ingot );
        itm_remove(ore);
    }
}

/****************************************************************************
 FUNCTION : __nxw_smeltOre
 AUTHOR   : Luxor
 PURPOSE  : The function called by Nox-Wizard engine to smelt ores
 ****************************************************************************/

public __nxw_smeltOre(const s, const color1, const color2, ore)
{
	if (s < 0 || color1 < 0 || color2 < 0) {
		printf("ERROR RUNNING __nxw_smeltOre");
		return;
	}
	new color = (color1 << 8) + color2;
	new str[50];	//Adjust the size if you create new ores with long names!
	new index = 0;
	for (index = 0; index < NUM_ORES; index++) {
		if (color == oreColor[index]) {
			sprintf(str, "%s Ingot", oreName[index]);
                        if (index == IRON) { //Iron and Silver have discordant ore/ingot colors
				__nxw_smeltOre2(s, ore,   0, 0x1B, 0xF2, 0x09, 0x61,str);
			} else if (index == SILVER) {
				__nxw_smeltOre2(s, ore,   0, 0x1B, 0xF2, 0, 0,str);
			} else {
				__nxw_smeltOre2(s, ore,   0, 0x1B, 0xF2, color1, color2,str);
			}
		}
	}
}

/********************************************************************************************
 FUNCTION : __nxw_ingot_mm
 AUTHOR   : Luxor
 PURPOSE  : The function called by Nox-Wizard engine to choose the makemenu for blacksmithing
 *******************************************************************************************/

public __nxw_ingot_mm(const color)
{
	new index = 0;
	for (index = 0; index < NUM_ORES; index++) {
		if (color == oreColor[index]) {
			return oreMakeMenu[index];
		}
	}
	return oreMakeMenu[IRON];
}
