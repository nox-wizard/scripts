// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts (mining.sma -> override.amx)                     ||
// || Maintained by Luxor   	                                          ||
// || Last Update (01-feb-03)                                             ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This file contains NoX-Wizard functions to support mining skill     ||
// || If you want a different mining system, change this.                 ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 

/*************************************************************************************
 AUTHOR:	Luxor
 DESCRIPTION:	In this file you can change the mining system, add new ores and so on.
 modified:	Horian
 ************************************************************************************/


/*----------------------------------------------------------------------------------------*\
Begin Customizable Metals
\*----------------------------------------------------------------------------------------*/

enum 
{
	 iron=0, shadow, merkite, copper, silver, bronze, gold, agapite, verite, mythril
};

//How many ores have we got?
const NUM_ORES = 10;
/*Numeric properties of metals
{oreweight, minskill for mining, chance to find ore, hex color of ore, ingame name of ore/ingot, minimal skill to use ingots as smith, scriptname of color}*/

enum oreprop
{
oreweight,
miningmin,
orechance,
orecolor,
oreuseskill,
oremaxamount,
orescriptname: 9
}
public oreProperty[NUM_ORES][oreprop] = {
{700, 000, 100, 0x0838, 000, 15, "iron"},
{700, 650, 60, 0x096c, 650, 10, "shadow"},
{700, 700, 55, 0x025e, 700, 10, "merkite"},
{700, 750, 50, 0x046E, 750, 8, "copper"},
{700, 790, 45, 0x0835, 790, 5, "silver"},
{700, 800, 40, 0x083b, 800, 5, "bronze"},
{700, 850, 35, 0x07d9, 850, 3, "golden"},
{700, 900, 30, 0x089d, 900, 2, "agapite"},
{700, 950, 25, 0x08a4, 950, 2, "verite"},
{700, 990, 20, 0x0191, 990, 1, "valorite"}
};

/*----------------------------------------------------------------------------------------
End Customizable Metals
----------------------------------------------------------------------------------------*/
  
/*----------------------------------------------------------------------------------------
Begin Customizable Regions
----------------------------------------------------------------------------------------*/
                                                                                        
static ENABLE_REGIONS = 1;//This must be 1 if you want region mining to be activated
const NUM_REGIONS = 2;
const ORERESPAWN_DELAY=3600; // Delay in seconds until ore can respawn
static regionMiningMap = 0;
static regionMiningRespawnMap = 0;

static regionChance[NUM_REGIONS][NUM_ORES] = {
{100, 100, 50, 50, 100, 20, 20, 20, 20, 20}, //Region 1
{100, 0, 40, 40, 0, 0, 100, 60, 60, 50}      //Region 2
};
/*----------------------------------------------------------------------------------------*\
End Customizable Regions
\*----------------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------------
Begin Customizable blacksmithing system by GerNox
----------------------------------------------------------------------------------------*/

const globalSkillVar1 = 1004; //first global Var to store data of skill use
const globalSkillVar2 = 1005; //second global Var to store data of skill use

/*Here starts the definition of item properties a blacksmith can do and you can customize, this order:
number of ingots needed for creation, minimal necessary skill, max. Skill with gain, Skill needed for succesful repair, number of ingots needed to repair
*/
const NUM_ITEMS = 49;
enum smithprop
{ 
ingotnumber, 
skillminsmith, 
skillmaxsmith,
repairskillsmith,
repairingot,
itemname: 20
};
static itemDef[NUM_ITEMS][smithprop]={ 
{10, 120, 240, 140, 2, "_ringmail_gloves"},
{14, 169, 401, 189, 4, "_ringmail_sleeves"},
{16, 194, 449, 214, 5, "_ringmail_leggings"},
{18, 219, 451, 239, 6, "_ringmail_tunic"},
{10, 145, 410, 165, 2, "_chain_coif"},
{18, 367, 609, 387, 6, "_chain_leggings"},
{20, 391, 650, 411, 7, "_chain_tunic"},
{10, 564, 804, 584, 2, "_plate_gorget"},
{12, 589, 857, 609, 3, "_plate_gloves"},
{15, 636, 902, 656, 4, "_plate_helm"},
{18, 663, 903, 683, 6, "_plate_sleeves"},
{20, 688, 971, 708, 7, "_plate_leggings"},
{12, 441, 712, 461, 3, "_female_plate"},
{25, 750, 1000, 770, 9, "_platemail"},
{15, 083, 190, 103, 4, "_bascinet"},
{15, 379, 455, 399, 4, "_close_helm"},
{15, 379, 403, 399, 4, "_helmet"},
{15, 379, 423, 399, 4, "_nose_helm"},
{10, 000, 200, 020, 2, "_buckler"},
{14, 000, 255, 020, 4, "_metal_shield"},
{12, 000, 250, 020, 3, "_bronze_shield"},
{08, 000, 167, 020, 1, "_wooden_kite_shield"},
{16, 046, 250, 066, 5, "_metal_kite_shield"},
{18, 243, 505, 263, 6, "_heater"},
{03, 000, 100, 020, 1, "_dagger"},
{08, 243, 507, 263, 1, "_cutlass"},
{08, 367, 604, 387, 1, "_iron_kryss"},
{08, 441, 712, 461, 1, "_katana"},
{10, 317, 549, 337, 2, "_scimitar"},
{10, 354, 613, 374, 2, "_broadsword"},
{12, 280, 567, 300, 3, "_long_sword"},
{14, 243, 511, 263, 4, "_viking_sword"},
{06, 145, 401, 165, 1, "_mace"},
{10, 194, 454, 214, 2, "_maul"},
{14, 028, 552, 048, 4, "_war_mace"},
{16, 342, 605, 362, 5, "_war_hammer"},
{18, 342, 515, 362, 6, "_hammer_pick"},
{06, 453, 708, 573, 1, "_short_spear"},
{12, 429, 643, 449, 3, "_war_fork"},
{12, 490, 753, 510, 3, "_spear"},
{12, 293, 568, 313, 3, "_double_axe"},
{14, 305, 558, 325, 4, "_battle_axe"},
{14, 280, 558, 300, 4, "_large_battle_axe"},
{14, 342, 603, 362, 4, "_axe"},
{16, 330, 606, 350, 5, "_two-handed_axe"},
{14, 342, 613, 362, 4, "_executioners_axe"},
{14, 391, 673, 411, 4, "_war_axe"},
{18, 317, 553, 337, 6, "_bardiche"},
{20, 391, 654, 411, 7, "_halberd"}
};

