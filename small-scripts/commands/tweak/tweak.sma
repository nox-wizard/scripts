/*!
\defgroup script_command_tweak 'tweak
\ingroup script_commands

@{
*/

/*!
\author Straylight/wintermute (www.anacron.net) and Horian (gernox.de)
\fn cmd_tweak(const chr)
\brief ingame char/item editing

<B>syntax:</B> 'tweak
Shows an ingame menu that allows all kinds of modifications to chars and items<BR>
\todo rename this function when commands are done in sources to cmd_tweak
<br>
*/

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//                                        general tweak stuff                                             //
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
const BUTTON_APPLY=10
const twkpages=8; //one line for one page, two rows for one page

const oldpic = 5002;
const newpic = 5003;

enum twk_buttons
{ 
new1,
old1,
new2,
old2,
new3,
old3,
new4,
old4,
new5,
old5,
new6,
old6,
new7,
old7,
new8,
old8
};

static twkButton[twkpages][twk_buttons] = {
{5003, 5209, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003},
{5209, 5003, 5003, 5209, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003},
{5209, 5003, 5209, 5003, 5003, 5209, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003},
{5209, 5003, 5209, 5003, 5209, 5003, 5003, 5209, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003},
{5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5003, 5209, 5209, 5003, 5209, 5003, 5209, 5003},
{5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5003, 5209, 5209, 5003, 5209, 5003},
{5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5003, 5209, 5209, 5003},
{5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5003, 5209}
};

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//                                      Item tweak definition                                             //
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

const NUM_itmevent = 16;

enum eventItm_prop
{
eventItmname: 24,
eventItmnum
};

static eventItm_array[NUM_itmevent][eventItm_prop] = {
{"on equip:              ", 02},
{"on unequip:            ", 03},
{"on check can use:      ", 09},
{"on click:              ", 04},
{"on double click:       ", 05},
{"on put in backpack:    ", 06},
{"on drop in land:       ", 07},
{"on take from container:", 17},
{"on trade to someone:   ", 10},
{"on thief has stolen it:", 11},
{"on try lockpicking:    ", 15},
{"on try to disarm trap: ", 14},
{"on poisoned:           ", 12},
{"on cause damage:       ", 01},
{"on decay:              ", 13},
{"on chr walks over it:  ", 16}
};

const NUM_itmtweak = 89;
static it_pg1_l =0; //number of lines at left row
static it_pg1_r =0; //number of lines at right row
static it_pg2_l =0;
static it_pg2_r =0;
static it_pg3_l =0;
static it_pg3_r =0;
static it_pg4_l =0;
static it_pg4_r =0;

new it_gu = 40;
new it_tex = 56;
new it_prop = 195;
new it_check = 280;
new it_radio = 195;
new it_desc = 195;

enum Itm_tweaklines
{
it_linetype,
it_linename: 18,
it_propnumber,
it_infotype,
it_propval,
it_inputname: 10
};

//0: empty line for sorting lines at pages or use with text entry if helpful
//1: property field, eg itemname
//2: infofield, eg weight
//3: inputfield, eg Nightsight
//4: checkbox
//5: radiobutton
//6: subproperties (morex/morey/morez)
//7: stock function call: ct_propnumber is number of stock function, ct_infotype: string:1 and integer: 0
static itm_twkarray[NUM_itmtweak][Itm_tweaklines] = {
{1,"Itemname:        ", 454, 0, 0, "         "},
{1,"Attackpower:     ", 200, 0, 0, "         "},
{1,"Armorvalue:      ", 204, 0, 0, "         "},
{1,"Dex bonus:       ", 205, 0, 0, "         "},
{1,"Dex required:    ", 206, 0, 0, "         "},
{1,"Hitpoints:       ", 213, 0, 0, "         "},
{1,"Max. Hitpoints:  ", 219, 0, 0, "         "},
{1,"Min. Damage:     ", 217, 0, 0, "         "},
{1,"Max. Damage:     ", 212, 0, 0, "         "},
{1,"Int bonus:       ", 214, 0, 0, "         "},
{1,"Int required:    ", 215, 0, 0, "         "},
{1,"Str bonus:       ", 238, 0, 0, "         "},
{1,"Weight:          ", 248, 0, 0, "         "},
{1,"Color:           ", 403, 0, 0, "         "},
{2,"Scriptid:        ", 251, 0, 0, "         "},
{5,"Visible by:  all:", 120, 0, 2, "         "},
{5,"   owner & GM:   ", 120, 1, 0, "         "},
{5,"   only GM:      ", 120, 2, 0, "         "},
{5,"Movable default: ", 111, 0, 3, "         "},
{5,"   all:          ", 111, 1, 0, "         "},
{5,"   never:        ", 111, 2, 0, "         "},
{5,"   owner only:   ", 111, 3, 0, "         "},
{2,"Pile able:       ", 454, 0, 0, "         "},
{4,"Is Newbie-Item:  ", 118, 2, 0, "         "},
{6,"X Position:      ", 227, 0, 3, "         "},
{6,"Y Position:      ", 227, 1, 0, "         "},
{6,"Z Position:      ", 227, 2, 0, "         "},
{6,"More1:           ", 112, 1, 3, "         "},
{6,"More2:           ", 112, 2, 0, "         "},
{6,"More3:           ", 112, 3, 0, "         "},
{6,"More4:           ", 112, 4, 0, "         "},
{6,"MoreB 1:         ", 113, 1, 3, "         "},
{6,"MoreB 2:         ", 113, 2, 0, "         "},
{6,"MoreB 3:         ", 113, 3, 0, "         "},
{6,"MoreB 4:         ", 113, 4, 0, "         "},
{6,"MoreX:           ", 220, 1, 2, "         "},
{6,"MoreY:           ", 220, 2, 0, "         "},
{6,"MoreZ:           ", 220, 3, 0, "         "},
{1,"Good:          ? ", 211, 0, 0, "         "},
{1,"Money Value:     ", 247, 0, 0, "         "},
{2,"Random valuerate:", 231, 0, 0, "         "},
{1,"Rank:            ", 228, 0, 0, "         "},
{1,"Creator:         ", 450, 0, 0, "         "},
{4,"Can Decay:       ", 118, 1, 0, "         "},
{1,"Decay after msec:", 203, 0, 0, "         "},
{1,"Wipeable:        ", 249, 0, 0, "         "},
{1,"Can be dyed:     ", 105, 0, 0, "         "},
{2,"Is Corpse:       ", 102, 0, 0, "         "},
{1,"Is in Container: ", 202, 0, 0, "         "},
{2,"Is disabled:     ", 207, 0, 0, "         "},
{1,"Time unused:   ? ", 240, 0, 0, "         "},
{1,"How long unused? ", 241, 0, 0, "         "},
{1,"Gatenumber:   ?  ", 208, 0, 0, "         "},
{1,"Gatetime:     ?  ", 209, 0, 0, "         "},
{2,"Door-Dir:        ", 103, 0, 0, "         "},
{2,"Door is open:    ", 104, 0, 0, "         "},
{2,"Layer:           ", 110, 0, 0, "         "},
{1,"Damagetype:      ", 121, 0, 0, "         "},
{2,"Weapon Speed:    ", 237, 0, 0, "         "},
{1,"Magic dmg type:  ", 122, 0, 0, "         "},
{1,"Resists type:    ", 253, 0, 0, "         "},
{1,"Magic Dmg-power: ", 254, 0, 0, "         "},
{2,"Used Ammo type:  ", 255, 0, 0, "         "},
{1,"Used Ammo Fx:    ", 256, 0, 0, "         "},
{1,"Is poisoned:  ?  ", 217, 0, 0, "         "},
{1,"Multiserial:     ", 221, 0, 0, "         "},
{1,"Is secure chest: ", 232, 0, 0, "         "},
{1,"smelt:        ?  ", 234, 0, 0, "         "},
{6,"Item type2:    ? ", 246, 0, 0, "         "},
{2,"Animation ID:    ", 252, 0, 0, "         "},
{0,"Spawner Stuff    ",   0, 0, 0, "         "},
{1,"Max at Spawner:  ", 400, 0, 0, "         "},
{1,"Now at Spawner:  ", 401, 0, 0, "         "},
{6,"Script to Spawn: ", 220, 1, 2, "         "},
{6,"Minimal time(min)", 220, 2, 0, "         "},
{6,"Maximum time(min)", 220, 3, 0, "         "},
{1,"Item=61 or NPC=62", 245, 0, 0, "         "},
{7,"Min. to Spawn:   ",   0, 0, 0, "         "},
{7,"Max. to Spawn:   ",   1, 0, 0, "         "},
{1,"Spawn Region:    ", 235, 0, 0, "         "},
{1,"Spawner serial:  ", 236, 0, 0, "         "},
{1,"Restockrate:  ?  ", 230, 0, 0, "         "},
{1,"Direction:       ", 402, 0, 0, "         "},
{1,"Hex ID:          ", 404, 0, 0, "         "},
{6,"Description:     ", 451, 0, 0, "         "},
{1,"Disabled-Message:", 452, 0, 0, "         "},
{1,"Corpse-Murderer: ", 453, 0, 0, "         "},
{1,"Item-ID name:  ? ", 455, 0, 0, "         "},
{1,"Incognito:  ?    ", 455, 0, 0, "         "}
};

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//                                      Char tweak definition                                             //
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

const NUM_lay = 24;
enum ct_layerlines
{
	lt_used,
	lt_name: 11
};

static ct_layerprop[NUM_lay][ct_layerlines] = {
{0,"Hand 1"},
{0,"Hand 2"},
{0,"Shoes"},
{0,"Pants"},
{0,"Shirt"},
{0,"Helm"},
{0,"Gloves"},
{0,"Ring"},
{0,"Light"},
{0,"Neck"},
{0,"Hair"},
{0,"Waist"},
{0,"Chest"},
{0,"bracelet"},
{0,"Unused"},
{0,"Beard"},
{0,"mid torso"},
{0,"Ears"},
{0,"Arms"},
{0,"Cloak"},
{0,"Backpack"},
{0,"Robe"},
{0,"Skirts"},
{0,"inner legs"}
};

const NUM_chrevent = 38;

enum eventChr_prop
{
eventname: 23,
eventnum
};

static eventChr_array[NUM_chrevent][eventChr_prop] = {
{"on start combat:      ", 33},
{"on try hit:           ", 34},
{"on begin attack:      ", 12},
{"on begin defense:     ", 13},
{"on hit:               ", 02},
{"on hit miss:          ", 03},
{"on get hit:           ", 04},
{"on wounded:           ", 01},
{"on death:             ", 00},
{"on died:              ", 37},
{"on kill:              ", 31},
{"on resurrect:         ", 07},
{"on skill advance:     ", 10},
{"on stat advance:      ", 11},
{"on get skillcap:      ", 22},
{"on get statcap:       ", 23},
{"on cast spell:        ", 21},
{"on dispel:            ", 06},
{"on break meditation:  ", 27},
{"on snooped:           ", 17},
{"on stolen:            ", 18},
{"on poisoned:          ", 19},
{"on change region:     ", 20},
{"on change reputation: ", 05},
{"on change flag:       ", 08},
{"on walk:              ", 09},
{"on block:             ", 24},
{"on check npcai        ", 36},
{"on mount:             ", 29},
{"on dismount:          ", 30},
{"on transfer:          ", 14},
{"on hear player:       ", 32},
{"on speech             ", 35},
{"on multi enter:       ", 15},
{"on multi leave:       ", 16},
{"on start:             ", 25},
{"on heart beat:        ", 26},
{"on click:             ", 28}
};

static ct_pg1_l =0; //number of lines at left row
static ct_pg1_r =0; //number of lines at right row
static ct_pg2_l =0;
static ct_pg2_r =0;
static ct_pg3_l =0;
static ct_pg3_r =0;
static ct_pg4_l =0;
static ct_pg4_r =0;
static ct_pg5_l =0;
static ct_pg5_r =0;
static ct_pg6_l =0;
static ct_pg6_r =0;
static ct_pg7_l =0;
static ct_pg7_r =0;

const NUM_chrtweak = 75;
enum Chr_tweaklines
{
ct_linetype,
ct_linename: 19,
ct_propnumber,
ct_infotype,
ct_propval,
ct_inputname: 10
};

