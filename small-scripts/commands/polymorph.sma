/*!
\defgroup script_command_polymorph 'polymorph
\ingroup script_commands

@{
*/

/*
decbody = decimal value of InsideUO-Anim,
hexbody = hex value of InsideUO-Anim,
hextile = hex value of anim tile pic (InsideUO artworks),
animname = name char when polymorphed should have 
To extend poly menu, simply edit or add your anims into the array, count the lines of array = new NUM_anims value
script does the rest
*/
const NUM_anims = 99;

enum animprop
{ 
scriptname: 27,
hextile,
animname: 23
};

static animProperty[NUM_anims][animprop] = {
{"$npc_an_alligator         ", 0x20da, "alligator"},
{"$npc_a_black_bear         ", 0x20cf, "black bear"},
{"$npc_a_grizzly_bear       ", 0x20db, "grizzly bear"},
{"$npc_a_polar_bear         ", 0x20e1, "polar bear"},
{"$npc_forest_bird          ", 0x211a, "bird"},
{"$npc_summoned_blade_spirit", 0x37ab, "blade spirit"},
{"$npc_a_boar               ", 0x2101, "boar"},
{"$npc_a_bullfrog           ", 0x2130, "bullfrog"},
{"$npc_a_bull               ", 0x20ef, "bull"},
{"$npc_a_bull_1             ", 0x20f0, "bull"},
{"$npc_a_cat                ", 0x211b, "cat"},
{"$npc_a_chicken            ", 0x20d1, "chicken"},
{"$npc_a_corpser            ", 0x20d2, "corpser"},
{"$npc_a_cow                ", 0x2103, "black cow"},
{"$npc_a_cow_1              ", 0x2103, "brown cow"},
{"$npc_a_cyclopedian_warrior", 0x212d, "cyclops with hammer"},
{"$npc_a_titan              ", 0x212e, "cyclops"},
{"$npc_deamon_unarmed       ", 0x20d3, "deamon"},
{"$npc_a_daemon             ", 0x20d3, "deamon with sword"},
{"$npc_a_dog                ", 0x211c, "dog"},
{"$npc_a_dolphin            ", 0x20f1, "dolphin"},
{"$npc_a_dragon             ", 0x20d6, "grey dragon"},
{"$npc_a_dragon_2           ", 0x20d6, "red dragon"},
{"$npc_a_drake              ", 0x20d6, "red drake"},
{"$npc_a_drake_1            ", 0x20d6, "grey drake"},
{"$npc_an_eagle             ", 0x211d, "eagle"},
{"$npc_an_air_elemental     ", 0x20ed, "air elemental"},
{"$npc_an_earth_elemental   ", 0x20d7, "earth elemental"},
{"$npc_a_fire_elemental     ", 0x20f3, "fire elemental"},
{"$npc_a_fire_elemental     ", 0x210b, "water elemental"},
{"$npc_an_ettin             ", 0x20d8, "ettin"},
{"$npc_an_ettin_1           ", 0x20d8, "ettin with mace"},
{"$npc_redlady              ", 0x20ce, "female"},
{"$npc_a_gargoyle           ", 0x20d9, "gargoyle"},
{"$npc_a_gazer              ", 0x20f4, "gazer"},
{"$npc_a_ghost              ", 0x1f03, "ghost"},
{"$npc_a_goat               ", 0x2108, "goat"},
{"$npc_a_gorilla            ", 0x20f5, "gorilla"},
{"$npc_a_harpy              ", 0x20dc, "harpie"},
{"$npc_a_great_hart         ", 0x20d4, "hart"},
{"$npc_a_headless           ", 0x210a, "headless"},
{"$npc_a_hind               ", 0x20d4, "hind"},
{"$npc_a_horse              ", 0x2124, "horse"},
{"$npc_a_horse_1            ", 0x211f, "horse"},
{"$npc_a_horse_2            ", 0x2120, "horse"},
{"$npc_a_horse_3            ", 0x2121, "horse"},
{"$npc_a_pack_horse         ", 0x2126, "pack horse"},
{"$npc_an_imp               ", 0x20f9, "imp"},
{"$npc_a_lava_lizard        ", 0x2131, "lava lizard"},
{"$npc_a_lich               ", 0x20f8, "lich"},
{"$npc_lizardman_fencer     ", 0x20de, "lizardman with spear"},
{"$npc_lizardman_macefighter", 0x20de, "lizardman with mace"},
{"$npc_lizardman            ", 0x20de, "lizardman"},
{"$npc_a_rideable_llama     ", 0x20f6, "llama"},
{"$npc_a_pack_llama         ", 0x2127, "pack llama"},
{"$npc_fancy_nobleman       ", 0x20cd, "male"},
{"$npc_an_ogre              ", 0x20df, "ogre"},
{"$npc_a_slime              ", 0x20e8, "ooze"},
{"$npc_an_ophidian_warrior  ", 0x0056, 0x2133, "ophidian warrior"},
{"$npc_an_ophidian_shaman   ", 0x2132, "ophidian mage"},
{"$npc_an_ophidian_matriarch", 0x2134, "ophidian queen"},
{"$npc_orc                  ", 0x20e0, "orc"},
{"$npc_orc_mace             ", 0x20e0, "orc with mace"},
{"$npc_orc_2_hand_axe       ", 0x20e0, "orc with axe"},
{"$npc_a_forest_ostard      ", 0x2137, "forrest ostard"},
{"$npc_a_frenzied_ostard    ", 0x2136, "frenzied ostard"},
{"$npc_a_desert_ostard      ", 0x2135, "desert ostard"},
{"$npc_a_panther            ", 0x2102, "panther"},
{"$npc_a_pig                ", 0x2101, "pig"},
{"$npc_a_rabbit             ", 0x2125, "rabbit"},
{"$npc_a_sewer_rat          ", 0x2123, "sewer rat"},
{"$npc_a_giant_rat          ", 0x20d0, "giant rat"},
{"$npc_ratman               ", 0x20e3, "ratman with sword"},
{"$npc_ratman_axe           ", 0x20e3, "ratman with axe"},
{"$npc_ratman_archer        ", 0x20e3, "ratman"},
{"$npc_a_reaper             ", 0x20fa, "reaper"},
{"$npc_a_giant_scorpion     ", 0x20e4, "giant scorpion"},
{"$npc_a_giant_serpent      ", 0x20fc, "giant serpent"},
{"$npc_a_sea_serpent        ", 0x20fb, "sea serpent"},
{"$npc_a_ghoul              ", 0x2109, "ghoul"},
{"$npc_sheered_sheep        ", 0x20e6, "sheered sheep"},
{"$npc_a_sheep              ", 0x20eb, "unsheered sheep"},
{"$npc_a_skeleton           ", 0x20e7, "skeleton"},
{"$npc_a_skeleton_1         ", 0x20e7, "skeleton with axe"},
{"$npc_a_bone_knight        ", 0x20e7, "skeleton with scimitar"},
{"$npc_a_snake              ", 0x20fe, "snake"},
{"$npc_a_giant_spider       ", 0x20fd, "giant spider"},
{"$npc_a_terathan_drone     ", 0x212b, "terathan drone"},
{"$npc_a_terathan_warrior   ", 0x212a, "terathan warrior"},
{"$npc_a_terathan_matriarch ", 0x212c, "terathan matriarch"},
{"$npc_a_giant_toad         ", 0x212f, "giant toad"},
{"$npc_a_troll              ", 0x20e9, "troll with axe"},
{"$npc_a_troll_1            ", 0x20e9, "troll"},
{"$npc_a_troll_2            ", 0x20e9, "troll with maul"},
{"$npc_a_kraken             ", 0x20e8, "unknown sea creature"},
{"$npc_a_zombie             ", 0x20ec, "zombie"},
{"$npc_a_walrus             ", 0x20ff, "walrus"},
{"$npc_a_wisp               ", 0x2100, "wisp"},
{"$npc_a_timber_wolf        ", 0x2122, "wolf"}
};