/*----------------------------------------------------------------------------------------*\
End Customizable blacksmithing system
\*----------------------------------------------------------------------------------------*/

/*****************************************************************************************
 FUNCTION :__nxw_sk_mining
 AUTHOR   :Luxor
 PURPOSE  :This function is called by Nox-Wizard engine after land and skill control,
 it chooses the picked up ore and put it in backpack.
 ****************************************************************************************/
public __nxw_sk_mining(const cc, const x, const y, const mapTileId)
{
	new oreFound = iron;	//Ore found if nothing else will be found by the miner.
	new oreMaxAmount=-1;
	new oreAmount = 1;
	new index = 0;
	new skill = chr_getSkill(cc, SK_MINING);
	if (ENABLE_REGIONS == 1) 
	{
		if ( regionMiningMap == 0 )
		{
			// make a persistent map so the resources are saved during worldsave
			regionMiningMap = createResourceMap();
			regionMiningRespawnMap= createResourceMap();
		}
		new oreMemory=getResourceLocationValue(regionMiningMap, x,y,0);
		new oreSpawnTime=getResourceLocationValue(regionMiningRespawnMap, x,y,0);
		if ( oreMemory >= 0 )
		{
			oreMaxAmount=(oreMemory>>16)&0xFFFF;
			oreFound=oreMemory&0xFFFF;
		}
		if ( oreSpawnTime > 0 && oreSpawnTime < getCurrentTime() )
		{
			oreMaxAmount=-1;
			oreFound=iron;
		}
	}
	if ( oreMaxAmount < 0 )
	{
		for (index = 0; index < NUM_ORES; index++) 
		{
			if (ENABLE_REGIONS == 1 && regionMiningMap == 0) 
				break;
			if (skill > oreProperty[index][miningmin] && random(100) < oreProperty[index][orechance]) 
			{
				/*
				if (ENABLE_REGIONS == 1 && regionMiningMap > 0) 
				{
					if (random(100) < regionChance[region][index])
						oreFound = index;
				} 
				else
				*/
					oreFound = index;
			}
		}
	}
	if (ENABLE_REGIONS == 1 && oreMaxAmount < 0 )
	{
		oreMaxAmount=random(oreProperty[oreFound][oremaxamount])+1;
	}
	if ( oreMaxAmount > 0 )
        	oreAmount = random(oreMaxAmount)+1;
        else
        	oreAmount = 0;
        if ( oreAmount == 0 )
        {
		chr_message( cc, _, msg_sk_miningDef[18]);
        	return;
        }
        oreMaxAmount -=oreAmount;
        if ( ENABLE_REGIONS == 1 )
        {
        	// if the use the region map then save the amount and type now
        	// since the value is a 32 bit unsigned WORD we save the remaining amount in the higher two bytes
        	// and the ore type in the lower to byte
        	setResourceLocationValue(
        		regionMiningMap, 
        		((oreMaxAmount&0xFFFF) <<16)+oreFound,
        		x, 
        		y, 
        		0 
        		);
        	setResourceLocationValue(
        		regionMiningRespawnMap, 
        		getTimerValue(ORERESPAWN_DELAY),
        		x, 
        		y, 
        		0 
        		);
        }
	new str[50];	//Adjust the size if you create new ores with long names!
	sprintf(str, "%s", msg_sk_miningDef[oreFound]);
	trim(str);   //remove triming spaces
	sprintf(str, msg_sk_miningDef[10], str);
	
	new bp = chr_getBackpack( cc, true );
	new ore = itm_createByDef( "$item_iron_ore" );
	itm_setProperty( ore, IP_AMOUNT, _, oreAmount );
	itm_setProperty(ore, IP_STR_NAME, 0, str);
	itm_setProperty(ore, IP_COLOR, _, oreProperty[oreFound][orecolor]);
	itm_setContSerial( ore, bp );
	itm_setProperty(ore, IP_WEIGHT, _, oreProperty[oreFound][oreweight]);
	chr_message( cc, _, msg_sk_miningDef[11], str);
	itm_contPileItem( bp, ore );
	itm_refresh(ore);
}


