public locationsMenu(const chr, const object)
{
	#if _CMD_DEBUG_
	log_message("^t->drawing locations menu");
	#endif
	
	cursor_setProperty(CRP_TAB,50);
	createSimpleListMenu(0,0,30,30,NUM_LOCATIONS,"Locations list","drawLocationsMenuLine","locationsMenuCback");	
	cursor_restoreDefaults();
	chr_addLocalIntVar(chr,CLV_CMDTEMP,object);
	menu_show(chr);
}

public drawLocationsMenuLine(i)
{
	new text[10];
	sprintf(text,"%d ",i);
	menu_addText(text);
	cursor_right(strlen(text));
	menu_addLabeledButton(i + 1,__locations[i][__locName]);
	cursor_back();
}

public locationsMenuCback(menu,chr,loc)
{
	if(!loc) return;
	--loc;
	new obj = chr_getLocalIntVar(chr,CLV_CMDTEMP);
	chr_delLocalVar(chr,CLV_CMDTEMP);
	
	if(isChar(obj))
		chr_moveTo(obj,__locations[loc][__locX],__locations[loc][__locY],__locations[loc][__locZ]);
	else if(isItem(obj))
		itm_moveTo(obj,__locations[loc][__locX],__locations[loc][__locY],__locations[loc][__locZ]);
		else
		{
			chr_message(chr,_,"ERROR: Invalid object");
			log_error("Invalid object serial in locationsMenuCback");
		}
}