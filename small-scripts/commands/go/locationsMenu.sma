#include "small-scripts/API/gui/defines.sma"
#include "small-scripts/commands/go/locations.sma"

public locationsMenu(const chr, const object)
{
	#if _CMD_DEBUG_
	log_message("^t->drawing locations menu");
	#endif
	
	cursor_setProperty(CRP_TAB,50);
	createListMenu(0,0,30,30,NUM_LOCATIONS,"LOCATIONS LIST","drawLocationsMenuLine","locationsMenuCback");	
	cursor_restoreDefaults();
	menu_storeValue(0,object);
	menu_show(chr);
}

public drawLocationsMenuLine(page,line,col,i)
{
	menu_addLabeledButton(i + 1,__locations[i][__locName]);
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