//0: empty line for sorting lines at pages or use with text entry if helpful
//1: property field, eg itemname
//2: infofield (for example weight): ct_propnumber is property num to get info or if 0 custom info function (then ct_infotype defines the number for custom function), ct_propval: string:1 and integer: 0
//3: inputfield, eg Nightsight, ct_propnumber = 1 for TFX-Effects, ct_propnumber = 2 for LocalVars Int, ct_propnumber = 3 for LocalVars Str
//4: checkbox: ct_propnumber is property num to change or 0 if custom function (then ct_infotype defines the number for custom function)
//5: radiobutton: ct_propnumber is property num to get info, ct_infotype is TRUE-value, ct_propval for grouping at page: how many MORE props in group?
//6: subproperties (morex/morey/morez), ct_propnumber is property num to get info, ct_infotype subproperty num, ct_propval for grouping at page: how many MORE props in group?
//7: stock function call: ct_propnumber is number of stock function, ct_infotype: string:1 and integer: 0
static chr_twkarray[NUM_chrtweak][Chr_tweaklines] = {
{1, "Char name:        ", 453, 0, 0, "         "},
{1, "Char title:       ", 455, 0, 0, "         "},
{1, "Karma:            ", 237, 0, 0, "         "},
{1, "Fame:             ", 218, 0, 0, "         "},
{6, "Strength:         ", 295, 2, 5, "         "},
{6, "Hits(from Str):   ", 295, 3, 0, "         "},
{6, "Dexterity:        ", 216, 2, 0, "         "},
{6, "Stamina(from Dex):", 216, 3, 0, "         "},
{6, "Intelligence:     ", 236, 2, 0, "         "},
{6, "Mana (from Int):  ", 236, 3, 0, "         "},
{1, "Kills:            ", 239, 0, 0, "         "},
{2, "Weight:           ", 312, 0, 0, "         "},
{7, "Skill sum:        ",   0, 0, 0, "         "},
{7, "Bank gold:        ",   1, 0, 0, "         "},
{4, "Open Bank box:    ",   0, 1, 0, "         "},
{4, "Open Gold bank:   ",   0, 2, 0, "         "},
{1, "Body color:       ", 404, 0, 0, "         "},
{1, "Body old color:   ", 406, 0, 0, "         "},
{1, "Body hexID:       ", 403, 0, 0, "         "},
{1, "Body old hexID:   ", 405, 0, 0, "         "},
{2, "ScriptID:         ", 272, 0, 0, "         "},
{1, "Command level:    ", 103, 0, 0, "         "},
{2, "Skill used:       ", 242, 0, 0, "         "},
{3, "Hunger:           ",  2,1002,0, "         "},
{3, "Thirst:           ",  2,1003,0, "         "},
{6, "X Position:       ", 262, 0, 2, "         "},
{6, "Y Position:       ", 262, 1, 0, "         "},
{6, "Z Position:       ", 262, 2, 0, "         "},
{6, "Foodposition X:   ", 220, 0, 2, "         "},
{6, "Foodposition Y:   ", 220, 1, 0, "         "},
{6, "Foodposition Z:   ", 220, 2, 0, "         "},
{6, "X Work Position:  ", 262, 0, 2, "         "},
{6, "Y Work Position:  ", 262, 1, 0, "         "},
{6, "Z Work Position:  ", 262, 2, 0, "         "},
{7, "Guild name:       ",   2, 1, 0, "         "},
{7, "Guild leader:     ",   3, 1, 0, "         "},
{4, "Go to Guild:      ",   0, 3, 0, "         "},
{7, "Char created at:  ",   4, 0, 0, "         "},
{4, "Invulnerable:     ", 134, 4, 0, "         "},
{4, "Kill/Dead:        ",   1, 0, 0, "         "},
{4, "Freeze:           ", 121, 2, 0, "         "},
{5, "Invis by skill:   ", 110, 1, 3, "         "},
{5, "Invis by spell:   ", 110, 2, 0, "         "},
{5, "permanent Invis:  ", 121, 8, 0, "         "},
{5, "Visible:          ", 110, 0, 0, "         "},
{4, "Warmode:          ", 128, 0, 0, "         "},
{2, "Reactive Armor:   ",   0, 1, 0, "         "},
{1, "Poisoned:         ", 258, 0, 0, "         "},
{1, "NPC Poison attack:", 257, 0, 0, "         "},
{1, "Poison time:      ", 261, 0, 0, "         "},
{1, "Face direction:   ", 104, 0, 0, "         "},
{3, "Nightsight:       ",   1, 2, 0, "millisec "},
{4, "Magic reflect:    ", 121,40, 0, "         "},
{4, "Polymorph:        ",   0, 4, 0, "         "},
{2, "Incognito:        ",   0, 2, 0, "         "},
{2, "Has shield:       ",   0, 3, 0, "         "},
{4, "See House as Icon:", 121, 4, 0, "         "},
{1, "Steps to fly:     ", 108, 0, 0, "         "},
{3, "Hallucination:    ",   1,20, 0, "millisec "},
{2, "Criminal:         ", 213, 0, 0, "         "},
{1, "Summontimer left: ", 296, 0, 0, "         "},
{2, "Is tamed:         ",   9, 0, 0, "         "},
{2, "Spawnerserial:    ", 285, 0, 0, "         "},
{2, "Is on horse:      ",   7, 0, 0, "         "},
{4, "Can move all:     ", 121, 1, 0, "         "},
{4, "Can Broadcast:    ", 134, 2, 0, "         "},
{1, "Defense rating:   ", 215, 0, 0, "         "},
{4, "Can dispel:       ", 121,20, 0, "         "},
{2, "Is jailed:        ",   5, 0, 0, "         "},
{4, "Needs no mana:    ", 121,10, 0, "         "},
{4, "Needs no reagents:", 121,80, 0, "         "},
{4, "Can see serials:  ", 134, 8, 0, "         "},
{4, "No skill title:   ", 134,10, 0, "         "},
{4, "Can snoop all:    ", 134,40, 0, "         "},
{1, "Wandermode:       ", 116, 0, 0, "         "}
};

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//                                         functions start                     //
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

public cmd_tweak(const chrsource)
{
	chr_message( chrsource, _, "About whom/what do you want info ?");
	target_create( chrsource, _, _, _, "TweakStart" );
}

public TweakStart( const t, const chrsource, const target, const x, const y, const z, const model, const param1 )
{
	//printf("chrsource: %d, target: %d, modell: %d, t: %d^n", chrsource, target, model, t);
	if ( chrsource < 0 )
		return;
	if ( target <= 0)
	{
		chr_message( chrsource, _,"Select a char or item,please");
		return;
	}
	if ( isChar(target)) //is npc/char
	        tweak_char(chrsource,target, 1);
	else if ( isItem(target))
		tweak_itm(chrsource,target, 1);
}

public init_tweak_itm()
{
	//printf("enter tweak initialization^n");
	static tweakinit = false;
	if(!tweakinit)
	{
		for(new i=0; i<NUM_itmtweak; ++i)
		{
			new j;
			if(itm_twkarray[i][it_linetype] == 5)
				j = i + itm_twkarray[i][it_propval]; //how many lines we need for the radiobuttonbox-thing?
			else if(itm_twkarray[i][it_linetype] == 6) //subprop-grouping
				j = i + itm_twkarray[i][it_propval];
			else j=i;
			//printf("j: %d^n", j);
			if(i<=13) //left row page1, we can only check first 14 array lines
			{
				if(j>=14)  //to add radio button would extend over max line number
					it_pg1_l = i-1; //then fewer lines then max to keep it together
				else if(j==13) //14 lines = maximum fits
					it_pg1_l = i; //maximum 14 lines that fit at row
			}
			else if(it_pg1_l < i <= (it_pg1_l+14))//right row first page, we can only check for next 14 array lines
			{
				if(j>(it_pg1_l+14)) // to add radio button would extend over max line number
				{
					it_pg1_r = i-1; //then fewer lines then max to keep it together
					i=it_pg1_l+14;
				}
				else if(j==(it_pg1_l+14))
					it_pg1_r = i; //maximum 14 lines that fit at row
			}
			else if(it_pg1_r < i <= (it_pg1_r+14))//left row 2. page
			{
				if(j>(it_pg1_r+14)) // to add radio button would extend over max line number
				{
					it_pg2_l = i-1; //then fewer lines then max to keep it together
					i=it_pg1_r+14;
				}
				else if(j==(it_pg1_r+14))
					it_pg2_l = i; //maximum 14 lines that fit at row
			}
			else if(it_pg2_l < i <= (it_pg2_l+14))//right row 2. page
			{
				if(j>(it_pg2_l+14)) // to add radio button would extend over max line number
				{
					it_pg2_r = i-1; //then fewer lines then max to keep it together
					i=it_pg2_l+14;
				}
				else if(j==(it_pg2_l+14))
					it_pg2_r = i; //maximum 14 lines that fit at row
			}
			else if(it_pg2_r < i <= (it_pg2_r+14))//left row 3. page
			{
				if(j>(it_pg2_r+14)) // to add radio button would extend over max line number
				{
					it_pg3_l = i-1; //then fewer lines then max to keep it together
					i=it_pg2_r+14;
				}
				else if((j==(it_pg2_r+14)) || i==(NUM_itmtweak-1))
					it_pg3_l = i; //maximum 14 lines that fit at row
			}
			else if(it_pg3_l < i <= (it_pg3_l+14))//right row 3. page
			{
				if(j>(it_pg3_l+14)) // to add radio button would extend over max line number
				{
					it_pg3_r = i-1; //then fewer lines then max to keep it together
					i=it_pg3_l+14;
				}
				else if((j==(it_pg3_l+14)) || i==(NUM_itmtweak-1))
					it_pg3_r = i; //maximum 14 lines that fit at row
			}
			else if(it_pg3_r < i <= (it_pg3_r+14))//left row 4. page
			{
				if(j>(it_pg3_r+14)) // to add radio button would extend over max line number
				{
					it_pg4_l = i-1; //then fewer lines then max to keep it together
					i=it_pg3_r+14;
				}
				else if((j==(it_pg3_r+14)) || i==(NUM_itmtweak-1))
					it_pg4_l = i; //maximum 14 lines that fit at row
			}
			else if(it_pg4_l < i <= (it_pg4_l+14))//right row 4. page
			{
				if(j>(it_pg4_l+14)) // to add radio button would extend over max line number
				{
					it_pg4_r = i-1; //then fewer lines then max to keep it together
					i=it_pg4_l+14;
				}
				else if((j==(it_pg3_l+14)) || i==(NUM_itmtweak-1))
					it_pg4_r = i; //maximum 14 lines that fit at row
			}//else if
		}//for
		for(new i=0; i<NUM_chrtweak; ++i)
		{
			new j;
			if(chr_twkarray[i][ct_linetype] == 5) //radiobutton-grouping
				j = i + chr_twkarray[i][ct_propval]; //how many lines we need for the radiobuttonbox-thing?
			else if(chr_twkarray[i][ct_linetype] == 6) //subprop-grouping
				j = i + chr_twkarray[i][ct_propval];
			else j=i;
			if(i<14) //left row page1, we can only check first 14 array lines
			{
				if(j>=14)  //to add radio button would extend over max line number
					ct_pg1_l = i-1; //then fewer lines then max to keep it together
				else if(j==13) //14 lines = maximum fits
					ct_pg1_l = i; //maximum 14 lines that fit at row
			}
			else if(ct_pg1_l < i <= (ct_pg1_l+14))//right row first page, we can only check for next 14 array lines
			{
				if(j>(ct_pg1_l+14)) // to add radio button would extend over max line number
				{
					ct_pg1_r = i-1; //then fewer lines then max to keep it together
					i=ct_pg1_l+14;
					//printf("i: %d, j: %d^n", i, j);
				}
				else if(j==(ct_pg1_l+14))
				{
					ct_pg1_r = i; //maximum 14 lines that fit at row
					//printf("J=last+14, i: %d^n", i);
				}
			}
			else if(ct_pg1_r < i <= (ct_pg1_r+14))//left row 2. page
			{
				if(j>(ct_pg1_r+14)) // to add radio button would extend over max line number
				{
					ct_pg2_l = i-1; //then fewer lines then max to keep it together
					i=ct_pg1_r+14;
				}
				else if(j==(ct_pg1_r+14))
					ct_pg2_l = i; //maximum 14 lines that fit at row
			}
			else if(ct_pg2_l < i <= (ct_pg2_l+14))//right row 2. page
			{
				if(j>(ct_pg2_l+14)) // to add radio button would extend over max line number
				{
					ct_pg2_r = i-1; //then fewer lines then max to keep it together
					i=ct_pg2_l+14;
				}
				else if(j==(ct_pg2_l+14))
					ct_pg2_r = i; //maximum 14 lines that fit at row
			}
			else if(ct_pg2_r < i <= (ct_pg2_r+14))//left row 3. page
			{
				if(j>(ct_pg2_r+14)) // to add radio button would extend over max line number
				{
					ct_pg3_l = i-1; //then fewer lines then max to keep it together
					i=ct_pg2_r+14;
				}
				else if((j==(ct_pg2_r+14)) || i==(NUM_chrtweak-1))
					ct_pg3_l = i; //maximum 14 lines that fit at row
			}
			else if(ct_pg3_l < i <= (ct_pg3_l+14))//right row 3. page
			{
				if(j>(ct_pg3_l+14)) // to add radio button would extend over max line number
				{
					ct_pg3_r = i-1; //then fewer lines then max to keep it together
					i=ct_pg3_l+14;
				}
				else if((j==(ct_pg3_l+14)) || i==(NUM_chrtweak-1))
					ct_pg3_r = i; //maximum 14 lines that fit at row
			}
			else if(ct_pg3_r < i <= (ct_pg3_r+14))//left row 4. page
			{
				if(j>(ct_pg3_r+14)) // to add radio button would extend over max line number
				{
					ct_pg4_l = i-1; //then fewer lines then max to keep it together
					i=ct_pg3_r+14;
				}
				else if((j==(ct_pg3_r+14)) || i==(NUM_chrtweak-1))
					ct_pg4_l = i; //maximum 14 lines that fit at row
			}
			else if(ct_pg4_l < i <= (ct_pg4_l+14))//right row 4. page
			{
				if(j>(ct_pg4_l+14)) // to add radio button would extend over max line number
				{
					ct_pg4_r = i-1; //then fewer lines then max to keep it together
					i=ct_pg4_l+14;
				}
				else if((j==(ct_pg3_l+14)) || i==(NUM_chrtweak-1))
					ct_pg4_r = i; //maximum 14 lines that fit at row
			}//else if
		}//for
	tweakinit = true;
	}//if
	//printf("^nL1: %d, R1: %d, Char L1: %d, R1: %d^n", it_pg1_l, it_pg1_r, ct_pg1_l, ct_pg1_r);
}

