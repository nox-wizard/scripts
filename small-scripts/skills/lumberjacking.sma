// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts (lumberjacking.sma -> override.amx)              ||
// || Maintained by Luxor, Xanathar, Ummon, Horian                        ||
// || Last Update (3-apr-03)                                             ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This file contains NoX-Wizard functions to support lumberjacking    ||
// || If you want a different lumberjacking system, change this.          ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

const NXW_LUMBERLOGS = 10;

/*----------------------------------------------------------------------------------------*\
Begin Customizable Logs
\*----------------------------------------------------------------------------------------*/


enum
{
	 pine=0, yew, maple, alder, walnut, cedar, oak, beech, mahogany, ebony
};


//Numeric properties of logs
//{weight, minskill for lumberjack, chance to identify tree, chance to get log, hex color of log, woodname ingame, minimal skill to use log as carpenter, name of wood in scripts}
const NUM_LOGS = 10;
enum logprop
{
logweight,
lumbermin,
logchance,
logcolor,
loguseskill,
logmaxamount,
logname: 9,
logscriptname: 9
}
public logProperty[NUM_LOGS][] = {
{700, 000, 100, 0x00fb, 000, 15,"pine"},
{700, 150, 60, 0x0095, 650, 10,"yew"},
{700, 250, 55, 0x015e, 700, 10,"maple"},
{700, 350, 50, 0x0283, 750, 8,"alder"},
{700, 450, 45, 0x02eb, 790, 5,"walnut"},
{700, 550, 40, 0x06b9, 800, 5,"cedar"},
{700, 650, 35, 0x01c0, 850, 3,"oak"},
{700, 750, 30, 0x0159, 900, 2,"beech"},
{700, 850, 25, 0x01ba, 950, 2,"mahogany"},
{700, 950, 20, 0x0345, 990, 1,"ebony"}
};

/*----------------------------------------------------------------------------------------
End Customizable Logs
----------------------------------------------------------------------------------------*/
const LUMBERRESPAWN_DELAY=3600; // Delay in seconds until ore can respawn
static resourceLumberMap = 0;
static resourceLumberRespawnMap = 0;

/*----------------------------------------------------------------------------------------
Begin Customizable Regions
----------------------------------------------------------------------------------------*/

static ENABLE_logRegions = 0;//This must be 1 if you want region lumberjacking to be activated
const NUM_logRegions = 2;

static logRegions[NUM_logRegions][4] = {
//Syntax: {x1,y1,x2,y2}
{0,0,100,100}, //Region 1
{200,200,400,400}  //Region 2
};

static regionLogChance[NUM_logRegions][NUM_LOGS] = {
{100, 100, 50, 50, 100, 20, 20, 20, 20, 20}, //Region 1
{100, 0, 40, 40, 0, 0, 100, 60, 60, 50}      //Region 2
};
/*----------------------------------------------------------------------------------------*\
End Customizable Regions
\*----------------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------------
Begin Customizable carpenter system by Horian, gerNox
----------------------------------------------------------------------------------------*/

const globalSkillVarwood1= 1004; //first global var to store data when skill is used
const globalSkillVarwood2 = 1005; //second global var to store data when skill is used

/*Here starts customizable definition of item properties:
number of boards needed, minimal skill, maximum skill with gain, skill needed to repair, boardnumber needed to repair
*/
const NUM_woodITEMS = 71;
enum carpprop
{
boardnumber,
skillmincarp,
skillmaxcarp,
repairskillcarp,
repairboard,
carpname: 23
};