/****************************************************************************
 FUNCTION : __nxw_smeltOre
 AUTHOR   : Luxor
 PURPOSE  : The function called by Nox-Wizard engine to smelt ores
 ****************************************************************************/
public __nxw_smeltOre(const cc, const color, ore)
{
    new skill = chr_getSkill(cc, SK_MINING);
    new index = 0;
    for (index = 0; index < NUM_ORES; index++) 
        {
        if (color == oreProperty[index][orecolor])
        {
              new minskill = oreProperty[index][miningmin]
              if (skill < minskill)
              {
                     chr_message( cc, _, msg_sk_miningDef[12]);
                     return;
              }
              new ore_amount = itm_getProperty(ore, IP_AMOUNT);
              if (!chr_checkSkill(cc, SK_MINING, 0, 1000, 1))
              {
                     if (ore_amount == 1)
                     {
                     chr_message( cc, _, msg_sk_miningDef[13]);
                     itm_remove(ore);
                     }
                     else
                     {
                     chr_message( cc, _, msg_sk_miningDef[14]);
                     itm_setProperty(ore, IP_AMOUNT, _, ore_amount/2);
                     itm_refresh(ore); // tell the client item has been changed
                     }
               }
               else
               {
               //new numingots=ore_amount*2;         // one ore gives two ingots
               new ingotname[50]
               sprintf(ingotname, "%s", msg_sk_miningDef[index]);
               trim(ingotname);   //remove triming spaces
               sprintf(ingotname, msg_sk_miningDef[15], ingotname);
               new backpack = chr_getBackpack( cc, true );
               new ingot = itm_createByDef( "$item_iron_ingots");
               itm_setProperty(ingot, IP_WEIGHT, _, 100);
               itm_setProperty(ingot, IP_COLOR, _, oreProperty[index][orecolor]); 
               itm_setProperty(ingot, IP_STR_NAME, 0, ingotname);
               itm_setContSerial( ingot, backpack );
               itm_contPileItem( backpack, ingot );
               itm_refresh(ingot);
               chr_message( cc, _, msg_sk_miningDef[17],ingotname);
               itm_remove(ore);
               }
        }//color if           
    }//for
}

//////////////////////////////////////////////////////////////////
///////// smith system by GerNoX /////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////// Horian + Saber //////////////////////////
//////////////////////////////////////////////////////////////////

public blacksmith(const itm, const chr)
{
bypass();
//printf("enter smith");
new itmx = itm_getProperty(itm, IP_POSITION, IP2_X); // Ausgabe der
new itmy = itm_getProperty(itm, IP_POSITION, IP2_Y); // Char und der Item Position
new itmz = itm_getProperty(itm, IP_POSITION, IP2_Z);
//printf("itmx: %d, itmy: %d^n", itmx, itmy);
new chrz = chr_getProperty(chr, CP_POSITION, CP2_Z);
new chrx = chr_getProperty(chr, CP_POSITION, CP2_X); // um den Abstand bestimmen 
new chry = chr_getProperty(chr, CP_POSITION, CP2_Y); // zu koennen
new x = itmx - chrx;
new y = itmy - chry;
new triggerscript = itm_getProperty(itm, IP_SCRIPTID);
new tonge = chr_countItems(chr, 0x0FBC, -1); //tonge is searched in pack
new hammer = chr_countItems(chr, 0x13E4, -1); //hammer is searched in pack
if((602 <= triggerscript <= 603) && (chr_lineOfSight(chr, chrx, chry, chrz, itmx, itmy, itmz, 63) == 1)) //trigger was anvil and Line of sight is ok
{
     //chr_message( chr, _, " x = %d y = %d", x, y);
     if ((x > 2)|(x < -2)) // distance to anvil?
         {
         chr_message( chr, _, "%s", msg_blacksmithDef[0]);
         return;
         }
     else if ((y > 2)|(y < -2))
         {
         chr_message( chr, _, "%s", msg_blacksmithDef[0]);
         return;
         }
     else if ((tonge || hammer) < 1) //if tools are there?
        {
        chr_message( chr, _, "%s", msg_blacksmithDef[2]);
        return;
        }
}
else if(triggerscript == 98) //trigger was smithy hammer
        {
        new itm_near = set_create(); // creating a new set, fill the set with all items in range
	set_addItemsNearXY( itm_near, chrx, chry, 2, false);
	for (set_rewind(itm_near); !set_end(itm_near);)  
	    {
	    new item = set_getItem(itm_near);
	    new itemid = itm_getProperty(item, IP_ID);
	    itmx = itm_getProperty(item, IP_POSITION, IP2_X); // gives item position
	    itmy = itm_getProperty(item, IP_POSITION, IP2_Y); 
	    itmz = itm_getProperty(item, IP_POSITION, IP2_Z);
	    new los = chr_lineOfSight(chr, chrx, chry, chrz, itmx, itmy, itmz, 63);
	    if (((itemid == 0x0FAF ) ||( itemid == 0x0FB0 )) &&  los == 1  )  //check for anvil in range and Line of sight is ok 
	        {
	        chr_message( chr, _, "%s", msg_blacksmithDef[1]);
	        target_create( chr, _, _, _, "blacksmithtwo" );
	        return;
	        }
            }//for closed
        set_delete(itm_near);
        chr_message( chr, _, "%s", msg_blacksmithDef[0]);
        return;
        }  //if closed
chr_message( chr, _, "%s", msg_blacksmithDef[1]);
target_create( chr, _, _, _, "blacksmithtwo" );
}


