#include "small-scripts/API/gui/defines.sma"
#include "small-scripts/commands/go/locations.sma"

public locationsMenu(const chr, const object)
{
	new BTN_UP = 0x29F4;  	//!< buttons up gump
	new BTN_DOWN = 0x29F6;	//!< buttons down gump
	new BTNW = 15;

	new  START_X = 0;	//!< start x, where the gump is created
	new  START_Y = 0;	//!< start y

	new COLS = 40;
	new ROWS = 20;

	new  WIDTH =  COLS*COL;
	new  HEIGHT = ROWS*ROW;

	#if _CMD_DEBUG_
	log_message("^t->drawing locations menu");
	#endif

	new x = START_X + 2*COL,y = START_Y + ROW/2 + ROW;
	new menu = gui_create(START_X,START_Y,true,true,true,"locationsMenuCback");

	//draw menu frame
	gui_addResizeGump(menu,START_X,START_Y,RESIZEGUMP,WIDTH,HEIGHT );
	gui_addResizeGump(menu,START_X + COL ,START_Y + ROW/2,RESIZEGUMP1,WIDTH - 2*COL,HEIGHT - ROW);
	gui_addText(menu,START_X + 10*COL,START_Y,TITLE_COLOR,"Locations menu");

	new p=1;

	gui_addPage(menu,p);

	for(new i; i < NUM_LOCATIONS; i++)
	{
		if(y >= START_Y + HEIGHT - ROW)
		{
			y = START_Y + ROW/2 + ROW;
			++p;
			gui_addText(menu,(START_X + WIDTH)/2 + 2*BTNW,START_Y + HEIGHT - ROW,TXT_COLOR,"next");
			gui_addPageButton(menu,(START_X + WIDTH)/2 + BTNW,START_Y + HEIGHT - ROW,BTN_UP,BTN_DOWN,p);
			gui_addPage(menu,p);
			gui_addText(menu,(START_X + WIDTH)/2 - 6*COL,START_Y + HEIGHT - ROW,TXT_COLOR,"prev");
			gui_addPageButton(menu,(START_X + WIDTH)/2 - BTNW,START_Y + HEIGHT - ROW,BTN_UP,BTN_DOWN,p - 1);
		}

		gui_addText(menu,x + BTNW,y,TXT_COLOR,__locations[i][__locName]);
		gui_addButton(menu,x,y,BTN_UP,BTN_DOWN,i + 1);

		y += (15*ROW)/10;
	}

	//store character to send to location
	gui_setProperty(menu,MP_BUFFER,0,object);
	gui_show(menu,chr);
}

public locationsMenuCback(menu,chr,loc)
{
	if(!loc) return;
	--loc;
	new obj = gui_getProperty(menu,MP_BUFFER,0);
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