static itemcarpDef[NUM_woodITEMS][carpprop]={
{17, 421, 526, 440, 5, "_counter1_1"},
{17, 421, 526, 440, 5, "_counter1_2"},
{23, 631, 788, 650, 10, "_table_A1_1"},
{23, 631, 788, 650, 10, "_table_A1_2"},
{23, 631, 788, 650, 10, "_table_B1_1"},
{23, 631, 788, 650, 10, "_table_B1_2"},
{23, 631, 788, 650, 10, "_table_B1_3"},
{23, 631, 788, 650, 10, "_table_B1_4"},
{23, 631, 788, 650, 10, "_table_B1_5"},
{23, 631, 788, 650, 10, "_table_C1_1"},
{23, 631, 788, 650, 10, "_table_C1_2"},
{23, 631, 788, 650, 10, "_table_D1_1"},
{23, 631, 788, 650, 10, "_table_D1_2"},
{23, 631, 788, 650, 10, "_table_D1_3"},
{23, 631, 788, 650, 10, "_table_D1_4"},
{23, 631, 788, 650, 10, "_table_D1_5"},
{27, 842, 1000, 862, 12, "_table_E1"},
{27, 842, 1000, 862, 12, "_table_F1"},
{17, 421, 526, 440, 5, "_table_G1_1"},
{17, 421, 526, 440, 5, "_table_G1_2"},
{23, 631, 788, 650, 10, "_table_H1_1"},
{23, 631, 788, 650, 10, "_table_H1_2"},
{23, 631, 788, 650, 10, "_table_H1_3"},
{27, 842, 1000, 863, 12, "_table_I"},
{27, 842, 1000, 862, 12, "_table_J"},
{27, 842, 1000, 862, 12, "_table_K"},
{27, 842, 1000, 862, 12, "_table_L"},
{17, 421, 526, 461, 5, "_table_M1_1"},
{17, 421, 526, 461, 5, "_table_M1_2"},
{17, 421, 526, 461, 5, "_writing_desk_1"},
{35, 842, 1000, 862, 16, "_chest_of_drawers1_1"},
{35, 842, 1000, 862, 16, "_dresser1_2"},
{35, 842, 1000, 862, 16, "_dresser1_1"},
{35, 842, 1000, 862, 16, "_armoire1_1"},
{35, 842, 1000, 862, 16, "_armoire2_1"},
{25, 315, 393, 335, 11, "_bookcase1_1"},
{25, 315, 393, 335, 11, "_bookcase1_2"},
{25, 315, 393, 335, 11, "_bookcase1_3"},
{25, 315, 393, 335, 11, "_wooden_shelf1"},
{17, 526, 657, 546, 5, "_bench_A1_1"},
{17, 526, 657, 546, 5, "_bench_A1_2"},
{17, 526, 657, 546, 5, "_bench_A1_3"},
{17, 526, 657, 546, 5, "_bench_B1_1"},
{17, 526, 657, 546, 5, "_bench_B1_2"},
{17, 526, 657, 546, 5, "_bench_B1_3"},
{17, 526, 657, 546, 5, "_bench_C1_1"},
{17, 526, 657, 546, 5, "_bench_C1_2"},
{21, 526, 657, 546, 7, "_wooden_bench_D1"},
{9, 110, 137, 130, 1, "_stool1"},
{9, 110, 137, 130, 1, "_stool2"},
{17, 526, 657, 546, 5, "_throne1"},
{13, 210, 262, 230, 3, "_wooden_chair1_1"},
{13, 210, 262, 230, 3, "_wooden_chair2_1"},
{15, 421, 526, 441, 4, "_fancy_chair1_1"},
{15, 421, 526, 441, 4, "_fancy_chair2_1"},
{13, 210, 262, 230, 3, "_straw_chair1_1"},
{50, 747, 933, 767, 24, "_bed_headboard_A1_1"},
{50, 747, 933, 767, 24, "_bed_headboard_A1_2"},
{50, 747, 933, 767, 24, "_bed_headboard_A1_3"},
{50, 747, 933, 767, 24, "_bed_headboard_A1_4"},
{50, 747, 933, 767, 24, "_bed_feet_A1_1"},
{50, 747, 933, 767, 24, "_bed_feet_A1_2"},
{50, 747, 933, 767, 24, "_bed_feet_A1_3"},
{40, 947, 1000, 967, 19, "_bigbed_headleft_A1_1"},
{40, 947, 1000, 967, 19, "_bigbed_feetleft_A1_1"},
{40, 947, 1000, 967, 19, "_bigbed_feetright_A1_1"},
{40, 947, 1000, 967, 19, "_bigbed_headright_A1_1"},
{40, 947, 1000, 967, 19, "_bigbed_headleft_A2_1"},
{40, 947, 1000, 967, 19, "_bigbed_feetleft_A2_1"},
{40, 947, 1000, 967, 19, "_bigbed_feetright_A2_1"},
{40, 947, 1000, 967, 19, "_bigbed_headright_A2_1"}
};