public blacksmithtwo( const t, const chr, const target, const x, const y, const z, const model, const param1 )
{
	new itemscript = itm_getProperty(target, IP_SCRIPTID);
	new itemid=itm_getProperty(target, IP_ID);
	if (300001 <= itemscript <= 390002)//weapon/armor was target
	{
		_repair(chr, target)
	}
	else if(itemid == 0x1bf2) //ingots was target
	{
		new backpack = chr_getBackpack( chr, true );
		if ((itm_getProperty(target, IP_CONTAINERSERIAL)) != (itm_getProperty(backpack,IP_SERIAL))) //ingots in pack?
		{
			chr_message( chr, _,"%s", msg_blacksmithDef[3]);
			return;
		}
		else
		{
			chr_setLocalIntVar(chr, globalSkillVar1, target); //Serial ingot-target stored at char
			new color = itm_getProperty(target, IP_COLOR);//color of ingots?
			new actualskill;
			//is char good enough to work with this kind of ingots?
			switch(color) 
			{
				case 2104:  actualskill=oreProperty[0][oreuseskill]; //iron
				case 2412:  actualskill=oreProperty[1][oreuseskill]; //shadow
				case 0606:  actualskill=oreProperty[2][oreuseskill]; //Merkit
				case 1134:  actualskill=oreProperty[3][oreuseskill]; //Kupfer
				case 2101:  actualskill=oreProperty[4][oreuseskill]; //silver
				case 2107:  actualskill=oreProperty[5][oreuseskill]; //Bronze
				case 2009:  actualskill=oreProperty[6][oreuseskill]; //Gold
				case 2205:  actualskill=oreProperty[7][oreuseskill]; //Agapit
				case 2212:  actualskill=oreProperty[8][oreuseskill]; //Verit
				case 0401:  actualskill=oreProperty[9][oreuseskill]; //Mythril
				default: chr_message( chr, _, "Ingots of unknown color!");
			}
			if (chr_getSkill(chr, SK_BLACKSMITHING) < actualskill)
			{
				chr_message( chr, _, "%s", msg_blacksmithDef[4]);
				return;
			}
			else menu_smith(chr);
		}
	}
	else chr_message( chr, _, "%s", msg_blacksmithDef[5]);
}


// Main smith menu
public menu_smith (const chr)
{
mnu_prepare(chr, 1, 11);
mnu_setStyle(chr, MENUSTYLE_STONE, 0x0);
mnu_setTitle(chr, msg_blacksmithDef[6]);

mnu_addItem(chr, 0, 0, msg_blacksmithDef[7]);
mnu_addItem(chr, 0, 1, msg_blacksmithDef[8]);
mnu_addItem(chr, 0, 2, msg_blacksmithDef[9]);
mnu_addItem(chr, 0, 3, msg_blacksmithDef[10]);
mnu_addItem(chr, 0, 4, msg_blacksmithDef[11]);
mnu_addItem(chr, 0, 5, msg_blacksmithDef[12]);
mnu_addItem(chr, 0, 6, msg_blacksmithDef[13]);
mnu_addItem(chr, 0, 7, msg_blacksmithDef[14]);
mnu_addItem(chr, 0, 8, msg_blacksmithDef[15]);
mnu_addItem(chr, 0, 9, msg_blacksmithDef[16]);
mnu_addItem(chr, 0,10, msg_blacksmithDef[17]);

mnu_setCallback(chr, funcidx("smithBtnPress"));
mnu_show(chr)
}

public smithBtnPress (const chr, const pg, const idx)
{
switch (idx)
{
case 0: menu_armor_ring(chr);
case 1: menu_armor_chain(chr);
case 2: menu_armor_plate(chr);
case 3: menu_helm(chr);
case 4: menu_schield(chr);
case 5: menu_weapon_sword(chr);
case 6: menu_weapon_mace(chr);
case 7: menu_weapon_Speer(chr);
case 8: menu_weapon_axe(chr);
case 9: menu_weapon_pole(chr);
case 10: last_smithitem(chr);
default: return;
}
}

public menu_armor_ring (const chr)
{
mnu_prepare(chr, 1, 5);
mnu_setStyle(chr, MENUSTYLE_STONE, 0x0);
mnu_setTitle(chr, msg_blacksmithDef[18]);

mnu_addItem(chr, 0, 0, " ");
mnu_addItem(chr, 0, 1, msg_blacksmithDef[19]);
mnu_addItem(chr, 0, 2, msg_blacksmithDef[20]);
mnu_addItem(chr, 0, 3, msg_blacksmithDef[21]);
mnu_addItem(chr, 0, 4, msg_blacksmithDef[22]);

mnu_setCallback(chr, funcidx("armorbtn_ring"));
mnu_show(chr)
}

