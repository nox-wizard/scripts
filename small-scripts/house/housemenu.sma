/*!
\defgroup script_command_house 'house
\ingroup script_commands

@{
*/

/*
\author Horian
\fn
\brief house menu

<B>syntax:</B> 'house
Shows the ingame house gump that allows all kinds of modifications<BR>
<br>
*/

const AUTOBOUNCEVAR = 9000;

const BUTTON_HOUSEAPPLY=11;
const housepages=3; //one line for one page, two rows for one page
const housepic1 = 5002;
const housepic2 = 5003;

enum house_buttons
{ 
newhous1,
oldhouse1,
newhous2,
oldhouse2,
newhous3,
oldhouse3
};

static houseButton[housepages][house_buttons] = {
{5003, 5209, 5209, 5003, 5209, 5003},
{5209, 5003, 5003, 5209, 5209, 5003},
{5209, 5003, 5209, 5003, 5003, 5209}
};

static houseuser[3][] = {
"Co-Owner", "Friends", "Banned"
};

static xstart = 28;
static ystart = 114;

public housestart(const itm, const chr)
{
	bypass();
        new more1 = (itm_getProperty(itm, IP_MORE, 1)&0xff)<<24;
	new more2 = (itm_getProperty(itm, IP_MORE, 2)&0xff)<<16;
	new more3 = (itm_getProperty(itm, IP_MORE, 3)&0xff)<<8;
	new more4 = (itm_getProperty(itm, IP_MORE, 4)&0xff)<<0;
	new house=more4+more3+more2+more1;
	//printf("start house gump, house ser is %d, item ser is: %d^n", house, itm);
	if( (chr == house_getProperty(house, HP_OWNER)) || (chr_getProperty(chr, CP_PRIVLEVEL) >= 150) ) //seer, gm and admin can use house menu too
		menu_house(chr, house, 1, itm);
	else chr_message(chr, _, msg_housemenuDef[0]);
}

