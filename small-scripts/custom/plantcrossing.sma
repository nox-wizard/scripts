const NUM_PCOLOR = 15;

enum plantcolor
{
hueDec,
chance,
colorname: 20
}
static pcolorProperty[NUM_PCOLOR][plantcolor] = {
{ 37, 8, "dull red  "},
{ 39, 1, "bright red"},
{243, 2, "dull orange"},
{ 49, 1, "bright orange"},
{553, 8, "dull yellow"},
{ 53, 1, "bright yellow"},
{767, 2, "dull green"},
{368, 1, "bright green"},
{  2, 8, "dull blue"},
{100, 1, "bright blue"},
{517, 2, "dull purple"},
{ 13, 1, "bright purple"},
{  0, 0, "plain"},
{802, 0, "black"},
{1001,1, "white"}
};

const NUM_COLORCROSS = 12;
static cCrossResult[NUM_COLORCROSS] = {
{  2,  2,  1,  1,  3,  3,  1,  1, 11, 11,  1,  1},
{  2,  2,  1,  1,  3,  3,  1,  1, 11, 11,  1,  1},
{  1,  1,  4,  4,  5,  5,  5,  5,  9,  9,  1,  1},
{  1,  1,  4,  4,  5,  5,  5,  5,  9,  9,  1,  1},
{  3,  3,  5,  5,  6,  6,  5,  5,  7,  7,  5,  5},
{  3,  3,  5,  5,  6,  6,  5,  5,  7,  7,  5,  5},
{  1,  1,  5,  5,  5,  5,  8,  8,  9,  9,  9,  9},
{  1,  1,  5,  5,  5,  5,  8,  8,  9,  9,  9,  9},
{ 11, 11,  9,  9,  7,  7,  9,  9, 10, 10,  9,  9},
{ 11, 11,  9,  9,  7,  7,  9,  9, 10, 10,  9,  9},
{  1,  1,  1,  1,  5,  5,  9,  9,  9,  9, 12, 12},
{  1,  1,  1,  1,  5,  5,  9,  9,  9,  9, 12, 12}
};

const NUM_PLANTCROSS = 17;
enum planttype
{
hexid,
plantname: 20
}
static tCrossResult[NUM_PLANTCROSS] = {
{  c83,  "campion flower"},
{  c86,  "poppy flower"},
{  c88,  "snowdrops"},
{  c94,  "bulrushes"},
{  c8b,  "Lilies"},
{  ca5,  "pampas grass"},
{  ca7,  "rushes"},
{  c97,  "elephant ear plant"},
{  c9f,  "fern"},
{  ca6,  "ponytail palm"},
{  c9c,  "small palm"},
{  d31,  "century plant"},
{  d04,  "water plant"},
{  ca9,  "snake plant"},
{  d2c,  "prickle pear cactus"},
{  d26,  "barrel cactus"},
{  d27,  "tribarrel cactus"},
{  2,  ""}
};

public plantcrossing1(const chr, const i, const target)
{
	new targetscript;
	new backpack = chr_getBackpack( chr);
	if(target != 0)
	{
		targetscript = itm_getProperty(target, IP_SCRIPTID); //now call target scriptid
	}
	new triggerscript = triggerscript; //now call trigger scriptid
	if((targetscript == 435) && (triggerscript == 105106)) //fertile dirt is target, trigger is bowl
	{
		itm_reduceAmount(i, 1);
		itm_reduceAmount(target, 40);
		new bowl = itm_createByDef("$item_bowl_with_soil2", backpack);
		chr_emoteAll(chr, "Fills a pewter bowl with fertile dirt.");
		return;
	}
	else
	{
		itm_reduceAmount(i, 1);
		new bowl = itm_createByDef("$item_bowl_with_soil1", backpack);
		chr_emoteAll(chr, "Fills a pewter bowl with dirt.");
	}	
}