public armorbtn_ring (const chr, const pg, const idx)
{ //IDX definition and item calculation
new itemtyp = -1 + idx;
if( (idx == 0) || (idx == -1))
{
	menu_smith(chr);
	return;
}
item_smith_create(chr, itemtyp);
}

public menu_armor_chain (const chr)
{
mnu_prepare(chr, 1, 4);
mnu_setStyle(chr, MENUSTYLE_STONE, 0x0);
mnu_setTitle(chr, msg_blacksmithDef[23]);

mnu_addItem(chr, 0, 0, " ");
mnu_addItem(chr, 0, 1, msg_blacksmithDef[24]);
mnu_addItem(chr, 0, 2, msg_blacksmithDef[21]);
mnu_addItem(chr, 0, 3, msg_blacksmithDef[22]);

mnu_setCallback(chr, funcidx("armorbtn_chain"));
mnu_show(chr)
}

public armorbtn_chain (const chr, const pg, const idx)
{
new starter = 3;
new itemtyp = starter+idx;
if( (idx == 0) || (idx == -1))
{
	menu_smith(chr);
	return;
}
item_smith_create(chr, itemtyp);
}

//Platenmail
public menu_armor_plate (const chr)
{
mnu_prepare(chr, 1, 8);
mnu_setStyle(chr, MENUSTYLE_STONE, 0x0);
mnu_setTitle(chr, msg_blacksmithDef[25]);

mnu_addItem(chr, 0, 0, " ");
mnu_addItem(chr, 0, 1, msg_blacksmithDef[26]);
mnu_addItem(chr, 0, 2, msg_blacksmithDef[19]);
mnu_addItem(chr, 0, 3, msg_blacksmithDef[27]);
mnu_addItem(chr, 0, 4, msg_blacksmithDef[20]);
mnu_addItem(chr, 0, 5, msg_blacksmithDef[21]);
mnu_addItem(chr, 0, 6, msg_blacksmithDef[28]);
mnu_addItem(chr, 0, 7, msg_blacksmithDef[22]);

mnu_setCallback(chr, funcidx("armorbtn_plate"));
mnu_show(chr)
}

public armorbtn_plate (const chr, const pg, const idx)
{
new starter = 6;
//printf("%d",idx);
new itemtyp = starter+idx;
if( (idx == 0) || (idx == -1))
{
	menu_smith(chr);
	return;
}
item_smith_create(chr, itemtyp);
}

public menu_helm (const chr)
{
mnu_prepare(chr, 1, 5);
mnu_setStyle(chr, MENUSTYLE_STONE, 0x0);
mnu_setTitle(chr, msg_blacksmithDef[29]);

mnu_addItem(chr, 0, 0, " ");
mnu_addItem(chr, 0, 1, msg_blacksmithDef[30]);
mnu_addItem(chr, 0, 2, msg_blacksmithDef[31]);
mnu_addItem(chr, 0, 3, msg_blacksmithDef[32]);
mnu_addItem(chr, 0, 4, msg_blacksmithDef[33]);

mnu_setCallback(chr, funcidx("helmbtn"));
mnu_show(chr)
}

public helmbtn (const chr, const pg, const idx)
{
new starter = 13;
//printf("%d",idx);
new itemtyp = starter+idx;
if( (idx == 0) || (idx == -1))
{
	menu_smith(chr);
	return;
}
item_smith_create(chr, itemtyp);
}

public menu_schield (const chr)
{
mnu_prepare(chr, 1, 7);
mnu_setStyle(chr, MENUSTYLE_STONE, 0x0);
mnu_setTitle(chr, msg_blacksmithDef[34]);

mnu_addItem(chr, 0, 0, " ");
mnu_addItem(chr, 0, 1, msg_blacksmithDef[35]);
mnu_addItem(chr, 0, 2, msg_blacksmithDef[36]);
mnu_addItem(chr, 0, 3, msg_blacksmithDef[37]);
mnu_addItem(chr, 0, 4, msg_blacksmithDef[38]);
mnu_addItem(chr, 0, 5, msg_blacksmithDef[39]);
mnu_addItem(chr, 0, 6, msg_blacksmithDef[40]);

mnu_setCallback(chr, funcidx("shieldbtn"));
mnu_show(chr)
}

public shieldbtn (const chr, const pg, const idx)
{
new starter = 17;
//printf("%d",idx);
new itemtyp = starter+idx;
if( (idx == 0) || (idx == -1))
{
	menu_smith(chr);
	return;
}
item_smith_create(chr, itemtyp);
}

public menu_weapon_sword (const chr)
{
mnu_prepare(chr, 1, 9);
mnu_setStyle(chr, MENUSTYLE_STONE, 0x0);
mnu_setTitle(chr, msg_blacksmithDef[41]);

mnu_addItem(chr, 0, 0, " ");
mnu_addItem(chr, 0, 1, msg_blacksmithDef[42]);
mnu_addItem(chr, 0, 2, msg_blacksmithDef[43]);
mnu_addItem(chr, 0, 3, msg_blacksmithDef[44]);
mnu_addItem(chr, 0, 4, msg_blacksmithDef[45]);
mnu_addItem(chr, 0, 5, msg_blacksmithDef[46]);
mnu_addItem(chr, 0, 6, msg_blacksmithDef[47]);
mnu_addItem(chr, 0, 7, msg_blacksmithDef[48]);
mnu_addItem(chr, 0, 8, msg_blacksmithDef[49]);

mnu_setCallback(chr, funcidx("weaponbtn_Schwerter"));
mnu_show(chr)
}

