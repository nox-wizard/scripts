/*!
\defgroup script_command_tweak 'tweak
\ingroup script_commands

@{
*/

/*!
\author Straylight of the freeshard Anacron, www.anacron.net, rewrite, extended and modified by Horian,gernox.de
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
const twkpages=7; //one line for one page, two rows for one page

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
old7
};

static twkButton[twkpages][twk_buttons] = {
{5003, 5209, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003},
{5209, 5003, 5003, 5209, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003},
{5209, 5003, 5209, 5003, 5003, 5209, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003},
{5209, 5003, 5209, 5003, 5209, 5003, 5003, 5209, 5209, 5003, 5209, 5003, 5209, 5003},
{5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5003, 5209, 5209, 5003, 5209, 5003},
{5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5003, 5209, 5209, 5003},
{5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5003, 5209}
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

const NUM_itmtweak = 83;
static it_pg1_l =0; //number of lines at left row
static it_pg1_r =0; //number of lines at right row
static it_pg2_l =0;
static it_pg2_r =0;
static it_pg3_l =0;
static it_pg3_r =0;
static it_pg4_l =0;
static it_pg4_r =0;

new it_gu = 40; //254
new it_tex = 56; //right: 270 = delta 104
new it_prop = 190; //right: 284
new it_check = 275;
new it_radio = 190;
new it_desc = 190; //description

enum Itm_tweaklines
{
it_linetype,
it_linename: 18,
it_propnumber,
it_infotype,
it_propval,
it_inputname: 10
};

//1: property field, eg itemname
//2: infofield, eg weight
//3: inputfield, eg Nightsight
//4: checkbox
//5: radiobutton
//6: subproperties (morex/morey/morez)
static itm_twkarray[NUM_itmtweak][Itm_tweaklines] = {
{1,"Itemname:        ", 454, 0, 0, "         "},
{1,"Creator:         ", 450, 0, 0, "         "},
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
{2,"Weight:          ", 248, 0, 0, "         "},
{1,"Good:          ? ", 211, 0, 0, "         "},
{6,"More1:           ", 112, 1, 0, "         "},
{6,"More2:           ", 112, 2, 0, "         "},
{6,"More3:           ", 112, 3, 0, "         "},
{6,"More4:           ", 112, 4, 0, "         "},
{6,"MoreB 1:         ", 113, 1, 0, "         "},
{6,"MoreB 2:         ", 113, 2, 0, "         "},
{6,"MoreB 3:         ", 113, 3, 0, "         "},
{6,"MoreB 4:         ", 113, 4, 0, "         "},
{4,"Can Decay:       ", 118, 1, 0, "         "},
{2,"Layer:           ", 110, 0, 0, "         "},
{1,"Money Value:     ", 247, 0, 0, "         "},
{1,"Can be dyed:     ", 105, 0, 0, "         "},
{6,"MoreX:           ", 220, 1, 0, "         "},
{6,"MoreY:           ", 220, 2, 0, "         "},
{6,"MoreZ:           ", 220, 3, 0, "         "},
{5,"Visible by:  all:", 120, 2, 0, "         "},
{5,"   owner & GM:   ", 120, 0, 1, "         "},
{5,"   only GM:      ", 120, 0, 2, "         "},
{2,"Is Corpse:       ", 102, 0, 0, "         "},
{2,"Door-Dir:        ", 103, 0, 0, "         "},
{2,"Door is open:    ", 104, 0, 0, "         "},
{5,"Movable default: ", 111, 3, 0, "         "},
{5,"   all:          ", 111, 0, 1, "         "},
{5,"   never:        ", 111, 0, 2, "         "},
{5,"   owner only:   ", 111, 0, 3, "         "},
{2,"Pile able:       ", 454, 0, 0, "         "},
{4,"Is Newbie-Item:  ", 118, 2, 0, "         "},
{1,"Damagetype:      ", 121, 0, 0, "         "},
{1,"Magic dmg type:  ", 122, 0, 0, "         "},
{1,"Is in Container: ", 202, 0, 0, "         "},
{1,"Decay after msec:", 203, 0, 0, "         "},
{2,"Is disabled:     ", 207, 0, 0, "         "},
{1,"Gatenumber:   ?  ", 208, 0, 0, "         "},
{1,"Gatetime:     ?  ", 209, 0, 0, "         "},
{1,"Multiserial:     ", 221, 0, 0, "         "},
{1,"Is poisoned:  ?  ", 217, 0, 0, "         "},
{6,"X Position:      ", 227, 0, 0, "         "},
{6,"Y Position:      ", 227, 1, 0, "         "},
{6,"Z Position:      ", 227, 2, 0, "         "},
{1,"Rank:            ", 228, 0, 0, "         "},
{1,"Restockrate:  ?  ", 230, 0, 0, "         "},
{2,"Random valuerate:", 231, 0, 0, "         "},
{1,"Is secure chest: ", 232, 0, 0, "         "},
{1,"smelt:        ?  ", 234, 0, 0, "         "},
{1,"Spawn Region:    ", 235, 0, 0, "         "},
{1,"Spawner serial:  ", 236, 0, 0, "         "},
{2,"Weapon Speed:    ", 237, 0, 0, "         "},
{1,"Time unused:   ? ", 240, 0, 0, "         "},
{1,"How long unused? ", 241, 0, 0, "         "},
{6,"Item type2:    ? ", 246, 0, 0, "         "},
{1,"Wipeable:        ", 249, 0, 0, "         "},
{1,"Scriptid:        ", 251, 0, 0, "         "},
{2,"Animation ID:    ", 252, 0, 0, "         "},
{1,"resists type:    ", 253, 0, 0, "         "},
{1,"Magic Dmg-power: ", 254, 0, 0, "         "},
{2,"Used Ammo type:  ", 255, 0, 0, "         "},
{1,"Used Ammo Fx:    ", 256, 0, 0, "         "},
{1,"Amount:          ", 400, 0, 0, "         "},
{1,"Amount 2:        ", 401, 0, 0, "         "},
{1,"Direction:       ", 402, 0, 0, "         "},
{2,"Color:           ", 403, 0, 0, "         "},
{1,"Hex ID:          ", 404, 0, 0, "         "},
{6,"Description:     ", 451, 0, 0, "         "},
{1,"Disabled-Message:", 452, 0, 0, "         "},
{1,"Corpse-Murderer: ", 453, 0, 0, "         "},
{2,"Itemname:        ", 454, 0, 0, "         "},
{1,"Item-ID name:  ? ", 455, 0, 0, "         "},
{1,"Incognito:  ?    ", 455, 0, 0, "         "}
};

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//                                      Char tweak definition                                             //
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

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

enum Chr_tweaklines
{
ct_linetype,
ct_linename: 18,
ct_propnumber,
ct_infotype,
ct_propval,
ct_inputname: 10
};
const NUM_chrtweak = 14;

//1: property field, eg itemname
//2: infofield, eg weight
//3: inputfield, eg Nightsight
//4: checkbox
//5: radiobutton
//6: subproperties (morex/morey/morez)
//7: stock function call
static chr_twkarray[NUM_chrtweak][Chr_tweaklines] = {
{1, "Char name:       ", 453, 0, 0, "         "},
{1, "Char title:      ", 455, 0, 0, "         "},
{1, "Karma:           ", 237, 0, 0, "         "},
{1, "Fame:            ", 218, 0, 0, "         "},
{6, "Strength:        ", 295, 0, 0, "         "},
{6, "Hits:            ", 295, 3, 0, "         "},
{6, "Dexterity:       ", 216, 0, 0, "         "},
{6, "Stamina:         ", 216, 3, 0, "         "},
{6, "Intelligence:    ", 236, 0, 0, "         "},
{6, "Mana:            ", 236, 3, 0, "         "},
{1, "Kills:           ", 239, 0, 0, "         "},
{1, "Foodposition:    ", 220, 0, 0, "         "},
{2, "Weight:          ", 312, 0, 0, "         "},
{7, "Skill sum:       ",   0, 0, 0, "         "}
};

const NUM_chrstock = 2;
enum Chr_tweakstock
{
ct_stockname: 18,
ct_numberpara,
ct_param1: 10,
ct_type1,
ct_param2: 10,
ct_type2,
ct_param3: 10,
ct_type3
};

//param type 1 = string value, propnumber 0 = integer
static chr_stockarray[NUM_chrstock][Chr_tweakstock] = {
{"chr_getSkillsum  ", 2, "chr      ", 0, "skillsum ", 0, "         ", 0},
{"chr_getSkillsum  ", 2, "chr      ", 0, "skillsum ", 0, "         ", 0}
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
				j = i + itm_twkarray[i][it_infotype]; //how many lines we need for the radiobuttonbox-thing?
			else j=i;
			if(i<14) //left row page1, we can only check first 14 array lines
			{
				if(j>=14)  //to add radio button would extend over max line number
					it_pg1_l = i-1; //then fewer lines then max to keep it together
				else if(j==13) //14 lines = maximum fits
					it_pg1_l = i; //maximum 14 lines that fit at row
			}
			else if(it_pg1_l < i <= (it_pg1_l+14))//right row first page, we can only check for next 14 array lines
			{
				if(j>(it_pg1_l+14)) // to add radio button would extend over max line number
					it_pg1_r = i-1; //then fewer lines then max to keep it together
				else if(j==(it_pg1_l+14))
					it_pg1_r = i; //maximum 14 lines that fit at row
			}
			else if(it_pg1_r < i <= (it_pg1_r+14))//left row 2. page
			{
				if(j>(it_pg1_r+14)) // to add radio button would extend over max line number
					it_pg2_l = i-1; //then fewer lines then max to keep it together
				else if(j==(it_pg1_r+14))
					it_pg2_l = i; //maximum 14 lines that fit at row
			}
			else if(it_pg2_l < i <= (it_pg2_l+14))//right row 2. page
			{
				if(j>(it_pg2_l+14)) // to add radio button would extend over max line number
					it_pg2_r = i-1; //then fewer lines then max to keep it together
				else if(j==(it_pg2_l+14))
					it_pg2_r = i; //maximum 14 lines that fit at row
			}
			else if(it_pg2_r < i <= (it_pg2_r+14))//left row 3. page
			{
				if(j>(it_pg2_r+14)) // to add radio button would extend over max line number
					it_pg3_l = i-1; //then fewer lines then max to keep it together
				else if((j==(it_pg2_r+14)) || i==(NUM_itmtweak-1))
					it_pg3_l = i; //maximum 14 lines that fit at row
			}
			else if(it_pg3_l < i <= (it_pg3_l+14))//right row 3. page
			{
				if(j>(it_pg3_l+14)) // to add radio button would extend over max line number
					it_pg3_r = i-1; //then fewer lines then max to keep it together
				else if((j==(it_pg3_l+14)) || i==(NUM_itmtweak-1))
					it_pg3_r = i; //maximum 14 lines that fit at row
			}
			else if(it_pg3_r < i <= (it_pg3_r+14))//left row 4. page
			{
				if(j>(it_pg3_r+14)) // to add radio button would extend over max line number
					it_pg4_l = i-1; //then fewer lines then max to keep it together
				else if((j==(it_pg3_r+14)) || i==(NUM_itmtweak-1))
					it_pg4_l = i; //maximum 14 lines that fit at row
			}
			else if(it_pg4_l < i <= (it_pg4_l+14))//right row 4. page
			{
				if(j>(it_pg4_l+14)) // to add radio button would extend over max line number
					it_pg4_r = i-1; //then fewer lines then max to keep it together
				else if((j==(it_pg3_l+14)) || i==(NUM_itmtweak-1))
					it_pg4_r = i; //maximum 14 lines that fit at row
			}//else if
		}//for
		for(new i=0; i<NUM_chrtweak; ++i)
		{
			new j;
			if(chr_twkarray[i][ct_linetype] == 5)
				j = i + chr_twkarray[i][ct_infotype]; //how many lines we need for the radiobuttonbox-thing?
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
					ct_pg1_r = i-1; //then fewer lines then max to keep it together
				else if(j==(ct_pg1_l+14))
					ct_pg1_r = i; //maximum 14 lines that fit at row
			}
			else if(ct_pg1_r < i <= (ct_pg1_r+14))//left row 2. page
			{
				if(j>(ct_pg1_r+14)) // to add radio button would extend over max line number
					ct_pg2_l = i-1; //then fewer lines then max to keep it together
				else if(j==(ct_pg1_r+14))
					ct_pg2_l = i; //maximum 14 lines that fit at row
			}
			else if(ct_pg2_l < i <= (ct_pg2_l+14))//right row 2. page
			{
				if(j>(ct_pg2_l+14)) // to add radio button would extend over max line number
					ct_pg2_r = i-1; //then fewer lines then max to keep it together
				else if(j==(ct_pg2_l+14))
					ct_pg2_r = i; //maximum 14 lines that fit at row
			}
			else if(ct_pg2_r < i <= (ct_pg2_r+14))//left row 3. page
			{
				if(j>(ct_pg2_r+14)) // to add radio button would extend over max line number
					ct_pg3_l = i-1; //then fewer lines then max to keep it together
				else if((j==(ct_pg2_r+14)) || i==(NUM_chrtweak-1))
					ct_pg3_l = i; //maximum 14 lines that fit at row
			}
			else if(ct_pg3_l < i <= (ct_pg3_l+14))//right row 3. page
			{
				if(j>(ct_pg3_l+14)) // to add radio button would extend over max line number
					ct_pg3_r = i-1; //then fewer lines then max to keep it together
				else if((j==(ct_pg3_l+14)) || i==(NUM_chrtweak-1))
					ct_pg3_r = i; //maximum 14 lines that fit at row
			}
			else if(ct_pg3_r < i <= (ct_pg3_r+14))//left row 4. page
			{
				if(j>(ct_pg3_r+14)) // to add radio button would extend over max line number
					ct_pg4_l = i-1; //then fewer lines then max to keep it together
				else if((j==(ct_pg3_r+14)) || i==(NUM_chrtweak-1))
					ct_pg4_l = i; //maximum 14 lines that fit at row
			}
			else if(ct_pg4_l < i <= (ct_pg4_l+14))//right row 4. page
			{
				if(j>(ct_pg4_l+14)) // to add radio button would extend over max line number
					ct_pg4_r = i-1; //then fewer lines then max to keep it together
				else if((j==(ct_pg3_l+14)) || i==(NUM_chrtweak-1))
					ct_pg4_r = i; //maximum 14 lines that fit at row
			}//else if
		}//for
	tweakinit = true;
	}//if
	//printf("^nL1: %d, R1: %d, L2: %d, R2: %d, L3: %d, R3: %d, L4: %d, R4: %d^n", it_pg1_l, it_pg1_r, it_pg2_l, it_pg2_r, it_pg3_l, it_pg3_r, it_pg4_l, it_pg4_r);
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
						gui_addCheckbox( twkItmMenu,it_check+k,180+(n*20),oldpic,newpic,checklev,i+10);
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
						gui_addCheckbox( twkItmMenu,it_prop+k,181+(n*20),oldpic,newpic,checklev,i+10);
						checklev=0;
					}
					case 5: //radiobutton
					{
						if(itm_twkarray[i][it_propval] == itm_getProperty( target,itm_twkarray[i][it_propnumber]))
							checklev = 1;
						if(itm_twkarray[i][it_propnumber] == 120) //visible
							{
							gui_addText(twkItmMenu,it_tex+k,180+(n*20),1310, itm_twkarray[i][it_linename]);
							gui_addRadioButton( twkItmMenu,it_radio+k,(180+(n*20)), oldpic,newpic,checklev,i+10);
							}
						if(itm_twkarray[i][it_propnumber] == 111) //moveable
						{
							gui_addText(twkItmMenu,it_tex+k,180+(n*20),1310, itm_twkarray[i][it_linename]);
							gui_addRadioButton( twkItmMenu,it_radio+k,(180+(n*20)), oldpic,newpic,checklev,i+10);
						}
						checklev=0;
					}
					case 6: //splitted properties (more for example)
					{
						gui_addGump(twkItmMenu,it_gu+k,181+(n*20), 0x827);
						gui_addText(twkItmMenu,it_tex+k,180+(n*20),1310, itm_twkarray[i][it_linename]);
						gui_addPropField( twkItmMenu, (it_prop+k), (180+(n*20)),150,30, (itm_twkarray[i][it_propnumber]), (itm_twkarray[i][it_infotype]));
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
			//gui_delete( twkItmMenu );
		}//for
		itm_refresh(target);
	}//apply button
}

public tweak_char(const chrsource, const target, pagenumber)
{
	new skillsum;
	new tempChrStr[100];
	new tweakchr_cllbck[15];
	sprintf( tweakchr_cllbck,"tweakchrBck%d",pagenumber);
	//printf("tweakchr_cllbck: %s", tweakchr_cllbck);
	new twkChrMenu = gui_create( 10,10,1,1,1,tweakchr_cllbck );
	
	gui_setProperty( twkChrMenu,MP_BUFFER,0,PROP_CHARACTER );
	gui_setProperty( twkChrMenu,MP_BUFFER,1,target );
	gui_setProperty( twkChrMenu,MP_BUFFER,3,BUTTON_APPLY );

	gui_addPage(twkChrMenu,0);
	gui_addResizeGump(twkChrMenu,10,35,5054,550,530 );
	gui_addResizeGump(twkChrMenu,20,105,3500,530,455);
	gui_addResizeGump(twkChrMenu,25,49,5100,525,51);
	
	gui_addText(twkChrMenu,250,32,1210,"Tweak Menue");
	gui_addButton( twkChrMenu,460,525, 0x084A, 0x084B,BUTTON_APPLY );
	gui_addPage(twkChrMenu,1);

	new tempStr[100];
	new tweak_cllbck[15];
	sprintf( tweak_cllbck,"tweakBck%d",pagenumber);
	//printf("tweak_cllbck: %s", tweak_cllbck);

	new arrayline = pagenumber-1;

	gui_addButton(twkChrMenu,35,51,twkButton[arrayline][new1],twkButton[arrayline][old1],1);
	gui_addText(twkChrMenu,60,49,33,"Main infos");
	gui_addButton(twkChrMenu,170,51,twkButton[arrayline][new2],twkButton[arrayline][old2],2);
	gui_addText(twkChrMenu,195,49,33,"Skills");
	gui_addButton(twkChrMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
	gui_addText(twkChrMenu,285,49,33,"Flags");
	gui_addButton(twkChrMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
	gui_addText(twkChrMenu,380,49,33,"Layer");
	gui_addButton(twkChrMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
	gui_addText(twkChrMenu,470,49,33,"Events");
	gui_addButton(twkChrMenu,35,81,twkButton[arrayline][new6],twkButton[arrayline][old6],6);
	gui_addText(twkChrMenu,60,79,33,"LocalVars");
	gui_addButton(twkChrMenu,170,81,twkButton[arrayline][new7],twkButton[arrayline][old7],7);
	gui_addText(twkChrMenu,195,79,33,"Flags 2");
	
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
	new ct_prop = 190; //right: 284
	new ct_check = 275;
	new ct_radio = 190;
	new ct_desc = 190; //description
	
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
					case 1: //property field, eg itemname
					{
						gui_addGump(twkChrMenu,it_gu+k,181+(n*20), 0x827);
						gui_addText(twkChrMenu,it_tex+k,180+(n*20),1310, itm_twkarray[i][it_linename]);
						if(itm_twkarray[i][it_infotype] != 0) //its a splitted property (more is more1, more2, more3 ...)
						{
							for(p = 1; p<= itm_twkarray[i][it_infotype]; p++)
							{
								gui_addPropField( twkChrMenu, it_prop+k-30+p*30, (180+(n*20)),150,30, itm_twkarray[i][it_propnumber]);
							}
						}
						else gui_addPropField( twkChrMenu, it_prop+k, (180+(n*20)),150,30, itm_twkarray[i][it_propnumber]);
					}
					case 2: //infofield, eg weight
					{
						gui_addText(twkChrMenu,it_tex+k,180+(n*20),1310,itm_twkarray[i][it_linename]);
						if(itm_twkarray[i][it_infotype]==0)
						{
							sprintf( tempChrStr,"%d",itm_getProperty(target,itm_twkarray[i][it_propnumber]));
						}
						gui_addText( twkChrMenu, it_desc+k, 180+(n*20),0,tempChrStr);
						sprintf( tempChrStr,"");
					}
					case 3: //inputfield, eg Nightsight
					{
						gui_addGump(twkChrMenu,it_gu+k, 181+(n*20), 0x827);
						if( isStrContainedInStr(itm_twkarray[i][it_linename], "Nightsight"))
						{
							if(tempfx_isActive( target,TFX_SPELL_LIGHT) == 1)
							checklev = 1;
						}
						gui_addText(twkChrMenu,it_tex+k,180+(n*20),1310,itm_twkarray[i][it_linename]);
						gui_addInputField( twkChrMenu,it_prop+k,180+(n*20),50,20,i,1110,itm_twkarray[i][it_inputname]);
						gui_addCheckbox( twkChrMenu,it_check+k,180+(n*20),oldpic,newpic,checklev,i+10);
						checklev=0;
					}
					case 4: //checkbox
					{
						if(itm_twkarray[i][it_propnumber] == 118) //decay
						{
							if(itm_getProperty( target,IP_PRIV)&itm_twkarray[i][it_infotype] != itm_twkarray[i][it_infotype]) //can decay
								checklev = 1;
						}
						gui_addText(twkChrMenu,it_tex+k,180+(n*20),1310,itm_twkarray[i][it_linename]);
						gui_addCheckbox( twkChrMenu,it_prop+k,181+(n*20),oldpic,newpic,checklev,i+10);
						checklev=0;
					}
					case 5: //radiobutton
					{
						if(itm_twkarray[i][it_propval] == itm_getProperty( target,itm_twkarray[i][it_propnumber]))
							checklev = 1;
						if(itm_twkarray[i][it_propnumber] == 120) //visible
							{
							gui_addText(twkChrMenu,it_tex+k,180+(n*20),1310, itm_twkarray[i][it_linename]);
							gui_addRadioButton( twkChrMenu,it_radio+k,(180+(n*20)), oldpic,newpic,checklev,i+10);
							}
						if(itm_twkarray[i][it_propnumber] == 111) //moveable
						{
							gui_addText(twkChrMenu,it_tex+k,180+(n*20),1310, itm_twkarray[i][it_linename]);
							gui_addRadioButton( twkChrMenu,it_radio+k,(180+(n*20)), oldpic,newpic,checklev,i+10);
						}
						checklev=0;
					}
					case 6: //splitted properties (more for example)
					{
						gui_addGump(twkChrMenu,it_gu+k,181+(n*20), 0x827);
						gui_addText(twkChrMenu,it_tex+k,180+(n*20),1310, itm_twkarray[i][it_linename]);
						gui_addPropField( twkChrMenu, (it_prop+k), (180+(n*20)),150,30, (itm_twkarray[i][it_propnumber]), (itm_twkarray[i][it_infotype]));
					}
					case 7: //stock function call
					{
						new p = itm_twkarray[i][it_propnumber];
						/*for(new o =1; o<= (chr_stockarray[p][ct_numberpara]); ++o)
						{
							new paramname[10];
							sprintf(paramname, "ct_param%d", o); //get x in ct_paramx
							if((chr_stockarray[p][paramname])== 1) //is a string
							{
								new param[10];
							}
						}*/
						callFunction2P(funcidx(chr_stockarray[p][ct_stockname]),chr_stockarray[p][ct_param1],chr_stockarray[p][ct_param2]);
					}
					default: printf("unknown item-tweak case!");
				}//linetype
				n=n+1;
			}//for
		}
	}//if pagenumber

	if( pagenumber == 1)
	{
		gui_addGump(twkChrMenu,50,181, 0x827);
		gui_addText(twkChrMenu,66,180,1310,"eventname :");
		gui_addPropField( twkChrMenu, 130, 180,150,30,CP_STR_NAME);
		
		gui_addGump(twkChrMenu,50,201, 0x827);
		gui_addText(twkChrMenu,66,200,1310,"Title:");
		gui_addPropField( twkChrMenu, 130, 200,150,30,CP_STR_TITLE);
		
		gui_addGump(twkChrMenu,50,221, 0x827);
		gui_addText(twkChrMenu,66,220,1310,"Karma:");
		gui_addPropField( twkChrMenu, 130, 220,150,30,CP_KARMA);
		
		gui_addGump(twkChrMenu,50,241, 0x827);
		gui_addText(twkChrMenu,66,240,1310,"Fame :");
		gui_addPropField( twkChrMenu, 130, 240,150,30,CP_FAME);
		
		gui_addGump(twkChrMenu,50,261, 0x827);
		gui_addText(twkChrMenu,66,260,1310,"Strength :");
		gui_addPropField( twkChrMenu, 130, 260,150,30,CP_STRENGTH,CP2_STR);
		
		gui_addGump(twkChrMenu,50,281, 0x827);
		gui_addText(twkChrMenu,66,280,1310,"Hits :");
		gui_addPropField( twkChrMenu, 130, 280,150,30,CP_STRENGTH,CP2_HITPOINTS);
		
		gui_addGump(twkChrMenu,50,301, 0x827);
		gui_addText(twkChrMenu,66,300,1310,"Dex :");
		gui_addPropField( twkChrMenu, 130, 300,150,30,CP_DEXTERITY,CP2_DEX);
		
		gui_addGump(twkChrMenu,50,321, 0x827);
		gui_addText(twkChrMenu,66,320,1310,"Stamina:");
		gui_addPropField( twkChrMenu, 130, 320,150,30,CP_DEXTERITY,CP2_STAMINA);
		
		gui_addGump(twkChrMenu,50,341, 0x827);
		gui_addText(twkChrMenu,66,340,1310,"Int :");
		gui_addPropField( twkChrMenu, 130, 340,150,30,CP_INTELLIGENCE,CP2_INT);
		
		gui_addGump(twkChrMenu,50,361, 0x827);
		gui_addText(twkChrMenu,66,360,1310,"Mana :");
		gui_addPropField( twkChrMenu, 130, 360,150,30,CP_INTELLIGENCE,CP2_MANA);
		
		gui_addGump(twkChrMenu,50,381, 0x827);
		gui_addText(twkChrMenu,66,380,1310,"Kills :");
		gui_addPropField( twkChrMenu, 130, 380,150,30,CP_KILLS);
		
		gui_addGump(twkChrMenu,50,401, 0x827);
		gui_addText(twkChrMenu,66,400,1310,"Food Pos. :");
		gui_addPropField( twkChrMenu, 130, 400,150,30,CP_FOODPOSITION);
		
		gui_addText(twkChrMenu,66,420,1310,"Weight:");
		sprintf( tempChrStr,"%d",chr_getProperty( target,CP_WEIGHT));
		gui_addText( twkChrMenu, 130, 420,0,tempChrStr);
		//gui_addPropField( twkChrMenu, 130, 420,150,30,CP_WEIGHT);

		gui_addText(twkChrMenu,270,180,1310,"Summ Skills :"); // Skillsumme
		new i;
		new skillsum;
		for (i=0;i<49;++i)
		{
			skillsum=skillsum+chr_getProperty(target,CP_BASESKILL,i);
		}
		new skillsumStr[10];
		sprintf(skillsumStr,"%d",skillsum);

		gui_addText(twkChrMenu,420,180,0,skillsumStr);
		
		gui_addText(twkChrMenu,270,200,1310,"Gold bankbox :"); //Gold
		sprintf( tempChrStr,"%d",chr_countBankGold(target));
		gui_addText( twkChrMenu, 420, 200,0,tempChrStr);
		
		gui_addText(twkChrMenu,270,220,1310,"bankbox open");
		gui_addButton(twkChrMenu,420,220,2224,2117,11);
		gui_addGump(twkChrMenu,254,241, 0x827);
		
		gui_addText(twkChrMenu,270,240,1310,"Body color :");
		gui_addPropField( twkChrMenu, 420, 240,150,30,CP_SKIN); // Color
		
		gui_addGump(twkChrMenu,254,261, 0x827);		
		gui_addText(twkChrMenu,270,260,1310,"Body oskin :");
		gui_addPropField( twkChrMenu, 420, 260,150,30,CP_XSKIN);
		
		gui_addGump(twkChrMenu,254,281, 0x827);
		gui_addText(twkChrMenu,270,280,1310,"ID :");
		gui_addPropField( twkChrMenu, 420, 280,150,30,CP_ID);
		
		gui_addGump(twkChrMenu,254,321, 0x827);
		gui_addText(twkChrMenu,270,300,1310,"O Body :");
		gui_addPropField( twkChrMenu, 420, 300,150,30,CP_XID);
		
		gui_addGump(twkChrMenu,254,301, 0x827);
		gui_addText(twkChrMenu,270,320,1310,"Script :");
		gui_addPropField( twkChrMenu, 420, 320,150,30,CP_SCRIPTID);
		
		gui_addGump(twkChrMenu,254,341, 0x827);
		gui_addText(twkChrMenu,270,340,1310,"Action (Skill) :");
		gui_addPropField( twkChrMenu, 420, 340,150,30,CP_MAKING);
		
		gui_addGump(twkChrMenu,254,361, 0x827);
		gui_addText(twkChrMenu,270,360,1310,"Position :");
		gui_addPropField( twkChrMenu, 390, 360,150,30,CP_POSITION,CP2_X);
		gui_addPropField( twkChrMenu, 440, 360,150,30,CP_POSITION,CP2_Y);
		gui_addPropField( twkChrMenu, 490, 360,150,30,CP_POSITION,CP2_Z);
		
		gui_addGump(twkChrMenu,254,381, 0x827);
		gui_addText(twkChrMenu,270,380,1310,"Workposition :");
		gui_addPropField( twkChrMenu, 390, 380,150,30,CP_POSITION,CP2_X);
		gui_addPropField( twkChrMenu, 440, 380,150,30,CP_POSITION,CP2_Y);
		gui_addPropField( twkChrMenu, 490, 380,150,30,CP_POSITION,CP2_Z);
		
		gui_addText(twkChrMenu,270,400,1310,"Script ID:");
		sprintf( tempChrStr,"%d",chr_getProperty(target,CP_SCRIPTID));
		
		gui_addText(twkChrMenu,66,460,1310,"guild eventname :");

		if ( chr_getGuild(target) >= 0 )

			guild_getProperty( chr_getGuild(target),GP_STR_NAME,_,0,tempChrStr );
		else	tempChrStr="Keine";
		gui_addText( twkChrMenu, 200, 460,0,tempChrStr);
		
		gui_addText(twkChrMenu,66,480,1310,"guild master :");
		gui_addText(twkChrMenu,200,480,0,"Not yet available");
		gui_addText(twkChrMenu,66,500,1310,"Go to guild");
		
		gui_addText(twkChrMenu,66,520,1310,"Char since");

		new age=chr_getProperty(target,CP_CREATIONDAY);
		if ( age > 0 )
		{	new year=cal_getRealYear(age);
			new dayInYear=cal_getDayInYear(age);
			new month=cal_getRealMonth(dayInYear,year);
			new day=cal_getDayInMonth(dayInYear,year);
			sprintf( tempChrStr,"%d/%d/%d ",day,month,year);
		}

		else	tempChrStr="--------";
		gui_addText( twkChrMenu, 180, 520,0,tempChrStr);
		gui_addText(twkChrMenu,270,520,1310,"existent");
		
		//gui_addText(twkChrMenu,270,420,1310,"Rewardpoints");
		//printf("test gui, twkChrMenu: %d^n", twkChrMenu);

		
	}
	else if(pagenumber ==2)
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
		gui_addText(twkChrMenu,195,49,33,"Skills");
		gui_addButton(twkChrMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
		gui_addText(twkChrMenu,285,49,33,"Flags");
		gui_addButton(twkChrMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
		gui_addText(twkChrMenu,380,49,33,"Layer");
		gui_addButton(twkChrMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
		gui_addText(twkChrMenu,470,49,33,"Events");
		gui_addButton(twkChrMenu,35,81,twkButton[arrayline][new6],twkButton[arrayline][old6],6);
		gui_addText(twkChrMenu,60,79,33,"LocalVars");
		gui_addButton(twkChrMenu,170,81,twkButton[arrayline][new7],twkButton[arrayline][old7],7);
		gui_addText(twkChrMenu,195,79,33,"Flags 2");
		
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
		printf("test gui, twkChrMenu: %d^n", twkChrMenu);
	}
	else if(pagenumber == 3)
	{
		new checklev = 0;
		new poisonText[5][10]={"None","Lightly","Normal","Heavy","Deadly"};

		gui_addText(twkChrMenu,100,150,33,"Flags");
		
		//Invul
		if(chr_isInvul(target) == 1) //invul
		      checklev = 1;
		gui_addCheckbox( twkChrMenu,190,173, oldpic,newpic,checklev,12);
		gui_addText(twkChrMenu,66,170,1310,"Invulnerable :");
		checklev=0;

		// Dead
		if(chr_getProperty(target,CP_DEAD) == 1) //tot
		       checklev = 1;
		gui_addText(twkChrMenu,66,190,1310,"Dead :");
		gui_addCheckbox( twkChrMenu,190,193, oldpic,newpic,checklev,13);
		checklev=0;

		//Freeze
		if((chr_getProperty(target,CP_PRIV2)&0x02) == 2) //eingefroren
		       checklev = 1;
		gui_addCheckbox( twkChrMenu,190,213, oldpic,newpic,checklev,14);
		gui_addText(twkChrMenu,66,210,1310,"Frozen :");
		checklev=0;

		//Invis
		new checklev2=0;
		new checklev3=0;
		new checklev4=0;
		if((chr_getProperty(target,CP_HIDDEN) == 1) && ((chr_getProperty( target,CP_PRIV2) & PRIV2_PERMAHIDDEN) != 8)) //invis skill
			checklev=1;
		else if((chr_getProperty(target,CP_HIDDEN) == 2) && ((chr_getProperty( target,CP_PRIV2) & PRIV2_PERMAHIDDEN) != 8)) //invis spell
			checklev2=1;
		else if((chr_getProperty(target,CP_PRIV2) & PRIV2_PERMAHIDDEN) == 8) //invis perma
			checklev3=1; //button is checked
		else checklev4=1;
		gui_addText(twkChrMenu,66,230,1310,"Invisible");
		gui_addText(twkChrMenu,66,245,1310,"  by:");
		gui_addText(twkChrMenu,140,237,0,"Skill");
		gui_addRadioButton( twkChrMenu,180,240, oldpic,newpic,checklev,15);
		gui_addText(twkChrMenu,216,237,0,"Spell");
		gui_addRadioButton( twkChrMenu,256,240, oldpic,newpic,checklev2,16);
		gui_addText(twkChrMenu,292,237,0,"Perma");
		gui_addRadioButton( twkChrMenu,337,240, oldpic,newpic,checklev3,17);
		gui_addText(twkChrMenu,370,237,0,"Visible");
		gui_addRadioButton( twkChrMenu,427,240, oldpic,newpic,checklev4,18);
		checklev=0;
		
		// gui_addButton(twkChrMenu,43,253,2224,2117,10);
		// gui_addText(twkChrMenu,66,250,1310,"Sleeping :");
		// gui_addText(twkChrMenu,190,250,1110,"<eval (<src.targ.flags>&010)==010>");
		
		//Warmode
		if(chr_getProperty(target,CP_WAR) == 1) //Warmode
		        checklev = 1;
		gui_addText(twkChrMenu,66,270,1310,"Warmode :");
		gui_addCheckbox( twkChrMenu,190,270,oldpic,newpic,checklev,19);
		checklev=0;
		
		gui_addText(twkChrMenu,66,290,1310,"Reactive Armor :");
		sprintf( tempChrStr,"%d",tempfx_isActive( target,TFX_SPELL_REACTARMOR));
		gui_addText(twkChrMenu,190,290,1110,tempChrStr);
		
		//Poison
		gui_addGump(twkChrMenu,50,310, 0x827);
		gui_addText(twkChrMenu,66,310,1310,"Poisoned :");
		gui_addPropField( twkChrMenu,190,310,125,30,CP_POISONED,_,1110);
		
		gui_addGump(twkChrMenu,50,330, 0x827);
		gui_addText( twkChrMenu,66,330,1310,"NPC Poison Attack: ");
		gui_addPropField( twkChrMenu,190,330,125,30,CP_POISON,_,1110);
		
		gui_addGump(twkChrMenu,50,350, 0x827);
		gui_addText( twkChrMenu,66,350,1310,"Poison Time : ");
		gui_addPropField(twkChrMenu,190,350,125,30,CP_POISONWEAROFFTIME,_,1110);
		
		gui_addGump(twkChrMenu,50,370, 0x827);
		gui_addText( twkChrMenu,66,370,1310,"Direction : ");
		gui_addPropField(twkChrMenu,190,370,125,30,CP_DIR,_,1110 );
		
		//Nightsight
		gui_addGump(twkChrMenu,50,390, 0x827);
		if(tempfx_isActive( target,TFX_SPELL_LIGHT) == 1) //Nightsight
		       checklev = 1;
		gui_addText(twkChrMenu,66,390,1310,"Nightsight:");
		gui_addInputField( twkChrMenu,190,390,50,20,20,1110,"millisec");
		gui_addCheckbox( twkChrMenu,265,393,oldpic,newpic,checklev,20);
		checklev=0;

		//Magic Reflect
		if(chr_getProperty( target, CP_PRIV2, _)&0x40 == 40) //Magic Reflection
		       checklev = 1;
		gui_addText(twkChrMenu,66,410,1310,"Magic Reflect :");
		gui_addCheckbox( twkChrMenu,190,413,oldpic,newpic,checklev,21);
		checklev=0;

		//Polymorph
		if( (chr_getProperty( target,CP_ID)) != (chr_getProperty(target,CP_XID))) //if(chr_getProperty( target,CP_POLYMORPH) == 1) //polymorphed
		       checklev = 1;
		gui_addText(twkChrMenu,66,430,1310,"Polymorph:");
		gui_addCheckbox( twkChrMenu,265,430, oldpic,newpic,checklev,22);
		checklev = 0;
		
		gui_addButton(twkChrMenu,43,453,2224,2117,23);
		gui_addText(twkChrMenu,66,450,1310,"Incognito :");
		sprintf( tempChrStr,"%d",tempfx_isActive( target,TFX_SPELL_INCOGNITO));
		gui_addText(twkChrMenu,190,450,1110,tempChrStr);
		
		gui_addButton(twkChrMenu,317,173,2224,2117,24);
		gui_addText(twkChrMenu,340,170,1310,"Has Shield :");

		if ( chr_getShield(target) > 0 )
		        sprintf( tempChrStr,"1" );
		else    sprintf( tempChrStr,"0");
		gui_addText(twkChrMenu,470,170,1110,tempChrStr);
		
		//Hausicons
		if(chr_getProperty(target,CP_PRIV2)&PRIV2_VIEWHOUSESASICON == 4 ) //Icon
		      checklev = 1;
		gui_addText(twkChrMenu,340,190,1310,"House as icons :");
		gui_addCheckbox( twkChrMenu,470,193,oldpic,newpic,checklev,25);
		checklev=0;

		//26
		gui_addGump(twkChrMenu,317,210, 0x827);
		gui_addText(twkChrMenu,340,210,1310,"Steps to fly :");
		gui_addPropField(twkChrMenu,470,210,125,30,CP_FLY_STEPS );
		
		gui_addButton(twkChrMenu,317,273,2224,2117,27);
		gui_addText(twkChrMenu,340,270,1310,"Respawn :");
		gui_addText(twkChrMenu,470,270,1110,"Respawn N/A");
		
		//Hallucination
		if(tempfx_isActive( target,TFX_LSD)) //LSD on
		      checklev = 1;
		gui_addText(twkChrMenu,340,290,1310,"Hallucinating :");
		gui_addInputField( twkChrMenu,470,290,50,20,28,1110,"millisec");
		gui_addCheckbox( twkChrMenu,535,293,oldpic,newpic,checklev,28);
		checklev=0;
		
		/*sprintf( tempChrStr,"%d",chr_getProperty(target,CP_HIDDEN);
		gui_addButton(twkChrMenu,317,313,2224,2117,29);
		gui_addText(twkChrMenu,340,310,1310,"Hidden :");
		gui_addText(twkChrMenu,470,310,1110,tempChrStr);*/
		
		gui_addButton(twkChrMenu,317,333,2224,2117,29);
		gui_addText(twkChrMenu,340,330,1310,"Indoors :");
		gui_addText(twkChrMenu,470,330,1110,"N/A");
		
		gui_addButton(twkChrMenu,317,353,2224,2117,29);
		gui_addText(twkChrMenu,340,350,1310,"Criminal :");
		sprintf( tempChrStr,"%d",chr_getProperty(target,CP_CRIMINALFLAG));
		gui_addText(twkChrMenu,470,350,1110,tempChrStr);
		
		gui_addButton(twkChrMenu,317,373,2224,2117,30);
		gui_addText(twkChrMenu,340,370,1310,"Conjured :");
		sprintf( tempChrStr,"%d",chr_getProperty(target,CP_SUMMONTIMER));
		gui_addText(twkChrMenu,470,370,1110,tempChrStr);
		
		gui_addButton(twkChrMenu,317,393,2224,2117, 31);
		gui_addText(twkChrMenu,340,390,1310,"Pet :");
		sprintf( tempChrStr,"%d",chr_getProperty(target,CP_TAMED));
		gui_addText(twkChrMenu,470,390,1110,tempChrStr);
		
		gui_addButton(twkChrMenu,317,413,2224,2117,32);
		gui_addText(twkChrMenu,340,410,1310,"Spawned :");
		sprintf( tempChrStr,"%d",chr_getProperty(target,CP_SPAWNSERIAL));
		gui_addText(twkChrMenu,470,410,1110,tempChrStr);
		
		gui_addButton(twkChrMenu,317,433,2224,2117,33);
		gui_addText(twkChrMenu,340,430,1310,"On Horse :");
		sprintf( tempChrStr,"%d",chr_getProperty(target,CP_ONHORSE));
		gui_addText(twkChrMenu,470,430,1110,tempChrStr);
		
		printf("test gui, twkChrMenu: %d^n", twkChrMenu);
	}
	else if(pagenumber == 4)
	{
		new items[24];
	new wornLayer[24]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
	static layerText[24][24]={
		"Hand 1",
		"Hand 2",
		"Shoes",
		"Pants",
		"Shirt",
		"Helm",
		"Gloves",
		"Ring",
		"Light",
		"Neck",
		"Hair",
		"Waist",
		"Chest",
		"bracelet",
		"Unused",
		"Beard",
		"mid torso",
		"Ears",
		"Arms",
		"Cloak",
		"Backpack",
		"Robe",
		"Skirts",
		"inner legs"
	};
		
		//gui_addText(twkChrMenu,50,150,1110,"Layer");

		new itemSet=set_create();
		set_addItemWeared(itemSet,target,false,true,true);
		new i=1;
		for (set_rewind(itemSet);!set_end(itemSet);)
		{
			new item = set_get(itemSet);
			new itemName[30];
			itm_getProperty(item,IP_STR_NAME,_,itemName);
			new layer= itm_getProperty(item,IP_LAYER);
			if ( layer <= 24)
			{
				wornLayer[layer]=1;
		
				if ( layer <= 12 )
				{
					gui_addTilePic(twkChrMenu,40+(layer-1)*40,150,itm_getProperty(item,IP_ID));
					gui_addCheckbox(twkChrMenu,43,243+(layer-1)*20, oldpic, newpic, 1, 6+(layer-1));
					gui_addText(twkChrMenu,66,240+(layer-1)*20,0,layerText[layer-1]);
					gui_addText(twkChrMenu,140,240+(layer-1)*20,1310,itemName);
				}
				else
				{
					gui_addTilePic(twkChrMenu,(layer-12)*40,190,itm_getProperty(item,IP_ID));
					gui_addCheckbox(twkChrMenu,317,203+(layer-11)*20, oldpic, newpic, 1, 6+(layer-1));
					gui_addText(twkChrMenu,340,200+(layer-11)*20,0,layerText[layer-1]);
					gui_addText(twkChrMenu,420,200+(layer-11)*20,1310,itemName);
				}
			}
		}
		set_delete(itemSet);
		for ( i=1;i <= 24;++i)
		{
			if ( wornLayer[i] == 0 )
			{
				if ( i <= 12 )
				{
					gui_addCheckbox(twkChrMenu,43,243+(i-1)*20, oldpic, newpic, 0, 6+(i-1));
					gui_addText(twkChrMenu,66,240+(i-1)*20,0,layerText[i-1]);
					gui_addText(twkChrMenu,140,240+(i-1)*20,1310,"Nothing");
				}
				else
				{
					gui_addCheckbox(twkChrMenu,317,203+(i-11)*20, oldpic, newpic, 0, 6+(i-1));
					gui_addText(twkChrMenu,340,200+(i-11)*20,0,layerText[i-1]);
					gui_addText(twkChrMenu,420,200+(i-11)*20,1310,"Nothing");
				}
			}
		}
		//printf("test gui, twkChrMenu: %d^n", twkChrMenu);
	}
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
		gui_addText(twkChrMenu,195,49,33,"Skills");
		gui_addButton(twkChrMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
		gui_addText(twkChrMenu,285,49,33,"Flags");
		gui_addButton(twkChrMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
		gui_addText(twkChrMenu,380,49,33,"Layer");
		gui_addButton(twkChrMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
		gui_addText(twkChrMenu,470,49,33,"Events");
		gui_addButton(twkChrMenu,35,81,twkButton[arrayline][new6],twkButton[arrayline][old6],6);
		gui_addText(twkChrMenu,60,79,33,"LocalVars");
		gui_addButton(twkChrMenu,170,81,twkButton[arrayline][new7],twkButton[arrayline][old7],7);
		gui_addText(twkChrMenu,195,79,33,"Flags 2");
		
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
		gui_addText(twkChrMenu,195,49,33,"Skills");
		gui_addButton(twkChrMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
		gui_addText(twkChrMenu,285,49,33,"Flags");
		gui_addButton(twkChrMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
		gui_addText(twkChrMenu,380,49,33,"Layer");
		gui_addButton(twkChrMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
		gui_addText(twkChrMenu,470,49,33,"Events");
		gui_addButton(twkChrMenu,35,81,twkButton[arrayline][new6],twkButton[arrayline][old6],6);
		gui_addText(twkChrMenu,60,79,33,"LocalVars");
		gui_addButton(twkChrMenu,170,81,twkButton[arrayline][new7],twkButton[arrayline][old7],7);
		gui_addText(twkChrMenu,195,79,33,"Flags 2");
		
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
						gui_addText(twkChrMenu,195,49,33,"Skills");
						gui_addButton(twkChrMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
						gui_addText(twkChrMenu,285,49,33,"Flags");
						gui_addButton(twkChrMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
						gui_addText(twkChrMenu,380,49,33,"Layer");
						gui_addButton(twkChrMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
						gui_addText(twkChrMenu,470,49,33,"Events");
						gui_addGump(twkChrMenu,35,81,twkButton[arrayline][new6]);
						gui_addText(twkChrMenu,60,79,33,"LocalVars");
						gui_addButton(twkChrMenu,170,81,twkButton[arrayline][new7],twkButton[arrayline][old7],7);
						gui_addText(twkChrMenu,195,79,33,"Flags 2");
						
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
							//printf("dividerrest > 16, enter sub page content, count: %d^n", count);
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
				else /*if((divider==0) || ((divider==1) && (dividerrest==0)))*/ //first page == almost static (no subpage)
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
	else if(pagenumber == 7)
	{
		new checker = 0;
		gui_addText(twkChrMenu,100,150,33,"Flags 2");
		
		//All move, 12
		if(chr_getProperty( target, CP_PRIV2, _)&PRIV2_ALLMOVE == 1) //can move all
			checker = 1;
		gui_addCheckbox( twkChrMenu,190,173, oldpic,newpic,checker,12);
		gui_addText(twkChrMenu,66,170,1310,"Can move all :");
		checker=0;

		//Can broadcast, 13
		if(chr_getProperty( target, CP_PRIV, _)&PRIV_CANBROADCAST == 2) //can broadcast
		{
			checker = 1;
		}
		gui_addCheckbox( twkChrMenu,190,193, oldpic,newpic,checker,13);
		gui_addText(twkChrMenu,66,190,1310,"Can broadcast :");
		checker=0;

		//Commandlevel, 14
		gui_addGump(twkChrMenu,50,210, 0x827);
		gui_addText(twkChrMenu,66,210,1310,"Ingame Command level :");
		gui_addText(twkChrMenu,66,230,1310,"(50 player, 100 CNS, 150 Seer, 200 GM, 250 Admin)"); 
		gui_addPropField(twkChrMenu,250,210,125,30,CP_PRIVLEVEL);
		
		//is CNS/GM, 15/16/17
		new checker2=0;
		new checker3=0;
		printf("true GM: %d", chr_isTrueGM(target));
		if(chr_getProperty( target, CP_PRIV)&PRIV_ISCOUNSELOR == 128) //is CNS
			checker=1;
		else if(chr_getProperty( target, CP_PRIV)&PRIV_ISGM == 1) //is GM
			checker2=1;
		else
			checker3=1; //player
		gui_addText(twkChrMenu,66,250,1310,"Is/Make");
		gui_addText(twkChrMenu,140,250,0,"CNS");
		gui_addRadioButton( twkChrMenu,180,253, oldpic,newpic,checker,15);
		gui_addText(twkChrMenu,216,250,0,"GM");
		gui_addRadioButton( twkChrMenu,256,253, oldpic,newpic,checker2,16);
		gui_addText(twkChrMenu,292,250,0,"Player");
		gui_addRadioButton( twkChrMenu,337,253, oldpic,newpic,checker3,17);
		checker=0;

		//pageable as GM, 18
		printf("pageable: %d", chr_getProperty( target, CP_PRIV, _)&PRIV_GMPAGEABLE);
		if(chr_getProperty( target, CP_PRIV, _)&PRIV_GMPAGEABLE == 32) //can be paged
		{
			checker = 1;
		}
		gui_addText(twkChrMenu,66,270,1310,"pageable as GM :");
		gui_addCheckbox( twkChrMenu,200,273, oldpic,newpic,checker,18);
		checker=0;

		//Defense, 19
		gui_addGump(twkChrMenu,50,290, 0x827);
		gui_addText(twkChrMenu,66,290,1310,"Defense :");
		gui_addPropField(twkChrMenu,190,290,125,30,CP_DEF);
		
		//Dispellable, 20
		if(chr_getProperty( target, CP_PRIV2, _)&0x20 == 32) //can dispel
		{
			checker = 1;
		}
		gui_addCheckbox( twkChrMenu,190,313, oldpic,newpic,checker,20);
		gui_addText(twkChrMenu,66,310,1310,"Can dispel :");
		checker=0;

		//Hunger, 21
		gui_addGump(twkChrMenu,50,330, 0x827);
		gui_addText(twkChrMenu,66,330,1310,"Hunger :");
		gui_addPropField(twkChrMenu,190,330,125,30,CP_HUNGER);
		
		//Jailed, 22
		gui_addGump(twkChrMenu,50,350, 0x827);
		//gui_addPropField(twkChrMenu,190,350,125,30,CP_JAILED);
		gui_addText(twkChrMenu,66,350,1310,"Is jailed :");
		
		//Needs Mana, 23
		if(chr_getProperty( target, CP_PRIV2, _)&0x10 == 16) //needs no mana
		{
			checker = 1;
		}
		gui_addCheckbox( twkChrMenu,190,373, oldpic,newpic,checker,23);
		gui_addText(twkChrMenu,66,370,1310,"Needs no mana :");
		checker=0;

		//Needs Reagents, 24
		if(chr_getProperty( target, CP_PRIV2, _)&0x80 == 128) //needs no reagents
		{
			checker = 1;
		}
		gui_addCheckbox( twkChrMenu,190,393, oldpic,newpic,checker,24);
		gui_addText(twkChrMenu,66,390,1310,"Needs no reagents :");
		checker=0;

		//Sees serials, 25
		if(chr_getProperty( target, CP_PRIV, _)&0x08 == 8) //can see serials at single click
		{
			checker = 1;
		}
		gui_addCheckbox( twkChrMenu,190,413, oldpic,newpic,checker,25);
		gui_addText(twkChrMenu,66,410,1310,"Can see serials :");
		checker=0;

		//Shows no skilltitle, 26
		if(chr_getProperty( target, CP_PRIV, _)&0x10 == 16) //shows no skilltitle
		{
			checker = 1;
		}
		gui_addCheckbox( twkChrMenu,190,433, oldpic,newpic,checker,26);
		gui_addText(twkChrMenu,66,430,1310,"No skill title :");
		checker=0;

		//can snoop all, 27
		if(chr_getProperty( target, CP_PRIV, _)&0x40 == 64) //can snoop all
		{
			checker = 1;
		}
		gui_addCheckbox( twkChrMenu,470,173, oldpic,newpic,checker,27);
		gui_addText(twkChrMenu,340,170,1310,"Can snoop all :");
		checker=0;

		//Wander Mode, 28
		gui_addGump(twkChrMenu,317,190, 0x827);
		gui_addText(twkChrMenu,340,190,1310,"Wandermode :");
		gui_addPropField(twkChrMenu,470,190,125,30,CP_NPCWANDER);
	}
	gui_show(twkChrMenu,chrsource); 
}

public viewchrMenu(const chrsource, const target, const buttonCode)
{
	//printf("enter viewchrMenu, page: %d", buttonCode);
	switch(buttonCode)
	{
		case 1: tweak_char(chrsource, target, 1);
		case 2: tweak_char(chrsource, target, 2);
		case 3: tweak_char(chrsource, target, 3);
		case 4: tweak_char(chrsource, target, 4);
		case 5: tweak_char(chrsource, target, 5);
		case 6: tweak_char(chrsource, target, 6);
		case 7: tweak_char(chrsource, target, 7);
	}
}

public tweakchrBck1(const twkChrMenu, const chrsource, const buttonCode)
{
	new target = gui_getProperty( twkChrMenu,MP_BUFFER,1 ); //target
	switch(buttonCode)
	{
		case 1,2,3,4,5,6,7: 	
		{		viewchrMenu(chrsource, target, buttonCode);
				//gui_delete( twkChrMenu );
		}
		case 10:
		{
			        chr_update(target);
			        //gui_delete( twkChrMenu );
		}
	}
}

public tweakchrBck2(const twkChrMenu, const chrsource, const buttonCode)
{
	new target = gui_getProperty( twkChrMenu,MP_BUFFER,1 ); //target
	switch(buttonCode)
	{
		case 1,2,3,4,5,6,7:
		{
			viewchrMenu(chrsource, target, buttonCode);
			//gui_delete( twkChrMenu );
		}
		case 10:
		{
			chr_update(target);
		}
	}

}

public tweakchrBck3(const twkChrMenu, const chrsource, const buttonCode)
{
	new target = gui_getProperty( twkChrMenu,MP_BUFFER,1 ); //target
	//new textbuf[5];
	switch(buttonCode)
	{
		case 1,2,3,4,5,6,7:
		{
			viewchrMenu(chrsource, target, buttonCode);
			//gui_delete( twkChrMenu );
		}
		case 10:
		{
			new i;
			for(i=12; i <= 28;++i)
			{
				if(i==12)
				{
					if ( gui_getProperty(twkChrMenu,MP_CHECK,i) )
						chr_makeInvul(target);
					else	chr_makeVulnerable(target);
				}
				if(i==13)
				{
					if ( gui_getProperty(twkChrMenu,MP_CHECK,i) )
						chr_setHitPoints(target,0);
					else	chr_resurrect(target);
				}
				if(i==14)
				{
					if ( gui_getProperty(twkChrMenu,MP_CHECK,i) )
						chr_freeze(target);
					else	chr_unfreeze(target);
				}
				if(i==15 )
				{
					if ( gui_getProperty(twkChrMenu,MP_RADIO,15) ) //skill
					{
						chr_setProperty( target,CP_HIDDEN,_,1);
						chr_setProperty( target,CP_PRIV2,_, chr_getProperty( target,CP_PRIV2,_) &~0x08 ); //nicht mehr permahidden
					}
					else if ( gui_getProperty(twkChrMenu,MP_RADIO,16) ) //spell
					{
						chr_setProperty( target,CP_HIDDEN,_,2);
						chr_setProperty( target,CP_PRIV2,_, chr_getProperty( target,CP_PRIV2,_) &~0x08 ); //nicht mehr permahidden
					}
					else if ( gui_getProperty(twkChrMenu,MP_RADIO,17) ) //perma
					{
						chr_setProperty( target,CP_HIDDEN,_,2); //invis durch spell
						chr_setProperty( target,CP_PRIV2,_,chr_getProperty( target,CP_PRIV2) | PRIV2_PERMAHIDDEN); //wird permahidden
						//printf("perma: %d",(chr_getProperty( target,CP_PRIV2) & PRIV2_PERMAHIDDEN));
					}
					else //visible
					{
						chr_setProperty( target,CP_HIDDEN,_,0); //wird visible,da invisflag weggeklickt wurde
						chr_setProperty( target,CP_PRIV2,_, chr_getProperty( target,CP_PRIV2,_) &~0x08 ); //nicht mehr permahidden
					}
				}
				if(i==19) //war mode
				{ 
					//if( chr_getProperty( target,CP_WAR) == 0 )
					if ( gui_getProperty(twkChrMenu,MP_CHECK,19) )
						chr_setProperty( target,CP_WAR,1);
					else	chr_setProperty( target,CP_WAR,0);
				}
				if(i==20)  //nightsight
				{
					new textbuf_night[15];
					gui_getProperty(twkChrMenu,MP_UNI_TEXT,20,textbuf_night);
					if( strcmp( textbuf_night,"millisec" ) && gui_getProperty(twkChrMenu,MP_CHECK,i)) //Entry made and is nightsight activated
					{
						trim(textbuf_night);
						if (isStrUnsignedInt(textbuf_night))
						{
							new value;
							value = str2UnsignedInt(textbuf_night);
							if ( tempfx_isActive( target,TFX_SPELL_LIGHT) != 1 ) // no nightsight already
							{
								tempfx_activate( TFX_SPELL_LIGHT,target,target,0,value,-1); //puts lighlevel for char to daylightlevel
							}
						}
						else chr_message( chrsource, _,"A number must be inserted!");
					}
					else if( (tempfx_isActive( target,TFX_SPELL_LIGHT) == 1) && !(gui_getProperty(twkChrMenu,MP_CHECK,i)) ) // no Entry,is not activated and nightsight is active
					{
						tempfx_delete( target,TFX_SPELL_LIGHT,true); //no more nightsight
					}
				}
				if(i==21)  //magic reflect
				{
					if( gui_getProperty(twkChrMenu,MP_CHECK,i) ) //magic reflect is activated
						chr_setProperty( target, CP_PRIV2, _,  chr_getProperty( target, CP_PRIV2, _) | 0x40 ); //activate magic reflect
					else
						chr_setProperty( target, CP_PRIV2, _,  chr_getProperty( target, CP_PRIV2, _) & ~0x40 ); //disable
				}
				if(i==22)
				{
					if(gui_getProperty(twkChrMenu,MP_CHECK,i))
				            callPolyMenu(chrsource, target,1); //polymorph
					else if (!(gui_getProperty(twkChrMenu,MP_CHECK,i))&& (chr_getProperty( target,CP_ID)) != (chr_getProperty(target,CP_XID)))
				            chr_unmorph(target);
				}
				if(i==25) //house icon
				{
					if ( gui_getProperty(twkChrMenu,MP_CHECK,i) )
					        chr_setProperty( target,CP_PRIV2,_,chr_getProperty( target,CP_PRIV2,_) | PRIV2_VIEWHOUSESASICON ); //set 0 to 1
					else	chr_setProperty( target,CP_PRIV2,_,chr_getProperty( target,CP_PRIV2,_) &~PRIV2_VIEWHOUSESASICON ); //set 1 to 0
				}
				if(i==28)  //nightsight
				{
					new textbuf_lsd[15];
					gui_getProperty(twkChrMenu,MP_UNI_TEXT,i,textbuf_lsd);
					if( strcmp( textbuf_lsd,"millisec" ) && gui_getProperty(twkChrMenu,MP_CHECK,i)) //Entry made and is hallucination activated
					{
						trim(textbuf_lsd);
						if (isStrUnsignedInt(textbuf_lsd))
						{
							new value;
							value = str2UnsignedInt(textbuf_lsd);
							if ( tempfx_isActive( target,TFX_LSD) != 1 ) // no nightsight already
							{
								tempfx_activate( TFX_LSD,target,target,0,value,-1); //lets char hallucinate
							}
						}
						else chr_message( chrsource, _,"A number must be inserted!");
					}
					else if( (tempfx_isActive( target,TFX_LSD) == 1) && !(gui_getProperty(twkChrMenu,MP_CHECK,i)) ) // no Entry,is not activated and nightsight is active
					{
						tempfx_delete( target,TFX_LSD,true); //no more nightsight
					}
				}
			}//for
		}//case
		default: printf("unknown button");
	}//switch
	chr_update(target);
	//printf("buttonCode: %d",buttonCode);
}

public tweakchrBck4(const twkChrMenu, const chrsource, const buttonCode)
{
	new target = gui_getProperty( twkChrMenu,MP_BUFFER,1 ); //target
	switch(buttonCode)
	{
		case 1,2,3,4,5,6,7:
		{
			viewchrMenu(chrsource, target, buttonCode);
			//gui_delete( twkChrMenu );
		}
		case 10:
		{
			new itemSet=set_create();
			set_addItemWeared(itemSet,target,false,true,true);
			for (set_rewind(itemSet);!set_end(itemSet);)
			{
				new item = set_get(itemSet);
				new itemName[30];
				itm_getProperty(item,IP_STR_NAME,_,itemName);
				new layer= itm_getProperty(item,IP_LAYER);
				if ( layer <= 24)
				{
					if(!gui_getProperty(twkChrMenu,MP_CHECK,6+(layer-1)))
					{
						new bp = chr_getBackpack(target, true);
						itm_setContSerial(item, bp);
						itm_refresh(item);
					}
				}
			}
			set_delete( itemSet );
			chr_update(target);
		}
	}

}

public tweakchrBck5(const twkChrMenu, const chrsource, const buttonCode)
{
	new target = gui_getProperty( twkChrMenu,MP_BUFFER,1 ); //target
	
	switch(buttonCode)
	{
		case 1,2,3,4,5,6,7:
		{
			viewchrMenu(chrsource, target, buttonCode);
			//gui_delete( twkChrMenu );
		}
		case 10:
		{
			new i=0;
			new callname[15];
			new oldevent[15];
			for(i=0;i<NUM_chrevent;i++)
			{
				if ( !gui_getProperty(twkChrMenu,MP_CHECK,i+1)) //checkbox no more checked and event had existed
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
			chr_update(target);
		}//case
	}

}

public tweakchrBck6(const twkChrMenu, const chrsource, const buttonCode)
{
	new target = gui_getProperty( twkChrMenu,MP_BUFFER,1 ); //target
	new tempChrStr[15];
	
	switch(buttonCode)
	{
		case 1,2,3,4,5,6,7:
		{
			viewchrMenu(chrsource, target, buttonCode);
		}
		case 10:
		{
			new i;
			for(i=1000;i<5000;i++)
			{
				if (chr_isaLocalVar(target, i, VAR_TYPE_ANY))
				{
					if(!(gui_getProperty(twkChrMenu,MP_CHECK,i)))
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
					}
				}//if var test
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
					printf("tempChrStrB: %s, number: %d^n", tempChrStrB, number);
					if(!(chr_isaLocalVar(target, number, VAR_TYPE_ANY))) //already exist
					{
						gui_getProperty(twkChrMenu,MP_UNI_TEXT,6,inpt); //value
						trim(inpt);
						printf("value: %s^n", inpt);
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
					printf("tempChrStrB: %s, number: %d^n", tempChrStrB, number);
					if(!(chr_isaLocalVar(target, number, VAR_TYPE_ANY))) //already exist
					{
						gui_getProperty(twkChrMenu,MP_UNI_TEXT,6,inpt); //value
						printf("input: %s", inpt);
						chr_addLocalStrVar(target, number);
						chr_setLocalStrVar(target, number, inpt);
					}
					else
						chr_message(target, _, "This char has already a localVar with this value!");
				}
				else
					chr_message(target, _, "The localVar number must consist of 0-9, no letters or other signs!");
			}
		}//case
		default: printf("unknown button");
	}//switch
	chr_update(target);
}

public tweakchrBck7(const twkChrMenu, const chrsource, const buttonCode)
{
	new target = gui_getProperty( twkChrMenu,MP_BUFFER,1 ); //target
	//new textbuf[5];
	switch(buttonCode)
	{
		case 1,2,3,4,5,6,7:
		{
			viewchrMenu(chrsource, target, buttonCode);
			//gui_delete( twkChrMenu );
		}
		case 10:
		{
			new i;
			for(i=12; i <= 28;++i)
			{
				if(i==12)
				{
					if(gui_getProperty(twkChrMenu,MP_CHECK,i))
						chr_setProperty( target, CP_PRIV2, _, chr_getProperty(target,CP_PRIV2) | PRIV2_ALLMOVE);
					else
						chr_setProperty( target, CP_PRIV2, _, chr_getProperty(target,CP_PRIV2) &~ PRIV2_ALLMOVE);
				}
				else if(i==13) //Can broadcast
				{
					if(gui_getProperty(twkChrMenu,MP_CHECK,i))
						chr_setProperty( target, CP_PRIV, _,  chr_getProperty( target, CP_PRIV) | PRIV_CANBROADCAST );
					else
						chr_setProperty( target, CP_PRIV, _,  chr_getProperty( target, CP_PRIV) &~PRIV_CANBROADCAST );
				}
				else if(i==15) //is CNS/GM/player
				{
					if ( gui_getProperty(twkChrMenu,MP_RADIO,15) ) //CNS
					{
						chr_setProperty( target,CP_PRIV,_, chr_getProperty( target,CP_PRIV) | 0x80 );
						chr_setProperty( target,CP_PRIV,_, chr_getProperty( target,CP_PRIV) &~0x01 ); //is no GM
					}
					else if ( gui_getProperty(twkChrMenu,MP_RADIO,16) ) //GM
					{
						chr_setProperty( target,CP_PRIV,_, chr_getProperty( target,CP_PRIV) &~ 0x80 );
						chr_setProperty( target,CP_PRIV,_, chr_getProperty( target,CP_PRIV) | 0x01 ); //is GM
					}
					else
					{
						chr_setProperty( target,CP_PRIV,_, chr_getProperty( target,CP_PRIV) &~0x80 ); //is no CNS
						chr_setProperty( target,CP_PRIV,_, chr_getProperty( target,CP_PRIV) &~0x01 ); //is no GM
					}
				}
				else if(i==18) //pageable as GM, 18
				{
					if( gui_getProperty(twkChrMenu,MP_CHECK,i) )
						chr_setProperty( target, CP_PRIV,_, chr_getProperty( target, CP_PRIV) | PRIV_GMPAGEABLE );
					else
						chr_setProperty( target, CP_PRIV,_,  chr_getProperty( target, CP_PRIV) & ~PRIV_GMPAGEABLE );
				}
				else if(i==20) //Dispellable, 20
				{
					if(gui_getProperty(twkChrMenu,MP_CHECK,i))
						chr_setProperty( target, CP_PRIV2, _,  chr_getProperty( target, CP_PRIV2, _) | 0x20 );
					else
						chr_setProperty( target, CP_PRIV2, _,  chr_getProperty( target, CP_PRIV2, _) & ~0x20 );
			
				} 
				else if(i==23) //Needs no Mana, 23
				{
					if(gui_getProperty(twkChrMenu,MP_CHECK,i))
						chr_setProperty( target, CP_PRIV2, _,  chr_getProperty( target, CP_PRIV2, _) | 0x10 );
					else
						chr_setProperty( target, CP_PRIV2, _,  chr_getProperty( target, CP_PRIV2, _) & ~0x10 );
				}
				else if(i==24) //Needs no Reagents, 24
				{
					if(gui_getProperty(twkChrMenu,MP_CHECK,i))
						chr_setProperty( target, CP_PRIV2, _,  chr_getProperty( target, CP_PRIV2, _) | 0x80 );
					else
						chr_setProperty( target, CP_PRIV2, _,  chr_getProperty( target, CP_PRIV2, _) & ~0x80 );
				}
				else if(i==25) //Sees serials, 25
				{
					if(gui_getProperty(twkChrMenu,MP_CHECK,i))
						chr_setProperty( target, CP_PRIV, _,  chr_getProperty( target, CP_PRIV, _) | 0x08 );
					else
						chr_setProperty( target, CP_PRIV, _,  chr_getProperty( target, CP_PRIV, _) & ~0x08 );
				}
				else if(i==26) //Shows no skilltitle, 26
				{
					if(gui_getProperty(twkChrMenu,MP_CHECK,i))
						chr_setProperty( target, CP_PRIV, _,  chr_getProperty( target, CP_PRIV, _) | 0x10 );
					else
						chr_setProperty( target, CP_PRIV, _,  chr_getProperty( target, CP_PRIV, _) & ~0x10 );
				}
				else if(i==27)
				{
					if(gui_getProperty(twkChrMenu,MP_CHECK,i))
						chr_setProperty( target, CP_PRIV, _,  chr_getProperty( target, CP_PRIV, _) | 0x40 );
					else
						chr_setProperty( target, CP_PRIV, _,  chr_getProperty( target, CP_PRIV, _) & ~0x40 );
				}//if
			}//for
		}//case
		default: printf("unknown button");
	}//switch
	chr_update(target);
}

/*! }@ */