public tweak_itm(const chrsource, const target, pagenumber)
{
	//printf("enter tweakstarter^n");
	init_tweak_itm();
	//printf("finished tweakinit^n");
	
	new tempItmStr[100];
	new twkItmMenu = gui_create( 10,10,1,1,1,"tweakItmBck" );
	
	gui_setProperty( twkItmMenu,MP_BUFFER,0,PROP_ITEM );
	gui_setProperty( twkItmMenu,MP_BUFFER,1,target );
	gui_setProperty( twkItmMenu,MP_BUFFER,3,BUTTON_APPLY );

	gui_addPage(twkItmMenu,0);
	gui_addResizeGump(twkItmMenu,10,35,5054,550,530 );
	gui_addResizeGump(twkItmMenu,20,105,3500,530,455);
	gui_addResizeGump(twkItmMenu,25,49,5100,525,51);
	
	gui_addText(twkItmMenu,250,32,1210,"Tweak Menue");
	gui_addButton( twkItmMenu,460,525, 0x084A, 0x084B,BUTTON_APPLY );
	gui_addPage(twkItmMenu,1);
	new arrayline = pagenumber-1;
	gui_addButton(twkItmMenu,35,51,twkButton[arrayline][new1],twkButton[arrayline][old1],1);
	gui_addText(twkItmMenu,60,49,33,"Main infos");
	gui_addButton(twkItmMenu,170,51,twkButton[arrayline][new2],twkButton[arrayline][old2],2);
	gui_addText(twkItmMenu,195,49,33,"Flags1");
	gui_addButton(twkItmMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
	gui_addText(twkItmMenu,285,49,33,"Flags2");
	gui_addButton(twkItmMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
	gui_addText(twkItmMenu,380,49,33,"Flags3");
	gui_addButton(twkItmMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
	gui_addText(twkItmMenu,470,49,33,"Events");
	gui_addButton(twkItmMenu,35,81,twkButton[arrayline][new6],twkButton[arrayline][old6],6);
	gui_addText(twkItmMenu,60,79,33,"LocalVars");
	
	gui_addText(twkItmMenu,66,120,33,"Owner :");
	sprintf( tempItmStr,"%d",itm_getProperty(target, IP_OWNERSERIAL));
	gui_addText( twkItmMenu, 130, 120,0,tempItmStr);
	
	gui_addText(twkItmMenu,220,120,33,"Serial :");
	sprintf( tempItmStr,"%d",itm_getProperty(target,IP_SERIAL));
	gui_addText( twkItmMenu, 276, 120,0,tempItmStr);
	
	gui_addGump(twkItmMenu,400,121, 0x827);
	gui_addText(twkItmMenu,421,120,33,"Itemtype:");
	gui_addPropField( twkItmMenu,485,120,50,150,245);
	
	new startline;
	new leftrow;
	new rightrow;
	new checklev;

	if( pagenumber == 1)
	{
		gui_addText(twkItmMenu,230,150,33,"Main info");
		startline = 0;
		leftrow = it_pg1_l;
		rightrow = it_pg1_r;
	}
	else if( pagenumber == 2)
	{
		gui_addText(twkItmMenu,230,150,33,"Flags 1");
		startline = it_pg1_r+1;
		leftrow = it_pg2_l;
		rightrow = it_pg2_r;
	}
	else if( pagenumber == 3)
	{
		gui_addText(twkItmMenu,230,150,33,"Flags 2");
		startline = it_pg2_r+1;
		leftrow = it_pg3_l;
		rightrow = it_pg3_r;
	}
	else if( pagenumber == 4)
	{
		gui_addText(twkItmMenu,230,150,33,"Flags 3");
		startline = it_pg2_r+1;
		leftrow = it_pg4_l;
		rightrow = it_pg4_r;
	}
	else if( pagenumber == 5)
	{
		gui_addText(twkItmMenu,230,150,33,"Events");
		new i;
		for ( i=0;i < NUM_itmevent;++i)
		{
			sprintf(tempItmStr, " ");
			gui_addGump(twkItmMenu,it_gu,181+(i*20), 0x827);
			gui_addText(twkItmMenu,it_tex,180+(i*20),1310,eventItm_array[i][eventItmname]);
			itm_getEventHandler(target,eventItm_array[i][eventItmnum],tempItmStr);
			gui_addInputField( twkItmMenu,it_prop+50,180+(i*20),150,20,i+1,0,tempItmStr);
			gui_addCheckbox( twkItmMenu, it_check+70, 181+(i*20), oldpic, newpic, 1, i+1 );
		}
	}
	else if( pagenumber == 6)
	{
		gui_addText(twkItmMenu,230,150,33,"LocalVars");
		
		new count=0;
		new LocalV[512];
		new dividerrest=0;
		new divider;
		new num;
		new subpages=33; //subpages-lines we already have
		
		gui_addText( twkItmMenu, 40, 500, 33, "Add LocalVar:");
		gui_addText(twkItmMenu,150,500,0,"Str:");
		gui_addRadioButton( twkItmMenu,190,503, oldpic,newpic,0,100);
		gui_addText(twkItmMenu,215,500,0,"Int:");
		gui_addRadioButton( twkItmMenu,255,503, oldpic,newpic,0,101);
		gui_addText(twkItmMenu,280,500,0,"None:");
		gui_addRadioButton( twkItmMenu,320,503, oldpic,newpic,1,102);
		gui_addInputField( twkItmMenu, 370, 500, 40, 20, 5, 1310, "(No.)");
		gui_addInputField( twkItmMenu, 420, 500, 100, 20, 6, 1310, "(Value)");	
		for (num=1000;num<5000;num++)
		{
			if(itm_isaLocalVar(target, num, VAR_TYPE_ANY))
			{
				count++; //count the real existing local vars we have
				divider = count/32; //one page allows 32 local vars, how many pages do we need?
				dividerrest = count%32; //divide the number of existing local vars with modulo %, how much is left after having put all into full 32rds = how many left after doing full pages
				//printf("found localVar, count: %d, divider: %d, dividerrest %d^n", count, divider, dividerrest);
				
				new subpagecount = subpages/32; //we reach a divider >= 1, so we add one page button and one page, make sure to add only ONE page/button per increased divider ...!
				if( ((divider==1)&&(dividerrest!=0)) || (divider>=2))
				{
					subpages++;
					//printf("subpagecount: %d, divider: %d, subpages: %d, dividerrest: %d^n", subpagecount, divider, subpages, dividerrest);
					if(dividerrest==1) //next page necessary
					{
						gui_addPageButton(twkItmMenu,310,523,2224,2224,(subpagecount+1)); //next page button at previous pages
						sprintf(tempItmStr, "next page (%d)", (subpagecount+1))
						gui_addText(twkItmMenu,330,520,1310,tempItmStr);
												
						//printf("make new page^n");
						gui_addPage(twkItmMenu,(subpagecount+1));
						
						//add pagebuttons to real dynamic pages that do not create additional pages
						gui_addText(twkItmMenu, 60,520,1310,"page 1"); //first page button
						gui_addPageButton(twkItmMenu, 40,523,2224,2224,1);
						
						if(subpagecount>=2)
						{
							gui_addPageButton(twkItmMenu,170,523,2223,2223,subpagecount); //previous page button at new page
							sprintf(tempItmStr, "previous page (%d)", subpagecount)
							gui_addText(twkItmMenu,190,520,1310,tempItmStr);
						}
												
						gui_addButton(twkItmMenu,35,51,twkButton[arrayline][new1],twkButton[arrayline][old1],1);
						gui_addText(twkItmMenu,60,49,33,"Main infos");
						gui_addButton(twkItmMenu,170,51,twkButton[arrayline][new2],twkButton[arrayline][old2],2);
						gui_addText(twkItmMenu,195,49,33,"Flags1");
						gui_addButton(twkItmMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
						gui_addText(twkItmMenu,285,49,33,"Flags2");
						gui_addButton(twkItmMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
						gui_addText(twkItmMenu,380,49,33,"Flags3");
						gui_addButton(twkItmMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
						gui_addText(twkItmMenu,470,49,33,"Events");
						gui_addButton(twkItmMenu,35,81,twkButton[arrayline][new6],twkButton[arrayline][old6],6);
						gui_addText(twkItmMenu,60,79,33,"LocalVars");
						
						gui_addText(twkItmMenu,66,120,33,"Owner :");
						sprintf( tempItmStr,"%d",itm_getProperty(target, IP_OWNERSERIAL));
						gui_addText( twkItmMenu, 130, 120,0,tempItmStr);
						
						gui_addText(twkItmMenu,220,120,33,"Serial :");
						sprintf( tempItmStr,"%d",itm_getProperty(target,IP_SERIAL));
						gui_addText( twkItmMenu, 276, 120,0,tempItmStr);
						
						gui_addGump(twkItmMenu,400,121, 0x827);
						gui_addText(twkItmMenu,421,120,33,"Itemtype:");
						gui_addPropField( twkItmMenu,485,120,50,150,245);
						
						sprintf( tempItmStr,"LocalVars %d",(subpagecount+1));
						gui_addText(twkItmMenu,230,150,33,tempItmStr);
						
						if (itm_isaLocalVar(target, num, VAR_TYPE_INTEGER))
						{
							sprintf(LocalV, "%d", itm_getLocalIntVar(target,num));
							sprintf(tempItmStr, "Int %d" , num);
						}
						else
						{
							itm_getLocalStrVar(target, num, LocalV);
							sprintf(tempItmStr, "Str %d" , num);
						}
						gui_addGump(twkItmMenu,39,180, 0x827);
						gui_addText( twkItmMenu, 60, 180, 1310, tempItmStr);
						gui_addInputField( twkItmMenu, 140, 180, 125, 30, num, 0, LocalV);
						gui_addCheckbox( twkItmMenu, 250, 180, oldpic, newpic, 1, num );
					}
					else
					{
						if( (dividerrest<=16) && (dividerrest != 0))
						{
							//printf("dividerrest < 16, enter sub page content, count: %d^n", count);
							if (itm_isaLocalVar(target, num, VAR_TYPE_INTEGER))
							{
								sprintf(LocalV, "%d", itm_getLocalIntVar(target,num));
								sprintf(tempItmStr, "Int %d" , num);
							}
							else
							{
								itm_getLocalStrVar(target, num, LocalV);
								sprintf(tempItmStr, "Str %d" , num);
							}
							gui_addGump(twkItmMenu,39, 160+(20*(count+1-divider*33)), 0x827);
							gui_addText( twkItmMenu, 60, 160+(20*(count+1-divider*33)), 1310, tempItmStr);
							gui_addInputField( twkItmMenu, 140, 160+(20*(count+1-divider*33)), 125, 30, num, 0, LocalV);
							gui_addCheckbox( twkItmMenu, 250, 160+(20*(count+1-divider*33)), oldpic, newpic, 1, num );
						}
						else
						{
							//printf("dividerrest > 16, enter sub page content, count: %d^n", count);
							if (itm_isaLocalVar(target, num, VAR_TYPE_INTEGER))
							{
								sprintf(LocalV, "%d", itm_getLocalIntVar(target,num));
								sprintf(tempItmStr, "Int %d" , num);
							}
							else
							{
								itm_getLocalStrVar(target, num, LocalV);
								sprintf(tempItmStr, "Str %d" , num);
							}
							if(dividerrest == 0)
								divider=divider-1;
							gui_addGump(twkItmMenu,299,160+(20*((count+1-divider*33)-16)), 0x827);
							gui_addText( twkItmMenu, 320, 160+(20*((count+1-divider*33)-16)), 1310, tempItmStr);
							gui_addInputField( twkItmMenu, 400, 160+(20*((count+1-divider*33)-16)), 125, 30, num, 0, LocalV);
							gui_addCheckbox( twkItmMenu, 510, 160+(20*((count+1-divider*33)-16)), oldpic, newpic, 1, num );
						}				
					}//for
				}//if subaccount
				else /*if((divider==0) || ((divider==1) && (dividerrest==0)))*/ //first page == almost static (no subpage)
				{
					if(1<=dividerrest<=16)
					{
						//printf("dividerrest < 16, enter first page content, count: %d^n", count);
						if (itm_isaLocalVar(target, num, VAR_TYPE_INTEGER))
						{
							sprintf(LocalV, "%d", itm_getLocalIntVar(target,num));
							sprintf(tempItmStr, "Int %d" , num);
						}
						else if(itm_isaLocalVar(target, num, VAR_TYPE_STRING))
						{
							itm_getLocalStrVar(target, num, LocalV);
							sprintf(tempItmStr, "Str %d" , num);
						}
						gui_addGump(twkItmMenu,39, 160+(20*count), 0x827);
						gui_addText( twkItmMenu, 60, 160+(20*count), 1310, tempItmStr);
						gui_addInputField( twkItmMenu, 140, 160+(20*count), 125, 30, num, 0, LocalV);
						gui_addCheckbox( twkItmMenu, 250, 160+(20*count), oldpic, newpic, 1, num );
					}
					else
					{
						//printf("dividerrest > 16, enter first page content, count: %d^n", count);
						if (itm_isaLocalVar(target, num, VAR_TYPE_INTEGER))
						{
							sprintf(LocalV, "%d", itm_getLocalIntVar(target,num));
							sprintf(tempItmStr, "Int %d" , num);
						}
						else if(itm_isaLocalVar(target, num, VAR_TYPE_STRING))
						{
							itm_getLocalStrVar(target, num, LocalV);
							sprintf(tempItmStr, "Str %d" , num);
						}
						gui_addGump(twkItmMenu,299,160+(20*(count-16)), 0x827);
						gui_addText( twkItmMenu, 320, 160+(20*(count-16)), 1310, tempItmStr);
						gui_addInputField( twkItmMenu, 400, 160+(20*(count-16)), 125, 30, num, 0, LocalV);
						gui_addCheckbox( twkItmMenu, 510, 160+(20*(count-16)), oldpic, newpic, 1, num );
					}
				}//if
			}//if
		}//for
		
		//printf("dividerrest: %d, count: %d", dividerrest, count);
	}//page number 6
	
	if( 1<= pagenumber <= 4)
	{
		new linetype; //type of the line (propertyfield, inputfield, radiobutton ...)
		new p; //creates several property fields if splitted (more is splitted into 4 more values and so p for more is 4)
		new k=0; //multiplier how many pixel right row is pushed to the right compared to the left row
		new n=0; //counts the line numbers per row, max is 14 lines
		if((rightrow == 0) && (leftrow != 0))
			rightrow = leftrow;
		else if((rightrow != 0) && (leftrow != 0))
		{
			for(new i=startline; i<=rightrow; ++i)
			{
				//printf("i: %d, pagenumber: %d^n", i, pagenumber);
				if(i==(leftrow+1))
				{
					k=254;
					n=0;
				}
				linetype = itm_twkarray[i][it_linetype];
				//printf("linetype: %d, i: %d^n, m: %d, n:%d^n", linetype, i, m, n);
				switch(linetype)
				{
					case 0:
					{
						gui_addText(twkItmMenu,it_tex+k,180+(n*20),33, itm_twkarray[i][it_linename]);					
					}
					case 1: //property field, eg itemname
					{
						gui_addGump(twkItmMenu,it_gu+k,181+(n*20), 0x827);
						gui_addText(twkItmMenu,it_tex+k,180+(n*20),1310, itm_twkarray[i][it_linename]);
						if(itm_twkarray[i][it_infotype] != 0) //its a splitted property (more is more1, more2, more3 ...)
						{
							for(p = 1; p<= itm_twkarray[i][it_infotype]; p++)
							{
								gui_addPropField( twkItmMenu, it_prop+k-30+p*30, (180+(n*20)),150,30, itm_twkarray[i][it_propnumber]);
							}
						}
						else gui_addPropField( twkItmMenu, it_prop+k, (180+(n*20)),150,30, itm_twkarray[i][it_propnumber]);
					}
					case 2: //infofield, eg weight
					{
						gui_addText(twkItmMenu,it_tex+k,180+(n*20),1310,itm_twkarray[i][it_linename]);
						if(itm_twkarray[i][it_infotype]==0)
						{
							sprintf( tempItmStr,"%d",itm_getProperty(target,itm_twkarray[i][it_propnumber]));
						}
						gui_addText( twkItmMenu, it_desc+k, 180+(n*20),0,tempItmStr);
						sprintf( tempItmStr,"");
					}
					case 3: //inputfield, eg Nightsight
					{
						gui_addGump(twkItmMenu,it_gu+k, 181+(n*20), 0x827);
						if( isStrContainedInStr(itm_twkarray[i][it_linename], "Nightsight"))
						{
							if(tempfx_isActive( target,TFX_SPELL_LIGHT) == 1)
							checklev = 1;
						}
						gui_addText(twkItmMenu,it_tex+k,180+(n*20),1310,itm_twkarray[i][it_linename]);
						gui_addInputField( twkItmMenu,it_prop+k,180+(n*20),50,20,i,1110,itm_twkarray[i][it_inputname]);
						gui_addCheckbox( twkItmMenu,it_check+k,180+(n*20),oldpic,newpic,checklev,i);
						checklev=0;
					}
					case 4: //checkbox
					{
						if(itm_twkarray[i][it_propnumber] == 118) //decay
						{
							if(itm_getProperty( target,IP_PRIV)&itm_twkarray[i][it_infotype] != itm_twkarray[i][it_infotype]) //can decay
								checklev = 1;
						}
						gui_addText(twkItmMenu,it_tex+k,180+(n*20),1310,itm_twkarray[i][it_linename]);
						gui_addCheckbox( twkItmMenu,it_prop+k,181+(n*20),oldpic,newpic,checklev,i);
						checklev=0;
					}
					case 5: //radiobutton
					{
						new u; //how many radiobuttons are part of this group?
						if( itm_twkarray[i][it_propval] != 0) //first line of a radiobuttongroup
						{
							u=itm_twkarray[i][it_propval]+1;
							gui_addGroup( twkItmMenu, u );
						}
						if(itm_twkarray[i][it_infotype] == itm_getProperty( target,itm_twkarray[i][it_propnumber]))
							checklev = 1;
						if(itm_twkarray[i][it_propnumber] == 120) //visible
							{
							gui_addText(twkItmMenu,it_tex+k,180+(n*20),1310, itm_twkarray[i][it_linename]);
							gui_addRadioButton( twkItmMenu,it_radio+k,(180+(n*20)), oldpic,newpic,checklev,i);
							}
						if(itm_twkarray[i][it_propnumber] == 111) //moveable
						{
							gui_addText(twkItmMenu,it_tex+k,180+(n*20),1310, itm_twkarray[i][it_linename]);
							gui_addRadioButton( twkItmMenu,it_radio+k,(180+(n*20)), oldpic,newpic,checklev,i);
						}
						checklev=0;
					}
					case 6: //splitted properties (more for example)
					{
						gui_addGump(twkItmMenu,it_gu+k,181+(n*20), 0x827);
						gui_addText(twkItmMenu,it_tex+k,180+(n*20),1310, itm_twkarray[i][it_linename]);
						gui_addPropField( twkItmMenu, (it_prop+k), (180+(n*20)),150,30, (itm_twkarray[i][it_propnumber]), (itm_twkarray[i][it_infotype]));
					}
					case 7:
					{
						new stocktype = itm_twkarray[i][it_propnumber];
						if( (stocktype == 0) || (stocktype == 1)) //MoreB1+2
						{
							new moreb1 = itm_getProperty(target, IP_MOREB, 1+2*stocktype);
							new moreb2 = itm_getProperty(target, IP_MOREB, 2+2*stocktype);
							moreb1 = (moreb1&0xff);
							moreb2 = (moreb2&0xff)<<8;
							sprintf(tempItmStr, "%d", moreb1+moreb2);
							gui_addGump(twkItmMenu,it_gu+k, 181+(n*20), 0x827);
							gui_addText(twkItmMenu,it_tex+k,180+(n*20),1310,itm_twkarray[i][it_linename]);
							gui_addInputField( twkItmMenu,it_prop+k,180+(n*20),50,20,i,1110,tempItmStr);
							gui_addCheckbox( twkItmMenu,it_check+k-10,180+(n*20),oldpic,newpic,checklev,i);
							checklev=0;
						}
					}
					default: printf("unknown item-tweak case!");
				}//linetype
				n=n+1;
			}//for
		}
	}//if pagenumber
	gui_show(twkItmMenu,chrsource); 
}

public viewItmMenu(const chrsource, const target, const buttonCode)
{
	//printf("enter viewItmMenu, page: %d^n", buttonCode);
	switch(buttonCode)
	{
		case 1: tweak_itm(chrsource, target, 1);
		case 2: tweak_itm(chrsource, target, 2);
		case 3: tweak_itm(chrsource, target, 3);
		case 4: tweak_itm(chrsource, target, 4);
		case 5: tweak_itm(chrsource, target, 5);
		case 6: tweak_itm(chrsource, target, 6);
		case 7: tweak_itm(chrsource, target, 7);
	}
}

public tweakItmBck(const twkItmMenu, const chrsource, const buttonCode)
{
	new target = gui_getProperty( twkItmMenu,MP_BUFFER,1 ); //target
	if( 1 <= buttonCode <= 7)
	{
		viewItmMenu(chrsource, target, buttonCode);
		//gui_delete( twkItmMenu );
	}
	else if( buttonCode == 10) //apply
	{
		for(new i=0; i <= NUM_itmtweak; ++i)
		{
			new linetype = itm_twkarray[i][it_linetype];
			if(linetype == 4) //checkbox
			{
				if(itm_twkarray[i][it_propnumber] == 118) //Priv
				{
					if( (itm_getProperty( target,IP_PRIV)&itm_twkarray[i][it_infotype] == itm_twkarray[i][it_infotype]) && (!gui_getProperty(twkItmMenu,MP_RADIO,i)) ) //is at TRUE and not checked
						itm_setProperty( target,IP_PRIV, _, itm_setProperty( target,IP_PRIV) &~ itm_twkarray[i][it_infotype] );
					else if( (itm_getProperty( target,IP_PRIV)&itm_twkarray[i][it_infotype] != itm_twkarray[i][it_infotype]) && (gui_getProperty(twkItmMenu,MP_RADIO,i))) //is false and checked now
						itm_setProperty( target,IP_PRIV, _, itm_setProperty( target,IP_PRIV) | itm_twkarray[i][it_infotype] );
				}
			}
			else if(linetype == 5) //radiobutton
			{
				new limit;
				if(itm_twkarray[i][it_infotype] != 0)
				{
					limit = itm_twkarray[i][it_infotype]
				}
				for( new m = 0; m <= limit; ++m)
				{
					if(gui_getProperty(twkItmMenu,MP_RADIO,i))
						itm_setProperty( target, itm_twkarray[i][it_propnumber], _, itm_twkarray[i][it_propval]);
				}
				limit = 0;
			}
			else if(linetype == 7) //stock function
			{
				new stocktype = itm_twkarray[i][it_propnumber];
				if( (stocktype == 0) || (stocktype == 1)) //MoreB1+2
				{
					new textbuf_input[15];
		        		new value=0;
		        		new checked = gui_getProperty(twkItmMenu,MP_CHECK,i);
		        		gui_getProperty(twkItmMenu,MP_UNI_TEXT,i,textbuf_input);
		        		trim(textbuf_input);
		        		if (isStrUnsignedInt(textbuf_input)) //should be an integer, is it?
		        		{
		        			value = str2UnsignedInt(textbuf_input);
						new moreb1 = value%256;
						new moreb2 = value/256;
						printf("moreb1: %d, moreb2: %d^n", moreb1, moreb2);
						itm_setProperty(target, IP_MOREB, 1+2*stocktype, moreb1);
						itm_setProperty(target, IP_MOREB, 2+2*stocktype, moreb2);
						printf("moreb1-subprop: %d, moreb2-subprop: %d^n", 1+2*stocktype*(9/10), 2+2*stocktype*(9/10));
		        		}
			        	else chr_message( chrsource, _,"A number must be inserted!");
			        }
			}//linetype
		}//for
		itm_refresh(target);
	}//apply button
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//                                                  char tweak                                           //
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

public tweak_char(const chrsource, const target, pagenumber)
{
	printf("enter char tweak seite %d^n", pagenumber);
	init_tweak_itm();
	new tempChrStr[100];
	
	new twkChrMenu = gui_create( 10,10,1,1,1,"tweakchrBck" );
	
	gui_setProperty( twkChrMenu,MP_BUFFER,0,PROP_CHARACTER );
	gui_setProperty( twkChrMenu,MP_BUFFER,1,target );
	gui_setProperty( twkChrMenu,MP_BUFFER,3,BUTTON_APPLY );
	gui_setProperty( twkChrMenu,MP_BUFFER,4,pagenumber );

	gui_addPage(twkChrMenu,0);
	gui_addResizeGump(twkChrMenu,10,35,5054,550,530 );
	gui_addResizeGump(twkChrMenu,20,105,3500,530,455);
	gui_addResizeGump(twkChrMenu,25,49,5100,525,51);
	
	gui_addText(twkChrMenu,250,32,1210,"Tweak Menue");
	gui_addButton( twkChrMenu,460,525, 0x084A, 0x084B,BUTTON_APPLY );
	gui_addPage(twkChrMenu,1);

	new arrayline = pagenumber-1;

	gui_addButton(twkChrMenu,35,51,twkButton[arrayline][new1],twkButton[arrayline][old1],1);
	gui_addText(twkChrMenu,60,49,33,"Main infos");
	gui_addButton(twkChrMenu,170,51,twkButton[arrayline][new2],twkButton[arrayline][old2],2);
	gui_addText(twkChrMenu,195,49,33,"Flags1");
	gui_addButton(twkChrMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
	gui_addText(twkChrMenu,285,49,33,"Flags2");
	gui_addButton(twkChrMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
	gui_addText(twkChrMenu,380,49,33,"Flags3");
	gui_addButton(twkChrMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
	gui_addText(twkChrMenu,470,49,33,"Events");
	gui_addButton(twkChrMenu,35,81,twkButton[arrayline][new6],twkButton[arrayline][old6],6);
	gui_addText(twkChrMenu,60,79,33,"LocalVars");
	gui_addButton(twkChrMenu,170,81,twkButton[arrayline][new7],twkButton[arrayline][old7],7);
	gui_addText(twkChrMenu,195,79,33,"Skills");
	gui_addButton(twkChrMenu,260,81,twkButton[arrayline][new8],twkButton[arrayline][old8],8);
	gui_addText(twkChrMenu,285,79,33,"Layer");
	
	printf("target: %d", target);
	gui_addText(twkChrMenu,66,120,33,"Account number :");
	sprintf( tempChrStr,"%d",chr_getProperty(target,CP_ACCOUNT));
	gui_addText( twkChrMenu, 185, 120,0,tempChrStr);
	
	gui_addText(twkChrMenu,280,120,33,"Serial :");
	sprintf( tempChrStr,"%d",chr_getProperty(target,CP_SERIAL));
	gui_addText( twkChrMenu, 336, 120,0,tempChrStr);
	
	gui_addGump(twkChrMenu,430,121, 0x827);
	gui_addText(twkChrMenu,451,120,33,"NPC-AI:");
	gui_addPropField( twkChrMenu,515,120,50,30,CP_NPCAI);
	
	new startline;
	new leftrow;
	new rightrow;
	new checklev;
	new ct_gu = 40; //254
	new ct_tex = 56; //right: 270 = delta 104
	new ct_prop = 195; //right: 284
	new ct_check = 280;
	new ct_radio = 195;
	new ct_desc = 195; //description
	
	if( pagenumber == 1)
	{
		gui_addText(twkChrMenu,230,150,33,"Main info");
		startline = 0;
		leftrow = ct_pg1_l;
		rightrow = ct_pg1_r;
	}
	else if( pagenumber == 2)
	{
		gui_addText(twkChrMenu,230,150,33,"Flags 1");
		startline = ct_pg1_r+1;
		leftrow = ct_pg2_l;
		rightrow = ct_pg2_r;
	}
	else if( pagenumber == 3)
	{
		gui_addText(twkChrMenu,230,150,33,"Flags 2");
		startline = ct_pg2_r+1;
		leftrow = ct_pg3_l;
		rightrow = ct_pg3_r;
	}
	else if( pagenumber == 4)
	{
		gui_addText(twkChrMenu,230,150,33,"Flags 3");
		startline = ct_pg2_r+1;
		leftrow = ct_pg4_l;
		rightrow = ct_pg4_r;
	}
	//printf("rightrow: %d, leftrow: %d", rightrow, leftrow);
	if( 1<= pagenumber <= 4)
	{
		new linetype; //type of the line (propertyfield, inputfield, radiobutton ...)
		new p; //creates several property fields if splitted (more is splitted into 4 more values and so p for more is 4)
		new k=0; //multiplier how many pixel right row is pushed to the right compared to the left row
		new n=0; //counts the line numbers per row, max is 14 lines
		new endline;
		if((rightrow == 0) && (leftrow != 0))
			endline = leftrow;
		else if((rightrow != 0) && (leftrow != 0))
			endline = rightrow;
		for(new i=startline; i<=endline; ++i)
		{
			if(i==(leftrow+1))//other row
			{
				k=254;
				n=0;
			}
			linetype = chr_twkarray[i][ct_linetype];
			
			switch(linetype)
			{
				case 0:
				{
					gui_addText(twkChrMenu,ct_tex+k,180+(n*20),33, chr_twkarray[i][ct_linename]);
				}
				case 1: //property field, eg itemname
				{
					gui_addGump(twkChrMenu,ct_gu+k,181+(n*20), 0x827);
					gui_addText(twkChrMenu,ct_tex+k,180+(n*20),1310, chr_twkarray[i][ct_linename]);
					if(chr_twkarray[i][ct_infotype] != 0) //its a splitted property (more is more1, more2, more3 ...)
					{
						for(p = 1; p<= chr_twkarray[i][ct_infotype]; p++)
						{
							gui_addPropField( twkChrMenu, ct_prop+k-30+p*30, (180+(n*20)),150,30, chr_twkarray[i][ct_propnumber]);
						}
					}
					else gui_addPropField( twkChrMenu, ct_prop+k, (180+(n*20)),150,30, chr_twkarray[i][ct_propnumber]);
				}
				case 2: //infofield, eg weight
				{
					gui_addText(twkChrMenu,ct_tex+k,180+(n*20),1310,chr_twkarray[i][ct_linename]);
					if(chr_twkarray[i][ct_propnumber]==0) //custom info function
					{
						if(chr_twkarray[i][ct_infotype]==1)
							sprintf( tempChrStr,"%d",tempfx_isActive( target,TFX_SPELL_REACTARMOR));
						else if(chr_twkarray[i][ct_infotype]==2)
							sprintf( tempChrStr,"%d",tempfx_isActive( target,TFX_SPELL_INCOGNITO));
						else if(chr_twkarray[i][ct_infotype]==3)
						       sprintf( tempChrStr,"%d",chr_getShield(target)); 
					}
					else if(chr_twkarray[i][ct_propval]==0) //is an integer information
					{
						sprintf( tempChrStr,"%d",chr_getProperty(target,chr_twkarray[i][ct_propnumber]));
					}
					gui_addText( twkChrMenu, ct_desc+k, 180+(n*20),0,tempChrStr);
					sprintf( tempChrStr,"");
				}
				case 3: //inputfield, eg Nightsight
				{
					if( chr_twkarray[i][ct_propnumber] == 1) //TFX function
					{
						if(tempfx_isActive( target,chr_twkarray[i][ct_infotype]) == 1)
							checklev = 1;
							sprintf(tempChrStr, "%s", chr_twkarray[i][ct_inputname]);
					}
					else if( chr_twkarray[i][ct_propnumber] == 2) //AMX LocalVars Int
					{
						new output = chr_getLocalIntVar(target, chr_twkarray[i][ct_infotype]);
						sprintf(tempChrStr, "%d",output);
					}
					else if( chr_twkarray[i][ct_propnumber] == 3) //AMX LocalVars Str
						chr_getLocalStrVar(target, chr_twkarray[i][ct_infotype], tempChrStr);
					gui_addGump(twkChrMenu,ct_gu+k, 181+(n*20), 0x827);
					gui_addText(twkChrMenu,ct_tex+k,180+(n*20),1310,chr_twkarray[i][ct_linename]);
					gui_addInputField( twkChrMenu,ct_prop+k,180+(n*20),50,20,i,1110,tempChrStr);
					gui_addCheckbox( twkChrMenu,ct_check+k-10,180+(n*20),oldpic,newpic,checklev,i);
					checklev=0;
				}
				case 4: //checkbox
				{
					if((chr_twkarray[i][ct_propnumber] == 134) || (chr_twkarray[i][ct_propnumber] == 121)) //CP_PRIV or CP_PRIV2 or ... (bitfields)
					{
						new privvalue = chr_twkarray[i][ct_infotype];
						if(privvalue >= 10)
							privvalue = (privvalue/10)*16;
						new originalval = chr_getProperty( target,chr_twkarray[i][ct_propnumber])&privvalue;
						if(originalval == privvalue) //for example is frozen
							checklev = 1;
					}
					else if(chr_twkarray[i][ct_propnumber] == 0) //customized button function, for example open bank box
					{
						if( chr_twkarray[i][ct_infotype] == 4)
						{
						       if( (chr_getProperty( target,CP_ID)) != (chr_getProperty(target,CP_XID))) //if(chr_getProperty( target,CP_POLYMORPH) == 1) //polymorphed
						              checklev = 1;
						}
					}
					else //on/off check only
					{
						if(chr_getProperty(target,chr_twkarray[i][ct_propnumber]) == 1)
							checklev = 1;
					}
					gui_addText(twkChrMenu,ct_tex+k,180+(n*20),1310,chr_twkarray[i][ct_linename]);
					gui_addCheckbox( twkChrMenu,ct_prop+k,181+(n*20),oldpic,newpic,checklev,i);
					checklev = 0;
				}
				case 5: //radiobutton
				{
					new u; //how many radiobuttons are part of this group?
					if( chr_twkarray[i][ct_propval] != 0) //first line of a radiobuttongroup
					{
						u=chr_twkarray[i][ct_propval]+1;
						gui_addGroup( twkChrMenu, u );
					}
					if(chr_twkarray[i][ct_propnumber] == 121) //bitfields (for example visibility)
					{
						new privvalue = chr_twkarray[i][ct_infotype];
						if(privvalue >= 10)
							privvalue = (privvalue/10)*16;
						new originalval = chr_getProperty( target,chr_twkarray[i][ct_propnumber])&privvalue;
						if(originalval == privvalue) //can decay
							checklev = 1;
					}
					else if (chr_twkarray[i][ct_propnumber] == 110)
					{
						if(chr_getProperty( target,chr_twkarray[i][ct_propnumber]) == chr_twkarray[i][ct_infotype])
							checklev = 1;
					}
					gui_addText(twkChrMenu,ct_tex+k,180+(n*20),1310, chr_twkarray[i][ct_linename]);
					gui_addRadioButton( twkChrMenu,ct_radio+k,(180+(n*20)), oldpic,newpic,checklev,i);
					checklev=0;
				}
				case 6: //splitted properties (more for example)
				{
					gui_addGump(twkChrMenu,ct_gu+k,181+(n*20), 0x827);
					gui_addText(twkChrMenu,ct_tex+k,180+(n*20),1310, chr_twkarray[i][ct_linename]);
					gui_addPropField( twkChrMenu, ct_prop+k, 180+(n*20),150,30, chr_twkarray[i][ct_propnumber], chr_twkarray[i][ct_infotype]);
				}
				case 7: //stock function call
				{
					new q = (chr_twkarray[i][ct_propnumber]); //type of stock function
					new output;
					if(q==0)
						output = chr_getSkillSum(target);
					else if(q==1)
						output = chr_countBankGold(target);
					else if(q==2)
					{
						if ( chr_getGuild(target) >= 0 )
							guild_getProperty( chr_getGuild(target),GP_STR_NAME,_,0,tempChrStr );
						else	tempChrStr="None";
					}
					else if(q==3)
					{
						if ( chr_getGuild(target) >= 0 )
							chr_getProperty(getGuildMaster(chr_getGuild(target)), CP_STR_NAME, _, tempChrStr);
						else	tempChrStr="None";
					}
					else if(q==4)
					{
						new age=chr_getProperty(target,CP_CREATIONDAY);
						if ( age > 0 )
						{
							new year=cal_getRealYear(age);
							new dayInYear=cal_getDayInYear(age);
							new month=cal_getRealMonth(dayInYear,year);
							new day=cal_getDayInMonth(dayInYear,year);
							sprintf(tempChrStr,"%d/%d/%d",day,month,year);
						}
						else	tempChrStr="----";
					}
					gui_addText(twkChrMenu,ct_tex+k,180+(n*20),1310,chr_twkarray[i][ct_linename]);
					if(chr_twkarray[i][ct_infotype] == 0) //integer value to display
						sprintf(tempChrStr, "%d", output);
					gui_addText( twkChrMenu, ct_desc+k, 180+(n*20),0,tempChrStr);
					tempChrStr=" ";
				}
				default: printf("unknown item-tweak case!");
			}//linetype
			n=n+1;
		}//for
	}//if pagenumber

	else if(pagenumber == 5)
	{
		gui_addPageButton(twkChrMenu,210,493,2224,2117,2);
		gui_addText(twkChrMenu,240,490,1310,"Events 2");
		gui_addPageButton(twkChrMenu,320,493,2224,2117,3);
		gui_addText(twkChrMenu,350,490,1310,"Events 3");
		
		gui_addText(twkChrMenu,50,150,1310,"Events 1");

		new i;
		for ( i=0;i <= 15;++i)
		{
			gui_addGump(twkChrMenu,50,173+(i*20), 0x827);
			gui_addText(twkChrMenu,66,170+(i*20),1310,eventChr_array[i][eventname]);
			chr_getEventHandler(target,eventChr_array[i][eventnum],tempChrStr);
			gui_addInputField( twkChrMenu,220,170+(i*20),150,20,i+1,0,tempChrStr);
			gui_addCheckbox( twkChrMenu, 200, 173+(i*20), oldpic, newpic, 1, i+1 );
		}
		
		gui_addPage(twkChrMenu,2);
		gui_addPageButton(twkChrMenu,100,493,2224,2117,1);
		gui_addText(twkChrMenu,130,490,1310,"Events 1");
		gui_addPageButton(twkChrMenu,320,493,2224,2117,3);
		gui_addText(twkChrMenu,350,490,1310,"Events 3");
		
		gui_addButton(twkChrMenu,35,51,twkButton[arrayline][new1],twkButton[arrayline][old1],1);
		gui_addText(twkChrMenu,60,49,33,"Main infos");
		gui_addButton(twkChrMenu,170,51,twkButton[arrayline][new2],twkButton[arrayline][old2],2);
		gui_addText(twkChrMenu,195,49,33,"Flags1");
		gui_addButton(twkChrMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
		gui_addText(twkChrMenu,285,49,33,"Flags2");
		gui_addButton(twkChrMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
		gui_addText(twkChrMenu,380,49,33,"Flags3");
		gui_addButton(twkChrMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
		gui_addText(twkChrMenu,470,49,33,"Events");
		gui_addButton(twkChrMenu,35,81,twkButton[arrayline][new6],twkButton[arrayline][old6],6);
		gui_addText(twkChrMenu,60,79,33,"LocalVars");
		gui_addButton(twkChrMenu,170,81,twkButton[arrayline][new7],twkButton[arrayline][old7],7);
		gui_addText(twkChrMenu,195,79,33,"Skills");
		gui_addButton(twkChrMenu,260,81,twkButton[arrayline][new8],twkButton[arrayline][old8],8);
		gui_addText(twkChrMenu,285,79,33,"Layer");
		
		gui_addText(twkChrMenu,66,120,33,"Account number :");
		sprintf( tempChrStr,"%d",chr_getProperty(target,CP_ACCOUNT));
		gui_addText( twkChrMenu, 185, 120,0,tempChrStr);
		
		gui_addText(twkChrMenu,280,120,33,"Serial :");
		sprintf( tempChrStr,"%d",chr_getProperty(target,CP_SERIAL));
		gui_addText( twkChrMenu, 336, 120,0,tempChrStr);
		
		gui_addGump(twkChrMenu,430,121, 0x827);
		gui_addText(twkChrMenu,451,120,33,"NPC-AI:");
		gui_addPropField( twkChrMenu,515,120,50,30,CP_NPCAI);
		
		gui_addText(twkChrMenu,50,150,1310,"Events 2");

		for ( i=16;i <= 31;++i)
		{
			gui_addGump(twkChrMenu,50,173+((i-16)*20), 0x827);
			gui_addText(twkChrMenu,66,170+((i-16)*20),1310,eventChr_array[i][eventname]);
			chr_getEventHandler(target,eventChr_array[i][eventnum],tempChrStr);
			gui_addInputField( twkChrMenu,220,170+((i-16)*20),150,20,i+1,0,tempChrStr);
			gui_addCheckbox( twkChrMenu, 200, 173+((i-16)*20), oldpic, newpic, 1, i+1 );
		}
		
		gui_addPage(twkChrMenu,3);
		gui_addPageButton(twkChrMenu,100,493,2224,2117,1);
		gui_addText(twkChrMenu,130,490,1310,"Events 1");
		gui_addPageButton(twkChrMenu,210,493,2224,2117,2);
		gui_addText(twkChrMenu,240,490,1310,"Events 2");
		
		gui_addButton(twkChrMenu,35,51,twkButton[arrayline][new1],twkButton[arrayline][old1],1);
		gui_addText(twkChrMenu,60,49,33,"Main infos");
		gui_addButton(twkChrMenu,170,51,twkButton[arrayline][new2],twkButton[arrayline][old2],2);
		gui_addText(twkChrMenu,195,49,33,"Flags1");
		gui_addButton(twkChrMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
		gui_addText(twkChrMenu,285,49,33,"Flags2");
		gui_addButton(twkChrMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
		gui_addText(twkChrMenu,380,49,33,"Flags3");
		gui_addButton(twkChrMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
		gui_addText(twkChrMenu,470,49,33,"Events");
		gui_addButton(twkChrMenu,35,81,twkButton[arrayline][new6],twkButton[arrayline][old6],6);
		gui_addText(twkChrMenu,60,79,33,"LocalVars");
		gui_addButton(twkChrMenu,170,81,twkButton[arrayline][new7],twkButton[arrayline][old7],7);
		gui_addText(twkChrMenu,195,79,33,"Skills");
		gui_addButton(twkChrMenu,260,81,twkButton[arrayline][new8],twkButton[arrayline][old8],8);
		gui_addText(twkChrMenu,285,79,33,"Layer");
		
		gui_addText(twkChrMenu,66,120,33,"Account number :");
		sprintf( tempChrStr,"%d",chr_getProperty(target,CP_ACCOUNT));
		gui_addText( twkChrMenu, 185, 120,0,tempChrStr);
		
		gui_addText(twkChrMenu,280,120,33,"Serial :");
		sprintf( tempChrStr,"%d",chr_getProperty(target,CP_SERIAL));
		gui_addText( twkChrMenu, 336, 120,0,tempChrStr);
		
		gui_addGump(twkChrMenu,430,121, 0x827);
		gui_addText(twkChrMenu,451,120,33,"NPC-AI:");
		gui_addPropField( twkChrMenu,515,120,50,30,CP_NPCAI);
		
		gui_addText(twkChrMenu,50,150,1310,"Events 3");

		for ( i=32;i <= 37;++i)
		{
			gui_addGump(twkChrMenu,50,173+((i-32)*20), 0x827);
			gui_addText(twkChrMenu,66,170+((i-32)*20),1310,eventChr_array[i][eventname]);
			gui_addCheckbox( twkChrMenu, 200, 173+((i-32)*20), oldpic, newpic, 1, i+1 );
			chr_getEventHandler(target,eventChr_array[i][eventnum],tempChrStr);
			gui_addInputField( twkChrMenu,220,170+((i-32)*20),150,20,i+1,0,tempChrStr);
		}
		//printf("test gui, twkChrMenu: %d^n", twkChrMenu);
	}
	
	else if(pagenumber ==7)
	{
		gui_addText(twkChrMenu,100,150,33,"Miscellaneous");
		new miscSkills[21]={ SK_ALCHEMY,SK_BLACKSMITHING,SK_BOWCRAFT,SK_CARPENTRY,SK_COOKING,SK_FISHING,SK_HEALING,SK_HERDING,SK_LOCKPICKING,SK_LUMBERJACKING,SK_MAGERY,SK_MEDITATION,SK_MINING,SK_MUSICIANSHIP,SK_REMOVETRAPS,	SK_MAGICRESISTANCE,SK_SNOOPING,SK_STEALING,SK_TAILORING,SK_TINKERING,SK_VETERINARY};
		for ( new i=0;i<13;++i)
		{
			gui_addGump(twkChrMenu,50,171+20*i, 0x827);
			gui_addText( twkChrMenu,66,170+20*i,1310,"%s : ",skillName[ miscSkills[i] ] );
			gui_addPropField( twkChrMenu,190,170+20*i,50,30,CP_BASESKILL,miscSkills[i],0 );
		}
		for ( new i=13;i<21;++i)
		{

			gui_addGump(twkChrMenu,321,171+20*(i-13), 0x827);
			gui_addText( twkChrMenu,335,170+20*(i-13),1310,"%s : ",skillName[ miscSkills[i] ] );
			gui_addPropField( twkChrMenu,470,170+20*(i-13),50,30,CP_BASESKILL,miscSkills[i],0 );
		}
		
		gui_addText(twkChrMenu,130,490,1310,"Skill Page 2 (Combat Ratings,Actions,Lore Knowledge)");
		gui_addPageButton(twkChrMenu,100,493,2224,2117,2);
		
		gui_addPage(twkChrMenu,2);
		gui_addPageButton(twkChrMenu,100,493,2224,2117,1);
		gui_addText(twkChrMenu,130,490,1310,"Skill Page 1 (Miscellaneous)");
		
		gui_addButton(twkChrMenu,35,51,twkButton[arrayline][new1],twkButton[arrayline][old1],1);
		gui_addText(twkChrMenu,60,49,33,"Main infos");
		gui_addButton(twkChrMenu,170,51,twkButton[arrayline][new2],twkButton[arrayline][old2],2);
		gui_addText(twkChrMenu,195,49,33,"Flags1");
		gui_addButton(twkChrMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
		gui_addText(twkChrMenu,285,49,33,"Flags2");
		gui_addButton(twkChrMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
		gui_addText(twkChrMenu,380,49,33,"Flags3");
		gui_addButton(twkChrMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
		gui_addText(twkChrMenu,470,49,33,"Events");
		gui_addButton(twkChrMenu,35,81,twkButton[arrayline][new6],twkButton[arrayline][old6],6);
		gui_addText(twkChrMenu,60,79,33,"LocalVars");
		gui_addButton(twkChrMenu,170,81,twkButton[arrayline][new7],twkButton[arrayline][old7],7);
		gui_addText(twkChrMenu,195,79,33,"Skills");
	
		gui_addButton(twkChrMenu,260,81,twkButton[arrayline][new8],twkButton[arrayline][old8],8);
		gui_addText(twkChrMenu,285,79,33,"Layer");
		
		gui_addText(twkChrMenu,66,120,33,"Account number :");
		sprintf( tempChrStr,"%d",chr_getProperty(target,CP_ACCOUNT));
		gui_addText( twkChrMenu, 185, 120,0,tempChrStr);
		
		gui_addText(twkChrMenu,280,120,33,"Serial :");
		sprintf( tempChrStr,"%d",chr_getProperty(target,CP_SERIAL));
		gui_addText( twkChrMenu, 336, 120,0,tempChrStr);
		
		gui_addGump(twkChrMenu,430,121, 0x827);
		gui_addText(twkChrMenu,451,120,33,"NPC-AI:");
		gui_addPropField( twkChrMenu,515,120,50,30,CP_NPCAI);
		
		gui_addText(twkChrMenu,100,150,33,"Combat Ratings");

		new combatSkills[8]={ SK_ARCHERY,SK_FENCING,SK_MACEFIGHTING,SK_PARRYING,SK_SWORDSMANSHIP,SK_TACTICS,SK_WRESTLING};
		for ( new i=0;i<8;++i)
		{
			gui_addGump(twkChrMenu,50,171+20*i, 0x827);
			gui_addText( twkChrMenu,66,170+20*i,1310,"%s : ",skillName[ combatSkills[i] ] );
			gui_addPropField( twkChrMenu,190,170+20*i,50,30,CP_BASESKILL,combatSkills[i],0 );
		}
		gui_addText(twkChrMenu,100,335,33,"Actions");
		new actionSkills[13]={ SK_TAMING,SK_BEGGING,SK_CAMPING,SK_CARTOGRAPHY,SK_DETECTINGHIDDEN,SK_ENTICEMENT,	SK_HIDING,SK_INSCRIPTION,SK_PEACEMAKING,SK_POISONING,SK_PROVOCATION,SK_SPIRITSPEAK,SK_TRACKING};
		for ( new i=0;i<7;++i)
		{
			gui_addGump(twkChrMenu,50,351+20*i, 0x827);
			gui_addText( twkChrMenu,66,350+20*i,1310,"%s : ",skillName[ actionSkills[i] ] );
			gui_addPropField( twkChrMenu,190,350+20*i,50,30,CP_BASESKILL,actionSkills[i],0 );
		}
		for ( new i=7;i<13;++i)
		{
			gui_addGump(twkChrMenu,321,171+20*(i-7), 0x827);
			gui_addText( twkChrMenu,335,170+20*(i-7),1310,"%s : ",skillName[ actionSkills[i] ] );
			gui_addPropField( twkChrMenu,470,170+20*(i-7),50,30,CP_BASESKILL,actionSkills[i],0 );
		}
		gui_addText(twkChrMenu,361,300,33,"Lore & Knowledge");
		new loreSkills[7]={ SK_ANATOMY,SK_ANIMALLORE,SK_ARMSLORE,SK_EVALUATINGINTEL,SK_FORENSICS,SK_ITEMID,SK_TASTEID};
		for ( new i=0;i<7;++i)
		{
			gui_addGump(twkChrMenu,321,321+20*i, 0x827);
			gui_addText( twkChrMenu,335,320+20*i,1310,"%s : ",skillName[ loreSkills[i] ] );
			gui_addPropField( twkChrMenu,470,320+20*i,50,30,CP_BASESKILL,loreSkills[i],0 );
		}
		//printf("test gui, twkChrMenu: %d^n", twkChrMenu);
	}
	else if(pagenumber == 8)
	{
		gui_addText(twkChrMenu,50,150,1110,"Layer");
				
		new layer;
		new r=20;
		new s;
		new t;
		new u;
		new itemSet=set_create();
		set_addItemWeared(itemSet,target,false,true,true);
		sprintf(tempChrStr, "");
		
		for (set_rewind(itemSet);!set_end(itemSet);)
		{
			new item = set_get(itemSet);
			new itemName[30];
			itm_getProperty(item,IP_STR_NAME,_,itemName);
			layer= itm_getProperty(item,IP_LAYER);
			ct_layerprop[layer-1][lt_used] = 1; //this layer is used
			if ( layer <= 24) //number of layer should only show equipplayer, not bankbox or others
			{
				if ( layer <= 12 )
				{
					s=0;
					t=274;
					u=10;
				}
				else
				{
					s=12;
					t=0;
					u=50;
				}
			}
			gui_addTilePic(twkChrMenu,(layer-s)*(r+2)*2, 170+u,itm_getProperty(item,IP_ID));
			sprintf(tempChrStr, "%s", itemName);
			gui_addCheckbox(twkChrMenu,307-t,253+(layer-s)*r, oldpic, newpic, 1, layer);
			gui_addText(twkChrMenu,330-t,250+(layer-s)*r,0,ct_layerprop[layer-1][lt_name]);
			gui_addText(twkChrMenu,410-t,250+(layer-s)*r,1310,tempChrStr);
			sprintf(tempChrStr, "");
		}
		set_delete(itemSet);
		for ( layer=1;layer <= 24;layer++) //now draw lines for unused layer
		{
			if ( ct_layerprop[layer-1][lt_used] == 0 )
			{
				if ( layer <= 12 )
				{
					s=0;
					t=274;
				}
				else
				{
					s=12;
					t=0;
				}
				sprintf(tempChrStr, "Nothing");
				gui_addText(twkChrMenu,330-t,250+(layer-s)*r,0,ct_layerprop[layer-1][lt_name]);
				gui_addText(twkChrMenu,410-t,250+(layer-s)*r,1310,tempChrStr);
				sprintf(tempChrStr, " ");
			}
		}
	}//pagenumber
	else if(pagenumber == 6)
	{
		gui_addText(twkChrMenu,230,150,33,"LocalVars 1");
		
		new count=0;
		new LocalV[512];
		new dividerrest=0;
		new divider;
		new num;
		new subpages=33; //subpages-lines we already have
		
		gui_addText( twkChrMenu, 40, 500, 33, "Add LocalVar:");
		gui_addText(twkChrMenu,150,500,0,"Str:");
		gui_addRadioButton( twkChrMenu,190,503, oldpic,newpic,0,100);
		gui_addText(twkChrMenu,215,500,0,"Int:");
		gui_addRadioButton( twkChrMenu,255,503, oldpic,newpic,0,101);
		gui_addText(twkChrMenu,280,500,0,"None:");
		gui_addRadioButton( twkChrMenu,320,503, oldpic,newpic,1,102);
		gui_addInputField( twkChrMenu, 370, 500, 40, 20, 5, 1310, "(No.)");
		gui_addInputField( twkChrMenu, 420, 500, 100, 20, 6, 1310, "(Value)");	

		for (num=1000;num<5000;num++)
		{
			if(chr_isaLocalVar(target, num, VAR_TYPE_ANY))
			{
				count++; //count the real existing local vars we have
				divider = count/32; //one page allows 32 local vars, how many pages do we need?
				dividerrest = count%32; //divide the number of existing local vars with modulo %, how much is left after having put all into full 32rds = how many left after doing full pages
				//printf("found localVar, count: %d, divider: %d, dividerrest %d^n", count, divider, dividerrest);
		
				new subpagecount = subpages/32; //we reach a divider >= 1, so we add one page button and one page, make sure to add only ONE page/button per increased divider ...!
				if( ((divider==1)&&(dividerrest!=0)) || (divider>=2))
				{
					subpages++;
					//printf("subpagecount: %d, divider: %d, subpages: %d, dividerrest: %d^n", subpagecount, divider, subpages, dividerrest);
					if(dividerrest==1) //next page necessary
					{
						gui_addPageButton(twkChrMenu,310,523,2224,2224,(subpagecount+1)); //next page button at previous pages
						sprintf(tempChrStr, "next page (%d)", (subpagecount+1))
						gui_addText(twkChrMenu,330,520,1310,tempChrStr);
												
						//printf("make new page^n");
						gui_addPage(twkChrMenu,(subpagecount+1));
						
						//add pagebuttons to real dynamic pages that do not create additional pages
						gui_addText(twkChrMenu, 60,520,1310,"page 1"); //first page button
						gui_addPageButton(twkChrMenu, 40,523,2224,2224,1);
						
						if(subpagecount>=2)
						{
							gui_addPageButton(twkChrMenu,170,523,2223,2223,subpagecount); //previous page button at new page
							sprintf(tempChrStr, "previous page (%d)", subpagecount)
							gui_addText(twkChrMenu,190,520,1310,tempChrStr);
						}
											
						gui_addButton(twkChrMenu,35,51,twkButton[arrayline][new1],twkButton[arrayline][old1],1);
						gui_addText(twkChrMenu,60,49,33,"Main infos");
						gui_addButton(twkChrMenu,170,51,twkButton[arrayline][new2],twkButton[arrayline][old2],2);
						gui_addText(twkChrMenu,195,49,33,"Flags1");
						gui_addButton(twkChrMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
						gui_addText(twkChrMenu,285,49,33,"Flags2");
						gui_addButton(twkChrMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
						gui_addText(twkChrMenu,380,49,33,"Flags3");
						gui_addButton(twkChrMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
						gui_addText(twkChrMenu,470,49,33,"Events");
						gui_addButton(twkChrMenu,35,81,twkButton[arrayline][new6],twkButton[arrayline][old6],6);
						gui_addText(twkChrMenu,60,79,33,"LocalVars");
						gui_addButton(twkChrMenu,170,81,twkButton[arrayline][new7],twkButton[arrayline][old7],7);
						gui_addText(twkChrMenu,195,79,33,"Skills");
						gui_addButton(twkChrMenu,260,81,twkButton[arrayline][new8],twkButton[arrayline][old8],8);
						gui_addText(twkChrMenu,285,79,33,"Layer");
				
						gui_addText(twkChrMenu,66,120,33,"Account number :");
						sprintf( tempChrStr,"%d",chr_getProperty(target,CP_ACCOUNT));
						gui_addText( twkChrMenu, 185, 120,0,tempChrStr);
						
						gui_addText(twkChrMenu,280,120,33,"Serial :");
						sprintf( tempChrStr,"%d",chr_getProperty(target,CP_SERIAL));
						gui_addText( twkChrMenu, 336, 120,0,tempChrStr);
						
						gui_addGump(twkChrMenu,430,121, 0x827);
						gui_addText(twkChrMenu,451,120,33,"NPC-AI:");
						gui_addPropField( twkChrMenu,515,120,50,30,CP_NPCAI);
						
						sprintf( tempChrStr,"LocalVars %d",(subpagecount+1));
						gui_addText(twkChrMenu,230,150,33,tempChrStr);
						
						if (chr_isaLocalVar(target, num, VAR_TYPE_INTEGER))
						{
							sprintf(LocalV, "%d", chr_getLocalIntVar(target,num));
							sprintf(tempChrStr, "Int %d" , num);
						}
						else
						{
							chr_getLocalStrVar(target, num, LocalV);
							sprintf(tempChrStr, "Str %d" , num);
						}
						gui_addGump(twkChrMenu,39,180, 0x827);
						gui_addText( twkChrMenu, 60, 180, 1310, tempChrStr);
						gui_addInputField( twkChrMenu, 140, 180, 125, 30, num, 0, LocalV);
						gui_addCheckbox( twkChrMenu, 250, 180, oldpic, newpic, 1, num );
					}
					else
					{
						if( (dividerrest<=16) && (dividerrest != 0))
						{
							//printf("dividerrest < 16, enter sub page content, count: %d^n", count);
							if (chr_isaLocalVar(target, num, VAR_TYPE_INTEGER))
							{
								sprintf(LocalV, "%d", chr_getLocalIntVar(target,num));
								sprintf(tempChrStr, "Int %d" , num);
							}
							else
							{
								chr_getLocalStrVar(target, num, LocalV);
								sprintf(tempChrStr, "Str %d" , num);
							}
							gui_addGump(twkChrMenu,39, 160+(20*(count+1-divider*33)), 0x827);
							gui_addText( twkChrMenu, 60, 160+(20*(count+1-divider*33)), 1310, tempChrStr);
							gui_addInputField( twkChrMenu, 140, 160+(20*(count+1-divider*33)), 125, 30, num, 0, LocalV);
							gui_addCheckbox( twkChrMenu, 250, 160+(20*(count+1-divider*33)), oldpic, newpic, 1, num );
						}
						else
						{
							if (chr_isaLocalVar(target, num, VAR_TYPE_INTEGER))
							{
								sprintf(LocalV, "%d", chr_getLocalIntVar(target,num));
								sprintf(tempChrStr, "Int %d" , num);
							}
							else
							{
								chr_getLocalStrVar(target, num, LocalV);
								sprintf(tempChrStr, "Str %d" , num);
							}
							if(dividerrest == 0)
								divider=divider-1;
							gui_addGump(twkChrMenu,299,160+(20*((count+1-divider*33)-16)), 0x827);
							gui_addText( twkChrMenu, 320, 160+(20*((count+1-divider*33)-16)), 1310, tempChrStr);
							gui_addInputField( twkChrMenu, 400, 160+(20*((count+1-divider*33)-16)), 125, 30, num, 0, LocalV);
							gui_addCheckbox( twkChrMenu, 510, 160+(20*((count+1-divider*33)-16)), oldpic, newpic, 1, num );
						}				
					}//for
				}//if subaccount
				else //first page == almost static (no subpage)
				{
					if(1<=dividerrest<=16)
					{
						//printf("dividerrest < 16, enter first page content, count: %d^n", count);
						if (chr_isaLocalVar(target, num, VAR_TYPE_INTEGER))
						{
							sprintf(LocalV, "%d", chr_getLocalIntVar(target,num));
							sprintf(tempChrStr, "Int %d" , num);
						}
						else if(chr_isaLocalVar(target, num, VAR_TYPE_STRING))
						{
							chr_getLocalStrVar(target, num, LocalV);
							sprintf(tempChrStr, "Str %d" , num);
						}
						gui_addGump(twkChrMenu,39, 160+(20*count), 0x827);
						gui_addText( twkChrMenu, 60, 160+(20*count), 1310, tempChrStr);
						gui_addInputField( twkChrMenu, 140, 160+(20*count), 125, 30, num, 0, LocalV);
						gui_addCheckbox( twkChrMenu, 250, 160+(20*count), oldpic, newpic, 1, num );
					}
					else
					{
						//printf("dividerrest > 16, enter first page content, count: %d^n", count);
						if (chr_isaLocalVar(target, num, VAR_TYPE_INTEGER))
						{
							sprintf(LocalV, "%d", chr_getLocalIntVar(target,num));
							sprintf(tempChrStr, "Int %d" , num);
						}
						else if(chr_isaLocalVar(target, num, VAR_TYPE_STRING))
						{
							chr_getLocalStrVar(target, num, LocalV);
							sprintf(tempChrStr, "Str %d" , num);
						}
						gui_addGump(twkChrMenu,299,160+(20*(count-16)), 0x827);
						gui_addText( twkChrMenu, 320, 160+(20*(count-16)), 1310, tempChrStr);
						gui_addInputField( twkChrMenu, 400, 160+(20*(count-16)), 125, 30, num, 0, LocalV);
						gui_addCheckbox( twkChrMenu, 510, 160+(20*(count-16)), oldpic, newpic, 1, num );
					}
				}//if
			}//if
		}//for
		//printf("dividerrest: %d, count: %d", dividerrest, count);
	}
	gui_show(twkChrMenu,chrsource); 
}

public tweakchrBck(const twkChrMenu, const chrsource, const buttonCode)
{
	new target = gui_getProperty( twkChrMenu,MP_BUFFER,1 );
	new pagenumber = gui_getProperty( twkChrMenu,MP_BUFFER,4 );
	new startline;
	new leftrow;
	new rightrow;
	new tempChrStr[50];
	
	if( pagenumber == 1)
	{
		startline = 0;
		leftrow = ct_pg1_l;
		rightrow = ct_pg1_r;
	}
	else if( pagenumber == 2)
	{
		startline = ct_pg1_r+1;
		leftrow = ct_pg2_l;
		rightrow = ct_pg2_r;
	}
	else if( pagenumber == 3)
	{
		startline = ct_pg2_r+1;
		leftrow = ct_pg3_l;
		rightrow = ct_pg3_r;
	}
	else if( pagenumber == 4)
	{
		startline = ct_pg2_r+1;
		leftrow = ct_pg4_l;
		rightrow = ct_pg4_r;
	}
	new endline;
	new i=0;
	//performance saver, only go through the array lines shown at the page with apply button
	if((rightrow == 0) && (leftrow != 0))
		endline = leftrow;
	else if((rightrow != 0) && (leftrow != 0))
		endline = rightrow;
	new checklev;
	new checked;
	
	switch(buttonCode)
	{
		case 1..8: 	
		{	
			tweak_char(chrsource, target, buttonCode);
			//gui_delete( twkChrMenu );
		}
		case 10:
		{
			if(0 < pagenumber < 5)
		        {
		        	for(i=startline; i<=endline; ++i)
		        	{
		        		checked=0;
		        		new linetype = chr_twkarray[i][ct_linetype];
		        		new propnumber = chr_twkarray[i][ct_propnumber];
		        		new type=chr_twkarray[i][ct_propnumber];
		        		checklev = 0;
		        		if(linetype == 3) //input line
		        		{
		        			new textbuf_input[15];
		        			new textbuf_origin[15];
		        			new value=0;
		        			checked = gui_getProperty(twkChrMenu,MP_CHECK,i);
		        			gui_getProperty(twkChrMenu,MP_UNI_TEXT,i,textbuf_input);
		        			if( type== 1) //TFX function
		        			{
		        				sprintf(textbuf_origin, "%s", chr_twkarray[i][ct_inputname]);
		        			}
		        			else if( type == 2) //AMX LocalVars Int
						{
							new origin = chr_getLocalIntVar(target, chr_twkarray[i][ct_infotype]);
							sprintf(textbuf_origin, "%d",origin);
						}
						else if( type == 3) //AMX LocalVars Str
						{
							chr_getLocalStrVar(target, chr_twkarray[i][ct_infotype], textbuf_origin);
						}
						if( strcmp( textbuf_input,textbuf_origin) && (checked==1)) //its checked so go on to get the entry if input different from origin
		        			{
		        				printf("different input, type 3, line %d^n", i);
		        				trim(textbuf_input);
		        				if ((isStrUnsignedInt(textbuf_input)) && (type != 3)) //should be an integer, is it?
		        				{
		        					value = str2UnsignedInt(textbuf_input);
		        					if( type == 1) //TFX function
		        					{
		        						if ( tempfx_isActive( target,chr_twkarray[i][ct_infotype]) != 1 ) // no tempfx already
		        						{
		        							tempfx_activate( chr_twkarray[i][ct_infotype],target,target,0,value,-1); //activates tempfx
		        						}
			        				}
			        				else if( type == 2)
			        				{
			        					chr_setLocalIntVar(target, chr_twkarray[i][ct_infotype], value);
			        				}
			        			}
			        			else if(type == 3)
			        			{
			        				chr_setLocalStrVar(target, chr_twkarray[i][ct_infotype], textbuf_input);
			        			}
			        			else chr_message( chrsource, _,"A number must be inserted!");
			        		}
			        		else if( (type == 1) && (tempfx_isActive( target,chr_twkarray[i][ct_infotype]) == 1) && (checked != 1) ) // is tempfx line and this tempfx is active yet but no Entry made and not checked -> remove the tempfx
			        		{
			        			tempfx_delete( target,chr_twkarray[i][ct_infotype],true); //no more tempfx
			        		}	        						
			        	}//linetype
			        	else if(linetype == 4) //checkbox
		        		{
		        			checked = gui_getProperty(twkChrMenu,MP_CHECK,i); //is it checked?
		        			if((propnumber == 134) || (propnumber == 121)) //CP_PRIV or CP_PRIV2 or ... (bitfields)
						{
							new privvalue = chr_twkarray[i][ct_infotype];
							new originalvalue = chr_getProperty( target,propnumber)&privvalue;
							if(privvalue >= 10)
								privvalue = (privvalue/10)*16;
							if( originalvalue == privvalue) //is already set
								checklev = 1;
							if( (checklev == 1) && (checked !=1) ) //is at TRUE and no longer checked
								chr_setProperty( target,propnumber, _, chr_getProperty( target,propnumber) &~ privvalue );
							else if( (checklev != 1) && (checked == 1)) //is false and checked now
								chr_setProperty( target,propnumber, _, chr_getProperty( target,propnumber) | privvalue );
						}
						else if(propnumber == 0) //customized button function, for example open bank box
						{
							new infotype = chr_twkarray[i][ct_infotype];
							new bank;
							if( (infotype == 1) && (checked == 1)) //bank box opening
							{
								bank = chr_getBankBox(target, BANKBOX_NORMAL);
								itm_showContainer(bank,chrsource);
							}
							else if((infotype == 2) && (checked == 1)) //gold bank opening
								itm_showContainer( chr_getBankBox(target, BANKBOX_GOLDONLY),chrsource);
							else if( (infotype == 3) && (checked == 1)) //go to guild stone
							{
								new x = itm_getProperty(chr_getGuild(target), IP_POSITION, IP2_X);
								new y = itm_getProperty(chr_getGuild(target), IP_POSITION, IP2_Y);
								new z = itm_getProperty(chr_getGuild(target), IP_POSITION, IP2_Z);
								chr_moveTo( chrsource, x, y, z);
							}
							else if( infotype == 4) //polymorp/unmorph
								if (!((checked == 1))&& (chr_getProperty( target,CP_ID)) != (chr_getProperty(target,CP_XID))) //not checked and is morphed, if(chr_getProperty( target,CP_POLYMORPH) == 1) //polymorphed
		        						chr_unmorph(target);
		        					else if(((checked == 1))&& (chr_getProperty( target,CP_ID)) == (chr_getProperty(target,CP_XID))) //is checked and not morphed
		        						callPolyMenu(chrsource, target,1); //polymorph
						}
						else //on/off check only
						{
							checklev = chr_getProperty(target,propnumber); //status of property
							if((checklev == 0) && ( (checked == 1))) //is checked and was zero
								chr_setProperty( target, (propnumber),_, 1);
							else if((checklev != 0) && (!(checked == 1))) //is not checked and was not zero
								chr_setProperty( target,(propnumber) ,_, 1);
						}
		        		}
		        		else if(linetype == 5) //radiobutton
		        		{
		        			checked = gui_getProperty(twkChrMenu,MP_RADIO,i);
		        			new privvalue = chr_twkarray[i][ct_propval];
		        			if(propnumber == 121) //bitfields (for example visibility)
						{
							new originalvalue = chr_getProperty( target,propnumber)&privvalue;
							if(privvalue >= 10)
								privvalue = (privvalue/10)*16;
							if( originalvalue == privvalue) //is already set
								checklev = 1;
							if( (checklev == 1) && (checked !=1) ) //is at TRUE and no longer checked
								chr_setProperty( target,propnumber, _, chr_getProperty( target,propnumber) &~ privvalue );
							else if( (checklev != 1) && (checked == 1)) //is false and checked now
								chr_setProperty( target,propnumber, _, chr_getProperty( target,propnumber) | privvalue );
							if((privvalue == 8)&& (checked == 1)) //perma invis flag needs additionally a hide property
								chr_setProperty( target,110, _, 2);
						}
						else if(propnumber == 110)//visibility
						{
							new originalvalue = chr_getProperty( target,propnumber);
							if( (checked == 1) && (originalvalue != privvalue)) //is false and checked now
							{
								chr_setProperty( target,propnumber, _, privvalue);
								chr_setProperty( target,121, _, chr_getProperty( target,121) | 8 ); //just to be carefull, perma invis is now set to false
							}
						}
		        		}//linetype
					else if(linetype == 7) //stock function call
					{
						//new q = (propnumber); //type of stock function
						//new output;
						//printf("needed callback: %d, line is %s^n", i, chr_twkarray[i][ct_linename]);
					}
		        	}//for
		        }
		        else if(pagenumber == 5) //events
		        {
		        	new callname[15];
		        	new oldevent[15];
		        	checked = gui_getProperty(twkChrMenu,MP_CHECK,i+1);
		        	for(i=0;i<NUM_chrevent;i++)
		        	{
		        		if ( checked != 1) // no more checked and event had existed
		        		{
		        			//printf("del event");
		        			chr_delEventHandler(target, eventChr_array[i][eventnum]);
		        		}
		        		else
		        		{
		        			gui_getProperty(twkChrMenu,MP_UNI_TEXT,i+1,callname);
		        			trim(callname);
		        			chr_getEventHandler(target,eventChr_array[i][eventnum],oldevent);
		        			if( strcmp( callname, oldevent) ) //different input happened
		        				chr_setEventHandler(target, eventChr_array[i][eventnum], EVENTTYPE_STATIC, callname);
		        		}
		        		sprintf(callname, "");
		        	}//for
		        }
		        else if(pagenumber == 6) //localVars
		        {
		        	checked = gui_getProperty(twkChrMenu,MP_CHECK,i);
		        	for(i=1000;i<5000;i++)
		        	{
		        		if (chr_isaLocalVar(target, i, VAR_TYPE_ANY))
		        		{
		        			if(checked != 1)
		        			{
		        				chr_delLocalVar(target, i)
		        			}
		        			else if(chr_isaLocalVar(target, i, VAR_TYPE_INTEGER))
		        			{
		        				gui_getProperty(twkChrMenu,MP_UNI_TEXT,i,tempChrStr);
		        				trim(tempChrStr);
		        				if (isStrUnsignedInt(tempChrStr) || strcmp( !tempChrStr, "0" ))
		        				{
		        					new value = str2UnsignedInt(tempChrStr);
		        					if(chr_getLocalIntVar(target,i)!=value)
		        						chr_setLocalIntVar(target, i, value);
		        				}
		        				else
		        					chr_message(target, _, "An integer localVar value may only contain numbers with 0-9!");
		        			}
		        			else if(chr_isaLocalVar(target, i, VAR_TYPE_STRING))
		        			{
		        				new value[256];
		        				gui_getProperty(twkChrMenu,MP_UNI_TEXT,i,tempChrStr);
		        				chr_getLocalStrVar(target,i, value);
		        				if( strcmp( value, tempChrStr )) //is different
		        					chr_setLocalStrVar(target, i, tempChrStr);
		        			}//if var test
		        		}//if
		        	}//for
		        	if(gui_getProperty(twkChrMenu,MP_RADIO,101)) //integer var adding
		        	{
		        		new tempChrStrB[15];
		        		new inpt[15];
		        		gui_getProperty(twkChrMenu,MP_UNI_TEXT,5,tempChrStrB); //number
		        		trim(tempChrStrB);
		        		if(isStrUnsignedInt(tempChrStrB)) //is numeric
		        		{
		        			new number = str2UnsignedInt(tempChrStrB);
		        			//printf("tempChrStrB: %s, number: %d^n", tempChrStrB, number);
		        			if(!(chr_isaLocalVar(target, number, VAR_TYPE_ANY))) //already exist
		        			{
		        				gui_getProperty(twkChrMenu,MP_UNI_TEXT,6,inpt); //value
		        				trim(inpt);
		        				//printf("value: %s^n", inpt);
		        				if ( (isStrUnsignedInt(inpt)) || strcmp( !inpt, "0" )) //value is numeric
		        				{
		        					new value = str2UnsignedInt(inpt);
		        					chr_addLocalIntVar(target, number);
		        					chr_setLocalIntVar(target, number, value);
		        				}
		        				else
		        					chr_message(target, _, "An integer localVar value may only contain numbers with 0-9!");
		        			}
		        			else
		        				chr_message(target, _, "This char has already a localVar with this value!");
		        		}
		        		else
		        			chr_message(target, _, "The localVar number must consist of 0-9, no letters or other signs!");
		        	}
		        	else if(gui_getProperty(twkChrMenu,MP_RADIO,100)) //string localvar
		        	{
		        		new tempChrStrB[15];
		        		new inpt[15];
		        		gui_getProperty(twkChrMenu,MP_UNI_TEXT,5,tempChrStrB); //number
		        		trim(tempChrStrB);
		        		if(isStrUnsignedInt(tempChrStrB)) //is numeric
		        		{
		        			new number = str2UnsignedInt(tempChrStrB);
		        			//printf("tempChrStrB: %s, number: %d^n", tempChrStrB, number);
		        			if(!(chr_isaLocalVar(target, number, VAR_TYPE_ANY))) //already exist
		        			{
		        				gui_getProperty(twkChrMenu,MP_UNI_TEXT,6,inpt); //value
		        				//printf("input: %s", inpt);
		        				chr_addLocalStrVar(target, number);
		        				chr_setLocalStrVar(target, number, inpt);
		        			}
		        			else
		        				chr_message(target, _, "This char has already a localVar with this value!");
		        		}
		        		else
		        			chr_message(target, _, "The localVar number must consist of 0-9, no letters or other signs!");
		        	}
		        }
		        else if(pagenumber == 8) //layer
		        {
		        	new itemSet=set_create();
		        	set_addItemWeared(itemSet,target,false,true,true);
		        	for (set_rewind(itemSet);!set_end(itemSet);)
		        	{
		        		new item = set_get(itemSet);
		        		new layer= itm_getProperty(item,IP_LAYER);
		        		if(!gui_getProperty(twkChrMenu,MP_CHECK,layer))
		        		{
		        			new bp = chr_getBackpack(target, true);
		        			itm_setContSerial(item, bp);
		        			itm_refresh(item);
		        		}
		        		
		        	}
		        	set_delete(itemSet);
		        }//pagenumber
		        chr_update(target);
		//gui_delete( twkChrMenu );
		}//case
	}//switch
}

/*! }@ */