public weaponbtn_Schwerter (const chr, const pg, const idx)
{
new starter = 23;
//printf("%d",idx);
new itemtyp = starter+idx;
if( (idx == 0) || (idx == -1))
{
	menu_smith(chr);
	return;
}
item_smith_create(chr, itemtyp);
}

public menu_weapon_mace (const chr)
{
mnu_prepare(chr, 1, 6);
mnu_setStyle(chr, MENUSTYLE_STONE, 0x0);
mnu_setTitle(chr, msg_blacksmithDef[87]);

mnu_addItem(chr, 0, 0, " ");
mnu_addItem(chr, 0, 1, msg_blacksmithDef[50]);
mnu_addItem(chr, 0, 2, msg_blacksmithDef[51]);
mnu_addItem(chr, 0, 3, msg_blacksmithDef[52]);
mnu_addItem(chr, 0, 4, msg_blacksmithDef[53]);
mnu_addItem(chr, 0, 5, msg_blacksmithDef[54]);

mnu_setCallback(chr, funcidx("weaponbtn_mace"));
mnu_show(chr)
}

public weaponbtn_mace (const chr, const pg, const idx)
{
new starter = 31;
//printf("%d",idx);
new itemtyp = starter+idx;
if( (idx == 0) || (idx == -1))
{
	menu_smith(chr);
	return;
}
item_smith_create(chr, itemtyp);
}

public menu_weapon_Speer (const chr)
{
mnu_prepare(chr, 1, 4);
mnu_setStyle(chr, MENUSTYLE_STONE, 0x0);
mnu_setTitle(chr, msg_blacksmithDef[55]);

mnu_addItem(chr, 0, 0, " ");
mnu_addItem(chr, 0, 1, msg_blacksmithDef[56]);
mnu_addItem(chr, 0, 2, msg_blacksmithDef[57]);
mnu_addItem(chr, 0, 3, msg_blacksmithDef[58]);

mnu_setCallback(chr, funcidx("weaponbtn_Speer"));
mnu_show(chr)
}

public weaponbtn_Speer (const chr, const pg, const idx)
{
new starter = 36;
//printf("%d",idx);
new itemtyp = starter+idx;
if( (idx == 0) || (idx == -1))
{
	menu_smith(chr);
	return;
}
item_smith_create(chr, itemtyp);
}

public menu_weapon_axe (const chr)
{
mnu_prepare(chr, 1, 8);
mnu_setStyle(chr, MENUSTYLE_STONE, 0x0);
mnu_setTitle(chr, msg_blacksmithDef[59]);

mnu_addItem(chr, 0, 0, " ");
mnu_addItem(chr, 0, 1, msg_blacksmithDef[60]);
mnu_addItem(chr, 0, 2, msg_blacksmithDef[61]);
mnu_addItem(chr, 0, 3, msg_blacksmithDef[62]);
mnu_addItem(chr, 0, 4, msg_blacksmithDef[63]);
mnu_addItem(chr, 0, 5, msg_blacksmithDef[64]);
mnu_addItem(chr, 0, 6, msg_blacksmithDef[65]);
mnu_addItem(chr, 0, 7, msg_blacksmithDef[66]);

mnu_setCallback(chr, funcidx("weaponbtn_axe"));
mnu_show(chr)
}

public weaponbtn_axe (const chr, const pg, const idx)
{
new starter = 39;
//printf("%d",idx);
new itemtyp = starter+idx;
if( (idx == 0) || (idx == -1))
{
	menu_smith(chr);
	return;
}
item_smith_create(chr, itemtyp);
}

public menu_weapon_pole (const chr)
{
mnu_prepare(chr, 1, 3);
mnu_setStyle(chr, MENUSTYLE_STONE, 0x0);
mnu_setTitle(chr, msg_blacksmithDef[67]);

mnu_addItem(chr, 0, 0, " ");
mnu_addItem(chr, 0, 1, msg_blacksmithDef[68]);
mnu_addItem(chr, 0, 2, msg_blacksmithDef[69]);

mnu_setCallback(chr, funcidx("weaponbtn_pole_arms"));
mnu_show(chr)
}

public weaponbtn_pole_arms (const chr, const pg, const idx)
{
new starter = 46;
//printf("%d",idx);
new itemtyp = starter+idx;
if( (idx == 0) || (idx == -1))
{
	menu_smith(chr);
	return;
}
item_smith_create(chr, itemtyp);
}

public last_smithitem (const chr)
{
new itemtyp = chr_getLocalIntVar(chr, globalSkillVar2);
item_smith_create( chr, itemtyp);
}

