//How many potions have we got?
const NUM_POTION = 20;
/*properties of potions
{minskill for alchem, chance to find potion, hex color of potion, ingame name of potion/ingot, minimal skill to use ingots as smith, scriptid of color}*/

enum potionprop
{
hexreag,
hexpotion,
alchemmin,
alchemmax,
potionchance,
reagentuse: 14,
reagentneed,
potionscript: 18
}
static potionProperty[NUM_POTION][potionprop] = {
{0x0F7B, 0x0F08, 151, 651,100,msg_sk_alchDef[0],1, "normal_agility   "},
{0x0F7B, 0x0F08, 351, 851,100,msg_sk_alchDef[0],3, "greater_agility  "},
{0x0F84, 0x0F07, 0, 500,100,msg_sk_alchDef[1],1, "lesser_cure      "},
{0x0F84, 0x0F07, 251, 751,100,msg_sk_alchDef[1],3, "normal_cure      "},
{0x0F84, 0x0F07, 651,1151, 70,msg_sk_alchDef[1],6, "greater_cure     "},
{0x0F8C, 0x0F0D, 51, 551,100,msg_sk_alchDef[2],3, "lesser_explosion "},
{0x0F8C, 0x0F0D, 351, 851,100,msg_sk_alchDef[2],5, "normal_explosion "},
{0x0F8C, 0x0F0D, 651,1151, 70,msg_sk_alchDef[2],10, "greater_explosion"},
{0x0F85, 0x0F0C, 0, 500,100,msg_sk_alchDef[3],1, "lesser_healing   "},
{0x0F85, 0x0F0C, 151, 651,100,msg_sk_alchDef[3],3, "normal_healing   "},
{0x0F85, 0x0F0C, 551,1051, 90,msg_sk_alchDef[3],7, "greater_healing  "},
{0x0F8D, 0x0F06, 0, 500,100,msg_sk_alchDef[4],1, "normal_nightsight"},
{0x0F88, 0x0F0A, 0, 500,100,msg_sk_alchDef[5],1, "lesser_poison    "},
{0x0F88, 0x0F0A, 151, 651,100,msg_sk_alchDef[5],2, "normal_poison    "},
{0x0F88, 0x0F0A, 551,1051, 90,msg_sk_alchDef[5],4, "greater_poison   "},
{0x0F88, 0x0F0A, 901,1401, 20,msg_sk_alchDef[5],8, "deadly_poison    "},
{0x0F7A, 0x0F0B, 0, 500,100,msg_sk_alchDef[6],1, "normal_energy    "},
{0x0F7A, 0x0F0B, 251, 751,100,msg_sk_alchDef[6],5, "greater_energy   "},
{0x0F86, 0x0F09, 251, 751,100,msg_sk_alchDef[7],2, "lesser_strength  "},
{0x0F86, 0x0F09, 451, 951,100,msg_sk_alchDef[7],5, "normal_strength  "}
};

const alchpages=8; //one line for one page, two rows for one page
const alchpic1 = 5002;
const alchpic2 = 5003;

enum alch_buttons
{ 
newalch1,
oldalch1,
newalch2,
oldalch2,
newalch3,
oldalch3,
newalch4,
oldalch4,
newalch5,
oldalch5,
newalch6,
oldalch6,
newalch7,
oldalch7,
newalch8,
oldalch8
};

static alchButton[alchpages][alch_buttons] = {
{5003, 5209, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003},
{5209, 5003, 5003, 5209, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003},
{5209, 5003, 5209, 5003, 5003, 5209, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003},
{5209, 5003, 5209, 5003, 5209, 5003, 5003, 5209, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003},
{5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5003, 5209, 5209, 5003, 5209, 5003, 5209, 5003},
{5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5003, 5209, 5209, 5003, 5209, 5003},
{5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5003, 5209, 5209, 5003},
{5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5003, 5209}
};

public __nxw_sk_alchemy( const itm, const chr)
{
	bypass();
	//check if its in backpack
	new backpack = chr_getBackpack( chr, true );
	if ((itm_getProperty(itm, IP_CONTAINERSERIAL)) != (itm_getProperty(backpack,IP_SERIAL)))
	{
		chr_message( chr, _,msg_sk_alchDef[8]);
		return;
	}
	alch_show(chr, 1);
}