/*----------------------------------------------------------------------------------------*\
End Customizable carpenter system
\*----------------------------------------------------------------------------------------*/
/****************************************************************************
 FUNCTION : __nxw_sk_lumber
 AUTHOR   : Luxor
 PURPOSE  : This function is called by Nox-Wizard engine after tree control
 ****************************************************************************/
public __nxw_sk_lumber(const cc, const x, const y, const mapid)
{
	bypass();
	new logFound = pine;//log found if nothing else will be found by the miner.
	new logAmount = 1;
	new logMaxAmount = -1;
	new index = 0;
	new skill = chr_getSkill(cc, SK_LUMBERJACKING);
	new region = -1;

	if ( resourceLumberMap == 0 )
	{
		// make a persistent map so the resources are saved during worldsave
		resourceLumberMap = createResourceMap(RESOURCEMAP_LOCATION, 1, "lumberjacking_type");
		resourceLumberRespawnMap= createResourceMap(RESOURCEMAP_LOCATION, 1, "lumberjacking_time");
	}
	new lumberMemory=getResourceLocationValue(resourceLumberMap, x,y,0);
	new lumberSpawnTime=getResourceLocationValue(resourceLumberRespawnMap, x,y,0);
	if ( lumberMemory >= 0 )
	{
		logMaxAmount=(lumberMemory>>16)&0xFFFF;
		logFound=lumberMemory&0xFFFF;
	}
	if ( lumberSpawnTime > 0 && lumberSpawnTime < getCurrentTime() )
	{
		logMaxAmount=-1;
		logFound=pine;
	}

	if (ENABLE_logRegions == 1)
	{
		for (index = 0; index < NUM_logRegions; index++)
			if ((logRegions[index][0] <= x <= logRegions[index][2]) && (logRegions[index][1] <= y <= logRegions[index][3]))
				region = index;
	}


	for (index = 0; index < NUM_LOGS; index++)
	{
		if (ENABLE_logRegions == 1 && region < 0)
			break;
		if (skill > logProperty[index][1] && random(100) < logProperty[index][2])
		{
			if (ENABLE_logRegions == 1 && region > -1)
			{
				if (random(100) < regionLogChance[region][index])
				{
					logFound = index;
				}
			}
			else
				logFound = index;
		}
	}

	if (ENABLE_logRegions == 1 && region < 0) 
		logFound = pine;
	if (logMaxAmount < 0 )
	{
		logMaxAmount=random(logProperty[logFound][logmaxamount])+1;
	}
	if ( logMaxAmount > 0 )
        	logAmount = random(logMaxAmount)+1;
        else
        	logAmount = 0;
        if ( logAmount == 0 )
        {
		chr_message( cc, _, msg_sk_lumbDef[17]);
        	return;
        }
        logMaxAmount -=logAmount;
        if ( resourceLumberMap > 0 )
        {
        	// if the use the region map then save the amount and type now
        	// since the value is a 32 bit unsigned WORD we save the remaining amount in the higher two bytes
        	// and the ore type in the lower to byte
        	setResourceLocationValue(
        		resourceLumberMap, 
        		((logMaxAmount&0xFFFF) <<16)+logFound,
        		x, 
        		y, 
        		0 
        		);
        	setResourceLocationValue(
        		resourceLumberRespawnMap, 
        		getTimerValue(LUMBERRESPAWN_DELAY),
        		x, 
        		y, 
        		0 
        		);
        }


	new str[50];//Adjust the size if you create new logs with long names!
	sprintf(str, "%s", msg_sk_lumbDef[logFound]);
	trim(str);   //remove triming spaces
	sprintf(str, msg_sk_lumbDef[10], str);
	new backpack = chr_getBackpack( cc, true );
	new log = itm_createByDef( "$item_logs", backpack );
	itm_setProperty( log, IP_AMOUNT, _, logAmount );
	itm_setProperty(log, IP_WEIGHT, _, logProperty[logFound][logweight]);
	itm_setProperty(log, IP_COLOR, _,logProperty[logFound][logcolor]);
	itm_setProperty(log, IP_STR_NAME, 0, str);
	itm_contPileItem( backpack, log );
	itm_refresh(log);
	chr_message( cc, _, msg_sk_lumbDef[11], str);
}