public plantcrossing2(const trigger, const chr, const target)
{
	new var_status = getIntFromDefine("$lclvar_plantcross_status");
	new var_water = getIntFromDefine("$lclvar_plantcross_water");
	new status = itm_getLocalIntVar(trigger, var_status);
	new water = itm_setLocalIntVar(trigger, var_water);
	new targetid;
	new targetscript;
	new triggerscript = itm_getProperty(trigger, IP_SCRIPTID); //now call target scriptid
	new triggerid = itm_getProperty(trigger, IP_ID);
	if(target != 0) //we are from a target here
	{
		targetscript = itm_getProperty(target, IP_SCRIPTID); //now call target scriptid
		targetid = itm_getProperty(target, IP_ID);
	}
	else if(target == 0) //double click at soil-filled bowl was trigger
	{
		if(status == 0)
		{
			chr_message( chr, _, "You need to water the soil with a pitcher.");
			return;
		}
		if(status == 1)
		{
			chr_message( chr, _, "You need to plant a seed inside.");
			return;
		}
		else plantcross_show(trigger, chr);
	}
	//water the soil, we allow to water the bowl till eternity of course = kill seed if put in, that is gardener skill so no warning
	else if( ( ((100093<=targetscript<=100096)&&(121072<=triggerscript<=121073)) || ((100093<=triggerscript<=100096)&&(121072<=targetscript<=121073)) ) && (0<=status<=1)) //trigger with dirt plus pitcher, but no seed inside
	{
		itm_setLocalIntVar(trigger, var_status, 1);
		itm_setLocalIntVar(trigger, var_water, water+1);
		add_and_del(chr, 105323, trigger); //delete the full pitcher and add an empty one
		chr_emoteAll(chr, "Waters the soil.");
		return;
	}
	//put in seed
	else if( ( ((0xdcc<=targetid<=0xdcf)&&(121072<=triggerscript<=121073)) || ((0xdcc<=triggerid<=0xdcf)&&(121072<=targetscript<=121073)) ) && (0<=status<=1)) //soil bowl plus seed, we allow to put the seed in not watered soil and watering afterwards too
	{
		itm_setLocalIntVar(trigger, var_status, 2);
		if(0xdcc<=targetid<=0xdcf)
		{
			itm_reduceAmount(target, 1);
		}
		else itm_reduceAmount(trigger, 1);
		chr_emoteAll(chr, "Puts a seed into the soil.");
	}
}
	
public plantcross_show(const trigger, const chr)
{
	bypass();
	new var_status = getIntFromDefine("$lclvar_plantcross_status");
	new status = itm_getLocalIntVar(trigger, var_status);
	if(status == 0) //only dirt but not watered
	{
		chr_message( chr, _, "You need to water the soil with a pitcher.");
		return;
	}
	else if(status == 0) //only watered dirt but no seed inside
	{
		chr_message( chr, _, "You need to plant a seed inside.");
		return;
	}
	const pagenumber = 1
	new plant_cross=gui_create(0,0,1,1,0, "plant_cross_bck");
	gui_addPage(plant_cross,0);
	gui_setProperty( plant_cross,MP_BUFFER,0,PROP_ITEM );
	
	gui_addResizeGump(plant_cross,20,30,83,210,190);
	new arrayline = pagenumber-1;
	
	new tempStr[75];
	
	//vines left
	gui_addTilePic(plant_cross, 9,60, 0x0cef);
	gui_addTilePic(plant_cross, 9,110, 0x0cf0);
	
	//vines right
	gui_addTilePic(plant_cross, 215,60, 0x0cef);
	gui_addTilePic(plant_cross, 215,110, 0x0cf0);
	
	//Button
	gui_addGump(plant_cross, 35,50, 0xd2);
	gui_addButton(plant_cross,35,50, 0x2333, 0x2333,1);
	
	gui_addButton(plant_cross,35,180, 0xd2, 0xd2,2);
	gui_addTilePic(plant_cross,18,180, 0xff8);
	
	gui_addButton(plant_cross,195,50, 0xd2, 0xd2,3);
	gui_addTilePic(plant_cross, 184,50, 0xd08);
	
	gui_addButton(plant_cross,195,180, 0xd2, 0xd2,4);
	gui_addTilePic(plant_cross, 183,179, 0x15fd);
	
	//Middle, pot with soil
	gui_addGump(plant_cross, 85, 80, 0x589);
	
	gui_addTilePic(plant_cross, 88,100, 0xee2);
	gui_addTilePic(plant_cross,100,110, 0xee0);
	gui_addTilePic(plant_cross,118, 95, 0xee0);
	
	gui_addTilePic(plant_cross, 88, 88, 0xee2);
	gui_addTilePic(plant_cross,100, 85, 0xee2);
	gui_addTilePic(plant_cross,110, 88, 0xee1);
			
	new k; //line in array where the potion categorie starts, attention, arraylines start with 0 and not with 1!
	new j; //line in array where the next potion categorie starts
	
	switch(pagenumber)
	{
		case 1: 
		{
			//agility
			k=0;
			j=2;
		}
		case 2:
		{
			//cure
			k=2;
			j=5;
		}
		case 3:
		{
			//explosion
			k=5;
			j=8;
		}
		case 4:
		{
			//healing
			k=8;
			j=11;
		}
		case 5:
		{
			//nightsight
			k=11;
			j=12;
		}
		case 6:
		{
			//poison
			k=12;
			j=16;
		}
		case 7:
		{
			//energy
			k=16;
			j=18;
		}
		case 8:
		{
			//strength
			k=18;
			j=20;
		}
		default: chr_message(chr, _, msg_sk_alchDef[9]);
		
	}
	
	gui_show(plant_cross, chr);
}

public plant_cross_bck()
{
	
}