public alch_show(const chr, const pagenumber)
{
	new alch_menu=gui_create(0, 0 ,0,0,0, "alch_bck");
	gui_addPage(alch_menu,0);
	gui_setProperty( alch_menu,MP_BUFFER,0,PROP_ITEM );
	
	gui_addResizeGump(alch_menu,0,0,2600,513,392);
	gui_addText(alch_menu,191,35, 33,"Alchemy Menu");
	new arrayline = pagenumber-1;
	
	gui_addText(alch_menu,81,62, 33,"Categories");
	gui_addText(alch_menu,86,103, 33,"Last Potiontype");
	gui_addButton(alch_menu,62,108, alchpic1, alchpic2, 1,1);
	gui_addText(alch_menu,86,126, 33,"Agility");
	gui_addButton(alch_menu,61,131, alchButton[arrayline][newalch1], alchButton[arrayline][oldalch1],1);
	gui_addText(alch_menu,86,149, 33,"Cure");
	gui_addButton(alch_menu,62,154, alchButton[arrayline][newalch2], alchButton[arrayline][oldalch2],2);
	gui_addText(alch_menu,86,172, 33,"Explosion");
	gui_addButton(alch_menu,62,177, alchButton[arrayline][newalch3], alchButton[arrayline][oldalch3],3);
	gui_addText(alch_menu,86,195, 33,"Heal");
	gui_addButton(alch_menu,62,200, alchButton[arrayline][newalch4], alchButton[arrayline][oldalch4],4);
	gui_addText(alch_menu,86,218, 33,"Nightsight");
	gui_addButton(alch_menu,62,223, alchButton[arrayline][newalch5], alchButton[arrayline][oldalch5],5);
	gui_addText(alch_menu,86,242, 33,"Poison");
	gui_addButton(alch_menu,62,247, alchButton[arrayline][newalch6], alchButton[arrayline][oldalch6],6);
	gui_addText(alch_menu,86,265, 33,"Energy");
	gui_addButton(alch_menu,62,270, alchButton[arrayline][newalch7], alchButton[arrayline][oldalch7],7);
	gui_addText(alch_menu,86,288, 33,"Strength");
	gui_addButton(alch_menu,62,293, alchButton[arrayline][newalch8], alchButton[arrayline][oldalch8],8);
	gui_addText(alch_menu,283,64, 33,"Selections");
	
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
	
	new oldletter[2];
	sprintf(oldletter, "_");
	new newletter[2];
	sprintf(newletter, " ");
	new potionreg[50];
	sprintf(potionreg, potionProperty[k][reagentuse]);
	replaceStr (potionreg, oldletter, newletter);
	trim( potionreg);
	sprintf(potionreg,  msg_sk_alchDef[10], potionreg);
	gui_addTilePic(alch_menu,200,350, potionProperty[k][hexreag]);
	gui_addText(alch_menu,155,324, 33,potionreg);
	gui_addText(alch_menu,86,324, 33,msg_sk_alchDef[11]);
	
	new m =0;
		
	for( new i=k;i<j;++i)
	{
		gui_addText(alch_menu,309,76,33,msg_sk_alchDef[12]);
		gui_addInputField( alch_menu,350,76,50,20,9,1110,"1");
		new potionname[50];
		sprintf(potionname, potionProperty[i][potionscript]);
		replaceStr (potionname, oldletter, newletter)
		trim(potionname)
		sprintf(potionname, "%s (%d)", potionname, potionProperty[i][reagentneed]);
		//printf("potionname: %s^n", potionname);
		if(chr_getProperty(chr,CP_SKILL,0) >= potionProperty[arrayline][alchemmin])
		{
			gui_addText(alch_menu,309,103+(27*m), 33,potionname);
			gui_addButton(alch_menu,285,110+(27*m),alchpic1, alchpic2, i+10);
			gui_addTilePic(alch_menu,250,110+(27*m), potionProperty[i][hexpotion]);
			m=++m;
		}
	}
	
	//Cancel
	gui_addButton(alch_menu,411,345,243,243);
	
	gui_show(alch_menu, chr);
}