/****************************************************************************
 FUNCTION : __nxw_cutlog
 AUTHOR   : Horian, modified after Luxor
 PURPOSE  : The function called by Item to cut logs to boards
 ****************************************************************************/

public _cutlog(const log, const cc)
{
    bypass();
    new skill = chr_getSkill(cc, SK_LUMBERJACKING);
    new color = itm_getProperty(log, IP_COLOR);
    new index = 0;
    for (index = 0; index < NUM_LOGS; index++)
        {
        if (color == logProperty[index][3])
        {
              new minskill = logProperty[index][1]
              if (skill < minskill)
              {
                     chr_message( cc, _, "You are too unexperienced to work with this kind of wood");
                     return;
              }
              new log_amount = itm_getProperty(log, IP_AMOUNT);
              if (!chr_checkSkill(cc, SK_LUMBERJACKING, 0, 1000, 1))
              {
                     if (log_amount == 1)
                     {
                     chr_message( cc, _, msg_sk_lumbDef[13]);
                     itm_remove(log);
                     }
                     else
                     {
                     chr_message( cc, _, "Euch rutscht die Hand aus und ein Teil des woodes ist Abfall.");
                     itm_setProperty(log, IP_AMOUNT, _, log_amount/2);
                     itm_refresh(log); // tell the client item has been changed
                     }
               }
               else
               {
               //new numboards=log_amount*2;         // one log gives two boards
               new boardname[50]
               sprintf(boardname, "%s", logProperty[index][logname]);
               trim(boardname);   //remove triming spaces
               sprintf(boardname, msg_sk_lumbDef[15], boardname);
               new backpack = chr_getBackpack( cc, true );
               new board = itm_createByDef( "$item_boards", backpack );
               itm_setProperty(board, IP_WEIGHT, _, 100);
               itm_setProperty(board, IP_COLOR, _,logProperty[index][3]);
               itm_setProperty(board, IP_STR_NAME, 0, boardname);
               itm_refresh(board);
               chr_message( cc, _,msg_sk_lumbDef[16],boardname);
               itm_remove(log);
               }
        }//color if
    }//for
}

//////////////////////////////////////////////////////////////////
///////// Carpenter System by Horian (after blacksmith by ////////
//////////////////////// Horian + Saber) /////////////////////////
//////////////////////////////////////////////////////////////////


public _carpenter(const itm, const chr) //itm is serial of saw, s is socket of char
{
bypass();
new saw1 = chr_countItems(chr, 0x1028, -1); //saw is searched for in pack
new saw2 = chr_countItems(chr, 0x1029, -1); //saw is searched for in pack
new nails1 = chr_countItems(chr, 0x102E, -1); //nails pack is searched for in backpack
new nails2 = chr_countItems(chr, 0x102F, -1); //nails pack is searched for in backpack
if(saw1 < 1 && saw2 <1) //saw is not inside the pack
{
chr_message( chr, _,"%s", msg_carpenterDef[0]);
return;
}
else if(nails1 < 1 && nails2 <1) //no nails inside the pack
{
chr_message( chr, _,"%s", msg_carpenterDef[2]);
return;
}
else
{
chr_message( chr, _, "%s", msg_carpenterDef[1]);
target_create( chr, _, _, _, "carpentertwo" );
}
}