public menu_house(const chrsource, const house, const pagenumber, sign)
{
	new tempStr[100];
	new houseMenu = gui_create( 10,10,1,1,1,"house_cllbck" );

	gui_setProperty( houseMenu,MP_BUFFER,1,house );
	gui_setProperty( houseMenu,MP_BUFFER,3,BUTTON_HOUSEAPPLY );
	gui_setProperty( houseMenu,MP_BUFFER,4,sign );

	gui_addResizeGump(houseMenu,0,0,2600,507,384);
	gui_addResizeGump(houseMenu,93,82,5100,0,0);
	gui_addResizeGump(houseMenu,37,85,3500,430,255);
	gui_addResizeGump(houseMenu,37,40,5100,437,23);

	gui_addPage(houseMenu,0);
	new arrayline = pagenumber-1;
	
	gui_addText(houseMenu,210,12,1210,"House Menue");
	gui_addButton( houseMenu,400,345, 0x084A, 0x084B,BUTTON_HOUSEAPPLY );
	gui_addText(houseMenu,58,41,33,"Info");
	gui_addButton(houseMenu,100,43,houseButton[arrayline][newhous1],houseButton[arrayline][oldhouse1],1);
	gui_addText(houseMenu,202,41,33,"Friends");
	gui_addButton(houseMenu,279,42,houseButton[arrayline][newhous2],houseButton[arrayline][oldhouse2],2);
	gui_addText(houseMenu,366,40,33,"Options");
	gui_addButton(houseMenu,423,42,houseButton[arrayline][newhous3],houseButton[arrayline][oldhouse3],3);
	
	gui_addButton(houseMenu,116,230+23*5,housepic1,housepic2,18);
	gui_addText(houseMenu,146,227+23*5,1310,"Bounce someone out of the house");

//Info
if( pagenumber ==1)
{
	gui_addText(houseMenu,xstart+40,ystart,1310,"Owner is:");
	new ownerser = house_getProperty(house, HP_OWNER, _);
	chr_getProperty(ownerser, CP_STR_NAME, _, tempStr);
	gui_addText(houseMenu,xstart+40+110,ystart,_,tempStr);
	
	gui_addText(houseMenu,xstart+40,ystart+20,1310,"Account:");
	sprintf( tempStr,"%d",chr_getProperty(ownerser,CP_ACCOUNT));
	gui_addText(houseMenu,xstart+40+233,ystart+20,_,tempStr);
	
	gui_addText(houseMenu,xstart+40,ystart+20*2,1310,"Number of locked down items:");
	sprintf( tempStr,"%d (of %d)", house_getProperty(house, HP_LOCKEDITEMS, _), house_getProperty(house, HP_MAXLOCKEDITEMS, _));
	gui_addText(houseMenu,xstart+40+233,ystart+20*2,_,tempStr);
	
	gui_addText(houseMenu,xstart+40,ystart+20*3,1310,"Number of secure container:");
	sprintf( tempStr,"%d (of %d)", house_getProperty(house, HP_SECUREDITEMS), house_getProperty(house, HP_MAXSECUREDITEMS));
	gui_addText(houseMenu,xstart+40+233,ystart+20*3,_,tempStr);
	
	gui_addGump(houseMenu,xstart+20, ystart+20*4, 0x827);
	gui_addText(houseMenu,xstart+40,ystart+20*4,1310,"This house is called:");
	itm_getProperty(sign, IP_STR_NAME, _, tempStr);
	gui_addInputField( houseMenu,xstart+40+233,ystart+20*4,150,20,11,_,tempStr);
		
#if _AUTOBOUNCE_AVAIL
	if(itm_isaLocalVar(house, AUTOBOUNCEVAR))
	{
		itm_addLocalIntVar( house, AUTOBOUNCEVAR, 0);
	}
	checklev = itm_getLocalIntVar(house, AUTOBOUNCEVAR);
 	gui_addText(houseMenu,xstart+15,ystart+20*4,1310,"activate Autoban");
	gui_addCheckbox(houseMenu,xstart+253,ystart+21*4,housepic1,housepic2,checklev,12);
#endif
}
//friends & owner
else if(pagenumber ==2)
{
	new chr;
	new i=1;
	new j;
	//page 1, coowner
	gui_addPage(houseMenu,1);
	gui_addPageButton(houseMenu,xstart+200,ystart-50,2224,2117,2);
	sprintf(tempStr, houseuser[1]);
	gui_addText(houseMenu,xstart+200+20,ystart-50,1310,tempStr);
	
	gui_addPageButton(houseMenu,xstart+350,ystart-50,2224,2117,3);
	sprintf(tempStr, houseuser[2]);
	gui_addText(houseMenu,xstart+350+20,ystart-50,1310,tempStr);
	
	sprintf(tempStr, "Add a %s", houseuser[0]);
	gui_addButton(houseMenu,xstart+50,ystart-10,housepic1,housepic2,12);
	gui_addText(houseMenu,xstart+80,ystart-13,1310,tempStr);
	
	sprintf(tempStr, "Delete all %s", houseuser[0]);
	gui_addButton(houseMenu,xstart+250,ystart-10,housepic1,housepic2,13);
	gui_addText(houseMenu,xstart+280,ystart-13,1310,tempStr);
	
	new coownerlist = set_create();
	set_addCoOwners( coownerlist, house);
	for (set_rewind(coownerlist);!set_end(coownerlist);)
	{
		chr = set_getChar( coownerlist );
		chr_getProperty(chr, CP_STR_NAME, _, tempStr);
		if(i>8)
			j=150;
		else j=0;
		gui_addCheckbox(houseMenu,xstart+20+j,ystart+21*i,housepic1,housepic2,1,10+i);
		gui_addText(houseMenu,xstart+40+j,ystart-1+21*i,1310,tempStr);
		i++;
	}
	set_delete(coownerlist);
	
	//page 2, friends
	i=1;
	gui_addPage(houseMenu,2);
	gui_addPageButton(houseMenu,xstart+50,ystart-50,2224,2117,1);
	sprintf(tempStr, houseuser[0]);
	gui_addText(houseMenu,xstart+50+20,ystart-50,1310,tempStr);
	
	gui_addPageButton(houseMenu,xstart+350,ystart-50,2224,2117,3);
	sprintf(tempStr, houseuser[2]);
	gui_addText(houseMenu,xstart+350+20,ystart-50,1310,tempStr);
	
	sprintf(tempStr, "Add a %s", houseuser[1]);
	gui_addButton(houseMenu,xstart+50,ystart-10,housepic1,housepic2,14);
	gui_addText(houseMenu,xstart+80,ystart-13,1310,tempStr);
	
	sprintf(tempStr, "Delete all %s", houseuser[1]);
	gui_addButton(houseMenu,xstart+250,ystart-10,housepic1,housepic2,15);
	gui_addText(houseMenu,xstart+280,ystart-13,1310,tempStr);
	
	new friendlist = set_create();
	set_addFriends( friendlist, house);
	for (set_rewind(friendlist);!set_end(friendlist);)
	{
		chr = set_getChar( friendlist );
		chr_getProperty(chr, CP_STR_NAME, _, tempStr);
		if(i>8)
			j=150;
		else j=0;
		gui_addCheckbox(houseMenu,xstart+20+j,ystart+21*i,housepic1,housepic2,1,30+i);
		gui_addText(houseMenu,xstart+40+j,ystart-1+21*i,1310,tempStr);
		i++;
	}
	set_delete(friendlist);
	
	//page 3, banned
	i=1;
	gui_addPage(houseMenu,3);
	gui_addPageButton(houseMenu,xstart+50,ystart-50,2224,2117,1);
	sprintf(tempStr, houseuser[0]);
	gui_addText(houseMenu,xstart+50+20,ystart-50,1310,tempStr);
	
	gui_addPageButton(houseMenu,xstart+200,ystart-50,2224,2117,2);
	sprintf(tempStr, houseuser[1]);
	gui_addText(houseMenu,xstart+200+20,ystart-50,1310,tempStr);
	
	sprintf(tempStr, "Add to %s list", houseuser[2]);
	gui_addButton(houseMenu,xstart+50,ystart-10,housepic1,housepic2,16);
	gui_addText(houseMenu,xstart+80,ystart-13,1310,tempStr);
	
	sprintf(tempStr, "Clean %s list", houseuser[2]);
	gui_addButton(houseMenu,xstart+250,ystart-10,housepic1,housepic2,17);
	gui_addText(houseMenu,xstart+280,ystart-13,1310,tempStr);
	
	new banlist = set_create();
	set_addBanned( banlist, house);
	for (set_rewind(banlist);!set_end(banlist);)
	{
		chr = set_getChar( banlist );
		chr_getProperty(chr, CP_STR_NAME, _, tempStr);
		if(i>8)
			j=150;
		else j=0;
		gui_addCheckbox(houseMenu,xstart+20+j,ystart+21*i,housepic1,housepic2,1,50+i);
		gui_addText(houseMenu,xstart+40+j,ystart-1+21*i,1310,tempStr);
		i++;
	}
	set_delete(banlist);
	
}
//options
else if(pagenumber ==3)
{
	
	gui_addButton(houseMenu,117,114,housepic1,housepic2,19);
	gui_addText(houseMenu,138,111+28*0,1310,"Transform house back into a deed");
	
	gui_addButton(houseMenu,117,114+28*1,housepic1,housepic2,20);
	gui_addText(houseMenu,138,111+28*1,1310,"Change the house locks");
	
	gui_addButton(houseMenu,117,114+28*2,housepic1,housepic2,21);
	if(house_getProperty(house, HP_PUBLICHOUSE) == 0)
		sprintf(tempStr, "Declare this house as public");
	else sprintf(tempStr, "Declare this house as non-public");
	gui_addText(houseMenu,138,111+28*2,1310,tempStr);
	gui_addText(houseMenu,138,111+28*3,1310,"(Public means it's not lockable!)");
	
	gui_addButton(houseMenu,117,114+28*4,housepic1,housepic2,22);
	gui_addText(houseMenu,138,111+28*4,1310,"Access your bank account");
	
	gui_addButton(houseMenu,117,114+28*5,housepic1,housepic2,23);
	gui_addText(houseMenu,138,111+28*5,1310,"Transfer ownership of the house");
}
gui_show(houseMenu, chrsource);
}