/*!
\author Horian
\fn cmd_polymorph(const chr)
\brief polymorphing of chars/npc

<B>syntax:</B> 'polymorph
Shows an ingame menu that allows to choose from all available bodys to polymorph the char<BR>
<br>
*/
public cmd_polymorph(const chrsource)
{
	chr_message( chrsource, _, "Whom do you want to polymorph/unmorph?");
	target_create( chrsource, _, _, _, "polymMenuCallback" );
}

public polymMenuCallback( const t, const chrsource, const target, const x, const y, const z, const model, const param1 )
{
	//printf("chrsource: %d, target: %d, modell: %d, t: %d^n", chrsource, target, model, t);
	if ( chrsource < 0 )
		return;
	if ( isChar(target)) //is npc/char
	{
		if(chr_getProperty( target,CP_ID) != chr_getProperty(target,CP_XID))
			chr_unmorph(target);
		else
			callPolyMenu(chrsource,target, 1);
	}
	else
	{
		chr_message( chrsource, _,"Select a char/npc,please");
		return;
	}
}

public callPolyMenu(const chrsource,const target, const page)
{
	new oldpic = 5002;
	new newpic = 5003;

	new polymMenu = gui_create( 10,10,1,1,1,"infoPolyCallback" );
	gui_setProperty( polymMenu,MP_BUFFER,0,PROP_CHARACTER );
	gui_setProperty( polymMenu,MP_BUFFER,1,target );
	gui_setProperty( polymMenu,MP_BUFFER,3,page );

	gui_addPage(polymMenu,0);
	gui_addResizeGump(polymMenu,10,65,5054,550,500 );
	gui_addResizeGump(polymMenu,20,75,3500,530,475);
	gui_addResizeGump(polymMenu,33,79,5100,505,21);

	gui_addText( polymMenu,215,80,1310,"Polymorph Menu");
	if(page !=8)	gui_addButton( polymMenu,503,83,2224,2224, 2); //button right
	if(page !=1)	gui_addButton( polymMenu,40,83,2223,2223, 1); //button left
	gui_addText( polymMenu,230,500,1310,"page: %d", page);

	gui_addText( polymMenu,50,120,1310,"custom name:" );
	gui_addInputField( polymMenu,140,120,100,20,3,1110,"(name)" );
	gui_addText( polymMenu,210,120,1310,"custom color:" );
	gui_addInputField( polymMenu,300,120,100,20,4,1110,"(decimal)" );
	gui_addText( polymMenu,385,120,1310,"keep stats:" );
	gui_addCheckbox( polymMenu,485,120,oldpic,newpic,0,5); //custom stats

	new i=(page-1)*14; //start line of array for first row of page
	new j=i+7; //end line of array for first row of page and start of second
	new k=i+14; //end line of array for second row of page

	new lastpage = NUM_anims/14;
	new lastpagerest = NUM_anims%14;
	if(lastpagerest)
	{
		lastpage = lastpage + 1;
	}
	//printf("lastpage: %d", lastpage);
	//printf("lastpagerest: %d^n", lastpagerest);
	if(page == lastpage)
	{
		if(lastpagerest <=7)
		{
			i = NUM_anims-lastpagerest;
			j = NUM_anims;
			k = NUM_anims; 
			//voll:i=0, j=7, k=14
			//Numanim 99: lastpagerest = 1, i=98, j=99, k=99
			//100: i=98 = konstant, stimmt; j= 100, k=100
			//105: i=98, j=105, k=105
		}
		else
		{
			i = NUM_anims-lastpagerest;
			j = NUM_anims-(lastpagerest-7);
			k = NUM_anims;
			//voll: 14, 21, 28
			//106: lastpagerest = 8, i=98, j=105, k=106
			//107: lastpagerest = 9, i=98, j=105, k=107
			//111: lastpagerest = 13, i=98, j=105, k= 111
		}
	}

	new l = i;
	for ( i;i<j;++i)
	{
		gui_addTilePic(polymMenu,60,151+50*(i-l), animProperty[i][hextile]);
		gui_addText( polymMenu,110,150+50*(i-l),1310,"%s : ",animProperty[i][animname] );
		gui_addButton( polymMenu,140,170+50*(i-l),oldpic,newpic, i+10);
	}

	i=j;
	for ( i;i<k;++i)
	{
		gui_addTilePic(polymMenu,331,151+50*(i-j), animProperty[i][hextile]);
		gui_addText( polymMenu,381,150+50*(i-j),1310,"%s : ",animProperty[i][animname] );
		gui_addButton( polymMenu,411,170+50*(i-j),oldpic,newpic, i+10);
	}

	gui_show(polymMenu,chrsource); 
}

