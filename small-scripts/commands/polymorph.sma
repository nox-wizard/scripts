/*!
\author Horian
\fn cmd_polymorph(const chr)
\brief polymorphing of chars/npc

<B>syntax:</B> 'tweak
Shows an ingame menu that allows to choose from all available bodys to polymorph the char<BR>
\todo make this function work when commands are done in sources
<br>
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
decbody,
hexbody,
hextile,
animname: 23
};

static animProperty[NUM_anims][animprop] = {
{0202, 0x00ca, 0x20da, "alligator"},
{0211, 0x00d3, 0x20cf, "black bear"},
{0212, 0x00D4, 0x20db, "grizzly bear"},
{0213, 0x00d5, 0x20e1, "polar bear"},
{0006, 0x0006, 0x211a, "bird"},
{0574, 0x023e, 0x37ab, "blade spirit"},
{0290, 0x0122, 0x2101, "boar"},
{0081, 0x0051, 0x2130, "bullfrog"},
{0232, 0x00e8, 0x20ef, "bull"},
{0233, 0x00e9, 0x20f0, "bull"},
{0201, 0x00c9, 0x211b, "cat"},
{0208, 0x00d0, 0x20d1, "chicken"},
{0008, 0x0008, 0x20d2, "corpser"},
{0216, 0x00d8, 0x2103, "black cow"},
{0231, 0x00e7, 0x2103, "brown cow"},
{0075, 0x004b, 0x212d, "cyclops with hammer"},
{0076, 0x004c, 0x212e, "cyclops"},
{0009, 0x0009, 0x20d3, "deamon"},
{0010, 0x000a, 0x20d3, "deamon with sword"},
{0217, 0x00d9, 0x211c, "dog"},
{0151, 0x0097, 0x20f1, "dolphin"},
{0012, 0x000c, 0x20d6, "grey dragon"},
{0059, 0x003b, 0x20d6, "red dragon"},
{0061, 0x003d, 0x20d6, "red drake"},
{0060, 0x003c, 0x20d6, "grey drake"},
{0005, 0x0005, 0x211d, "eagle"},
{0013, 0x000d, 0x20ed, "air elemental"},
{0014, 0x000e, 0x20d7, "earth elemental"},
{0015, 0x000f, 0x20f3, "fire elemental"},
{0016, 0x0010, 0x210b, "water elemental"},
{0002, 0x0002, 0x20d8, "ettin"},
{0018, 0x0012, 0x20d8, "ettin with mace"},
{0400, 0x0191, 0x20ce, "female"},
{0004, 0x0004, 0x20d9, "gargoyle"},
{0022, 0x0016, 0x20f4, "gazer"},
{0971, 0x03cb, 0x1f03, "ghost"},
{0209, 0x00d1, 0x2108, "goat"},
{0029, 0x001d, 0x20f5, "gorilla"},
{0030, 0x001e, 0x20dc, "harpie"},
{0234, 0x00ea, 0x20d4, "hart"},
{0031, 0x001f, 0x210a, "headless"},
{0237, 0x00ed, 0x20d4, "hind"},
{0200, 0x00C8, 0x2124, "horse"},
{0226, 0x00E2, 0x211f, "horse"},
{0228, 0x00E4, 0x2120, "horse"},
{0204, 0x00CC, 0x2121, "horse"},
{0291, 0x0123, 0x2126, "pack horse"},
{0039, 0x0027, 0x20f9, "imp"},
{0206, 0x00ce, 0x2131, "lava lizard"},
{0024, 0x0018, 0x20f8, "lich"},
{0035, 0x0023, 0x20de, "lizardman with spear"},
{0036, 0x0024, 0x20de, "lizardman with mace"},
{0033, 0x0021, 0x20de, "lizardman"},
{0220, 0x00dc, 0x20f6, "llama"},
{0292, 0x0124, 0x2127, "pack llama"},
{0400, 0x0190, 0x20cd, "male"},
{0001, 0x0001, 0x20df, "ogre"},
{0051, 0x0033, 0x20e8, "ooze"},
{0086, 0x0056, 0x2133, "ophidian warrior"},
{0085, 0x0055, 0x2132, "ophidian mage"},
{0087, 0x0057, 0x2134, "ophidian queen"},
{0017, 0x0011, 0x20e0, "orc"},
{0041, 0x0029, 0x20e0, "orc with mace"},
{0007, 0x0007, 0x20e0, "orc with axe"},
{0219, 0x00db, 0x2137, "forrest ostard"},
{0218, 0x00da, 0x2136, "frenzied ostard"},
{0210, 0x00d2, 0x2135, "desert ostard"},
{0214, 0x00d6, 0x2102, "panther"},
{0203, 0x00cb, 0x2101, "pig"},
{0205, 0x00cd, 0x2125, "rabbit"},
{0238, 0x00ee, 0x2123, "sewer rat"},
{0215, 0x00d7, 0x20d0, "giant rat"},
{0045, 0x002d, 0x20e3, "ratman with sword"},
{0044, 0x002c, 0x20e3, "ratman with axe"},
{0042, 0x002a, 0x20e3, "ratman"},
{0047, 0x002f, 0x20fa, "reaper"},
{0048, 0x0030, 0x20e4, "giant scorpion"},
{0021, 0x0015, 0x20fc, "giant serpent"},
{0150, 0x0096, 0x20fb, "sea serpent"},
{0026, 0x001a, 0x2109, "shade"},
{0223, 0x00df, 0x20e6, "sheered sheep"},
{0207, 0x00cf, 0x20eb, "unsheered sheep"},
{0050, 0x0032, 0x20e7, "skeleton"},
{0056, 0x0038, 0x20e7, "skeleton with axe"},
{0057, 0x0039, 0x20e7, "skeleton with scimitar"},
{0052, 0x0034, 0x20fe, "snake"},
{0028, 0x001c, 0x20fd, "giant spider"},
{0071, 0x0047, 0x212b, "terathan drone"},
{0070, 0x0046, 0x212a, "terathan warrior"},
{0072, 0x0048, 0x212c, "terathan matriarch"},
{0080, 0x0050, 0x212f, "giant toad"},
{0053, 0x0035, 0x20e9, "troll with axe"},
{0054, 0x0036, 0x20e9, "troll"},
{0055, 0x0037, 0x20e9, "troll with maul"},
{0095, 0x005f, 0x20e8, "unknown sea creature"},
{0003, 0x0003, 0x20ec, "zombie"},
{0221, 0x00dd, 0x20ff, "walrus"},
{0058, 0x003a, 0x2100, "wisp"},
{0225, 0x00e1, 0x2122, "wolf"}
};

public cmd_polymorph(const chrsource)
{
	if( (chr_isGM(chrsource)!=0) || (chr_getProperty(chrsource, CP_ACCOUNT)!= 0)) //no admin or gm -> abort
		return;
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
		if( strcmp( color,"(decimal)") ) //entry made (no more "(decimal)")
		{
			trim(color);
			if (isStrUnsignedInt(color))	skincolor = str2UnsignedInt(color);
		}
		chr_morph( target, animProperty[arrayline][decbody], skincolor,-1,-1,-1,-1,1,chrname); //polymorphes body with backup for name and body
		chr_update(target);
	}
}