public carpentertwo(const target, const chr, const obj) //s is char socket, item is board serial, target is empty
{
new itemid=itm_getProperty(target, IP_ID);
new saw1 = chr_countItems(chr, 0x1028, -1); //saw is searched for in pack
new saw2 = chr_countItems(chr, 0x1029, -1); //saw is searched for in pack
new nails1 = chr_countItems(chr, 0x102E, -1); //nails pack is searched for in backpack
new nails2 = chr_countItems(chr, 0x102F, -1); //nails pack is searched for in backpack

if((saw1 >= 1 || saw2 >=1) && (itemid == 0x1BD7) && (nails1 >= 1 || nails2 >=1)) //boards are target, nails and saw is there
   {
   new backpack = chr_getBackpack( chr, true );
   if ((itm_getProperty(target, IP_CONTAINERSERIAL)) != (itm_getProperty(backpack,IP_SERIAL))) //are target boards in the pack?
       {
       chr_message( chr, _,"%s", msg_carpenterDef[3]);
       return;
       }
   else
       {
       chr_setLocalIntVar(chr, globalSkillVarwood1, target); //Serial boards is stored as local var at Char
       new color = itm_getProperty(target, IP_COLOR);//wood color is called
       new carpskill;
       //color defines the skill needed to use the wood
           switch(color)
            {
       case 0251:  carpskill=logProperty[0][loguseskill]; //pine
       case 0149:  carpskill=logProperty[1][loguseskill]; //yew
       case 0350:  carpskill=logProperty[2][loguseskill]; //maple
       case 0643:  carpskill=logProperty[3][loguseskill]; //alder
       case 0747:  carpskill=logProperty[4][loguseskill]; //walnut
       case 1721:  carpskill=logProperty[5][loguseskill]; //cedar
       case 0448:  carpskill=logProperty[6][loguseskill]; //oak
       case 0345:  carpskill=logProperty[7][loguseskill]; //beech
       case 0442:  carpskill=logProperty[8][loguseskill]; //mahogany
       case 0837:  carpskill=logProperty[9][loguseskill]; //ebony
             }
       if (chr_getSkill(chr, SK_CARPENTRY) < carpskill)
              {
              chr_message( chr, _, "%s", msg_carpenterDef[4]);
              return;
              }
       else menu_carpenter(chr)
       }
    }
else chr_message( chr, _, "%s", msg_carpenterDef[5]);
}


// main carpenter menu
public menu_carpenter (const chr)
{
mnu_prepare(chr, 1, 9);
mnu_setStyle(chr, MENUSTYLE_STONE, 0x0);
mnu_setTitle(chr, msg_carpenterDef[6]);

mnu_addItem(chr, 0, 0, msg_carpenterDef[7]);
mnu_addItem(chr, 0, 1, msg_carpenterDef[8]);
mnu_addItem(chr, 0, 2, msg_carpenterDef[9]);
mnu_addItem(chr, 0, 3, msg_carpenterDef[10]);
mnu_addItem(chr, 0, 4, msg_carpenterDef[11]);
mnu_addItem(chr, 0, 5, msg_carpenterDef[12]);
mnu_addItem(chr, 0, 6, msg_carpenterDef[13]);
mnu_addItem(chr, 0, 7, msg_carpenterDef[14]);
mnu_addItem(chr, 0, 8, msg_carpenterDef[15]);

mnu_setCallback(chr, funcidx("carp_BtnPress"));
mnu_show(chr)
}
public carp_BtnPress (const chr, const pg, const idx)
{
switch (idx)
{
case 0: menu_normal_tables_1(chr); //normal tables 1
case 1: menu_normal_tables_2(chr); //normal tables 2
case 2: menu_normal_tables_3(chr); //normal tables 3
case 3: menu_other_furniture(chr); //other_furnituree
case 4: menu_benchs(chr); //benches
case 5: menu_chairs(chr); //chairs
case 6: menu_small_beds(chr); //small beds
case 7: menu_big_beds(chr); //big beds
case 8: last_item(chr); //last item
default: return;
}
}

//normal tables 1
public menu_normal_tables_1 (const chr)
{
mnu_prepare(chr, 1, 11);
mnu_setStyle(chr, MENUSTYLE_STONE, 0x0);
mnu_setTitle(chr, msg_carpenterDef[16]);

mnu_addItem(chr, 0, 0, " ");
mnu_addItem(chr, 0, 1, msg_carpenterDef[17]);
mnu_addItem(chr, 0, 2, msg_carpenterDef[18]);
mnu_addItem(chr, 0, 3, msg_carpenterDef[19]);
mnu_addItem(chr, 0, 4, msg_carpenterDef[20]);
mnu_addItem(chr, 0, 5, msg_carpenterDef[21]);
mnu_addItem(chr, 0, 6, msg_carpenterDef[22]);
mnu_addItem(chr, 0, 7, msg_carpenterDef[23]);
mnu_addItem(chr, 0, 8, msg_carpenterDef[24]);
mnu_addItem(chr, 0, 9, msg_carpenterDef[25]);
mnu_addItem(chr, 0, 10, msg_carpenterDef[26]);

mnu_setCallback(chr, funcidx("tablebtn_1"));
mnu_show(chr)
}

public tablebtn_1 (const chr, const pg, const idx)
{ //IDX definition und Erstellung der Items
new carptyp = -1 + idx;
if( idx <= 0)
{
menu_carpenter(chr);
return;
}
carpcreate(chr, carptyp);
}

