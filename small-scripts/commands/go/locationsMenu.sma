public locationsMenu(const chr, const object)
{
	#if _CMD_DEBUG_
	log_message("^t->drawing locations menu");
	#endif
	
	cursor_setProperty(CRP_TAB,50);
	createListMenu1(0,0,30,30,NUM_LOCATIONS,"Locations list","drawLocationsMenuLine","locationsMenuCback");	
	cursor_restoreDefaults();
	menu_storeValue(0,object);
	printf("showing menu^n");
	menu_show(chr);
}

public drawLocationsMenuLine(page,line,col,i)
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
	new obj = menu_readValue(menu,0);
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