public alch_bck(const alch_menu, const chrsource, const buttonCode)
{
	new amount[10];
	gui_getProperty(alch_menu,MP_UNI_TEXT,9,amount);
	
	if(0 <= buttonCode <= 8)
		alch_show(chrsource, buttonCode);
	else if(buttonCode >= 10)
	{
		new value;
		trim(amount);
		if (isStrUnsignedInt(amount))
		{
			value = str2UnsignedInt(amount);
		}
		else
		{
			chr_message( chrsource, _,"You can only enter a number for the potion amount.");
			alch_show(chrsource, 1);
			return;
		}
		createPotion( chrsource, buttonCode-10, value);
	}
	else chr_message(chrsource, _, msg_sk_alchDef[13], buttonCode);
}

public createPotion(const chr, const arrayline, const amount)
{
	new backpack = chr_getBackpack( chr, true );
	
	//now a dirty workaround to get the shards script-ID from the scriptname (scriptname should always be the same), feature request for this as new function is a good idea
	new scriptname[50];
	sprintf(scriptname, "$item_%s", potionProperty[arrayline][reagentuse]);
	trim(scriptname);
	new dummyitm = itm_createByDef(scriptname); //we create a dummy item with the script name
	new reagscript = itm_getProperty(dummyitm, IP_SCRIPTID); //we get the scriptis of this dummyitem
	itm_remove(dummyitm); //delete the dummyitem
	new reagnumber;
	
	dummyitm = itm_createByDef("$item_bottle11");
	new bottlescript = itm_getProperty(dummyitm, IP_SCRIPTID);
	//printf("bottlescript: %d^n", bottlescript);
	itm_remove(dummyitm); //delete the dummyitem
	
	if(itm_countItemsByID(backpack, bottlescript) < amount)
	{
		chr_message(chr, _, msg_sk_alchDef[14]);
		return;
	}
	
	new itemSet=set_create();
	set_addItemsInCont( itemSet, backpack );
	for (set_rewind(itemSet);!set_end(itemSet);)
	{
		new item = set_get(itemSet);
		new itemscript = itm_getProperty(item, IP_SCRIPTID);
		if(itemscript == reagscript)
		{
			itm_contPileItem(backpack, item); //first pile all items inside the backpack that fit the reagent
		}
		else if(itemscript == bottlescript)
		{
			itm_contPileItem(backpack, item); //first pile all items inside the backpack that fit the reagent
		}
	}
	set_delete(itemSet);
	
	reagnumber = itm_countItemsByID(backpack, reagscript); //now we count how many items with the needed scriptid we have
	new alchskill = chr_getProperty(chr,CP_SKILL,0);
	reagnumber = reagnumber * amount;
	if((reagnumber >= potionProperty[arrayline][reagentneed]) && (alchskill >= potionProperty[arrayline][alchemmin]))
	{
		if (!chr_checkSkill(chr, 0, 0, 1000, 1)) //skill fails
		{
			itm_delAmountByID(backpack, ((potionProperty[arrayline][reagentneed])*amount)/2, reagscript); //we delete the half amount of needed reagents
			itm_delAmountByID(backpack, amount/2, bottlescript);
			chr_message( chr, _,  msg_sk_alchDef[15]);
		}
		itm_delAmountByID(backpack, (potionProperty[arrayline][reagentneed])*amount, reagscript); //and we delete the needed reagents
		itm_delAmountByID(backpack, amount, bottlescript);
		chr_sound(chr, 0x242); //do sound
		
		//extract the item name from the array
		new potionreg[50];
		sprintf(potionreg, potionProperty[arrayline][reagentuse]);
		replaceStr (potionreg, "_", " ");
		trim( potionreg);
		
		//call char name
		new chrname[30]; //new empty string for creator name
		chr_getProperty(chr, CP_STR_NAME, 0, chrname); //call char name
		
		new emotetext[50];
		sprintf(emotetext, msg_sk_alchDef[16], chrname, potionreg); //combine the names
		chr_emoteall( chr, emotetext);
		
		//combine the potion scriptname out of array and $item_
		sprintf(scriptname, potionProperty[arrayline][potionscript]);
		trim(scriptname);
		sprintf(scriptname, "$%s_potion", scriptname);
		itm_createByDef(scriptname, backpack, 1*amount);
	}
	else if(reagnumber >= potionProperty[arrayline][reagentneed])
	{
		chr_message(chr, _, msg_sk_alchDef[17]);
		return
	}
	else if(alchskill >= potionProperty[arrayline][alchemmin])
	{
		chr_message(chr, _, msg_sk_alchDef[18]);
		return		
	}
	else chr_message(chr, _, msg_sk_alchDef[19]);
}