public house_cllbck(const houseMenu, const chrsource, const buttonCode)
{
	//printf("start house callback, page: %d", buttonCode);
	new sign = gui_getProperty(houseMenu, MP_BUFFER, 4);
	new house = gui_getProperty(houseMenu, MP_BUFFER, 1);
	new i;
	new chr;
	switch(buttonCode)
	{
		case 1..3: menu_house(chrsource, house, buttonCode, sign);
		case 11:
		{
			new setlist = set_create();
			for(i=11; i<=12;++i)
			{
				if(i==11) //house name (at sign)
				{
					new textbuf_input[50];
					gui_getProperty(houseMenu, MP_UNI_TEXT, i, textbuf_input);
		        		new textbuf_origin[50];
		        		itm_getProperty(sign, IP_STR_NAME, _, textbuf_origin);
		        		trim(textbuf_input);
					if( strcmp( textbuf_input,textbuf_origin)) //go on to get the entry if input different from origin
		        		{
		        			//printf("set name of house to: %s", textbuf_input);
		        			itm_setProperty(sign, IP_STR_NAME, _, textbuf_input);
		        		}
				}
				#if _AUTOBOUNCE_AVAIL
				else if(i==12) //autobounce
				{
					new checked = gui_getProperty(houseMenu,MP_CHECK,i);
					if( itm_isaLocalVar( house, AUTOBOUNCEVAR, VAR_TYPE_ANY ) == 0) //0 means no var at globalVar
						itm_addLocalIntVar( house, AUTOBOUNCEVAR, checked );
					else if(itm_isaLocalVar( house, AUTOBOUNCEVAR, VAR_TYPE_STRING ) == 1) //there already is a string variable (shouldn't happen)
					{
						itm_delLocalVar( house, AUTOBOUNCEVAR, VAR_TYPE_STRING);
						itm_addLocalIntVar( house, AUTOBOUNCEVAR, checked );
					}
					else if(itm_getLocalIntVar(house, AUTOBOUNCEVAR) != checked)
					{
						itm_setLocalIntVar( house, AUTOBOUNCEVAR, checked );
						if(checked = 1)
						{
							itm_setEventHandler(house, EVENT_CHR_ONMULTIENTER, EVENTTYPE_STATIC, "BounceBan");
						}
						else itm_delEventHandler(house, EVENT_CHR_ONMULTIENTER);
					}
				}
				#endif
			}//for
			set_clear( setlist );
			set_addCoOwners( setlist, house);
			i=21;
			for (set_rewind(setlist);!set_end(setlist);)
			{
				chr = set_getChar( setlist );
				if(gui_getProperty(houseMenu,MP_CHECK,i)==0)
					house_removeCoOwner(house, chr);
				i++;
			}
			set_clear( setlist );
			set_addFriends( setlist, house);
			i=31;
			for (set_rewind(setlist);!set_end(setlist);)
			{
				chr = set_getChar( setlist );
				if(gui_getProperty(houseMenu,MP_CHECK,i)==0)
					house_removeFriend(house, chr);
				i++;
			}
			set_clear( setlist );
			set_addBanned( setlist, house);
			i=51;
			for (set_rewind(setlist);!set_end(setlist);)
			{
				chr = set_getChar( setlist );
				if(gui_getProperty(houseMenu,MP_CHECK,i)==0)
					house_removeBan(house, chr);
				i++;
			}
			set_delete(setlist);
		}
		case 12..17: //add/clean lists
		{
			if((buttonCode==12)||(buttonCode==14)||(buttonCode==16))
			{
				new setlist = set_create();
				new listsize;
				if(buttonCode==12)
				{
					set_addCoOwners( setlist, house);
					listsize = set_size( setlist );
					if( listsize<HOUSE_COOWNER)
					{
						chr_message( chrsource, _, msg_housemenuDef[1]);
						target_create( chrsource, house,_, _,  "Addcoowner" );
						return;
					}
					else chr_message(chrsource,chrsource, msg_housemenuDef[2], HOUSE_COOWNER);
				}
				else if(buttonCode==14)
				{
					set_addFriends( setlist, house);
					listsize = set_size( setlist );
					if( listsize<HOUSE_FRIENDS)
					{
						chr_message( chrsource, _, msg_housemenuDef[3]);
						target_create( chrsource,house, _, _, "Addfriend" );
						return;
					}
					else chr_message(chrsource,chrsource, msg_housemenuDef[4], HOUSE_COOWNER);
				}
				else if(buttonCode==16)
				{
					set_addBanned( setlist, house);
					listsize = set_size( setlist );
					if( listsize<HOUSE_BANNED)
					{
						chr_message( chrsource, _, msg_housemenuDef[5]);
						target_create( chrsource,house, _, _, "AddBanned" );
						return;
					}
					else chr_message(chrsource,chrsource, msg_housemenuDef[6], HOUSE_COOWNER);
				}
			}
			else if( (buttonCode==13)||(buttonCode==15)||(buttonCode==17))
			{
				new setlist = set_create();
				if(buttonCode==13)
				{
					set_addCoOwners( setlist, house);
					for (set_rewind(setlist);!set_end(setlist);)
					{
						chr = set_getChar( setlist );
						house_removeCoOwner(house, chr);
					}
				}
				else if(buttonCode==15)
				{
					set_addFriends( setlist, house);
					for (set_rewind(setlist);!set_end(setlist);)
					{
						chr = set_getChar( setlist );
						house_removeFriend(house, chr);
					}
				}
				else if(buttonCode==17)
				{
					set_addBanned( setlist, house);
					for (set_rewind(setlist);!set_end(setlist);)
					{
						chr = set_getChar( setlist );
						house_removeBan(house, chr);
					}
				}
			}
		}
		case 18: //bounce out
		{
			chr_message( chrsource, _, msg_housemenuDef[7]);
			target_create( chrsource,house, _, _, "Bounceout" );
			return;
		}
		case 19: //redeed
		{
			new deed = house_getProperty(house, HP_HOUSEDEED,_);
			house_delete(house);
			itm_createInBp( deed, chrsource, true);
		}
		case 20: //change locks
		{
			house_deleteKeys(house);
			house_changeLocks(house);
			house_makeKeys(house, chrsource);
		}
		case 21: //declare public
		{
			if(house_getProperty(house, HP_PUBLICHOUSE) == 0)
				house_setProperty(house, HP_PUBLICHOUSE, _, 1);
			else house_setProperty(house, HP_PUBLICHOUSE, _, 0);
		}
		case 22: //access bank account
		{
			new bank = chr_getBankBox(chrsource, BANKBOX_NORMAL);
			itm_showContainer(bank,chrsource);
		}
		case 23: //transfer
		{
			chr_message( chrsource, _, msg_housemenuDef[8]);
			target_create( chrsource,house, _, _, "TransferHouse" );
			return;
		}
		default: printf("unknown button");
	}
}