public item_smith_create(const chr,  const itemtyp)
{
new barrenid = chr_getLocalIntVar(chr, globalSkillVar1 );//serial of ingots is called
new color = itm_getProperty(barrenid, IP_COLOR);//ingot color is called

if (itm_getProperty(barrenid, IP_AMOUNT) >= itemDef[itemtyp][ingotnumber])
{
if (chr_checkSkill(chr, SK_BLACKSMITHING, itemDef[itemtyp][skillminsmith], itemDef[itemtyp][skillmaxsmith], 1)) //skillcheck and gain-decision
{
itm_reduceAmount(barrenid, itemDef[itemtyp][ingotnumber]); //fail but should be able? nevertheless ingot loss
itm_refresh(barrenid);
item_smith_create_two(chr, itemtyp, color)
}
else
{
itm_reduceAmount(barrenid, (itemDef[itemtyp][ingotnumber])/2); //is not able to create them? nevertheless half amount of needed ingots taken
itm_refresh(barrenid);
chr_message( chr, _,"%s", msg_blacksmithDef[70]);
return;
}
}
else
{
 chr_message( chr, _,"%s", msg_blacksmithDef[71]);
 return;
}
}


public item_smith_create_two (const chr, const itemtyp, const colornum)
{
new backpack = chr_getBackpack( chr, true );
chr_setLocalIntVar(chr, globalSkillVar2, itemtyp);
new color[50];
switch(colornum) //get the color name for item creation
{
       case 2104:  sprintf(color, "%s", oreProperty[0][orescriptname]); //iron
       case 2412:  sprintf(color, "%s", oreProperty[1][orescriptname]); //shadow
       case 0606:  sprintf(color, "%s", oreProperty[2][orescriptname]); //Merkit
       case 1134:  sprintf(color, "%s", oreProperty[3][orescriptname]); //Kupfer
       case 2101:  sprintf(color, "%s", oreProperty[4][orescriptname]); //silver
       case 2107:  sprintf(color, "%s", oreProperty[5][orescriptname]); //Bronze
       case 2009:  sprintf(color, "%s", oreProperty[6][orescriptname]); //Gold
       case 2205:  sprintf(color, "%s", oreProperty[7][orescriptname]); //Agapit
       case 2212:  sprintf(color, "%s", oreProperty[8][orescriptname]); //Verit
       case 0401:  sprintf(color, "%s", oreProperty[9][orescriptname]); //Mythril
       default: chr_message( chr, _, "Ore of unknown color!");
}
trim(color);   //remove triming spaces
new name[50];
sprintf(name, "%s", itemDef[itemtyp][itemname]);
trim(name); 
sprintf(name, "$item_%s%s", color, itemDef[itemtyp][itemname]);
new smithitem = itm_createByDef(name, backpack); //item-Script-Name is composed and item in Pack created
itm_refresh(smithitem);

chr_sound (chr, 42); //Sound blacksmith
chr_action (chr, 11); //Animation blacksmiths

//skill-dependent random number calculated
new skillBS = chr_getSkill(chr, SK_BLACKSMITHING)/10;
new skillAL = chr_getSkill(chr, SK_ARMSLORE)/100;
new chance = random(100);//random between 0-100
new itmrandom = ((chance*100) / skillBS - skillAL);
//printf("SkillBS = %d, SkillAL = %d, Chance = %d, ItmRandom = %d^n", skillBS, skillAL, chance, itmrandom);
if (itmrandom > 100)
{
itmrandom = 100;
}
else if (itmrandom < 0)
{
itmrandom = 0;
}
//printf("ItmRandom = %d^n",itmrandom);
new chrstr[30]; //new empty string for creator name
new chrname = chr_getProperty(chr, CP_STR_NAME, 0, chrstr); //call char name
itm_setProperty(smithitem, IP_STR_CREATOR, _, chrname); // imprint the creator name at item

//quality control
new hp = itm_getProperty(smithitem, IP_HP); //HP is called
new def = itm_getProperty(smithitem, IP_DEF); // defense value is called
new mindamage = itm_getProperty(smithitem, IP_LODAMAGE); //minimal damage is called
new itmname[50]; //new string for item name
itm_getProperty(smithitem, IP_STR_NAME, 0, itmname); //item name is called
if (chr_getProperty(chr, CP_SKILL, SK_BLACKSMITHING) == 1000)//creator was grandmaster?
{
itm_setProperty(smithitem, IP_STR_NAME, _, "%s %s %s", itmname, msg_blacksmithDef[72], chrname); //then extend the itemname

}
itm_getProperty(smithitem, IP_STR_NAME, 0, itmname); //item name again called

new defrandom = random(18)+1 //RandomDefence
new hprandom = random(20)+1 //RandomItemHP
new damagerandom = random(4)+1 //RandomLODamage
//printf("defrandom = %d, hp random = %d, damagerandom = %d^n", defrandom, hprandom, damagerandom);
switch (itmrandom)
{
case 0..29:
{
if (0 < itemtyp < 24)//is armor
{
itm_setProperty(smithitem, IP_DEF, _, (def+def*defrandom/100)); // defense value is increased
itm_setProperty(smithitem, IP_HP, _, (hp + (hprandom/2))); //hitpoint(robustness) value is increased
itm_setProperty(smithitem, IP_MAXHP, _, (hp + (hprandom/2)));
}
else if (itemtyp >= 24) //is weapon
{
itm_setProperty(smithitem, IP_HP, _, (hp + hprandom)); //hitpoint(robustness) value is increased
itm_setProperty(smithitem, IP_MAXHP, _, (hp + hprandom));
itm_setProperty(smithitem, IP_LODAMAGE, _, mindamage+damagerandom);//minimal damage is increased

}
else log_message("%s", msg_blacksmithDef[73]);

itm_setProperty(smithitem, IP_STR_NAME, _, "%s %s", msg_blacksmithDef[74], itmname); //"exeptional" added to itemname
chr_message( chr, _, "%s", msg_blacksmithDef[75]);
}
case 30..79:chr_message( chr, _, "%s", msg_blacksmithDef[76]);
case 80..100:
{
if (0 < itemtyp < 24)//is armor
{
itm_setProperty(smithitem, IP_DEF, _, (def-def*(defrandom/2)/100)); // defense value is lowered
itm_setProperty(smithitem, IP_HP, _, (hp - (hprandom/2))); //hitpoint(robustness) value is lowered
itm_setProperty(smithitem, IP_MAXHP, _, (hp - (hprandom/2)));
}
else if (itemtyp >= 24) //is weapon
{
itm_setProperty(smithitem, IP_HP, _, (hp - hprandom)); //hitpoint(robustness) value is lowered
itm_setProperty(smithitem, IP_MAXHP, _, (hp - hprandom));
itm_setProperty(smithitem, IP_LODAMAGE, _, mindamage-(damagerandom/2)); //minimal damage is lowered
}
else log_message("%s", msg_blacksmithDef[77]);

chr_message( chr, _, "%s", msg_blacksmithDef[78]);
}
default: log_message("%s", msg_blacksmithDef[79]);
}
}

