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

#define _AUTOBOUNCE_AVAIL 0 // this activates auto-bounce option in gumps to prevent house looting by exploiter (getting into a house without using the door), 1 means ON (only friends and co-owner can enter the house no matter if the door is open or locked)
#define _AUTOBOUNCE_KEY 1 // this decides if the autoban should be only active if a non-friend/non-coowner enters the house and the door us looked, so _AUTOBOUNCE_KEY 1 means that player still need to take care for locked doors even if auto-bounce is active
const AUTOBOUNCEVAR = 9000;

const BUTTON_APPLY=11;
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

static xstart = 28;
static ystart = 114;

public housestart(const itm, const chr)
{
	bypass();
	//new tempStr[100];
        new more1 = itm_getProperty(itm, IP_MORE, 1);
        more1 = (more1&0xff)<<24;
	new more2 = itm_getProperty(itm, IP_MORE, 2);
	more2 = (more2&0xff)<<16;
	new more3 = itm_getProperty(itm, IP_MORE, 3);
	more3 = (more3&0xff)<<8;
	new more4 = itm_getProperty(itm, IP_MORE, 4);
	more4 = (more4&0xff)<<0;
	new house=more4+more3+more2+more1;
	printf("start house gump, house ser is %d, item ser is: %d^n", house, itm);
	printf("more4 verschoben: %d, more3: %d, more2: %d, more1: %d^n", more4, more3, more2, more1);
	menu_house(chr, house, 1);
}