//normal tables 2
public menu_normal_tables_2 (const chr)
{
mnu_prepare(chr, 1, 12);
mnu_setStyle(chr, MENUSTYLE_STONE, 0x0);
mnu_setTitle(chr, msg_carpenterDef[27]);

mnu_addItem(chr, 0, 0, " ");
mnu_addItem(chr, 0, 1, msg_carpenterDef[28]);
mnu_addItem(chr, 0, 2, msg_carpenterDef[29]);
mnu_addItem(chr, 0, 3, msg_carpenterDef[30]);
mnu_addItem(chr, 0, 4, msg_carpenterDef[31]);
mnu_addItem(chr, 0, 5, msg_carpenterDef[32]);
mnu_addItem(chr, 0, 6, msg_carpenterDef[33]);
mnu_addItem(chr, 0, 7, msg_carpenterDef[34]);
mnu_addItem(chr, 0, 8, msg_carpenterDef[35]);
mnu_addItem(chr, 0, 9, msg_carpenterDef[36]);
mnu_addItem(chr, 0, 10, msg_carpenterDef[37]);
mnu_addItem(chr, 0, 11, msg_carpenterDef[38]);

mnu_setCallback(chr, funcidx("tablebtn_2"));
mnu_show(chr)
}

public tablebtn_2 (const chr, const pg, const idx)
{
new starter = 10;
//printf("%d",idx);
new carptyp = starter+idx;
if( (idx == 0) || (idx == -1))
{
menu_carpenter(chr);
return;
}
carpcreate(chr, carptyp);
}

//normal tables 3
public menu_normal_tables_3 (const chr)
{
mnu_prepare(chr, 1, 8);
mnu_setStyle(chr, MENUSTYLE_STONE, 0x0);
mnu_setTitle(chr, msg_carpenterDef[39]);

mnu_addItem(chr, 0, 0, " ");
mnu_addItem(chr, 0, 1, msg_carpenterDef[40]);
mnu_addItem(chr, 0, 2, msg_carpenterDef[41]);
mnu_addItem(chr, 0, 3, msg_carpenterDef[42]);
mnu_addItem(chr, 0, 4, msg_carpenterDef[43]);
mnu_addItem(chr, 0, 5, msg_carpenterDef[44]);
mnu_addItem(chr, 0, 6, msg_carpenterDef[45]);
mnu_addItem(chr, 0, 7, msg_carpenterDef[46]);
mnu_addItem(chr, 0, 6, msg_carpenterDef[47]);
mnu_addItem(chr, 0, 7, msg_carpenterDef[48]);

mnu_setCallback(chr, funcidx("tablebtn_3"));
mnu_show(chr)
}

public tablebtn_3 (const chr, const pg, const idx)
{
new starter = 21;
//printf("%d",idx);
new carptyp = starter+idx;
if( (idx == 0) || (idx == -1))
{
menu_carpenter(chr);
return;
}
carpcreate(chr, carptyp);
}

// other_furniture
public menu_other_furniture (const chr)
{
mnu_prepare(chr, 1, 28);
mnu_setStyle(chr, MENUSTYLE_STONE, 0x0);
mnu_setTitle(chr, msg_carpenterDef[49]);

mnu_addItem(chr, 0, 0, " ");
mnu_addItem(chr, 0, 1, msg_carpenterDef[50]);
mnu_addItem(chr, 0, 2, msg_carpenterDef[51]);
mnu_addItem(chr, 0, 3, msg_carpenterDef[52]);
mnu_addItem(chr, 0, 4, msg_carpenterDef[53]);
mnu_addItem(chr, 0, 5, msg_carpenterDef[54]);
mnu_addItem(chr, 0, 6, msg_carpenterDef[55]);
mnu_addItem(chr, 0, 7, msg_carpenterDef[56]);
mnu_addItem(chr, 0, 8, msg_carpenterDef[57]);
mnu_addItem(chr, 0, 9, msg_carpenterDef[58]);
mnu_addItem(chr, 0, 10, msg_carpenterDef[59]);
mnu_addItem(chr, 0, 11, msg_carpenterDef[60]);

mnu_setCallback(chr, funcidx("other_furniturebtn"));
mnu_show(chr)
}
public other_furniturebtn (const chr, const pg, const idx)
{
new starter = 28;
//printf("%d",idx);
new carptyp = starter+idx;
if( (idx == 0) || (idx == -1))
{
menu_carpenter(chr);
return;
}
carpcreate(chr, carptyp);
}

