#if defined _pagemenu_included_
	#endinput
#endif
#define _pagemenu_included_

/*!
\defgroup script_commands_pagesystem_menu page list menu
\ingroup script_commands_pagesystem

@{
*/


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
	new s;
	if(isChar(chr)) //we want a specific char's pages
	{
		s = set_create();
		set_add(s,chr);
	}
	else 	if(!getGmPageList(s)) //or we want all pages
		{
			log_error("There was an error reading the GM page list");
			chr_message(solver,_,"There was an error reading the GM page list");
			return 1;
		}

	if(set_size(s) == 0)
	{
		set_delete(s);
		return 0;
	}	
	//now s contains serials of the characters we want to see the pages
	new COLS = 40;
	new ROWS = set_size(s)*4;
	cursor_setProperty(CRP_TAB,50);
	createSetListMenu(0,0,ROWS,COLS,s,"Submitted pages","pagemenu_printpage","pagemenu_cback");
	
	set_delete(s);
	menu_show(solver);
	return 1;
}

public pagemenu_printpage(p,line,col,i,set)
{
	//read current pager and print his name
	new name[30];
	new pager = set_getChar(set);
	chr_getProperty(pager,CP_STR_NAME,0,name);
	if(chr_isOnline(pager))
		sprintf(name,"%s [online]",name);
	else
		sprintf(name,"%s [offline]",name);
		
	menu_addLabeledButtonFn(pager,"pagemenu_go2Char_cback",name)
	
	cursor_newline();
	
	//print pages
	new label[100], reason[100], time[10];
	for(new page = 1; chr_getGmPage(pager,page,reason,time); page++)
	{
		sprintf(label,"%s %s",time,reason);
		cursor_right(5);
		menu_addLabeledButton(page*100000 + pager + 1,label);
		cursor_back();
		cursor_newline();
	}
}

public pagemenu_cback(menu,chr,btncode)
{
	if(!btncode) return;
	
	btncode--;
	
	new page = btncode/100000;
	new pager = btncode%100000;

	if(chr_solveGmPage(pager,page))
		sendPageHandlingMessage(chr,pager,page,PAGE_STATUS_SOLVED);
}

public pagemenu_go2Char_cback(menu,solver,pager)
{
	new x,y,z;
	chr_getPosition(pager,x,y,z);
	new x1=x, y1=y, z1=z;
	chr_moveTo(solver,x1 + 1,y1,z1);
	sendPageHandlingMessage(solver,pager,INVALID,PAGE_STATUS_SOLVING);
}
/*! @}*/