#include "small-scripts/translations/tweak_lines.sma"
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
const BUTTON_APPLY=11
const twkpages=9; //one line for one page, two rows for one page

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
old8,
new9,
old9
};

static twkButton[twkpages][twk_buttons] = {
{5003, 5209, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003},
{5209, 5003, 5003, 5209, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003},
{5209, 5003, 5209, 5003, 5003, 5209, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003},
{5209, 5003, 5209, 5003, 5209, 5003, 5003, 5209, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003},
{5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5003, 5209, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003},
{5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5003, 5209, 5209, 5003, 5209, 5003, 5209, 5003},
{5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5003, 5209, 5209, 5003, 5209, 5003},
{5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5003, 5209, 5209, 5003},
{5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5209, 5003, 5003, 5209}
};

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//                                      Item tweak definition                                             //
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

static it_pg1_l =0; //number of lines at left row
static it_pg1_r =0; //number of lines at right row
static it_pg2_l =0;
static it_pg2_r =0;
static it_pg3_l =0;
static it_pg3_r =0;
static it_pg4_l =0;
static it_pg4_r =0;
static it_pg5_l =0;
static it_pg5_r =0;

new it_gu = 40;
new it_tex = 56;
new it_prop = 195;
new it_check = 280;
new it_radio = 195;
new it_desc = 195;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//                                      Char tweak definition                                             //
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

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

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//                                         functions start                     //
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

public cmd_tweak(const chrsource)
{
	chr_message( chrsource, _, msg_commandsDef[38]);
	target_create( chrsource, _, _, _, "TweakStart" );
}