//benchs
public menu_benchs (const chr)
{
mnu_prepare(chr, 1, 10);
mnu_setStyle(chr, MENUSTYLE_STONE, 0x0);
mnu_setTitle(chr, msg_carpenterDef[61]);

mnu_addItem(chr, 0, 0, " ");
mnu_addItem(chr, 0, 1, msg_carpenterDef[62]);
mnu_addItem(chr, 0, 2, msg_carpenterDef[63]);
mnu_addItem(chr, 0, 3, msg_carpenterDef[64]);
mnu_addItem(chr, 0, 4, msg_carpenterDef[65]);
mnu_addItem(chr, 0, 5, msg_carpenterDef[66]);
mnu_addItem(chr, 0, 6, msg_carpenterDef[67]);
mnu_addItem(chr, 0, 7, msg_carpenterDef[68]);
mnu_addItem(chr, 0, 8, msg_carpenterDef[69]);
mnu_addItem(chr, 0, 9, msg_carpenterDef[70]);

mnu_setCallback(chr, funcidx("btn_benches"));
mnu_show(chr)
}

public btn_benches (const chr, const pg, const idx)
{
new starter = 39;
//printf("%d",idx);
new carptyp = starter+idx;
if( (idx == 0) || (idx == -1))
{
menu_carpenter(chr);
return;
}
carpcreate(chr, carptyp);
}

// chairs
public menu_chairs (const chr)
{
mnu_prepare(chr, 1, 9);
mnu_setStyle(chr, MENUSTYLE_STONE, 0x0);
mnu_setTitle(chr, msg_carpenterDef[71]);

mnu_addItem(chr, 0, 0, " ");
mnu_addItem(chr, 0, 1, msg_carpenterDef[72]);
mnu_addItem(chr, 0, 2, msg_carpenterDef[73]);
mnu_addItem(chr, 0, 3, msg_carpenterDef[74]);
mnu_addItem(chr, 0, 4, msg_carpenterDef[75]);
mnu_addItem(chr, 0, 5, msg_carpenterDef[76]);
mnu_addItem(chr, 0, 6, msg_carpenterDef[77]);
mnu_addItem(chr, 0, 7, msg_carpenterDef[78]);
mnu_addItem(chr, 0, 8, msg_carpenterDef[79]);

mnu_setCallback(chr, funcidx("btn_chairs"));
mnu_show(chr)
}

public btn_chairs (const chr, const pg, const idx)
{
new starter = 48;
//printf("%d",idx);
new carptyp = starter+idx;
if( (idx == 0) || (idx == -1))
{
menu_carpenter(chr);
return;
}

carpcreate(chr, carptyp);
}
// small beds
public menu_small_beds (const chr)
{
mnu_prepare(chr, 1, 8);
mnu_setStyle(chr, MENUSTYLE_STONE, 0x0);
mnu_setTitle(chr, msg_carpenterDef[80]);

mnu_addItem(chr, 0, 0, " ");
mnu_addItem(chr, 0, 1, msg_carpenterDef[81]);
mnu_addItem(chr, 0, 2, msg_carpenterDef[82]);
mnu_addItem(chr, 0, 3, msg_carpenterDef[83]);
mnu_addItem(chr, 0, 4, msg_carpenterDef[84]);
mnu_addItem(chr, 0, 5, msg_carpenterDef[85]);
mnu_addItem(chr, 0, 6, msg_carpenterDef[86]);
mnu_addItem(chr, 0, 7, msg_carpenterDef[87]);

mnu_setCallback(chr, funcidx("btn_smallbeds"));
mnu_show(chr)
}

public btn_smallbeds (const chr, const pg, const idx)
{
new starter = 56;
//printf("%d",idx);
new carptyp = starter+idx;
if( (idx == 0) || (idx == -1))
{
menu_carpenter(chr);
return;
}
carpcreate(chr, carptyp);
}

