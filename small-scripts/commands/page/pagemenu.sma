#if defined _pagemenu_included_
	#endinput
#endif
#define _pagemenu_included_

/*!
\defgroup script_commands_pagesystem_menu page list menu
\ingroup script_commands_pagesystem

@{
*/

#include "small-scripts/commands/page/constants.sma"

/*!
\author Fax
\fn drawPageListMenu(const solver, const chr)
\param solver: the character that will be shown the menu
\param chr: the character whose pages we want to read, INVALID means all paging characters
\since 0.82
\brief shows the page list menu of a character or all paging charatcers

shows the page list menu of a character or all paging charatcers, passing a valid character serial
as chr will cause the menu to show only the selected character's pages, passing INVALID will result in the gump
showing all paging character's pages

\return nothing
*/
public drawPageListMenu(const solver, const chr)
{
	new s = set_create();
	if(isChar(chr))
		set_add(s,chr);
	else 	if(!getGmPageList(s))
		{
			log_error("There was an error reading the GM page list");
			return;
		}

	//now s contains serials of the characters we want to see the pages
	
	new COLS = 40;
	new ROWS = set_size(s)*4;
	cursor_setProperty(CRP_TAB,50);
	createSetListMenu(0,0,ROWS,COLS,s,"Submitted pages","pagemenu_printpage","pagemenu_cback");
	/*new BTN_UP = 0x29F4;  	//!< buttons up gump
	new BTN_DOWN = 0x29F6;	//!< buttons down gump

	new  START_X = 0;
	new  START_Y = 0;

	new L_MARG = 2*COL;

	new BTNW = 15;

	new COLS = 40;
	new ROWS = set_size(s)*4;

	new  WIDTH =  COLS*COL;
	new  HEIGHT = (ROWS + 3)*ROW;

	new x,y;
	new menu = gui_create(START_X,START_Y,true,true,true,"pagemenu_cback");

	//draw menu frame
	gui_addResizeGump(menu,START_X,START_Y,RESIZEGUMP,WIDTH,HEIGHT + ROW );
	gui_addResizeGump(menu,START_X + COL ,START_Y + ROW/2,RESIZEGUMP1,WIDTH - 2*COL,HEIGHT);

	x = START_X + L_MARG;
	y = START_Y + ROW/2 + ROW;

	new p=1;
	new tab = 5;
	gui_addPage(menu,p);
	new name[30], reason[100], time[10],pager,page;
	for(set_rewind(s);!set_end(s);)
	{
		if(y >= START_Y + HEIGHT)
		{
			y = START_Y + ROW/2 + ROW;
			++p;
			gui_addText(menu,(START_X + WIDTH)/2 + 2*BTNW,START_Y + HEIGHT,TXT_COLOR,"next");
			gui_addPageButton(menu,(START_X + WIDTH)/2 + BTNW,START_Y + HEIGHT,BTN_UP,BTN_DOWN,p);
			gui_addPage(menu,p);
			gui_addText(menu,(START_X + WIDTH)/2 - 6*COL,START_Y + HEIGHT,TXT_COLOR,"prev");
			gui_addPageButton(menu,(START_X + WIDTH)/2 - BTNW,START_Y + HEIGHT,BTN_UP,BTN_DOWN,p - 1);
		}

		page = 1;pager = set_getChar(s);
		chr_getProperty(chr,CP_STR_NAME,0,name);

		gui_addButtonFn(menu,x,y,BTN_UP,BTN_DOWN,pager,true,"pagemenu_go2Char_cback");
		gui_addText(menu,x + BTNW,y,TITLE_COLOR,name);
		y += ROW;

		while(chr_getGmPage(pager,page++,reason,time))
		{
			gui_addButton(menu,x + (tab - 2)*COL,y,BTN_UP,BTN_DOWN,page*100000 + pager + 1);
			gui_addText(menu,x + tab*COL,y,TXT_COLOR,time);
			gui_addText(menu,x + tab*COL + 12,y,TXT_COLOR,reason);
			y += ROW;
		}
	}
	*/
	menu_show(chr);
}

public pagemenu_printpage(p,line,col,i,set)
{
	new name[30], reason[100], time[10],pager = set_getChar(set),page = 1;
	chr_getProperty(pager,CP_STR_NAME,0,name);

	menu_addLabeledButtonFn(pager,"pagemenu_go2Char_cback",name)
	cursor_newline();
	
	new label[100];
	while(chr_getGmPage(pager,page++,reason,time))
	{
		sprintf(label,"%s %s",time,reason);
		menu_addLabeledButton(page*100000 + pager + 1,label);
		cursor_newline();
	}
}

public pagemenu_cback(menu,chr,btncode)
{
	if(!btncode) return;

	new page = btncode/100000;
	new pager = btncode%100000 - 1;

	chr_solveGmPage(pager,page);
	sendPageHandlingMessage(chr,pager,page,PAGE_STATUS_SOLVED);
}

public pagemenu_go2Char_cback(menu,solver,pager)
{
	new x,y,z;
	chr_getPosition(pager,x,y,z);
	chr_moveTo(solver,x,y,z);
	sendPageHandlingMessage(solver,pager,INVALID,PAGE_STATUS_SOLVING);
}
/*! @}*/