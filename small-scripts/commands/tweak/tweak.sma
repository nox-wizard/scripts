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

const BUTTON_APPLY=11
const twkpages=7; //one line for one page, two rows for one page
const NUM_chrevent = 38;
//const textbuf[10] = "");
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

enum event_prop
{
eventname: 23,
eventnum
};

static event_array[NUM_chrevent][event_prop] = {
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
	if ( target < 0)
	{
		chr_message( chrsource, _,"Select a char or item,please");
		return;
	}
	if ( isChar(target)) //is npc/char
	        tweak_char(chrsource,target, 1);
	else if ( isItem(target))
		callItemMenu(chrsource,target, 1);
}

public tweak_char(const chrsource, const target, pagenumber)
{
	new tempStr[100];
	new tweak_cllbck[15];
	sprintf( tweak_cllbck,"tweakBck%d",pagenumber);
	//printf("tweak_cllbck: %s", tweak_cllbck);
	new twkMenu = gui_create( 10,10,1,1,1,tweak_cllbck );

	gui_setProperty( twkMenu,MP_BUFFER,0,PROP_CHARACTER );
	gui_setProperty( twkMenu,MP_BUFFER,1,target );
	gui_setProperty( twkMenu,MP_BUFFER,3,BUTTON_APPLY );

	gui_addPage(twkMenu,0);
	gui_addResizeGump(twkMenu,10,35,5054,550,530 );
	gui_addResizeGump(twkMenu,20,105,3500,530,455);
	gui_addResizeGump(twkMenu,25,49,5100,525,51);

	gui_addText(twkMenu,250,32,1210,"Tweak Menue");
	gui_addButton( twkMenu,460,525, 0x084A, 0x084B,BUTTON_APPLY );
	gui_addPage(twkMenu,1);
	new arrayline = pagenumber-1;
	gui_addButton(twkMenu,35,51,twkButton[arrayline][new1],twkButton[arrayline][old1],1);
	gui_addText(twkMenu,60,49,33,"Main infos");
	gui_addButton(twkMenu,170,51,twkButton[arrayline][new2],twkButton[arrayline][old2],2);
	gui_addText(twkMenu,195,49,33,"Skills");
	gui_addButton(twkMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
	gui_addText(twkMenu,285,49,33,"Flags");
	gui_addButton(twkMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
	gui_addText(twkMenu,380,49,33,"Layer");
	gui_addButton(twkMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
	gui_addText(twkMenu,470,49,33,"Events");
	gui_addButton(twkMenu,35,81,twkButton[arrayline][new6],twkButton[arrayline][old6],6);
	gui_addText(twkMenu,60,79,33,"LocalVars");
	gui_addButton(twkMenu,170,81,twkButton[arrayline][new7],twkButton[arrayline][old7],7);
	gui_addText(twkMenu,195,79,33,"Flags 2");

	gui_addText(twkMenu,66,120,33,"Account number :");
	sprintf( tempStr,"%d",chr_getProperty(target,CP_ACCOUNT));
	gui_addText( twkMenu, 185, 120,0,tempStr);

	gui_addText(twkMenu,280,120,33,"Serial :");
	sprintf( tempStr,"%d",chr_getProperty(target,CP_SERIAL));
	gui_addText( twkMenu, 336, 120,0,tempStr);

	gui_addGump(twkMenu,430,121, 0x827);
	gui_addText(twkMenu,451,120,33,"NPC-AI:");
	gui_addPropField( twkMenu,515,120,50,30,CP_NPCAI);

	if( pagenumber == 1)
	{
		gui_addText(twkMenu,230,150,33,"Main info");

		gui_addGump(twkMenu,50,181, 0x827);
		gui_addText(twkMenu,66,180,1310,"eventname :");
		gui_addPropField( twkMenu, 130, 180,150,30,CP_STR_NAME);

		gui_addGump(twkMenu,50,201, 0x827);
		gui_addText(twkMenu,66,200,1310,"Title:");
		gui_addPropField( twkMenu, 130, 200,150,30,CP_STR_TITLE);

		gui_addGump(twkMenu,50,221, 0x827);
		gui_addText(twkMenu,66,220,1310,"Karma:");
		gui_addPropField( twkMenu, 130, 220,150,30,CP_KARMA);

		gui_addGump(twkMenu,50,241, 0x827);
		gui_addText(twkMenu,66,240,1310,"Fame :");
		gui_addPropField( twkMenu, 130, 240,150,30,CP_FAME);

		gui_addGump(twkMenu,50,261, 0x827);
		gui_addText(twkMenu,66,260,1310,"Strength :");
		gui_addPropField( twkMenu, 130, 260,150,30,CP_STRENGTH,CP2_STR);

		gui_addGump(twkMenu,50,281, 0x827);
		gui_addText(twkMenu,66,280,1310,"Hits :");
		gui_addPropField( twkMenu, 130, 280,150,30,CP_STRENGTH,CP2_HITPOINTS);

		gui_addGump(twkMenu,50,301, 0x827);
		gui_addText(twkMenu,66,300,1310,"Dex :");
		gui_addPropField( twkMenu, 130, 300,150,30,CP_DEXTERITY,CP2_DEX);

		gui_addGump(twkMenu,50,321, 0x827);
		gui_addText(twkMenu,66,320,1310,"Stamina:");
		gui_addPropField( twkMenu, 130, 320,150,30,CP_DEXTERITY,CP2_STAMINA);

		gui_addGump(twkMenu,50,341, 0x827);
		gui_addText(twkMenu,66,340,1310,"Int :");
		gui_addPropField( twkMenu, 130, 340,150,30,CP_INTELLIGENCE,CP2_INT);

		gui_addGump(twkMenu,50,361, 0x827);
		gui_addText(twkMenu,66,360,1310,"Mana :");
		gui_addPropField( twkMenu, 130, 360,150,30,CP_INTELLIGENCE,CP2_MANA);

		gui_addGump(twkMenu,50,381, 0x827);
		gui_addText(twkMenu,66,380,1310,"Kills :");
		gui_addPropField( twkMenu, 130, 380,150,30,CP_KILLS);

		gui_addGump(twkMenu,50,401, 0x827);
		gui_addText(twkMenu,66,400,1310,"Food Pos. :");
		gui_addPropField( twkMenu, 130, 400,150,30,CP_FOODPOSITION);

		gui_addText(twkMenu,66,420,1310,"Weight:");
		sprintf( tempStr,"%d",chr_getProperty( target,CP_WEIGHT));
		gui_addText( twkMenu, 130, 420,0,tempStr);
		//gui_addPropField( twkMenu, 130, 420,150,30,CP_WEIGHT);

		gui_addText(twkMenu,270,180,1310,"Summ Skills :"); // Skillsumme
		new i;
		new skillsum;
		for (i=0;i<49;++i)
		{
			skillsum=skillsum+chr_getProperty(target,CP_BASESKILL,i);
		}
		new skillsumStr[10];
		sprintf(skillsumStr,"%d",skillsum);
		gui_addText(twkMenu,420,180,0,skillsumStr);

		gui_addText(twkMenu,270,200,1310,"Gold bankbox :"); //Gold
		sprintf( tempStr,"%d",chr_countBankGold(target));
		gui_addText( twkMenu, 420, 200,0,tempStr);

		gui_addText(twkMenu,270,220,1310,"bankbox open");
		gui_addButton(twkMenu,420,220,2224,2117,11);
		gui_addGump(twkMenu,254,241, 0x827);

		gui_addText(twkMenu,270,240,1310,"Body color :");
		gui_addPropField( twkMenu, 420, 240,150,30,CP_SKIN); // Color

		gui_addGump(twkMenu,254,261, 0x827);
		gui_addText(twkMenu,270,260,1310,"Body oskin :");
		gui_addPropField( twkMenu, 420, 260,150,30,CP_XSKIN);

		gui_addGump(twkMenu,254,281, 0x827);
		gui_addText(twkMenu,270,280,1310,"ID :");
		gui_addPropField( twkMenu, 420, 280,150,30,CP_ID);

		gui_addGump(twkMenu,254,321, 0x827);
		gui_addText(twkMenu,270,300,1310,"O Body :");
		gui_addPropField( twkMenu, 420, 300,150,30,CP_XID);

		gui_addGump(twkMenu,254,301, 0x827);
		gui_addText(twkMenu,270,320,1310,"Script :");
		gui_addPropField( twkMenu, 420, 320,150,30,CP_SCRIPTID);

		gui_addGump(twkMenu,254,341, 0x827);
		gui_addText(twkMenu,270,340,1310,"Action (Skill) :");
		gui_addPropField( twkMenu, 420, 340,150,30,CP_MAKING);

		gui_addGump(twkMenu,254,361, 0x827);
		gui_addText(twkMenu,270,360,1310,"Position :");
		gui_addPropField( twkMenu, 390, 360,150,30,CP_POSITION,CP2_X);
		gui_addPropField( twkMenu, 440, 360,150,30,CP_POSITION,CP2_Y);
		gui_addPropField( twkMenu, 490, 360,150,30,CP_POSITION,CP2_Z);

		gui_addGump(twkMenu,254,381, 0x827);
		gui_addText(twkMenu,270,380,1310,"Workposition :");
		gui_addPropField( twkMenu, 390, 380,150,30,CP_POSITION,CP2_X);
		gui_addPropField( twkMenu, 440, 380,150,30,CP_POSITION,CP2_Y);
		gui_addPropField( twkMenu, 490, 380,150,30,CP_POSITION,CP2_Z);

		gui_addText(twkMenu,270,400,1310,"Script ID:");
		sprintf( tempStr,"%d",chr_getProperty(target,CP_SCRIPTID));

		gui_addText(twkMenu,66,460,1310,"guild eventname :");
		if ( chr_getGuild(target) >= 0 )
			guild_getProperty( chr_getGuild(target),GP_STR_NAME,_,0,tempStr );
		else	tempStr="Keine";
		gui_addText( twkMenu, 200, 460,0,tempStr);

		gui_addText(twkMenu,66,480,1310,"guild master :");
		gui_addText(twkMenu,200,480,0,"Not yet available");
		gui_addText(twkMenu,66,500,1310,"Go to guild");

		gui_addText(twkMenu,66,520,1310,"Char since");
		new age=chr_getProperty(target,CP_CREATIONDAY);
		if ( age > 0 )
		{	new year=cal_getRealYear(age);
			new dayInYear=cal_getDayInYear(age);
			new month=cal_getRealMonth(dayInYear,year);
			new day=cal_getDayInMonth(dayInYear,year);
			sprintf( tempStr,"%d/%d/%d ",day,month,year);
		}
		else	tempStr="--------";
		gui_addText( twkMenu, 180, 520,0,tempStr);
		gui_addText(twkMenu,270,520,1310,"existent");

		//gui_addText(twkMenu,270,420,1310,"Rewardpoints");
		//printf("test gui, twkMenu: %d^n", twkMenu);
	}
	else if(pagenumber ==2)
	{
		gui_addText(twkMenu,100,150,33,"Miscellaneous");
		new miscSkills[21]={ SK_ALCHEMY,SK_BLACKSMITHING,SK_BOWCRAFT,SK_CARPENTRY,SK_COOKING,SK_FISHING,SK_HEALING,SK_HERDING,SK_LOCKPICKING,SK_LUMBERJACKING,SK_MAGERY,SK_MEDITATION,SK_MINING,SK_MUSICIANSHIP,SK_REMOVETRAPS,	SK_MAGICRESISTANCE,SK_SNOOPING,SK_STEALING,SK_TAILORING,SK_TINKERING,SK_VETERINARY};
		for ( new i=0;i<13;++i)
		{
			gui_addGump(twkMenu,50,171+20*i, 0x827);
			gui_addText( twkMenu,66,170+20*i,1310,"%s : ",skillName[ miscSkills[i] ] );
			gui_addPropField( twkMenu,190,170+20*i,50,30,CP_BASESKILL,miscSkills[i],0 );
		}
		for ( new i=13;i<21;++i)
		{
			gui_addGump(twkMenu,321,171+20*(i-13), 0x827);
			gui_addText( twkMenu,335,170+20*(i-13),1310,"%s : ",skillName[ miscSkills[i] ] );
			gui_addPropField( twkMenu,470,170+20*(i-13),50,30,CP_BASESKILL,miscSkills[i],0 );
		}

		gui_addText(twkMenu,130,490,1310,"Skill Page 2 (Combat Ratings,Actions,Lore Knowledge)");
		gui_addPageButton(twkMenu,100,493,2224,2117,2);

		gui_addPage(twkMenu,2);
		gui_addPageButton(twkMenu,100,493,2224,2117,1);
		gui_addText(twkMenu,130,490,1310,"Skill Page 1 (Miscellaneous)");

		gui_addButton(twkMenu,35,51,twkButton[arrayline][new1],twkButton[arrayline][old1],1);
		gui_addText(twkMenu,60,49,33,"Main infos");
		gui_addButton(twkMenu,170,51,twkButton[arrayline][new2],twkButton[arrayline][old2],2);
		gui_addText(twkMenu,195,49,33,"Skills");
		gui_addButton(twkMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
		gui_addText(twkMenu,285,49,33,"Flags");
		gui_addButton(twkMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
		gui_addText(twkMenu,380,49,33,"Layer");
		gui_addButton(twkMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
		gui_addText(twkMenu,470,49,33,"Events");
		gui_addButton(twkMenu,35,81,twkButton[arrayline][new6],twkButton[arrayline][old6],6);
		gui_addText(twkMenu,60,79,33,"LocalVars");
		gui_addButton(twkMenu,170,81,twkButton[arrayline][new7],twkButton[arrayline][old7],7);
		gui_addText(twkMenu,195,79,33,"Flags 2");

		gui_addText(twkMenu,66,120,33,"Account number :");
		sprintf( tempStr,"%d",chr_getProperty(target,CP_ACCOUNT));
		gui_addText( twkMenu, 185, 120,0,tempStr);

		gui_addText(twkMenu,280,120,33,"Serial :");
		sprintf( tempStr,"%d",chr_getProperty(target,CP_SERIAL));
		gui_addText( twkMenu, 336, 120,0,tempStr);

		gui_addGump(twkMenu,430,121, 0x827);
		gui_addText(twkMenu,451,120,33,"NPC-AI:");
		gui_addPropField( twkMenu,515,120,50,30,CP_NPCAI);

		gui_addText(twkMenu,100,150,33,"Combat Ratings");
		new combatSkills[8]={ SK_ARCHERY,SK_FENCING,SK_MACEFIGHTING,SK_PARRYING,SK_SWORDSMANSHIP,SK_TACTICS,SK_WRESTLING};
		for ( new i=0;i<8;++i)
		{
			gui_addGump(twkMenu,50,171+20*i, 0x827);
			gui_addText( twkMenu,66,170+20*i,1310,"%s : ",skillName[ combatSkills[i] ] );
			gui_addPropField( twkMenu,190,170+20*i,50,30,CP_BASESKILL,combatSkills[i],0 );
		}
		gui_addText(twkMenu,100,335,33,"Actions");
		new actionSkills[13]={ SK_TAMING,SK_BEGGING,SK_CAMPING,SK_CARTOGRAPHY,SK_DETECTINGHIDDEN,SK_ENTICEMENT,	SK_HIDING,SK_INSCRIPTION,SK_PEACEMAKING,SK_POISONING,SK_PROVOCATION,SK_SPIRITSPEAK,SK_TRACKING};
		for ( new i=0;i<7;++i)
		{
			gui_addGump(twkMenu,50,351+20*i, 0x827);
			gui_addText( twkMenu,66,350+20*i,1310,"%s : ",skillName[ actionSkills[i] ] );
			gui_addPropField( twkMenu,190,350+20*i,50,30,CP_BASESKILL,actionSkills[i],0 );
		}
		for ( new i=7;i<13;++i)
		{
			gui_addGump(twkMenu,321,171+20*(i-7), 0x827);
			gui_addText( twkMenu,335,170+20*(i-7),1310,"%s : ",skillName[ actionSkills[i] ] );
			gui_addPropField( twkMenu,470,170+20*(i-7),50,30,CP_BASESKILL,actionSkills[i],0 );
		}
		gui_addText(twkMenu,361,300,33,"Lore & Knowledge");
		new loreSkills[7]={ SK_ANATOMY,SK_ANIMALLORE,SK_ARMSLORE,SK_EVALUATINGINTEL,SK_FORENSICS,SK_ITEMID,SK_TASTEID};
		for ( new i=0;i<7;++i)
		{
			gui_addGump(twkMenu,321,321+20*i, 0x827);
			gui_addText( twkMenu,335,320+20*i,1310,"%s : ",skillName[ loreSkills[i] ] );
			gui_addPropField( twkMenu,470,320+20*i,50,30,CP_BASESKILL,loreSkills[i],0 );
		}
		printf("test gui, twkMenu: %d^n", twkMenu);
	}
	else if(pagenumber == 3)
	{
		new checklev = 0;
		new poisonText[5][10]={"None","Lightly","Normal","Heavy","Deadly"};
		gui_addText(twkMenu,100,150,33,"Flags");

		//Invul
		if(chr_isInvul(target) == 1) //invul
		      checklev = 1;
		gui_addCheckbox( twkMenu,190,173, oldpic,newpic,checklev,12);
		gui_addText(twkMenu,66,170,1310,"Invulnerable :");
		checklev=0;

		// Dead
		if(chr_getProperty(target,CP_DEAD) == 1) //tot
		       checklev = 1;
		gui_addText(twkMenu,66,190,1310,"Dead :");
		gui_addCheckbox( twkMenu,190,193, oldpic,newpic,checklev,13);
		checklev=0;

		//Freeze
		if((chr_getProperty(target,CP_PRIV2)&0x02) == 2) //eingefroren
		       checklev = 1;
		gui_addCheckbox( twkMenu,190,213, oldpic,newpic,checklev,14);
		gui_addText(twkMenu,66,210,1310,"Frozen :");
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
		gui_addText(twkMenu,66,230,1310,"Invisible");
		gui_addText(twkMenu,66,245,1310,"  by:");
		gui_addText(twkMenu,140,237,0,"Skill");
		gui_addRadioButton( twkMenu,180,240, oldpic,newpic,checklev,15);
		gui_addText(twkMenu,216,237,0,"Spell");
		gui_addRadioButton( twkMenu,256,240, oldpic,newpic,checklev2,16);
		gui_addText(twkMenu,292,237,0,"Perma");
		gui_addRadioButton( twkMenu,337,240, oldpic,newpic,checklev3,17);
		gui_addText(twkMenu,370,237,0,"Visible");
		gui_addRadioButton( twkMenu,427,240, oldpic,newpic,checklev4,18);
		checklev=0;

		// gui_addButton(twkMenu,43,253,2224,2117,10);
		// gui_addText(twkMenu,66,250,1310,"Sleeping :");
		// gui_addText(twkMenu,190,250,1110,"<eval (<src.targ.flags>&010)==010>");

		//Warmode
		if(chr_getProperty(target,CP_WAR) == 1) //Warmode
		        checklev = 1;
		gui_addText(twkMenu,66,270,1310,"Warmode :");
		gui_addCheckbox( twkMenu,190,270,oldpic,newpic,checklev,19);
		checklev=0;

		gui_addText(twkMenu,66,290,1310,"Reactive Armor :");
		sprintf( tempStr,"%d",tempfx_isActive( target,TFX_SPELL_REACTARMOR));
		gui_addText(twkMenu,190,290,1110,tempStr);

		//Poison
		gui_addGump(twkMenu,50,310, 0x827);
		gui_addText(twkMenu,66,310,1310,"Poisoned :");
		gui_addPropField( twkMenu,190,310,125,30,CP_POISONED,_,1110);

		gui_addGump(twkMenu,50,330, 0x827);
		gui_addText( twkMenu,66,330,1310,"NPC Poison Attack: ");
		gui_addPropField( twkMenu,190,330,125,30,CP_POISON,_,1110);

		gui_addGump(twkMenu,50,350, 0x827);
		gui_addText( twkMenu,66,350,1310,"Poison Time : ");
		gui_addPropField(twkMenu,190,350,125,30,CP_POISONWEAROFFTIME,_,1110);

		gui_addGump(twkMenu,50,370, 0x827);
		gui_addText( twkMenu,66,370,1310,"Direction : ");
		gui_addPropField(twkMenu,190,370,125,30,CP_DIR,_,1110 );

		//Nightsight
		gui_addGump(twkMenu,50,390, 0x827);
		if(tempfx_isActive( target,TFX_SPELL_LIGHT) == 1) //Nightsight
		       checklev = 1;
		gui_addText(twkMenu,66,390,1310,"Nightsight:");
		gui_addInputField( twkMenu,190,390,50,20,20,1110,"millisec");
		gui_addCheckbox( twkMenu,265,393,oldpic,newpic,checklev,20);
		checklev=0;

		//Magic Reflect
		if(chr_getProperty( target, CP_PRIV2, _)&0x40 == 40) //Magic Reflection
		       checklev = 1;
		gui_addText(twkMenu,66,410,1310,"Magic Reflect :");
		gui_addCheckbox( twkMenu,190,413,oldpic,newpic,checklev,21);
		checklev=0;

		//Polymorph
		if( (chr_getProperty( target,CP_ID)) != (chr_getProperty(target,CP_XID))) //if(chr_getProperty( target,CP_POLYMORPH) == 1) //polymorphed
		       checklev = 1;
		gui_addText(twkMenu,66,430,1310,"Polymorph:");
		gui_addCheckbox( twkMenu,265,430, oldpic,newpic,checklev,22);
		checklev = 0;

		gui_addButton(twkMenu,43,453,2224,2117,23);
		gui_addText(twkMenu,66,450,1310,"Incognito :");
		sprintf( tempStr,"%d",tempfx_isActive( target,TFX_SPELL_INCOGNITO));
		gui_addText(twkMenu,190,450,1110,tempStr);

		gui_addButton(twkMenu,317,173,2224,2117,24);
		gui_addText(twkMenu,340,170,1310,"Has Shield :");
		if ( chr_getShield(target) > 0 )
		        sprintf( tempStr,"1" );
		else    sprintf( tempStr,"0");
		gui_addText(twkMenu,470,170,1110,tempStr);

		//Hausicons
		if(chr_getProperty(target,CP_PRIV2)&PRIV2_VIEWHOUSESASICON == 4 ) //Icon
		      checklev = 1;
		gui_addText(twkMenu,340,190,1310,"House as icons :");
		gui_addCheckbox( twkMenu,470,193,oldpic,newpic,checklev,25);
		checklev=0;

		//26
		gui_addGump(twkMenu,317,210, 0x827);
		gui_addText(twkMenu,340,210,1310,"Steps to fly :");
		gui_addPropField(twkMenu,470,210,125,30,CP_FLY_STEPS );

		gui_addButton(twkMenu,317,273,2224,2117,27);
		gui_addText(twkMenu,340,270,1310,"Respawn :");
		gui_addText(twkMenu,470,270,1110,"Respawn N/A");

		//Hallucination
		if(tempfx_isActive( target,TFX_LSD)) //LSD on
		      checklev = 1;
		gui_addText(twkMenu,340,290,1310,"Hallucinating :");
		gui_addInputField( twkMenu,470,290,50,20,28,1110,"millisec");
		gui_addCheckbox( twkMenu,535,293,oldpic,newpic,checklev,28);
		checklev=0;

		/*sprintf( tempStr,"%d",chr_getProperty(target,CP_HIDDEN);
		gui_addButton(twkMenu,317,313,2224,2117,29);
		gui_addText(twkMenu,340,310,1310,"Hidden :");
		gui_addText(twkMenu,470,310,1110,tempStr);*/

		gui_addButton(twkMenu,317,333,2224,2117,29);
		gui_addText(twkMenu,340,330,1310,"Indoors :");
		gui_addText(twkMenu,470,330,1110,"N/A");

		gui_addButton(twkMenu,317,353,2224,2117,29);
		gui_addText(twkMenu,340,350,1310,"Criminal :");
		sprintf( tempStr,"%d",chr_getProperty(target,CP_CRIMINALFLAG));
		gui_addText(twkMenu,470,350,1110,tempStr);

		gui_addButton(twkMenu,317,373,2224,2117,30);
		gui_addText(twkMenu,340,370,1310,"Conjured :");
		sprintf( tempStr,"%d",chr_getProperty(target,CP_SUMMONTIMER));
		gui_addText(twkMenu,470,370,1110,tempStr);

		gui_addButton(twkMenu,317,393,2224,2117, 31);
		gui_addText(twkMenu,340,390,1310,"Pet :");
		sprintf( tempStr,"%d",chr_getProperty(target,CP_TAMED));
		gui_addText(twkMenu,470,390,1110,tempStr);

		gui_addButton(twkMenu,317,413,2224,2117,32);
		gui_addText(twkMenu,340,410,1310,"Spawned :");
		sprintf( tempStr,"%d",chr_getProperty(target,CP_SPAWNSERIAL));
		gui_addText(twkMenu,470,410,1110,tempStr);

		gui_addButton(twkMenu,317,433,2224,2117,33);
		gui_addText(twkMenu,340,430,1310,"On Horse :");
		sprintf( tempStr,"%d",chr_getProperty(target,CP_ONHORSE));
		gui_addText(twkMenu,470,430,1110,tempStr);

		printf("test gui, twkMenu: %d^n", twkMenu);
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

		//gui_addText(twkMenu,50,150,1110,"Layer");
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
					gui_addTilePic(twkMenu,40+(layer-1)*40,150,itm_getProperty(item,IP_ID));
					gui_addCheckbox(twkMenu,43,243+(layer-1)*20, oldpic, newpic, 1, 6+(layer-1));
					gui_addText(twkMenu,66,240+(layer-1)*20,0,layerText[layer-1]);
					gui_addText(twkMenu,140,240+(layer-1)*20,1310,itemName);
				}
				else
				{
					gui_addTilePic(twkMenu,(layer-12)*40,190,itm_getProperty(item,IP_ID));
					gui_addCheckbox(twkMenu,317,203+(layer-11)*20, oldpic, newpic, 1, 6+(layer-1));
					gui_addText(twkMenu,340,200+(layer-11)*20,0,layerText[layer-1]);
					gui_addText(twkMenu,420,200+(layer-11)*20,1310,itemName);
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
					gui_addCheckbox(twkMenu,43,243+(i-1)*20, oldpic, newpic, 0, 6+(i-1));
					gui_addText(twkMenu,66,240+(i-1)*20,0,layerText[i-1]);
					gui_addText(twkMenu,140,240+(i-1)*20,1310,"Nothing");
				}
				else
				{
					gui_addCheckbox(twkMenu,317,203+(i-11)*20, oldpic, newpic, 0, 6+(i-1));
					gui_addText(twkMenu,340,200+(i-11)*20,0,layerText[i-1]);
					gui_addText(twkMenu,420,200+(i-11)*20,1310,"Nothing");
				}
			}
		}
		//printf("test gui, twkMenu: %d^n", twkMenu);
	}
	else if(pagenumber == 5)
	{
		gui_addPageButton(twkMenu,210,493,2224,2117,2);
		gui_addText(twkMenu,240,490,1310,"Events 2");
		gui_addPageButton(twkMenu,320,493,2224,2117,3);
		gui_addText(twkMenu,350,490,1310,"Events 3");

		gui_addText(twkMenu,50,150,1310,"Events 1");
		new i;
		for ( i=0;i <= 15;++i)
		{
			gui_addGump(twkMenu,50,173+(i*20), 0x827);
			gui_addText(twkMenu,66,170+(i*20),1310,event_array[i][eventname]);
			chr_getEventHandler(target,event_array[i][eventnum],tempStr);
			gui_addInputField( twkMenu,220,170+(i*20),150,20,i+1,0,tempStr);
			gui_addCheckbox( twkMenu, 200, 173+(i*20), oldpic, newpic, 1, i+1 );
		}

		gui_addPage(twkMenu,2);
		gui_addPageButton(twkMenu,100,493,2224,2117,1);
		gui_addText(twkMenu,130,490,1310,"Events 1");
		gui_addPageButton(twkMenu,320,493,2224,2117,3);
		gui_addText(twkMenu,350,490,1310,"Events 3");

		gui_addButton(twkMenu,35,51,twkButton[arrayline][new1],twkButton[arrayline][old1],1);
		gui_addText(twkMenu,60,49,33,"Main infos");
		gui_addButton(twkMenu,170,51,twkButton[arrayline][new2],twkButton[arrayline][old2],2);
		gui_addText(twkMenu,195,49,33,"Skills");
		gui_addButton(twkMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
		gui_addText(twkMenu,285,49,33,"Flags");
		gui_addButton(twkMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
		gui_addText(twkMenu,380,49,33,"Layer");
		gui_addButton(twkMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
		gui_addText(twkMenu,470,49,33,"Events");
		gui_addButton(twkMenu,35,81,twkButton[arrayline][new6],twkButton[arrayline][old6],6);
		gui_addText(twkMenu,60,79,33,"LocalVars");
		gui_addButton(twkMenu,170,81,twkButton[arrayline][new7],twkButton[arrayline][old7],7);
		gui_addText(twkMenu,195,79,33,"Flags 2");

		gui_addText(twkMenu,66,120,33,"Account number :");
		sprintf( tempStr,"%d",chr_getProperty(target,CP_ACCOUNT));
		gui_addText( twkMenu, 185, 120,0,tempStr);

		gui_addText(twkMenu,280,120,33,"Serial :");
		sprintf( tempStr,"%d",chr_getProperty(target,CP_SERIAL));
		gui_addText( twkMenu, 336, 120,0,tempStr);

		gui_addGump(twkMenu,430,121, 0x827);
		gui_addText(twkMenu,451,120,33,"NPC-AI:");
		gui_addPropField( twkMenu,515,120,50,30,CP_NPCAI);

		gui_addText(twkMenu,50,150,1310,"Events 2");
		for ( i=16;i <= 31;++i)
		{
			gui_addGump(twkMenu,50,173+((i-16)*20), 0x827);
			gui_addText(twkMenu,66,170+((i-16)*20),1310,event_array[i][eventname]);
			chr_getEventHandler(target,event_array[i][eventnum],tempStr);
			gui_addInputField( twkMenu,220,170+((i-16)*20),150,20,i+1,0,tempStr);
			gui_addCheckbox( twkMenu, 200, 173+((i-16)*20), oldpic, newpic, 1, i+1 );
		}

		gui_addPage(twkMenu,3);
		gui_addPageButton(twkMenu,100,493,2224,2117,1);
		gui_addText(twkMenu,130,490,1310,"Events 1");
		gui_addPageButton(twkMenu,210,493,2224,2117,2);
		gui_addText(twkMenu,240,490,1310,"Events 2");

		gui_addButton(twkMenu,35,51,twkButton[arrayline][new1],twkButton[arrayline][old1],1);
		gui_addText(twkMenu,60,49,33,"Main infos");
		gui_addButton(twkMenu,170,51,twkButton[arrayline][new2],twkButton[arrayline][old2],2);
		gui_addText(twkMenu,195,49,33,"Skills");
		gui_addButton(twkMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
		gui_addText(twkMenu,285,49,33,"Flags");
		gui_addButton(twkMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
		gui_addText(twkMenu,380,49,33,"Layer");
		gui_addButton(twkMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
		gui_addText(twkMenu,470,49,33,"Events");
		gui_addButton(twkMenu,35,81,twkButton[arrayline][new6],twkButton[arrayline][old6],6);
		gui_addText(twkMenu,60,79,33,"LocalVars");
		gui_addButton(twkMenu,170,81,twkButton[arrayline][new7],twkButton[arrayline][old7],7);
		gui_addText(twkMenu,195,79,33,"Flags 2");

		gui_addText(twkMenu,66,120,33,"Account number :");
		sprintf( tempStr,"%d",chr_getProperty(target,CP_ACCOUNT));
		gui_addText( twkMenu, 185, 120,0,tempStr);

		gui_addText(twkMenu,280,120,33,"Serial :");
		sprintf( tempStr,"%d",chr_getProperty(target,CP_SERIAL));
		gui_addText( twkMenu, 336, 120,0,tempStr);

		gui_addGump(twkMenu,430,121, 0x827);
		gui_addText(twkMenu,451,120,33,"NPC-AI:");
		gui_addPropField( twkMenu,515,120,50,30,CP_NPCAI);

		gui_addText(twkMenu,50,150,1310,"Events 3");
		for ( i=32;i <= 37;++i)
		{
			gui_addGump(twkMenu,50,173+((i-32)*20), 0x827);
			gui_addText(twkMenu,66,170+((i-32)*20),1310,event_array[i][eventname]);
			gui_addCheckbox( twkMenu, 200, 173+((i-32)*20), oldpic, newpic, 1, i+1 );
			chr_getEventHandler(target,event_array[i][eventnum],tempStr);
			gui_addInputField( twkMenu,220,170+((i-32)*20),150,20,i+1,0,tempStr);
		}
		//printf("test gui, twkMenu: %d^n", twkMenu);
	}
	else if(pagenumber == 6)
	{
		gui_addText(twkMenu,230,150,33,"LocalVars 1");

		new count=0;
		new LocalV[512];
		new dividerrest=0;
		new divider;
		new num;
		new subpages=33; //subpages-lines we already have

		gui_addText( twkMenu, 40, 500, 33, "Add LocalVar:");
		gui_addText(twkMenu,150,500,0,"Str:");
		gui_addRadioButton( twkMenu,190,503, oldpic,newpic,0,100);
		gui_addText(twkMenu,215,500,0,"Int:");
		gui_addRadioButton( twkMenu,255,503, oldpic,newpic,0,101);
		gui_addText(twkMenu,280,500,0,"None:");
		gui_addRadioButton( twkMenu,320,503, oldpic,newpic,1,102);
		gui_addInputField( twkMenu, 370, 500, 40, 20, 5, 1310, "(No.)");
		gui_addInputField( twkMenu, 420, 500, 100, 20, 6, 1310, "(Value)");
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
						gui_addPageButton(twkMenu,310,523,2224,2224,(subpagecount+1)); //next page button at previous pages
						sprintf(tempStr, "next page (%d)", (subpagecount+1))
						gui_addText(twkMenu,330,520,1310,tempStr);
										
						//printf("make new page^n");
						gui_addPage(twkMenu,(subpagecount+1));
				
						//add pagebuttons to real dynamic pages that do not create additional pages
						gui_addText(twkMenu, 60,520,1310,"page 1"); //first page button
						gui_addPageButton(twkMenu, 40,523,2224,2224,1);
				
						if(subpagecount>=2)
						{
							gui_addPageButton(twkMenu,170,523,2223,2223,subpagecount); //previous page button at new page
							sprintf(tempStr, "previous page (%d)", subpagecount)
							gui_addText(twkMenu,190,520,1310,tempStr);
						}
										
						gui_addButton(twkMenu,35,51,twkButton[arrayline][new1],twkButton[arrayline][old1],1);
						gui_addText(twkMenu,60,49,33,"Main infos");
						gui_addButton(twkMenu,170,51,twkButton[arrayline][new2],twkButton[arrayline][old2],2);
						gui_addText(twkMenu,195,49,33,"Skills");
						gui_addButton(twkMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
						gui_addText(twkMenu,285,49,33,"Flags");
						gui_addButton(twkMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
						gui_addText(twkMenu,380,49,33,"Layer");
						gui_addButton(twkMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
						gui_addText(twkMenu,470,49,33,"Events");
						gui_addGump(twkMenu,35,81,twkButton[arrayline][new6]);
						gui_addText(twkMenu,60,79,33,"LocalVars");
						gui_addButton(twkMenu,170,81,twkButton[arrayline][new7],twkButton[arrayline][old7],7);
						gui_addText(twkMenu,195,79,33,"Flags 2");
				
						gui_addText(twkMenu,66,120,33,"Account number :");
						sprintf( tempStr,"%d",chr_getProperty(target,CP_ACCOUNT));
						gui_addText( twkMenu, 185, 120,0,tempStr);
				
						gui_addText(twkMenu,280,120,33,"Serial :");
						sprintf( tempStr,"%d",chr_getProperty(target,CP_SERIAL));
						gui_addText( twkMenu, 336, 120,0,tempStr);
				
						gui_addGump(twkMenu,430,121, 0x827);
						gui_addText(twkMenu,451,120,33,"NPC-AI:");
						gui_addPropField( twkMenu,515,120,50,30,CP_NPCAI);
				
						sprintf( tempStr,"LocalVars %d",(subpagecount+1));
						gui_addText(twkMenu,230,150,33,tempStr);
				
						if (chr_isaLocalVar(target, num, VAR_TYPE_INTEGER))
						{
							sprintf(LocalV, "%d", chr_getLocalIntVar(target,num));
							sprintf(tempStr, "Int %d" , num);
						}
						else
						{
							chr_getLocalStrVar(target, num, LocalV);
							sprintf(tempStr, "Str %d" , num);
						}
						gui_addGump(twkMenu,39,180, 0x827);
						gui_addText( twkMenu, 60, 180, 1310, tempStr);
						gui_addInputField( twkMenu, 140, 180, 125, 30, num, 0, LocalV);
						gui_addCheckbox( twkMenu, 250, 180, oldpic, newpic, 1, num );
					}
					else
					{
						if( (dividerrest<=16) && (dividerrest != 0))
						{
							//printf("dividerrest < 16, enter sub page content, count: %d^n", count);
							if (chr_isaLocalVar(target, num, VAR_TYPE_INTEGER))
							{
								sprintf(LocalV, "%d", chr_getLocalIntVar(target,num));
								sprintf(tempStr, "Int %d" , num);
							}
							else
							{
								chr_getLocalStrVar(target, num, LocalV);
								sprintf(tempStr, "Str %d" , num);
							}
							gui_addGump(twkMenu,39, 160+(20*(count+1-divider*33)), 0x827);
							gui_addText( twkMenu, 60, 160+(20*(count+1-divider*33)), 1310, tempStr);
							gui_addInputField( twkMenu, 140, 160+(20*(count+1-divider*33)), 125, 30, num, 0, LocalV);
							gui_addCheckbox( twkMenu, 250, 160+(20*(count+1-divider*33)), oldpic, newpic, 1, num );
						}
						else
						{
							//printf("dividerrest > 16, enter sub page content, count: %d^n", count);
							if (chr_isaLocalVar(target, num, VAR_TYPE_INTEGER))
							{
								sprintf(LocalV, "%d", chr_getLocalIntVar(target,num));
								sprintf(tempStr, "Int %d" , num);
							}
							else
							{
								chr_getLocalStrVar(target, num, LocalV);
								sprintf(tempStr, "Str %d" , num);
							}
							if(dividerrest == 0)
								divider=divider-1;
							gui_addGump(twkMenu,299,160+(20*((count+1-divider*33)-16)), 0x827);
							gui_addText( twkMenu, 320, 160+(20*((count+1-divider*33)-16)), 1310, tempStr);
							gui_addInputField( twkMenu, 400, 160+(20*((count+1-divider*33)-16)), 125, 30, num, 0, LocalV);
							gui_addCheckbox( twkMenu, 510, 160+(20*((count+1-divider*33)-16)), oldpic, newpic, 1, num );
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
							sprintf(tempStr, "Int %d" , num);
						}
						else if(chr_isaLocalVar(target, num, VAR_TYPE_STRING))
						{
							chr_getLocalStrVar(target, num, LocalV);
							sprintf(tempStr, "Str %d" , num);
						}
						gui_addGump(twkMenu,39, 160+(20*count), 0x827);
						gui_addText( twkMenu, 60, 160+(20*count), 1310, tempStr);
						gui_addInputField( twkMenu, 140, 160+(20*count), 125, 30, num, 0, LocalV);
						gui_addCheckbox( twkMenu, 250, 160+(20*count), oldpic, newpic, 1, num );
					}
					else
					{
						//printf("dividerrest > 16, enter first page content, count: %d^n", count);
						if (chr_isaLocalVar(target, num, VAR_TYPE_INTEGER))
						{
							sprintf(LocalV, "%d", chr_getLocalIntVar(target,num));
							sprintf(tempStr, "Int %d" , num);
						}
						else if(chr_isaLocalVar(target, num, VAR_TYPE_STRING))
						{
							chr_getLocalStrVar(target, num, LocalV);
							sprintf(tempStr, "Str %d" , num);
						}
						gui_addGump(twkMenu,299,160+(20*(count-16)), 0x827);
						gui_addText( twkMenu, 320, 160+(20*(count-16)), 1310, tempStr);
						gui_addInputField( twkMenu, 400, 160+(20*(count-16)), 125, 30, num, 0, LocalV);
						gui_addCheckbox( twkMenu, 510, 160+(20*(count-16)), oldpic, newpic, 1, num );
					}
				}//if
			}//if
		}//for

		//printf("dividerrest: %d, count: %d", dividerrest, count);
	}
	else if(pagenumber == 7)
	{
		new checker = 0;
		gui_addText(twkMenu,100,150,33,"Flags 2");

		//All move, 12
		if(chr_getProperty( target, CP_PRIV2, _)&PRIV2_ALLMOVE == 1) //can move all
			checker = 1;
		gui_addCheckbox( twkMenu,190,173, oldpic,newpic,checker,12);
		gui_addText(twkMenu,66,170,1310,"Can move all :");
		checker=0;

		//Can broadcast, 13
		if(chr_getProperty( target, CP_PRIV, _)&PRIV_CANBROADCAST == 2) //can broadcast
		{
			checker = 1;
		}
		gui_addCheckbox( twkMenu,190,193, oldpic,newpic,checker,13);
		gui_addText(twkMenu,66,190,1310,"Can broadcast :");
		checker=0;

		//Commandlevel, 14
		gui_addGump(twkMenu,50,210, 0x827);
		gui_addText(twkMenu,66,210,1310,"Ingame Command level :");
		gui_addText(twkMenu,66,230,1310,"(0: as player, 1: as CNS, 2: as GM)"); 
		gui_addPropField(twkMenu,250,210,125,30,CP_PRIVLEVEL);

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
		gui_addText(twkMenu,66,250,1310,"Is/Make");
		gui_addText(twkMenu,140,250,0,"CNS");
		gui_addRadioButton( twkMenu,180,253, oldpic,newpic,checker,15);
		gui_addText(twkMenu,216,250,0,"GM");
		gui_addRadioButton( twkMenu,256,253, oldpic,newpic,checker2,16);
		gui_addText(twkMenu,292,250,0,"Player");
		gui_addRadioButton( twkMenu,337,253, oldpic,newpic,checker3,17);
		checker=0;

		//pageable as GM, 18
		printf("pageable: %d", chr_getProperty( target, CP_PRIV, _)&PRIV_GMPAGEABLE);
		if(chr_getProperty( target, CP_PRIV, _)&PRIV_GMPAGEABLE == 32) //can be paged
		{
			checker = 1;
		}
		gui_addText(twkMenu,66,270,1310,"pageable as GM :");
		gui_addCheckbox( twkMenu,200,273, oldpic,newpic,checker,18);
		checker=0;

		//Defense, 19
		gui_addGump(twkMenu,50,290, 0x827);
		gui_addText(twkMenu,66,290,1310,"Defense :");
		gui_addPropField(twkMenu,190,290,125,30,CP_DEF);

		//Dispellable, 20
		if(chr_getProperty( target, CP_PRIV2, _)&0x20 == 32) //can dispel
		{
			checker = 1;
		}
		gui_addCheckbox( twkMenu,190,313, oldpic,newpic,checker,20);
		gui_addText(twkMenu,66,310,1310,"Can dispel :");
		checker=0;

		//Hunger, 21
		gui_addGump(twkMenu,50,330, 0x827);
		gui_addText(twkMenu,66,330,1310,"Hunger :");
		gui_addPropField(twkMenu,190,330,125,30,CP_HUNGER);

		//Jailed, 22
		gui_addGump(twkMenu,50,350, 0x827);
		//gui_addPropField(twkMenu,190,350,125,30,CP_JAILED);
		gui_addText(twkMenu,66,350,1310,"Is jailed :");

		//Needs Mana, 23
		if(chr_getProperty( target, CP_PRIV2, _)&0x10 == 16) //needs no mana
		{
			checker = 1;
		}
		gui_addCheckbox( twkMenu,190,373, oldpic,newpic,checker,23);
		gui_addText(twkMenu,66,370,1310,"Needs no mana :");
		checker=0;

		//Needs Reagents, 24
		if(chr_getProperty( target, CP_PRIV2, _)&0x80 == 128) //needs no reagents
		{
			checker = 1;
		}
		gui_addCheckbox( twkMenu,190,393, oldpic,newpic,checker,24);
		gui_addText(twkMenu,66,390,1310,"Needs no reagents :");
		checker=0;

		//Sees serials, 25
		if(chr_getProperty( target, CP_PRIV, _)&0x08 == 8) //can see serials at single click
		{
			checker = 1;
		}
		gui_addCheckbox( twkMenu,190,413, oldpic,newpic,checker,25);
		gui_addText(twkMenu,66,410,1310,"Can see serials :");
		checker=0;

		//Shows no skilltitle, 26
		if(chr_getProperty( target, CP_PRIV, _)&0x10 == 16) //shows no skilltitle
		{
			checker = 1;
		}
		gui_addCheckbox( twkMenu,190,433, oldpic,newpic,checker,26);
		gui_addText(twkMenu,66,430,1310,"No skill title :");
		checker=0;

		//can snoop all, 27
		if(chr_getProperty( target, CP_PRIV, _)&0x40 == 64) //can snoop all
		{
			checker = 1;
		}
		gui_addCheckbox( twkMenu,470,173, oldpic,newpic,checker,27);
		gui_addText(twkMenu,340,170,1310,"Can snoop all :");
		checker=0;

		//Wander Mode, 28
		gui_addGump(twkMenu,317,190, 0x827);
		gui_addText(twkMenu,340,190,1310,"Wandermode :");
		gui_addPropField(twkMenu,470,190,125,30,CP_NPCWANDER);
	}
	gui_show(twkMenu,chrsource); 
}

public viewMenu(const chrsource, const target, const buttonCode)
{
	//printf("enter viewmenu, page: %d", buttonCode);
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

public tweakBck1(const twkMenu, const chrsource, const buttonCode)
{
	new target = gui_getProperty( twkMenu,MP_BUFFER,1 ); //target
	switch(buttonCode)
	{
		case 1,2,3,4,5,6,7: 
		{		viewMenu(chrsource, target, buttonCode);
				//gui_delete( twkMenu );
		}
		case 11:
		{
			        chr_update(target);
			        //gui_delete( twkMenu );
		}
	}
}

public tweakBck2(const twkMenu, const chrsource, const buttonCode)
{
	new target = gui_getProperty( twkMenu,MP_BUFFER,1 ); //target
	switch(buttonCode)
	{
		case 1,2,3,4,5,6,7:
		{
			viewMenu(chrsource, target, buttonCode);
			//gui_delete( twkMenu );
		}
		case 11:
		{
			chr_update(target);
		}
	}

}

public tweakBck3(const twkMenu, const chrsource, const buttonCode)
{
	new target = gui_getProperty( twkMenu,MP_BUFFER,1 ); //target
	//new textbuf[5];
	switch(buttonCode)
	{
		case 1,2,3,4,5,6,7:
		{
			viewMenu(chrsource, target, buttonCode);
			//gui_delete( twkMenu );
		}
		case 11:
		{
			new i;
			for(i=12; i <= 28;++i)
			{
				if(i==12)
				{
					if ( gui_getProperty(twkMenu,MP_CHECK,i))
						chr_makeInvul(target);
					else	chr_makeVulnerable(target);
				}
				if(i==13)
				{
					if ( gui_getProperty(twkMenu,MP_CHECK,i))
						chr_setHitPoints(target,0);
					else	chr_resurrect(target);
				}
				if(i==14)
				{
					if ( gui_getProperty(twkMenu,MP_CHECK,i))
						chr_freeze(target);
					else	chr_unfreeze(target);
				}
				if(i==15 )
				{
					if ( gui_getProperty(twkMenu,MP_RADIO,15)) //skill
					{
						chr_setProperty( target,CP_HIDDEN,_,1);
						chr_setProperty( target,CP_PRIV2,_, chr_getProperty( target,CP_PRIV2,_) &~0x08 ); //nicht mehr permahidden
					}
					else if ( gui_getProperty(twkMenu,MP_RADIO,16)) //spell
					{
						chr_setProperty( target,CP_HIDDEN,_,2);
						chr_setProperty( target,CP_PRIV2,_, chr_getProperty( target,CP_PRIV2,_) &~0x08 ); //nicht mehr permahidden
					}
					else if ( gui_getProperty(twkMenu,MP_RADIO,17)) //perma
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
					if ( gui_getProperty(twkMenu,MP_CHECK,19))
						chr_setProperty( target,CP_WAR,1);
					else	chr_setProperty( target,CP_WAR,0);
				}
				if(i==20)  //nightsight
				{
					new textbuf_night[15];
					gui_getProperty(twkMenu,MP_UNI_TEXT,20,textbuf_night);
					if( strcmp( textbuf_night,"millisec" ) && gui_getProperty(twkMenu,MP_CHECK,i)) //Entry made and is nightsight activated
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
					else if( (tempfx_isActive( target,TFX_SPELL_LIGHT) == 1) && !(gui_getProperty(twkMenu,MP_CHECK,i))) // no Entry,is not activated and nightsight is active
					{
						tempfx_delete( target,TFX_SPELL_LIGHT,true); //no more nightsight
					}
				}
				if(i==21)  //magic reflect
				{
					if( gui_getProperty(twkMenu,MP_CHECK,i)) //magic reflect is activated
						chr_setProperty( target, CP_PRIV2, _,  chr_getProperty( target, CP_PRIV2, _) | 0x40 ); //activate magic reflect
					else
						chr_setProperty( target, CP_PRIV2, _,  chr_getProperty( target, CP_PRIV2, _) & ~0x40 ); //disable
				}
				if(i==22)
				{
					if(gui_getProperty(twkMenu,MP_CHECK,i))
				            callPolyMenu(chrsource, target,1); //polymorph
					else if (!(gui_getProperty(twkMenu,MP_CHECK,i))&& (chr_getProperty( target,CP_ID)) != (chr_getProperty(target,CP_XID)))
				            chr_unmorph(target);
				}
				if(i==25) //house icon
				{
					if ( gui_getProperty(twkMenu,MP_CHECK,i))
					        chr_setProperty( target,CP_PRIV2,_,chr_getProperty( target,CP_PRIV2,_) | PRIV2_VIEWHOUSESASICON ); //set 0 to 1
					else	chr_setProperty( target,CP_PRIV2,_,chr_getProperty( target,CP_PRIV2,_) &~PRIV2_VIEWHOUSESASICON ); //set 1 to 0
				}
				if(i==28)  //nightsight
				{
					new textbuf_lsd[15];
					gui_getProperty(twkMenu,MP_UNI_TEXT,i,textbuf_lsd);
					if( strcmp( textbuf_lsd,"millisec" ) && gui_getProperty(twkMenu,MP_CHECK,i)) //Entry made and is hallucination activated
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
					else if( (tempfx_isActive( target,TFX_LSD) == 1) && !(gui_getProperty(twkMenu,MP_CHECK,i))) // no Entry,is not activated and nightsight is active
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

public tweakBck4(const twkMenu, const chrsource, const buttonCode)
{
	new target = gui_getProperty( twkMenu,MP_BUFFER,1 ); //target
	switch(buttonCode)
	{
		case 1,2,3,4,5,6,7:
		{
			viewMenu(chrsource, target, buttonCode);
			//gui_delete( twkMenu );
		}
		case 11:
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
					if(!gui_getProperty(twkMenu,MP_CHECK,6+(layer-1)))
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

public tweakBck5(const twkMenu, const chrsource, const buttonCode)
{
	new target = gui_getProperty( twkMenu,MP_BUFFER,1 ); //target

	switch(buttonCode)
	{
		case 1,2,3,4,5,6,7:
		{
			viewMenu(chrsource, target, buttonCode);
			//gui_delete( twkMenu );
		}
		case 11:
		{
			new i=0;
			new callname[15];
			new oldevent[15];
			for(i=0;i<NUM_chrevent;i++)
			{
				if ( !gui_getProperty(twkMenu,MP_CHECK,i+1)) //checkbox no more checked and event had existed
				{
					//printf("del event");
					chr_delEventHandler(target, event_array[i][eventnum]);
				}
				else
				{
					gui_getProperty(twkMenu,MP_UNI_TEXT,i+1,callname);
					trim(callname);
					chr_getEventHandler(target,event_array[i][eventnum],oldevent);
					if( strcmp( callname, oldevent)) //different input happened
						chr_setEventHandler(target, event_array[i][eventnum], EVENTTYPE_STATIC, callname);
				}
				sprintf(callname, "");
			}//for
			chr_update(target);
		}//case
	}

}

public tweakBck6(const twkMenu, const chrsource, const buttonCode)
{
	new target = gui_getProperty( twkMenu,MP_BUFFER,1 ); //target
	new tempStr[15];

	switch(buttonCode)
	{
		case 1,2,3,4,5,6,7:
		{
			viewMenu(chrsource, target, buttonCode);
		}
		case 11:
		{
			new i;
			for(i=1000;i<5000;i++)
			{
				if (chr_isaLocalVar(target, i, VAR_TYPE_ANY))
				{
					if(!(gui_getProperty(twkMenu,MP_CHECK,i)))
					{
						chr_delLocalVar(target, i)
					}
					else if(chr_isaLocalVar(target, i, VAR_TYPE_INTEGER))
					{
						gui_getProperty(twkMenu,MP_UNI_TEXT,i,tempStr);
						trim(tempStr);
						if (isStrUnsignedInt(tempStr) || strcmp( !tempStr, "0" ))
						{
							new value = str2UnsignedInt(tempStr);
							if(chr_getLocalIntVar(target,i)!=value)
							         chr_setLocalIntVar(target, i, value);
						}
						else
							chr_message(target, _, "An integer localVar value may only contain numbers with 0-9!");
					}
					else if(chr_isaLocalVar(target, i, VAR_TYPE_STRING))
					{
						new value[256];				
						gui_getProperty(twkMenu,MP_UNI_TEXT,i,tempStr);
						chr_getLocalStrVar(target,i, value);
						if( strcmp( value, tempStr )) //is different
						            chr_setLocalStrVar(target, i, tempStr);
					}
				}//if var test
			}//for
			if(gui_getProperty(twkMenu,MP_RADIO,101)) //integer var adding
			{
				new tempStrB[15];
				new inpt[15];
				gui_getProperty(twkMenu,MP_UNI_TEXT,5,tempStrB); //number
				trim(tempStrB);
				if(isStrUnsignedInt(tempStrB)) //is numeric
				{
					new number = str2UnsignedInt(tempStrB);
					printf("tempStrB: %s, number: %d^n", tempStrB, number);
					if(!(chr_isaLocalVar(target, number, VAR_TYPE_ANY))) //already exist
					{
						gui_getProperty(twkMenu,MP_UNI_TEXT,6,inpt); //value
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
			else if(gui_getProperty(twkMenu,MP_RADIO,100)) //string localvar
			{
				new tempStrB[15];
				new inpt[15];
				gui_getProperty(twkMenu,MP_UNI_TEXT,5,tempStrB); //number
				trim(tempStrB);
				if(isStrUnsignedInt(tempStrB)) //is numeric
				{
					new number = str2UnsignedInt(tempStrB);
					printf("tempStrB: %s, number: %d^n", tempStrB, number);
					if(!(chr_isaLocalVar(target, number, VAR_TYPE_ANY))) //already exist
					{
						gui_getProperty(twkMenu,MP_UNI_TEXT,6,inpt); //value
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

public tweakBck7(const twkMenu, const chrsource, const buttonCode)
{
	new target = gui_getProperty( twkMenu,MP_BUFFER,1 ); //target
	//new textbuf[5];
	switch(buttonCode)
	{
		case 1,2,3,4,5,6,7:
		{
			viewMenu(chrsource, target, buttonCode);
			//gui_delete( twkMenu );
		}
		case 11:
		{
			new i;
			for(i=12; i <= 28;++i)
			{
				if(i==12)
				{
					if(gui_getProperty(twkMenu,MP_CHECK,i))
						chr_setProperty( target, CP_PRIV2, _, chr_getProperty(target,CP_PRIV2) | PRIV2_ALLMOVE);
					else
						chr_setProperty( target, CP_PRIV2, _, chr_getProperty(target,CP_PRIV2) &~ PRIV2_ALLMOVE);
				}
				else if(i==13) //Can broadcast
				{
					if(gui_getProperty(twkMenu,MP_CHECK,i))
						chr_setProperty( target, CP_PRIV, _,  chr_getProperty( target, CP_PRIV) | PRIV_CANBROADCAST );
					else
						chr_setProperty( target, CP_PRIV, _,  chr_getProperty( target, CP_PRIV) &~PRIV_CANBROADCAST );
				}
				else if(i==15) //is CNS/GM/player
				{
					if ( gui_getProperty(twkMenu,MP_RADIO,15)) //CNS
					{
						chr_setProperty( target,CP_PRIV,_, chr_getProperty( target,CP_PRIV) | 0x80 );
						chr_setProperty( target,CP_PRIV,_, chr_getProperty( target,CP_PRIV) &~0x01 ); //is no GM
					}
					else if ( gui_getProperty(twkMenu,MP_RADIO,16)) //GM
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
					if( gui_getProperty(twkMenu,MP_CHECK,i))
						chr_setProperty( target, CP_PRIV,_, chr_getProperty( target, CP_PRIV) | PRIV_GMPAGEABLE );
					else
						chr_setProperty( target, CP_PRIV,_,  chr_getProperty( target, CP_PRIV) & ~PRIV_GMPAGEABLE );
				}
				else if(i==20) //Dispellable, 20
				{
					if(gui_getProperty(twkMenu,MP_CHECK,i))
						chr_setProperty( target, CP_PRIV2, _,  chr_getProperty( target, CP_PRIV2, _) | 0x20 );
					else
						chr_setProperty( target, CP_PRIV2, _,  chr_getProperty( target, CP_PRIV2, _) & ~0x20 );
			
				} 
				else if(i==23) //Needs no Mana, 23
				{
					if(gui_getProperty(twkMenu,MP_CHECK,i))
						chr_setProperty( target, CP_PRIV2, _,  chr_getProperty( target, CP_PRIV2, _) | 0x10 );
					else
						chr_setProperty( target, CP_PRIV2, _,  chr_getProperty( target, CP_PRIV2, _) & ~0x10 );
				}
				else if(i==24) //Needs no Reagents, 24
				{
					if(gui_getProperty(twkMenu,MP_CHECK,i))
						chr_setProperty( target, CP_PRIV2, _,  chr_getProperty( target, CP_PRIV2, _) | 0x80 );
					else
						chr_setProperty( target, CP_PRIV2, _,  chr_getProperty( target, CP_PRIV2, _) & ~0x80 );
				}
				else if(i==25) //Sees serials, 25
				{
					if(gui_getProperty(twkMenu,MP_CHECK,i))
						chr_setProperty( target, CP_PRIV, _,  chr_getProperty( target, CP_PRIV, _) | 0x08 );
					else
						chr_setProperty( target, CP_PRIV, _,  chr_getProperty( target, CP_PRIV, _) & ~0x08 );
				}
				else if(i==26) //Shows no skilltitle, 26
				{
					if(gui_getProperty(twkMenu,MP_CHECK,i))
						chr_setProperty( target, CP_PRIV, _,  chr_getProperty( target, CP_PRIV, _) | 0x10 );
					else
						chr_setProperty( target, CP_PRIV, _,  chr_getProperty( target, CP_PRIV, _) & ~0x10 );
				}
				else if(i==27)
				{
					if(gui_getProperty(twkMenu,MP_CHECK,i))
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

public callItemMenu(const chrsource,const target, const pagenumber)
{
	new tempStr[50];
	new menuitemprop1=gui_create(10,10,1,1,1,"callitemprop1");
		gui_setProperty( menuitemprop1,MP_BUFFER,0,PROP_ITEM );
		gui_setProperty( menuitemprop1,MP_BUFFER,1,target );
		gui_setProperty( menuitemprop1,MP_BUFFER,3,BUTTON_APPLY );
		gui_addPage(menuitemprop1,0);
		gui_addResizeGump(menuitemprop1,10,95,5054,550,450);
		gui_addResizeGump(menuitemprop1,20,135,3500,530,355);
		gui_addResizeGump(menuitemprop1,25,101,5100,525,31);
		gui_addButton(menuitemprop1,260,105,5200,5201,900);
		gui_addButton(menuitemprop1,30,105,5042,5043,902);
		gui_addButton(menuitemprop1,180,105,5052,5053,903);
		gui_addButton(menuitemprop1,210,105,5050,5051,904);
		gui_addTilePic(menuitemprop1,350,340,itm_getProperty(target,IP_ID));
		gui_addText(menuitemprop1,70,150,1310,"Serial :");
		sprintf( tempStr,"%d",itm_getProperty(target,IP_SERIAL));
		gui_addText(menuitemprop1,160,150,0,tempStr,0);
		gui_addText(menuitemprop1,70,170,1310,"Script ID :");
		gui_addPropField( menuitemprop1, 160, 170,150,30,IP_SCRIPTID);
		gui_addText(menuitemprop1,70,190,1310,"eventname :");
		gui_addPropField( menuitemprop1, 160, 190,150,30,IP_STR_NAME);
		gui_addText(menuitemprop1,70,210,1310,"Farbe :");
		gui_addPropField( menuitemprop1, 160, 210,150,30,IP_COLOR);
		gui_addText(menuitemprop1,70,230,1310,"Decaytimer :");
		gui_addPropField( menuitemprop1, 160, 230,150,30,IP_DECAYTIME);
		gui_addButton(menuitemprop1,40,253,2224,2117,7);
		gui_addText(menuitemprop1,70,250,1310,"Position :");
		sprintf( tempStr,"%d,%d,%d",itm_getProperty(target,IP_POSITION,IP2_X),itm_getProperty(target,IP_POSITION,IP2_Y),itm_getProperty(target,IP_POSITION,IP2_Z));
		gui_addText(menuitemprop1,160,250,0,tempStr,0);
		gui_addText(menuitemprop1,70,270,1310,"Stueckz. :");
		gui_addPropField( menuitemprop1, 160, 270,150,30,IP_AMOUNT);
		gui_addButton(menuitemprop1,40,293,2224,2117,9);
		gui_addText(menuitemprop1,70,290,1310,"Type :");
		sprintf( tempStr,"%d",itm_getProperty(target,IP_TYPE));
		gui_addText(menuitemprop1,160,290,0,tempStr,0);
		gui_addButton(menuitemprop1,40,293,2224,2117,10);
		gui_addText(menuitemprop1,70,310,1310,"More 1 :");
		new value = itm_getProperty(target,IP_MORE,1) << 24 + itm_getProperty(target,IP_MORE,2) << 16 + itm_getProperty(target,IP_MORE,3) << 8 + itm_getProperty(target,IP_MORE,4);
		sprintf( tempStr,"%d",value);
		gui_addText(menuitemprop1,160,310,0,tempStr);
		gui_addButton(menuitemprop1,40,293,2224,2117,11);
		gui_addText(menuitemprop1,70,330,1310,"More B :");
		value = itm_getProperty(target,IP_MOREB,1) << 24 + itm_getProperty(target,IP_MOREB,2) << 16 + itm_getProperty(target,IP_MOREB,3) << 8 + itm_getProperty(target,IP_MOREB,4);
		sprintf( tempStr,"%d",value);
		gui_addText(menuitemprop1,160,330,0,tempStr);
		gui_addButton(menuitemprop1,40,353,2224,2117,12);
		gui_addText(menuitemprop1,70,350,1310,"Can Decay :");
		sprintf( tempStr,"%x",itm_getProperty(target,IP_PRIV)&1);
		gui_addText(menuitemprop1,160,350,0,tempStr,0);
		gui_addButton(menuitemprop1,40,373,2224,2117,13);
		gui_addText(menuitemprop1,70,370,1310,"Weight :");
		sprintf( tempStr,"%d",itm_getProperty(target,IP_WEIGHT)/10);
		gui_addText(menuitemprop1,160,370,0,tempStr,0);
		gui_addText(menuitemprop1,70,390,1310,"Layer :");
		sprintf( tempStr,"%d",itm_getProperty(target,IP_LAYER));
		gui_addText(menuitemprop1,160,390,0,tempStr,0);
		gui_addButton(menuitemprop1,40,433,2224,2117,16);
		gui_addText(menuitemprop1,70,430,1310,"Armor :");
		gui_addPropField( menuitemprop1, 160, 430,150,30,IP_DEF);
		gui_addText(menuitemprop1,330,150,1310,"Value :");
		gui_addPropField( menuitemprop1, 490, 150,150,30,IP_VALUE);
		gui_addButton(menuitemprop1,310,173,2224,2117,18);
		gui_addText(menuitemprop1,330,170,1310,"Dyeable :");
		gui_addPropField( menuitemprop1, 490, 150,150,30,IP_VALUE);
		sprintf( tempStr,"%d",itm_getProperty(target,IP_DYE));
		gui_addText(menuitemprop1,400,170,0,tempStr,0);
		gui_addButton(menuitemprop1,310,193,2224,2117,19);
		gui_addText(menuitemprop1,330,190,1310,"More P :");
		sprintf( tempStr,"%d,%d,%d",itm_getProperty(target,IP_MOREPOSITION,IP2_X),itm_getProperty(target,IP_MOREPOSITION,IP2_Y),itm_getProperty(target,IP_MOREPOSITION,IP2_Z));
		gui_addText(menuitemprop1,400,190,0,tempStr,0);
		gui_addButton(menuitemprop1,310,213,2224,2117,20);
		gui_addText(menuitemprop1,330,210,1310,"Owner :");
		sprintf( tempStr,"%d",itm_getProperty(target,IP_OWNERSERIAL));
		gui_addText(menuitemprop1,400,210,0,tempStr,0);
		gui_addButton(menuitemprop1,310,233,2224,2117,21);
		gui_addText(menuitemprop1,330,230,1310,"Visible :");
		sprintf( tempStr,"%d",itm_getProperty(target,IP_VISIBLE));
		gui_addText(menuitemprop1,400,230,0,tempStr,0);
		gui_show(menuitemprop1,chrsource);
}

/*! }@ */