// big bedss und Forkes
public menu_big_beds (const chr)
{
mnu_prepare(chr, 1, 9);
mnu_setStyle(chr, MENUSTYLE_STONE, 0x0);
mnu_setTitle(chr, msg_carpenterDef[88]);

mnu_addItem(chr, 0, 0, " ");
mnu_addItem(chr, 0, 1, msg_carpenterDef[89]);
mnu_addItem(chr, 0, 2, msg_carpenterDef[90]);
mnu_addItem(chr, 0, 3, msg_carpenterDef[91]);
mnu_addItem(chr, 0, 4, msg_carpenterDef[92]);
mnu_addItem(chr, 0, 5, msg_carpenterDef[93]);
mnu_addItem(chr, 0, 6, msg_carpenterDef[94]);
mnu_addItem(chr, 0, 7, msg_carpenterDef[95]);
mnu_addItem(chr, 0, 8, msg_carpenterDef[96]);

mnu_setCallback(chr, funcidx("btn_bigbeds"));
mnu_show(chr)
}

public btn_bigbeds (const chr, const pg, const idx)
{
new starter = 63;
//printf("%d",idx);
new carptyp = starter + idx;
if( (idx == 0) || (idx == -1))
{
menu_carpenter(chr);
return;
}
carpcreate(chr, carptyp);
}

public last_item (const chr)
{
new carptyp = chr_getLocalIntVar(chr, globalSkillVarwood2);
carpcreate( chr, carptyp);
}


public carpcreate(const chr,  const carptyp)
{
new barrenid = chr_getLocalIntVar(chr, globalSkillVarwood1 );//board serial is called
new color = itm_getProperty(barrenid, IP_COLOR);//board color is called
if (itm_getProperty(barrenid, IP_AMOUNT) >= itemcarpDef[carptyp][boardnumber])
{
    if (chr_checkSkill(chr, SK_BLACKSMITHING, itemcarpDef[carptyp][skillmincarp], itemcarpDef[carptyp][skillmaxcarp], 1)) //skillcheck and gain control
        {
        itm_reduceAmount(barrenid, itemcarpDef[carptyp][boardnumber]); //delete needed boards
        itm_refresh(barrenid);
        carpcreate_zwei(chr, carptyp, color)
        }
    else
        {
        itm_reduceAmount(barrenid, (itemcarpDef[carptyp][boardnumber])/2); //too unexperienced for this item, delete half amount of needed boards
        itm_refresh(barrenid);
        chr_message( chr, _,"%s", msg_carpenterDef[99]); //not good enough
        return;
        }
    }
else
    {
    chr_message( chr, _,"%s", msg_carpenterDef[100]); //too few boards
    return;
    }
}


public carpcreate_zwei (const chr, const carptyp, const colornum)
{
new backpack = chr_getBackpack( chr );
chr_setLocalIntVar(chr, globalSkillVarwood2, carptyp);
new color[50];
switch(colornum)//get color name
{
       case 0251:  sprintf(color, "%s", logProperty[0][logscriptname]); //pine
       case 0149:  sprintf(color, "%s", logProperty[1][logscriptname]); //yew
       case 0350:  sprintf(color, "%s", logProperty[2][logscriptname]); //maple
       case 0643:  sprintf(color, "%s", logProperty[3][logscriptname]); //alder
       case 0747:  sprintf(color, "%s", logProperty[4][logscriptname]); //Nussbaum
       case 1721:  sprintf(color, "%s", logProperty[5][logscriptname]); //cedar
       case 0448:  sprintf(color, "%s", logProperty[6][logscriptname]); //oak
       case 0345:  sprintf(color, "%s", logProperty[7][logscriptname]); //beech
       case 0442:  sprintf(color, "%s", logProperty[8][logscriptname]); //mahogany
       case 0837:  sprintf(color, "%s", logProperty[9][logscriptname]); //ebony
       default: chr_message( chr, _, "wood of unknown color!");
}
trim(color);   //remove triming spaces
new name[50];
sprintf(name, "%s", itemcarpDef[carptyp][carpname]);
trim(name);
sprintf(name, "$item_%s%s", color, itemcarpDef[carptyp][carpname]);
new carpitem = itm_createByDef(name, backpack); //item-Script-Name is composed and item created in backpack
itm_refresh(carpitem);

chr_sound (chr, 42); //Sound carp
chr_action (chr, 11); //Animation carp
}
