#include "small-scripts/translations/polymorph_lines.sma"
/*!
\defgroup script_command_polymorph 'polymorph
\ingroup script_commands

@{
*/

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
	chr_message( chrsource, _, msg_commandsDef[191]);
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
		{
			chr_unmorph(target);
			chr_update(target);
		}
		else
			callPolyMenu(chrsource,target, 1);
	}
	else
	{
		chr_message( chrsource, _,msg_commandsDef[192]);
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

	gui_addText( polymMenu,215,80,1310,msg_commandsDef[193]);
	if(page !=8)	gui_addButton( polymMenu,503,83,2224,2224, 2); //button right
	if(page !=1)	gui_addButton( polymMenu,40,83,2223,2223, 1); //button left
	gui_addText( polymMenu,230,500,1310,"page: %d", page);

	gui_addText( polymMenu,50,120,1310, msg_commandsDef[194]);
	gui_addInputField( polymMenu,140,120,100,20,3,1110, msg_commandsDef[195]);
	gui_addText( polymMenu,210,120,1310, msg_commandsDef[196]);
	gui_addInputField( polymMenu,300,120,100,20,4,1110, msg_commandsDef[197]);
	gui_addText( polymMenu,385,120,1310, msg_commandsDef[198]);
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
	//printf("page: %d", page);
	//printf("buttonCode: %d", buttonCode);

	//0: rechtsklick, 1: vorhergehendes, 2: folgendes Menü, 3: custom name, 4: custom color, 5: custom stats, 10 u. folgende: bodyID

	if(buttonCode == 0) return;
	else if(buttonCode == 1) callPolyMenu(chrsource, target,(page-1)); //back
	else if(buttonCode == 2) callPolyMenu(chrsource, target, (page+1)); //next page
	else if(buttonCode >= 10)
	{
		new arrayline = buttonCode-10;
		new chrname[30];
		gui_getProperty(polymMenu,MP_UNI_TEXT,3,chrname);
		if( !strcmp( chrname,msg_commandsDef[195] )) //is Entry not made (is still "(name)")
		{
			sprintf(chrname, "%s", animProperty[arrayline][animname]);
		}
		new color[15];
		new skincolor = 0000;
		gui_getProperty(polymMenu,MP_UNI_TEXT,4,color);
		if( strcmp( color,msg_commandsDef[197])) //entry made (no more "(decimal)")
		{
			trim(color);
			if (isStrUnsignedInt(color))	skincolor = str2UnsignedInt(color);
		}
		new script[25];
		sprintf(script, "%s", animProperty[arrayline][scriptname]);
		trim(script);
		new scriptID = getIntFromDefine(script, true);
		printf("scriptid: %d", scriptID);
		chr_morph( target, scriptID ,1); //polymorphes body into npc-like one
		chr_update(target);
	}
}

/*! }@ */