public Addcoowner( const t, const chrsource, const target, const x, const y, const z, const model, const house )
{
	if ( isChar(target) && !chr_isNpc(target)) //is player char
	{
		house_addCoOwner(house, target);
		printf("add char as coowner^n");
	}
	else chr_message(chrsource, chrsource, msg_housemenuDef[9]);
}

public Addfriend( const t, const chrsource, const target, const x, const y, const z, const model, const house )
{
	if ( isChar(target) && !chr_isNpc(target)) //is player char
		house_addFriend(house, target);
	else chr_message(chrsource, chrsource, msg_housemenuDef[10]);
}

public AddBanned( const t, const chrsource, const target, const x, const y, const z, const model, const house )
{
	//if ( isChar(target) && !chr_isNpc(target)) //is player char
	printf("enter addbanned^n");
	if ( isChar(target)) //is player char
		house_addBan(house, target);
	else chr_message(chrsource, chrsource, msg_housemenuDef[11]);
}

public Bounceout(const t, const chrsource, const target, const x, const y, const z, const model, const house)
{
	new hx1 = house_getProperty(house, HP_DIMENSION, 0);
	new hy1 = house_getProperty(house, HP_DIMENSION, 2);
	printf("hx: %d, hy: %d", hx1, hy1);
	chr_moveTo(target, hx1-1, hy1-1, chr_getProperty(target, CP_POSITION, CP2_X));
	chr_message(target, _, msg_housemenuDef[12]);
	chr_update(target);
}

public TransferHouse(const t, const chrsource, const target, const x, const y, const z, const model, const house)
{
	house_setProperty(house, HP_OWNER, _, target);
	chr_message(chrsource, _, msg_housemenuDef[13]);
	chr_message(target, _, msg_housemenuDef[14]);
}

public BounceBan(const house, const enterchr, const chrdir, const sequence)
{
	printf("enter multi, multi is %d, char is %d", house, enterchr);
	if(house_isBanned(house, enterchr) == 1)
	{
		Bounceout(0, 0, enterchr, 0, 0, 0, 0, house);
		chr_message(enterchr, _, msg_housemenuDef[15]);
	}
	else if( (itm_getLocalIntVar( house, AUTOBOUNCEVAR) == 1) && !(house_isFriend(house, enterchr)) && !(house_isCoOwner(house, enterchr)))
	{
		Bounceout(0, 0, enterchr, 0, 0, 0, 0, house);
		chr_message(enterchr, _, msg_housemenuDef[15]);
	}
}