/****************************************************
************* Repair ********************************
****************************************************/

public _repair(const target, const chr)
{
	new smithing = chr_getProperty(chr, CP_SKILL, SK_BLACKSMITHING);
	new hp = itm_getProperty(target, IP_HP);
	new maxhp = itm_getProperty(target, IP_MAXHP);
	//new magic = itm_getProperty(target, IP_MAGIC);
	new color = itm_getProperty(target, IP_COLOR);//color is called
	//new itemid=itm_getProperty(target, IP_ID);//ItemID is called
	new barrennum  = chr_countItems(chr, 0x1bf2, color);
	new index = 0;
	for (index = 0; index < NUM_ITEMS; index++)
	{
		//if (itemid == itemDef[index][3])//Array-line calculation
		//{
		if (smithing < 500)
		{
			chr_message( chr, _,"%s", msg_blacksmithDef[80]);
			return;
		}
		//if (magic!= 0) //right now every item has magic 0 so does not work at the moment
		new backpack = chr_getBackpack( chr, true );
		if ((itm_getProperty(target, IP_CONTAINERSERIAL)) != (itm_getProperty(backpack,IP_SERIAL)))
		{
			chr_message( chr, _,"%s", msg_blacksmithDef[81]);
			return;
		}
		if (!hp)//does the item has an hp-value? if not we can't repair it
		{
			chr_message( chr, _,"%s", msg_blacksmithDef[82]);
			return;
		}
		else if (hp==maxhp)
		{
			chr_message( chr, _, "%s", msg_blacksmithDef[83]);
			return;
		}
		if (barrennum <= itemDef[index][repairingot])
		{
			chr_message( chr, _, "%s", msg_blacksmithDef[84]);
			return;
		}
		new dmg = 4;    // repairing creates a damage at max-damage possible
		if((smithing>=900)) dmg=1;
		else if ((smithing>=700)) dmg=2;
		else if ((smithing>=500)) dmg=3;
		if (chr_checkSkill(chr, SK_BLACKSMITHING, itemDef[index][repairskillsmith], itemDef[index][skillmaxsmith], 0))
		{
			maxhp=maxhp-dmg;
			itm_contDelAmount(backpack , itemDef[index][repairingot],  0x1bf2, color);
			itm_setProperty(target, IP_HP, _, maxhp);
			itm_setProperty(target, IP_MAXHP, _, maxhp);
			chr_message( chr, _,"%s", msg_blacksmithDef[88]);
		}
		//smithing is too low for repair normally but nevertheless there is a random chance for repairing
		
	new chance = random(50)
	switch(chance)
	{
		case 0..35:
		{
			hp=hp-2;
			itm_contDelAmount(backpack , (itemDef[index][repairingot])/2, 0x1bf2 , color);
			itm_setProperty(target, IP_HP, _, hp);
			chr_message( chr, _,"%s", msg_blacksmithDef[85]);
		}
		case 36..50:
		{
			maxhp=maxhp-1;
			itm_contDelAmount(backpack , (itemDef[index][repairingot])/2, 0x1bf2 , color);
			itm_setProperty(target, IP_MAXHP, _, maxhp);
			chr_message( chr, _,"%s", msg_blacksmithDef[86]);
		}
		default: return;
	}//switch
	/*}//if itemid
	else chr_message( chr, _, "%s", msg_blacksmithDef[82]); */
	}//for
}