public TweakStart( const t, const chrsource, const target, const x, const y, const z, const model, const param1 )
{
	//printf("chrsource: %d, target: %d, modell: %d, t: %d^n", chrsource, target, model, t);
	if ( chrsource < 0 )
		return;
	if ( target <= 0)
	{
		chr_message( chrsource, _,msg_commandsDef[39]);
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
				else if((j==(ct_pg4_l+14)) || i==(NUM_chrtweak-1))
					ct_pg4_r = i; //maximum 14 lines that fit at row
			}//else if
			else if(ct_pg4_r < i <= (ct_pg4_r+14))//left row 4. page
			{
				if(j>(ct_pg4_r+14)) // to add radio button would extend over max line number
				{
					ct_pg5_l = i-1; //then fewer lines then max to keep it together
					i=ct_pg4_r+14;
				}
				else if((j==(ct_pg4_r+14)) || i==(NUM_chrtweak-1))
					ct_pg5_l = i; //maximum 14 lines that fit at row
			}
			else if(ct_pg5_l < i <= (ct_pg5_l+14))//right row 4. page
			{
				if(j>(ct_pg5_l+14)) // to add radio button would extend over max line number
				{
					ct_pg5_r = i-1; //then fewer lines then max to keep it together
					i=ct_pg5_l+14;
				}
				else if((j==(ct_pg5_l+14)) || i==(NUM_chrtweak-1))
					ct_pg5_r = i; //maximum 14 lines that fit at row
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
	gui_setProperty( twkItmMenu,MP_BUFFER,4,pagenumber );

	gui_addPage(twkItmMenu,0);
	gui_addResizeGump(twkItmMenu,10,35,5054,550,530 );
	gui_addResizeGump(twkItmMenu,20,105,3500,530,455);
	gui_addResizeGump(twkItmMenu,25,49,5100,525,51);
	
	gui_addText(twkItmMenu,250,32,1210,msg_commandsDef[40]);
	gui_addButton( twkItmMenu,460,525, 0x084A, 0x084B,BUTTON_APPLY );
	gui_addPage(twkItmMenu,1);
	new arrayline = pagenumber-1;
	gui_addButton(twkItmMenu,35,51,twkButton[arrayline][new1],twkButton[arrayline][old1],1);
	gui_addText(twkItmMenu,60,49,33,msg_commandsDef[41]);
	gui_addButton(twkItmMenu,170,51,twkButton[arrayline][new2],twkButton[arrayline][old2],2);
	gui_addText(twkItmMenu,195,49,33,msg_commandsDef[42]);
	gui_addButton(twkItmMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
	gui_addText(twkItmMenu,285,49,33,msg_commandsDef[43]);
	gui_addButton(twkItmMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
	gui_addText(twkItmMenu,380,49,33,msg_commandsDef[44]);
	gui_addButton(twkItmMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
	gui_addText(twkItmMenu,470,49,33,msg_commandsDef[45]); //events
	gui_addButton(twkItmMenu,35,81,twkButton[arrayline][new6],twkButton[arrayline][old6],6);
	gui_addText(twkItmMenu,60,79,33,msg_commandsDef[46]); //localvars
	
	gui_addText(twkItmMenu,66,120,33,msg_commandsDef[50]);
	sprintf( tempItmStr,"%d",itm_getProperty(target, IP_OWNERSERIAL));
	gui_addText( twkItmMenu, 130, 120,0,tempItmStr);
	
	gui_addText(twkItmMenu,220,120,33,msg_commandsDef[51]);
	sprintf( tempItmStr,"%d",itm_getProperty(target,IP_SERIAL));
	gui_addText( twkItmMenu, 276, 120,0,tempItmStr);
	
	gui_addGump(twkItmMenu,400,121, 0x827);
	gui_addText(twkItmMenu,421,120,33,msg_commandsDef[52]);
	gui_addPropField( twkItmMenu,485,120,50,150,245);
	
	new startline;
	new leftrow;
	new rightrow;
	new checklev;

	if( pagenumber == 1)
	{
		gui_addText(twkItmMenu,230,150,33,msg_commandsDef[41]);
		startline = 0;
		leftrow = it_pg1_l;
		rightrow = it_pg1_r;
	}
	else if( pagenumber == 2)
	{
		gui_addText(twkItmMenu,230,150,33,msg_commandsDef[42]);
		startline = it_pg1_r+1;
		leftrow = it_pg2_l;
		rightrow = it_pg2_r;
	}
	else if( pagenumber == 3)
	{
		gui_addText(twkItmMenu,230,150,33,msg_commandsDef[43]);
		startline = it_pg2_r+1;
		leftrow = it_pg3_l;
		rightrow = it_pg3_r;
	}
	else if( pagenumber == 4)
	{
		gui_addText(twkItmMenu,230,150,33,msg_commandsDef[44]);
		startline = it_pg3_r+1;
		leftrow = it_pg4_l;
		rightrow = it_pg4_r;
	}
	else if( pagenumber == 5) //events
	{
		gui_addText(twkItmMenu,230,150,33,msg_commandsDef[45]);
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
	else if( pagenumber == 6) //localvars
	{
		gui_addText(twkItmMenu,230,150,33,msg_commandsDef[53]);
		
		new count=0;
		new LocalV[512];
		new dividerrest=0;
		new divider;
		new num;
		new subpages=33; //subpages-lines we already have
		
		gui_addText( twkItmMenu, 40, 500, 33, msg_commandsDef[54]); //add
		
		gui_addText(twkItmMenu,150,500,0,msg_commandsDef[55]); //str
		gui_addRadioButton( twkItmMenu,190,503, oldpic,newpic,0,100);
		gui_addText(twkItmMenu,215,500,0,msg_commandsDef[56]); //int
		gui_addRadioButton( twkItmMenu,255,503, oldpic,newpic,0,101);
		gui_addText(twkItmMenu,280,500,0,msg_commandsDef[57]); //none
		gui_addRadioButton( twkItmMenu,320,503, oldpic,newpic,1,102);
		
		gui_addInputField( twkItmMenu, 370, 500, 40, 20, 5, 1310, msg_commandsDef[58]); //No
		gui_addInputField( twkItmMenu, 420, 500, 100, 20, 6, 1310, msg_commandsDef[59]);	//value
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
						sprintf(tempItmStr, msg_commandsDef[60], (subpagecount+1))
						gui_addText(twkItmMenu,330,520,1310,tempItmStr);
												
						//printf("make new page^n");
						gui_addPage(twkItmMenu,(subpagecount+1));
						
						//add pagebuttons to real dynamic pages that do not create additional pages
						gui_addText(twkItmMenu, 60,520,1310,msg_commandsDef[61]); //first page button
						gui_addPageButton(twkItmMenu, 40,523,2224,2224,1);
						
						if(subpagecount>=2)
						{
							gui_addPageButton(twkItmMenu,170,523,2223,2223,subpagecount); //previous page button at new page
							sprintf(tempItmStr, msg_commandsDef[62], subpagecount)
							gui_addText(twkItmMenu,190,520,1310,tempItmStr);
						}
												
						gui_addButton(twkItmMenu,35,51,twkButton[arrayline][new1],twkButton[arrayline][old1],1);
						gui_addText(twkItmMenu,60,49,33,msg_commandsDef[41]);
						gui_addButton(twkItmMenu,170,51,twkButton[arrayline][new2],twkButton[arrayline][old2],2);
						gui_addText(twkItmMenu,195,49,33,msg_commandsDef[42]);
						gui_addButton(twkItmMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
						gui_addText(twkItmMenu,285,49,33,msg_commandsDef[43]);
						gui_addButton(twkItmMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
						gui_addText(twkItmMenu,380,49,33,msg_commandsDef[44]);
						gui_addButton(twkItmMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
						gui_addText(twkItmMenu,470,49,33,msg_commandsDef[45]);
						gui_addButton(twkItmMenu,35,81,twkButton[arrayline][new6],twkButton[arrayline][old6],6);
						gui_addText(twkItmMenu,60,79,33,msg_commandsDef[46]);
						
							gui_addText(twkItmMenu,66,120,33,msg_commandsDef[50]);
							sprintf( tempItmStr,"%d",itm_getProperty(target, IP_OWNERSERIAL));
							gui_addText( twkItmMenu, 130, 120,0,tempItmStr);
							
							gui_addText(twkItmMenu,220,120,33,msg_commandsDef[51]);
							sprintf( tempItmStr,"%d",itm_getProperty(target,IP_SERIAL));
							gui_addText( twkItmMenu, 276, 120,0,tempItmStr);
							
							gui_addGump(twkItmMenu,400,121, 0x827);
							gui_addText(twkItmMenu,421,120,33,msg_commandsDef[52]);
							gui_addPropField( twkItmMenu,485,120,50,150,245);
						
						sprintf( tempItmStr,msg_commandsDef[63],(subpagecount+1));
						gui_addText(twkItmMenu,230,150,33,tempItmStr);
						
						if (itm_isaLocalVar(target, num, VAR_TYPE_INTEGER))
						{
							sprintf(LocalV, "%d", itm_getLocalIntVar(target,num));
							sprintf(tempItmStr, msg_commandsDef[64] , num);
						}
						else
						{
							itm_getLocalStrVar(target, num, LocalV);
							sprintf(tempItmStr, msg_commandsDef[65] , num);
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
								sprintf(LocalV, "%d %d", num, itm_getLocalIntVar(target,num));
								sprintf(tempItmStr, msg_commandsDef[64] , num);
							}
							else
							{
								itm_getLocalStrVar(target, num, LocalV);
								sprintf(tempItmStr, msg_commandsDef[65] , num, LocalV);
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
								sprintf(LocalV, "%d %d", num, itm_getLocalIntVar(target,num));
								sprintf(tempItmStr, msg_commandsDef[64] , num);
							}
							else
							{
								itm_getLocalStrVar(target, num, LocalV);
								sprintf(tempItmStr, msg_commandsDef[65] , num, LocalV);
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
							sprintf(LocalV, "%d %d", num, itm_getLocalIntVar(target,num));
							sprintf(tempItmStr, msg_commandsDef[64] , num);
						}
						else if(itm_isaLocalVar(target, num, VAR_TYPE_STRING))
						{
							itm_getLocalStrVar(target, num, LocalV);
							sprintf(tempItmStr, msg_commandsDef[65] , num, LocalV);
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
							sprintf(LocalV, "%d %d", num, itm_getLocalIntVar(target,num));
							sprintf(tempItmStr, msg_commandsDef[64] , num);
						}
						else if(itm_isaLocalVar(target, num, VAR_TYPE_STRING))
						{
							itm_getLocalStrVar(target, num, LocalV);
							sprintf(tempItmStr, msg_commandsDef[65] , num, LocalV);
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
	
	if( 1<= pagenumber <= 5)
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

public tweakItmBck(const twkItmMenu, const chrsource, const buttonCode)
{
	new target = gui_getProperty( twkItmMenu,MP_BUFFER,1 ); //target
	new pagenumber = gui_getProperty( twkItmMenu,MP_BUFFER,4 );
	new leftrow;
	new rightrow;
	new tempItmStr[50];
	/*
	new startline;
	if( pagenumber == 1)
	{
		startline = 0;
		leftrow = it_pg1_l;
		rightrow = it_pg1_r;
	}
	else if( pagenumber == 2)
	{
		startline = it_pg1_r+1;
		leftrow = it_pg2_l;
		rightrow = it_pg2_r;
	}
	else if( pagenumber == 3)
	{
		startline = it_pg2_r+1;
		leftrow = it_pg3_l;
		rightrow = it_pg3_r;
	}
	else if( pagenumber == 4)
	{
		startline = it_pg3_r+1;
		leftrow = it_pg4_l;
		rightrow = it_pg4_r;
	}
	else if( pagenumber == 5)
	{
		startline = it_pg4_r+1;
		leftrow = it_pg5_l;
		rightrow = it_pg5_r;
	}*/
	new endline;
	new i=0;
	//performance saver, only go through the array lines shown at the page with apply button
	if((rightrow == 0) && (leftrow != 0))
		endline = leftrow;
	else if((rightrow != 0) && (leftrow != 0))
		endline = rightrow;
	new checked;
	if( 1 <= buttonCode <= 9)
	{
		tweak_itm(chrsource, target, buttonCode);
	}
	else if( buttonCode == 11) //apply
	{
		if( 1<= pagenumber <= 5)
		{
			for(i=0; i <= NUM_itmtweak; ++i)
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
					if(itm_twkarray[i][it_propval] != 0)
					{
						limit = itm_twkarray[i][it_propval];
					}
					for( new m = 0; m <= limit; ++m)
					{
						if(gui_getProperty(twkItmMenu,MP_RADIO,i))
							itm_setProperty( target, itm_twkarray[i][it_propnumber], _, itm_twkarray[i][it_infotype]);
						++i;
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
						gui_getProperty(twkItmMenu,MP_UNI_TEXT,i,textbuf_input);
						trim(textbuf_input);
						if (isStrUnsignedInt(textbuf_input)) //should be an integer, is it?
						{
							value = str2UnsignedInt(textbuf_input);
							new moreb1 = value%256;
							new moreb2 = value/256;
							itm_setProperty(target, IP_MOREB, 1+2*stocktype, moreb1);
							itm_setProperty(target, IP_MOREB, 2+2*stocktype, moreb2);
							//printf("moreb1-subprop: %d, moreb2-subprop: %d^n", 1+2*stocktype*(9/10), 2+2*stocktype*(9/10));
						}
						else chr_message( chrsource, _,msg_commandsDef[76]);
					}
				}//linetype
			}//for
		}//array page
		else if(pagenumber == 9) //events
		{
			new callname[15];
		        new oldevent[15];
		        checked = gui_getProperty(twkItmMenu,MP_CHECK,i+1);
		        for(i=0;i<NUM_itmevent;i++)
		        {
		        	if ( checked != 1) // no more checked and event had existed
		        	{
		        		//printf("del event");
		        		itm_delEventHandler(target, eventItm_array[i][eventnum]);
		        	}
		        	else
		        	{
		        		gui_getProperty(twkItmMenu,MP_UNI_TEXT,i+1,callname);
		        		trim(callname);
		        		itm_getEventHandler(target,eventItm_array[i][eventnum],oldevent);
		        		if( strcmp( callname, oldevent) ) //different input happened
		        			itm_setEventHandler(target, eventItm_array[i][eventnum], EVENTTYPE_STATIC, callname);
		        	}
		        	sprintf(callname, "");
		        }//for
		}
	        else if(pagenumber == 6) //localVars
		{
		       	checked = gui_getProperty(twkItmMenu,MP_CHECK,i);
		       	for(i=1000;i<5000;i++)
		       	{
		       		if (chr_isaLocalVar(target, i, VAR_TYPE_ANY))
		       		{
		       			if(checked != 1)
		       			{
		       				itm_delLocalVar(target, i)
		       			}
		       			else if(itm_isaLocalVar(target, i, VAR_TYPE_INTEGER))
		       			{
		       				gui_getProperty(twkItmMenu,MP_UNI_TEXT,i,tempItmStr);
		       				trim(tempItmStr);
		       				if (isStrUnsignedInt(tempItmStr) || strcmp( !tempItmStr, "0" ))
		       				{
		       					new value = str2UnsignedInt(tempItmStr);
		       					if(itm_getLocalIntVar(target,i)!=value)
		       						itm_setLocalIntVar(target, i, value);
		       				}
		       				else
		       					chr_message(target, _, msg_commandsDef[76]);
		       			}
		       			else if(chr_isaLocalVar(target, i, VAR_TYPE_STRING))
		       			{
		       				new value[256];
		       				gui_getProperty(twkItmMenu,MP_UNI_TEXT,i,tempItmStr);
		       				itm_getLocalStrVar(target,i, value);
		       				if( strcmp( value, tempItmStr )) //is different
		       					itm_setLocalStrVar(target, i, tempItmStr);
		       			}//if var test
		       		}//if
		       	}//for
		       	if(gui_getProperty(twkItmMenu,MP_RADIO,101)) //integer var adding
		       	{
		       		new tempItmStrB[15];
		       		new inpt[15];
		       		gui_getProperty(twkItmMenu,MP_UNI_TEXT,5,tempItmStrB); //number
		       		trim(tempItmStrB);
		       		if(isStrUnsignedInt(tempItmStrB)) //is numeric
		       		{
		       			new number = str2UnsignedInt(tempItmStrB);
		       			//printf("tempChrStrB: %s, number: %d^n", tempChrStrB, number);
		       			if(!(itm_isaLocalVar(target, number, VAR_TYPE_ANY))) //already exist
		       			{
		       				gui_getProperty(twkItmMenu,MP_UNI_TEXT,6,inpt); //value
		       				trim(inpt);
		       				//printf("value: %s^n", inpt);
		       				if ( (isStrUnsignedInt(inpt)) || strcmp( !inpt, "0" )) //value is numeric
		       				{
		       					new value = str2UnsignedInt(inpt);
		       					itm_addLocalIntVar(target, number);
		       					itm_setLocalIntVar(target, number, value);
		       				}
		       				else
		       					chr_message(target, _, msg_commandsDef[76]);
		       			}
		       			else
		       				chr_message(target, _, msg_commandsDef[78]);
		       		}
		       		else
		       			chr_message(target, _, msg_commandsDef[77]);
		       	}
		       	else if(gui_getProperty(twkItmMenu,MP_RADIO,100)) //string localvar
		       	{
		       		new tempItmStrB[15];
		       		new inpt[15];
		       		gui_getProperty(twkItmMenu,MP_UNI_TEXT,5,tempItmStrB); //number
		       		trim(tempItmStrB);
		       		if(isStrUnsignedInt(tempItmStrB)) //is numeric
		       		{
		       			new number = str2UnsignedInt(tempItmStrB);
		       			//printf("tempChrStrB: %s, number: %d^n", tempChrStrB, number);
		       			if(!(itm_isaLocalVar(target, number, VAR_TYPE_ANY))) //already exist
		       			{
		       				gui_getProperty(twkItmMenu,MP_UNI_TEXT,6,inpt); //value
		       				//printf("input: %s", inpt);
		       				itm_addLocalStrVar(target, number);
		       				itm_setLocalStrVar(target, number, inpt);
		       			}
		       			else
		       				chr_message(target, _, msg_commandsDef[78]);
		       		}
		       		else
		       			chr_message(target, _, msg_commandsDef[77]);
		       	}
		}//pagenumber
	itm_refresh(target);
	}//apply
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
//                                                  char tweak                                           //
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

public tweak_char(const chrsource, const target, pagenumber)
{
	//printf("enter char tweak seite %d^n", pagenumber);
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
	
	gui_addText(twkChrMenu,250,32,1210,msg_commandsDef[40]);
	gui_addButton( twkChrMenu,460,525, 0x084A, 0x084B,BUTTON_APPLY );
	gui_addPage(twkChrMenu,1);

	new arrayline = pagenumber-1;

	gui_addButton(twkChrMenu,35,51,twkButton[arrayline][new1],twkButton[arrayline][old1],1);
	gui_addText(twkChrMenu,60,49,33,msg_commandsDef[41]);
	gui_addButton(twkChrMenu,170,51,twkButton[arrayline][new2],twkButton[arrayline][old2],2);
	gui_addText(twkChrMenu,195,49,33,msg_commandsDef[42]);//flag1
	gui_addButton(twkChrMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
	gui_addText(twkChrMenu,285,49,33,msg_commandsDef[43]);//flag2
	gui_addButton(twkChrMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
	gui_addText(twkChrMenu,380,49,33,msg_commandsDef[44]);//flag3
	gui_addButton(twkChrMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
	gui_addText(twkChrMenu,470,49,33,msg_commandsDef[47]);//flag4
	gui_addButton(twkChrMenu,35,81,twkButton[arrayline][new6],twkButton[arrayline][old6],6);
	gui_addText(twkChrMenu,60,79,33,msg_commandsDef[45]); //localVars
	gui_addButton(twkChrMenu,170,81,twkButton[arrayline][new7],twkButton[arrayline][old7],7);
	gui_addText(twkChrMenu,195,79,33,msg_commandsDef[48]);//skill
	gui_addButton(twkChrMenu,260,81,twkButton[arrayline][new8],twkButton[arrayline][old8],8);
	gui_addText(twkChrMenu,285,79,33,msg_commandsDef[49]);//layer
	gui_addButton(twkChrMenu,355,81,twkButton[arrayline][new9],twkButton[arrayline][old9],9);
	gui_addText(twkChrMenu,380,79,33,msg_commandsDef[46]);//event
	
	//printf("target: %d", target);
	gui_addText(twkChrMenu,66,120,33,msg_commandsDef[66]);
	sprintf( tempChrStr,"%d",chr_getProperty(target,CP_ACCOUNT));
	gui_addText( twkChrMenu, 185, 120,0,tempChrStr);
	
	gui_addText(twkChrMenu,280,120,33,msg_commandsDef[51]);
	sprintf( tempChrStr,"%d",chr_getProperty(target,CP_SERIAL));
	gui_addText( twkChrMenu, 336, 120,0,tempChrStr);
	
	gui_addGump(twkChrMenu,430,121, 0x827);
	gui_addText(twkChrMenu,451,120,33,msg_commandsDef[67]);
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
		gui_addText(twkChrMenu,230,150,33,msg_commandsDef[41]);
		startline = 0;
		leftrow = ct_pg1_l;
		rightrow = ct_pg1_r;
	}
	else if( pagenumber == 2)
	{
		gui_addText(twkChrMenu,230,150,33,msg_commandsDef[42]);
		startline = ct_pg1_r+1;
		leftrow = ct_pg2_l;
		rightrow = ct_pg2_r;
	}
	else if( pagenumber == 3)
	{
		gui_addText(twkChrMenu,230,150,33,msg_commandsDef[43]);
		startline = ct_pg2_r+1;
		leftrow = ct_pg3_l;
		rightrow = ct_pg3_r;
	}
	else if( pagenumber == 4)
	{
		gui_addText(twkChrMenu,230,150,33,msg_commandsDef[44]);
		startline = ct_pg3_r+1;
		leftrow = ct_pg4_l;
		rightrow = ct_pg4_r;
	}
	else if( pagenumber == 5)
	{
		gui_addText(twkChrMenu,230,150,33,msg_commandsDef[45]);
		startline = ct_pg4_r+1;
		leftrow = ct_pg5_l;
		rightrow = ct_pg5_r;
	}
	//printf("rightrow: %d, leftrow: %d", rightrow, leftrow);
	if( 1<= pagenumber <= 5)
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
					new infotext=1;
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
					else if(q==4)//creation day
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
					else if(q==5) //kill/dead
					{
						new status = chr_getProperty(target,chr_twkarray[i][ct_propval]);
						if(status == 1)
							checklev = 1;
						gui_addText(twkChrMenu,ct_tex+k,180+(n*20),1310,chr_twkarray[i][ct_linename]);
						gui_addCheckbox( twkChrMenu,ct_prop+k,181+(n*20),oldpic,newpic,checklev,i);
						checklev = 0;
						infotext=0;
						printf("status: %d", status);
					}
					gui_addText(twkChrMenu,ct_tex+k,180+(n*20),1310,chr_twkarray[i][ct_linename]);
					if(chr_twkarray[i][ct_infotype] == 0) //integer value to display
						sprintf(tempChrStr, "%d", output);
					if(infotext == 1)
						gui_addText( twkChrMenu, ct_desc+k, 180+(n*20),0,tempChrStr);
					tempChrStr=" ";
				}
				default: printf("unknown item-tweak case!");
			}//linetype
			n=n+1;
		}//for
	}//if pagenumber

	else if(pagenumber == 9)
	{
		gui_addPageButton(twkChrMenu,210,493,2224,2117,2);
		gui_addText(twkChrMenu,240,490,1310,msg_commandsDef[68]);
		gui_addPageButton(twkChrMenu,320,493,2224,2117,3);
		gui_addText(twkChrMenu,350,490,1310,msg_commandsDef[69]);
		
		gui_addText(twkChrMenu,50,150,1310,msg_commandsDef[70]);

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
		gui_addText(twkChrMenu,130,490,1310,msg_commandsDef[70]);
		gui_addPageButton(twkChrMenu,320,493,2224,2117,3);
		gui_addText(twkChrMenu,350,490,1310,msg_commandsDef[69]);
		
		gui_addButton(twkChrMenu,35,51,twkButton[arrayline][new1],twkButton[arrayline][old1],1);
	gui_addText(twkChrMenu,60,49,33,msg_commandsDef[41]);
	gui_addButton(twkChrMenu,170,51,twkButton[arrayline][new2],twkButton[arrayline][old2],2);
	gui_addText(twkChrMenu,195,49,33,msg_commandsDef[42]);//flag1
	gui_addButton(twkChrMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
	gui_addText(twkChrMenu,285,49,33,msg_commandsDef[43]);//flag2
	gui_addButton(twkChrMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
	gui_addText(twkChrMenu,380,49,33,msg_commandsDef[44]);//flag3
	gui_addButton(twkChrMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
	gui_addText(twkChrMenu,470,49,33,msg_commandsDef[47]);//flag4
	gui_addButton(twkChrMenu,35,81,twkButton[arrayline][new6],twkButton[arrayline][old6],6);
	gui_addText(twkChrMenu,60,79,33,msg_commandsDef[45]); //localVars
	gui_addButton(twkChrMenu,170,81,twkButton[arrayline][new7],twkButton[arrayline][old7],7);
	gui_addText(twkChrMenu,195,79,33,msg_commandsDef[48]);//skill
	gui_addButton(twkChrMenu,260,81,twkButton[arrayline][new8],twkButton[arrayline][old8],8);
	gui_addText(twkChrMenu,285,79,33,msg_commandsDef[49]);//layer
	gui_addButton(twkChrMenu,355,81,twkButton[arrayline][new9],twkButton[arrayline][old9],9);
	gui_addText(twkChrMenu,380,79,33,msg_commandsDef[46]);//event
	
	//printf("target: %d", target);
	gui_addText(twkChrMenu,66,120,33,msg_commandsDef[66]);
	sprintf( tempChrStr,"%d",chr_getProperty(target,CP_ACCOUNT));
	gui_addText( twkChrMenu, 185, 120,0,tempChrStr);
	
	gui_addText(twkChrMenu,280,120,33,msg_commandsDef[51]);
	sprintf( tempChrStr,"%d",chr_getProperty(target,CP_SERIAL));
	gui_addText( twkChrMenu, 336, 120,0,tempChrStr);
	
	gui_addGump(twkChrMenu,430,121, 0x827);
	gui_addText(twkChrMenu,451,120,33,msg_commandsDef[67]);
	gui_addPropField( twkChrMenu,515,120,50,30,CP_NPCAI);
		
		gui_addText(twkChrMenu,50,150,1310,msg_commandsDef[68]);

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
		gui_addText(twkChrMenu,130,490,1310,msg_commandsDef[70]);
		gui_addPageButton(twkChrMenu,210,493,2224,2117,2);
		gui_addText(twkChrMenu,240,490,1310,msg_commandsDef[68]);
		
	gui_addButton(twkChrMenu,35,51,twkButton[arrayline][new1],twkButton[arrayline][old1],1);
	gui_addText(twkChrMenu,60,49,33,msg_commandsDef[41]);
	gui_addButton(twkChrMenu,170,51,twkButton[arrayline][new2],twkButton[arrayline][old2],2);
	gui_addText(twkChrMenu,195,49,33,msg_commandsDef[42]);//flag1
	gui_addButton(twkChrMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
	gui_addText(twkChrMenu,285,49,33,msg_commandsDef[43]);//flag2
	gui_addButton(twkChrMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
	gui_addText(twkChrMenu,380,49,33,msg_commandsDef[44]);//flag3
	gui_addButton(twkChrMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
	gui_addText(twkChrMenu,470,49,33,msg_commandsDef[47]);//flag4
	gui_addButton(twkChrMenu,35,81,twkButton[arrayline][new6],twkButton[arrayline][old6],6);
	gui_addText(twkChrMenu,60,79,33,msg_commandsDef[45]); //localVars
	gui_addButton(twkChrMenu,170,81,twkButton[arrayline][new7],twkButton[arrayline][old7],7);
	gui_addText(twkChrMenu,195,79,33,msg_commandsDef[48]);//skill
	gui_addButton(twkChrMenu,260,81,twkButton[arrayline][new8],twkButton[arrayline][old8],8);
	gui_addText(twkChrMenu,285,79,33,msg_commandsDef[49]);//layer
	gui_addButton(twkChrMenu,355,81,twkButton[arrayline][new9],twkButton[arrayline][old9],9);
	gui_addText(twkChrMenu,380,79,33,msg_commandsDef[46]);//event
	
	//printf("target: %d", target);
	gui_addText(twkChrMenu,66,120,33,msg_commandsDef[66]);
	sprintf( tempChrStr,"%d",chr_getProperty(target,CP_ACCOUNT));
	gui_addText( twkChrMenu, 185, 120,0,tempChrStr);
	
	gui_addText(twkChrMenu,280,120,33,msg_commandsDef[51]);
	sprintf( tempChrStr,"%d",chr_getProperty(target,CP_SERIAL));
	gui_addText( twkChrMenu, 336, 120,0,tempChrStr);
	
	gui_addGump(twkChrMenu,430,121, 0x827);
	gui_addText(twkChrMenu,451,120,33,msg_commandsDef[67]);
	gui_addPropField( twkChrMenu,515,120,50,30,CP_NPCAI);
		
		gui_addText(twkChrMenu,50,150,1310,msg_commandsDef[69]);

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
		gui_addText(twkChrMenu,100,150,33,msg_commandsDef[71]);
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
		
		gui_addText(twkChrMenu,130,490,1310,msg_commandsDef[72]);
		gui_addPageButton(twkChrMenu,100,493,2224,2117,2);
		
		gui_addPage(twkChrMenu,2);
		gui_addPageButton(twkChrMenu,100,493,2224,2117,1);
		gui_addText(twkChrMenu,130,490,1310,msg_commandsDef[71]);
		
	gui_addButton(twkChrMenu,35,51,twkButton[arrayline][new1],twkButton[arrayline][old1],1);
	gui_addText(twkChrMenu,60,49,33,msg_commandsDef[41]);
	gui_addButton(twkChrMenu,170,51,twkButton[arrayline][new2],twkButton[arrayline][old2],2);
	gui_addText(twkChrMenu,195,49,33,msg_commandsDef[42]);//flag1
	gui_addButton(twkChrMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
	gui_addText(twkChrMenu,285,49,33,msg_commandsDef[43]);//flag2
	gui_addButton(twkChrMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
	gui_addText(twkChrMenu,380,49,33,msg_commandsDef[44]);//flag3
	gui_addButton(twkChrMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
	gui_addText(twkChrMenu,470,49,33,msg_commandsDef[47]);//flag4
	gui_addButton(twkChrMenu,35,81,twkButton[arrayline][new6],twkButton[arrayline][old6],6);
	gui_addText(twkChrMenu,60,79,33,msg_commandsDef[45]); //localVars
	gui_addButton(twkChrMenu,170,81,twkButton[arrayline][new7],twkButton[arrayline][old7],7);
	gui_addText(twkChrMenu,195,79,33,msg_commandsDef[48]);//skill
	gui_addButton(twkChrMenu,260,81,twkButton[arrayline][new8],twkButton[arrayline][old8],8);
	gui_addText(twkChrMenu,285,79,33,msg_commandsDef[49]);//layer
	gui_addButton(twkChrMenu,355,81,twkButton[arrayline][new9],twkButton[arrayline][old9],9);
	gui_addText(twkChrMenu,380,79,33,msg_commandsDef[46]);//event
	
	//printf("target: %d", target);
	gui_addText(twkChrMenu,66,120,33,msg_commandsDef[66]);
	sprintf( tempChrStr,"%d",chr_getProperty(target,CP_ACCOUNT));
	gui_addText( twkChrMenu, 185, 120,0,tempChrStr);
	
	gui_addText(twkChrMenu,280,120,33,msg_commandsDef[51]);
	sprintf( tempChrStr,"%d",chr_getProperty(target,CP_SERIAL));
	gui_addText( twkChrMenu, 336, 120,0,tempChrStr);
	
	gui_addGump(twkChrMenu,430,121, 0x827);
	gui_addText(twkChrMenu,451,120,33,msg_commandsDef[67]);
	gui_addPropField( twkChrMenu,515,120,50,30,CP_NPCAI);
		
		gui_addText(twkChrMenu,100,150,33,msg_commandsDef[73]);

		new combatSkills[8]={ SK_ARCHERY,SK_FENCING,SK_MACEFIGHTING,SK_PARRYING,SK_SWORDSMANSHIP,SK_TACTICS,SK_WRESTLING};
		for ( new i=0;i<8;++i)
		{
			gui_addGump(twkChrMenu,50,171+20*i, 0x827);
			gui_addText( twkChrMenu,66,170+20*i,1310,"%s : ",skillName[ combatSkills[i] ] );
			gui_addPropField( twkChrMenu,190,170+20*i,50,30,CP_BASESKILL,combatSkills[i],0 );
		}
		gui_addText(twkChrMenu,100,335,33,msg_commandsDef[71]);
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
		gui_addText(twkChrMenu,361,300,33,msg_commandsDef[74]);
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
		gui_addText(twkChrMenu,50,150,1110,msg_commandsDef[49]);
				
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
				sprintf(tempChrStr, msg_commandsDef[75]);
				gui_addText(twkChrMenu,330-t,250+(layer-s)*r,0,ct_layerprop[layer-1][lt_name]);
				gui_addText(twkChrMenu,410-t,250+(layer-s)*r,1310,tempChrStr);
				sprintf(tempChrStr, " ");
			}
		}
	}//pagenumber
	else if(pagenumber == 6)
	{
		gui_addText(twkChrMenu,230,150,33,msg_commandsDef[53]);
		
		new count=0;
		new LocalV[512];
		new dividerrest=0;
		new divider;
		new num;
		new subpages=33; //subpages-lines we already have
		
		gui_addText( twkChrMenu, 40, 500, 33, msg_commandsDef[54]); //add
		
		gui_addText(twkChrMenu,150,500,0,msg_commandsDef[55]); //str
		gui_addRadioButton( twkChrMenu,190,503, oldpic,newpic,0,100);
		gui_addText(twkChrMenu,215,500,0,msg_commandsDef[56]); //int
		gui_addRadioButton( twkChrMenu,255,503, oldpic,newpic,0,101);
		gui_addText(twkChrMenu,280,500,0,msg_commandsDef[57]); //none
		gui_addRadioButton( twkChrMenu,320,503, oldpic,newpic,1,102);
		
		gui_addInputField( twkChrMenu, 370, 500, 40, 20, 5, 1310, msg_commandsDef[58]); //No
		gui_addInputField( twkChrMenu, 420, 500, 100, 20, 6, 1310, msg_commandsDef[59]);	//value
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
						sprintf(tempChrStr, msg_commandsDef[60], (subpagecount+1))
						gui_addText(twkChrMenu,330,520,1310,tempChrStr);
												
						//printf("make new page^n");
						gui_addPage(twkChrMenu,(subpagecount+1));
						
						//add pagebuttons to real dynamic pages that do not create additional pages
						gui_addText(twkChrMenu, 60,520,1310,msg_commandsDef[61]); //first page button
						gui_addPageButton(twkChrMenu, 40,523,2224,2224,1);
						
						if(subpagecount>=2)
						{
							gui_addPageButton(twkChrMenu,170,523,2223,2223,subpagecount); //previous page button at new page
							sprintf(tempChrStr, msg_commandsDef[62], subpagecount)
							gui_addText(twkChrMenu,190,520,1310,tempChrStr);
						}
												
						gui_addButton(twkChrMenu,35,51,twkButton[arrayline][new1],twkButton[arrayline][old1],1);
						gui_addText(twkChrMenu,60,49,33,msg_commandsDef[41]);
						gui_addButton(twkChrMenu,170,51,twkButton[arrayline][new2],twkButton[arrayline][old2],2);
						gui_addText(twkChrMenu,195,49,33,msg_commandsDef[42]);
						gui_addButton(twkChrMenu,260,51,twkButton[arrayline][new3],twkButton[arrayline][old3],3);
						gui_addText(twkChrMenu,285,49,33,msg_commandsDef[43]);
						gui_addButton(twkChrMenu,355,51,twkButton[arrayline][new4],twkButton[arrayline][old4],4);
						gui_addText(twkChrMenu,380,49,33,msg_commandsDef[44]);
						gui_addButton(twkChrMenu,445,51,twkButton[arrayline][new5],twkButton[arrayline][old5],5);
						gui_addText(twkChrMenu,470,49,33,msg_commandsDef[45]);
						gui_addButton(twkChrMenu,35,81,twkButton[arrayline][new6],twkButton[arrayline][old6],6);
						gui_addText(twkChrMenu,60,79,33,msg_commandsDef[46]);
						
							gui_addText(twkChrMenu,66,120,33,msg_commandsDef[50]);
							sprintf( tempChrStr,"%d",chr_getProperty(target, IP_OWNERSERIAL));
							gui_addText( twkChrMenu, 130, 120,0,tempChrStr);
							
							gui_addText(twkChrMenu,220,120,33,msg_commandsDef[51]);
							sprintf( tempChrStr,"%d",chr_getProperty(target,IP_SERIAL));
							gui_addText( twkChrMenu, 276, 120,0,tempChrStr);
							
							gui_addGump(twkChrMenu,400,121, 0x827);
							gui_addText(twkChrMenu,421,120,33,msg_commandsDef[52]);
							gui_addPropField( twkChrMenu,485,120,50,150,245);
						
						sprintf( tempChrStr,msg_commandsDef[63],(subpagecount+1));
						gui_addText(twkChrMenu,230,150,33,tempChrStr);
						
						if (chr_isaLocalVar(target, num, VAR_TYPE_INTEGER))
						{
							sprintf(LocalV, "%d", chr_getLocalIntVar(target,num));
							sprintf(tempChrStr, msg_commandsDef[64] , num);
						}
						else
						{
							chr_getLocalStrVar(target, num, LocalV);
							sprintf(tempChrStr, msg_commandsDef[65] , num);
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
								sprintf(LocalV, "%d %d", num, chr_getLocalIntVar(target,num));
								sprintf(tempChrStr, msg_commandsDef[64] , num);
							}
							else
							{
								chr_getLocalStrVar(target, num, LocalV);
								sprintf(tempChrStr, msg_commandsDef[65] , num, LocalV);
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
								sprintf(LocalV, "%d %d", num, chr_getLocalIntVar(target,num));
								sprintf(tempChrStr, msg_commandsDef[64] , num);
							}
							else
							{
								chr_getLocalStrVar(target, num, LocalV);
								sprintf(tempChrStr, msg_commandsDef[65] , num, LocalV);
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
							sprintf(LocalV, "%d %d", num, chr_getLocalIntVar(target,num));
							sprintf(tempChrStr, msg_commandsDef[64] , num);
						}
						else if(chr_isaLocalVar(target, num, VAR_TYPE_STRING))
						{
							chr_getLocalStrVar(target, num, LocalV);
							sprintf(tempChrStr, msg_commandsDef[65] , num, LocalV);
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
							sprintf(LocalV, "%d %d", num, chr_getLocalIntVar(target,num));
							sprintf(tempChrStr, msg_commandsDef[64] , num);
						}
						else if(chr_isaLocalVar(target, num, VAR_TYPE_STRING))
						{
							chr_getLocalStrVar(target, num, LocalV);
							sprintf(tempChrStr, msg_commandsDef[65] , num, LocalV);
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
		startline = ct_pg3_r+1;
		leftrow = ct_pg4_l;
		rightrow = ct_pg4_r;
	}
	else if( pagenumber == 5)
	{
		startline = ct_pg4_r+1;
		leftrow = ct_pg5_l;
		rightrow = ct_pg5_r;
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
		case 1..9: 	
		{	
			tweak_char(chrsource, target, buttonCode);
			//gui_delete( twkChrMenu );
		}
		case 11:
		{
			if(0 < pagenumber <= 5)
		        {
		        	for(i=startline; i<=endline; ++i)
		        	{
		        		checked=0;
		        		new linetype = chr_twkarray[i][ct_linetype];
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
		        				//printf("different input, type 3, line %d^n", i);
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
			        			else chr_message( chrsource, _,msg_commandsDef[65]);
			        		}
			        		else if( (type == 1) && (tempfx_isActive( target,chr_twkarray[i][ct_infotype]) == 1) && (checked != 1) ) // is tempfx line and this tempfx is active yet but no Entry made and not checked -> remove the tempfx
			        		{
			        			tempfx_delete( target,chr_twkarray[i][ct_infotype],true); //no more tempfx
			        		}	        						
			        	}//linetype
			        	else if(linetype == 4) //checkbox
		        		{
		        			checked = gui_getProperty(twkChrMenu,MP_CHECK,i); //is it checked?
		        			if((type == 134) || (type == 121)) //CP_PRIV or CP_PRIV2 or ... (bitfields)
						{
							new privvalue = chr_twkarray[i][ct_infotype];
							new originalvalue = chr_getProperty( target,type)&privvalue;
							if(privvalue >= 10)
								privvalue = (privvalue/10)*16;
							if( originalvalue == privvalue) //is already set
								checklev = 1;
							if( (checklev == 1) && (checked !=1) ) //is at TRUE and no longer checked
								chr_setProperty( target,type, _, chr_getProperty( target,type) &~ privvalue );
							else if( (checklev != 1) && (checked == 1)) //is false and checked now
								chr_setProperty( target,type, _, chr_getProperty( target,type) | privvalue );
						}
						else if(type == 0) //customized button function, for example open bank box
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
								new x = chr_getProperty(chr_getGuild(target), IP_POSITION, IP2_X);
								new y = chr_getProperty(chr_getGuild(target), IP_POSITION, IP2_Y);
								new z = chr_getProperty(chr_getGuild(target), IP_POSITION, IP2_Z);
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
							checklev = chr_getProperty(target,type); //status of property
							if((checklev == 0) && ( (checked == 1))) //is checked and was zero
								chr_setProperty( target, (type),_, 1);
							else if((checklev != 0) && (!(checked == 1))) //is not checked and was not zero
								chr_setProperty( target,(type) ,_, 1);
						}
		        		}
		        		else if(linetype == 5) //radiobutton
		        		{
		        			checked = gui_getProperty(twkChrMenu,MP_RADIO,i);
		        			new privvalue = chr_twkarray[i][ct_propval];
		        			if(type == 121) //bitfields (for example visibility)
						{
							new originalvalue = chr_getProperty( target,type)&privvalue;
							if(privvalue >= 10)
								privvalue = (privvalue/10)*16;
							if( originalvalue == privvalue) //is already set
								checklev = 1;
							if( (checklev == 1) && (checked !=1) ) //is at TRUE and no longer checked
								chr_setProperty( target,type, _, chr_getProperty( target,type) &~ privvalue );
							else if( (checklev != 1) && (checked == 1)) //is false and checked now
								chr_setProperty( target,type, _, chr_getProperty( target,type) | privvalue );
							if((privvalue == 8)&& (checked == 1)) //perma invis flag needs additionally a hide property
								chr_setProperty( target,110, _, 2);
						}
						else if(type == 110)//visibility
						{
							new originalvalue = chr_getProperty( target,type);
							if( (checked == 1) && (originalvalue != privvalue)) //is false and checked now
							{
								chr_setProperty( target,type, _, privvalue);
								chr_setProperty( target,121, _, chr_getProperty( target,121) | 8 ); //just to be carefull, perma invis is now set to false
							}
						}
		        		}//linetype
					else if(linetype == 7) //stock function call
					{
						new q = (chr_twkarray[i][ct_propnumber]); //type of stock function
						checked = gui_getProperty(twkChrMenu,MP_CHECK,i); //is it checked?
						if( q == 5)
						{
							new status = chr_getProperty(target, chr_twkarray[i][ct_propval]);
							if( (status == 0) && checked) //not dead but checked now
							{
								chr_kill(target);
							}
							else if ((status == 1) && !checked) //dead but no more checked
								chr_resurrect(target);
						}
					}
		        	}//for
		        }
		        else if(pagenumber == 9) //events
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
		        					chr_message(target, _, msg_commandsDef[76]);
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
		        					chr_message(target, _, msg_commandsDef[76]);
		        			}
		        			else
		        				chr_message(target, _, msg_commandsDef[78]);
		        		}
		        		else
		        			chr_message(target, _, msg_commandsDef[77]);
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
		        				chr_message(target, _, msg_commandsDef[78]);
		        		}
		        		else
		        			chr_message(target, _, msg_commandsDef[77]);
		        	}
		        }
		        else if(pagenumber == 8) //layer
		        {
		        	new itemSet=set_create();
		        	set_addItemWeared(itemSet,target,false,true,true);
		        	for (set_rewind(itemSet);!set_end(itemSet);)
		        	{
		        		new item = set_get(itemSet);
		        		new layer= chr_getProperty(item,IP_LAYER);
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