public infoPolyCallback(const polymMenu, const chrsource, const buttonCode)
{
	new target = gui_getProperty( polymMenu,MP_BUFFER,1 ); //target
	new page = gui_getProperty( polymMenu,MP_BUFFER,3 ); //page number
	printf("page: %d", page);
	printf("buttonCode: %d", buttonCode);

	//0: rechtsklick, 1: vorhergehendes, 2: folgendes Menü, 3: custom name, 4: custom color, 5: custom stats, 10 u. folgende: bodyID

	if(buttonCode == 0) return;
	else if(buttonCode == 1) callPolyMenu(chrsource, target,(page-1)); //back
	else if(buttonCode == 2) callPolyMenu(chrsource, target, (page+1)); //next page
	else if(buttonCode >= 10)
	{
		new arrayline = buttonCode-10;
		new chrname[30];
		gui_getProperty(polymMenu,MP_UNI_TEXT,3,chrname);
		if( !strcmp( chrname,"(name)" )) //is Entry not made (is still "(name)")
		{
			sprintf(chrname, "%s", animProperty[arrayline][animname]);
		}
		new color[15];
		new skincolor = 0000;
		gui_getProperty(polymMenu,MP_UNI_TEXT,4,color);
		if( strcmp( color,"(decimal)")) //entry made (no more "(decimal)")
		{
			trim(color);
			if (isStrUnsignedInt(color))	skincolor = str2UnsignedInt(color);
		}
		new script[25];
		sprintf(script, "%s", animProperty[arrayline][scriptname]);
		trim(script);
		new scriptID = getIntFromDefine(script, false);
		chr_morph( target, scriptID ,1); //polymorphes body into npc like one
		chr_update(target);
	}
}

/*! }@ */