public menu_house(const chr, const house, const pagenumber)
{
	new tempStr[100];
	new checklev = 0;
	new houseMenu = gui_create( 10,10,1,1,1,"house_cllbck" );
	new x;
	new y;

	gui_setProperty( houseMenu,MP_BUFFER,1,house );
	gui_setProperty( houseMenu,MP_BUFFER,3,BUTTON_APPLY );
	gui_setProperty( houseMenu,MP_BUFFER,4,pagenumber );

	gui_addResizeGump(houseMenu,0,0,2600,507,384);
	gui_addResizeGump(houseMenu,93,82,5100,0,0);
	gui_addResizeGump(houseMenu,37,85,3500,430,255);
	gui_addResizeGump(houseMenu,37,40,5100,437,23);

	gui_addPage(houseMenu,0);
	new arrayline = pagenumber-1;
	
	gui_addText(houseMenu,210,12,1210,"House Menue");
	gui_addButton( houseMenu,400,345, 0x084A, 0x084B,BUTTON_APPLY );
	gui_addText(houseMenu,58,41,33,"Info");
	gui_addButton(houseMenu,100,43,houseButton[arrayline][newhous1],houseButton[arrayline][oldhouse1],1);
	gui_addText(houseMenu,202,41,33,"Friends");
	gui_addButton(houseMenu,279,42,houseButton[arrayline][newhous2],houseButton[arrayline][oldhouse2],2);
	gui_addText(houseMenu,366,40,33,"Options");
	gui_addButton(houseMenu,423,42,houseButton[arrayline][newhous3],houseButton[arrayline][oldhouse3],3);

//Info
if( pagenumber ==1)
{
	gui_addText(houseMenu,xstart+40,ystart,1310,"Owner is:");
	new ownerser = house_getProperty(house, HP_OWNER, _);
	chr_getProperty(ownerser, CP_STR_NAME, _, tempStr);
	gui_addText(houseMenu,xstart+40+30,ystart,_,tempStr);
	printf("ownerser: %d^n", ownerser);
	
	gui_addText(houseMenu,xstart+40+250,ystart,1310,"Account:");
	sprintf( tempStr,"%d",chr_getProperty(ownerser,CP_ACCOUNT));
	gui_addText(houseMenu,xstart+40+330,ystart,_,tempStr);
	
	gui_addText(houseMenu,xstart+40,ystart+20,1310,"Number of locked down items:");
	sprintf( tempStr,"%d (of %d)", house_getProperty(house, HP_LOCKEDITEMS, _), house_getProperty(house, HP_MAXLOCKEDITEMS, _));
	gui_addText(houseMenu,xstart+40+253,ystart+20,_,tempStr);
	
	gui_addText(houseMenu,xstart+40,ystart+20*2,1310,"Number of secure container:");
	sprintf( tempStr,"%d (of %d)", house_getProperty(house, HP_SECUREDITEMS), house_getProperty(house, HP_MAXSECUREDITEMS));
	gui_addText(houseMenu,xstart+40+253,ystart+20*2,_,tempStr);
	
	gui_addGump(houseMenu,xstart+20, ystart+20*3, 0x827);
	gui_addText(houseMenu,xstart+40,ystart+20*3,1310,"This house is called:");
	house_getProperty(house, HP_STR_HOUSENAME, _, tempStr);
	gui_addInputField( houseMenu,xstart+40+253,ystart+20*3,150,20,11,_,tempStr);
	
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
	gui_addButton(houseMenu,60,114,housepic1,housepic2,11);
	gui_addText(houseMenu,90,111,1310,"List of Co-Owner");
	
	gui_addButton(houseMenu,60,114+23*1,housepic1,housepic2,12);
	gui_addText(houseMenu,90,111+23*1,1310,"Add a Co-Owner");
	
	gui_addButton(houseMenu,60,114+23*2,housepic1,housepic2,13);
	gui_addText(houseMenu,90,111+23*2,1310,"Remove a Co-Owner");
	
	gui_addButton(houseMenu,60,114+23*3,housepic1,housepic2,14);
	gui_addText(houseMenu,90,111+23*3,1310,"Delete all Co-Owner");
	
	gui_addButton(houseMenu,290,114,housepic1,housepic2,15);
	gui_addText(houseMenu,320,111,1310,"List of Friends");
	
	gui_addButton(houseMenu,290,114+23*1,housepic1,housepic2,16);
	gui_addText(houseMenu,320,111+23*1,1310,"Add a Friend");
	
	gui_addButton(houseMenu,290,114+23*2,housepic1,housepic2,17);
	gui_addText(houseMenu,320,111+23*2,1310,"Remove a Friend");
	
	gui_addButton(houseMenu,290,114+23*3,housepic1,housepic2,18);
	gui_addText(houseMenu,320,111+23*3,1310,"Delete all Friends");
	
	gui_addButton(houseMenu,116,230+23*0,housepic1,housepic2,19);
	gui_addText(houseMenu,146,227+23*0,1310,"Ban someone from the house");
	
	gui_addButton(houseMenu,116,230+23*1,housepic1,housepic2,20);
	gui_addText(houseMenu,146,227+23*1,1310,"Bounce someone out of the house");
	
	gui_addButton(houseMenu,116,230+23*2,housepic1,housepic2,21);
	gui_addText(houseMenu,146,227+23*2,1310,"View list of banned people");
	
	gui_addButton(houseMenu,116,230+23*3,housepic1,housepic2,22);
	gui_addText(houseMenu,146,227+23*3,1310,"Unban somone");
}
//options
else if(pagenumber ==3)
{
	
	gui_addButton(houseMenu,117,114,housepic1,housepic2,23);
	gui_addText(houseMenu,138,111+28*0,1310,"Transform house back into a deed");
	
	gui_addButton(houseMenu,117,114+28*1,housepic1,housepic2,24);
	gui_addText(houseMenu,138,111+28*1,1310,"Change the house locks");
	
	gui_addButton(houseMenu,117,114+28*2,housepic1,housepic2,25);
	gui_addText(houseMenu,138,111+28*2,1310,"Declare this house as public");
	gui_addText(houseMenu,138,111+28*3,1310,"- its not lockable then!");
	
	gui_addButton(houseMenu,117,114+28*4,housepic1,housepic2,26);
	gui_addText(houseMenu,138,111+28*4,1310,"Access your bank account");
	
	gui_addButton(houseMenu,117,114+28*5,housepic1,housepic2,27);
	gui_addText(houseMenu,138,111+28*5,1310,"Transfer ownership of the house");
}
gui_show(houseMenu, chr);
}

public house_cllbck(const houseMenu, const chrsource, const buttonCode)
{
	printf("start house callback, page: %d", buttonCode);
	new pagenumber = gui_getProperty(houseMenu, MP_BUFFER, 4);
	new house = gui_getProperty(houseMenu, MP_BUFFER, 1);
	new i;
	switch(buttonCode)
	{
		case 1..3: menu_house(chrsource, house, buttonCode);
		case 11:
		{
			for(i=11; i<=12;++i)
			{
				if(i==11) //house name
				{
					new textbuf_input[50];
		        		new textbuf_origin[50];
		        		new value=0;
		        		house_getProperty(house, HP_STR_HOUSENAME, _, textbuf_origin);
		        		trim(textbuf_input);
					if( strcmp( textbuf_input,textbuf_origin)) //go on to get the entry if input different from origin
		        		{		        			
		        			house_setProperty(house, HP_STR_HOUSENAME, _, textbuf_input);
		        		}
				}
				#if _AUTOBOUNCE_AVAIL
				else if(i==12) //autobounce
				{
					new checked = gui_getProperty(twkChrMenu,MP_CHECK,i);
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
							new autobounce = file_open(autobouncelist,"r");
						}
					}
				}
				#endif
			}//for
		}
		default: printf("unknown button");
	}
}