/*!
\defgroup script_command_where 'where
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_regioncp(const chr)
\brief opens region control panel

<B>syntax:</B> 'regioncp

<br>
*/
#include "small-scripts/API/gui/defines.sma"

public cmd_regioncp(const chr)
{
	regioncp(chr,chr_getProperty(chr,CP_REGION));
}

public regioncp(const chr, const r)
{
	new START_X = 0;
	new START_Y = 0;
	new COLS = 25;
	new ROWS = 15;
	new WIDTH = COLS*COL;
	new HEIGHT = ROWS*ROW;

	new menu = gui_create(START_X,START_Y,true,true,true,"regioncp_cback");
	gui_addResizeGump(menu,START_X,START_Y,RESIZEGUMP,WIDTH,HEIGHT );
	gui_addResizeGump(menu,START_X + COL ,START_Y + COL,RESIZEGUMP1,WIDTH - 2*COL,4*ROW);
	gui_addResizeGump(menu,START_X + COL ,START_Y + 4*ROW,RESIZEGUMP1,WIDTH - 2*COL,HEIGHT - 4*ROW - COL);

	new name[100];
	rgn_getName(r,name);
	gui_addText(menu,5*COL,ROW,TITLE_COLOR,"Region control panel");
	gui_addText(menu,5*COL,2*ROW,TXT_COLOR,"%s",name);

	new row = 4;
	new tab = 19;

	gui_addText(menu,5*COL,++row*ROW,TXT_COLOR,"Guarded ");
	gui_addCheckbox(menu, tab*COL,row*ROW,CHK_OFF,CHK_ON,rgn_isGuarded(r),0);

	gui_addText(menu,5*COL,++row*ROW,TXT_COLOR,"Can recall");
	gui_addCheckbox(menu, tab*COL,row*ROW,CHK_OFF,CHK_ON,rgn_canRecall(r),1);

	gui_addText(menu,5*COL,++row*ROW,TXT_COLOR,"Can mark");
	gui_addCheckbox(menu, tab*COL,row*ROW,CHK_OFF,CHK_ON,rgn_canMark(r),2);

	gui_addText(menu,5*COL,++row*ROW,TXT_COLOR,"Weather");
	new weather = rgn_getWeather(r);
	switch(weather)
	{
		case WEATHER_SUN: gui_addInputField(menu,tab*COL,row*ROW,10*COL,ROW,3,TXT_COLOR,"sun");
		case WEATHER_RAIN:gui_addInputField(menu,tab*COL,row*ROW,10*COL,ROW,3,TXT_COLOR,"rain");
		case WEATHER_SNOW:gui_addInputField(menu,tab*COL,row*ROW,10*COL,ROW,3,TXT_COLOR,"snow");
	}

	gui_addText(menu,5*COL,++row*ROW,TXT_COLOR,"Can gate");
	gui_addCheckbox(menu, tab*COL,row*ROW,CHK_OFF,CHK_ON,rgn_canGate(r),4);

	gui_addText(menu,5*COL,++row*ROW,TXT_COLOR,"No magic damage");
	gui_addCheckbox(menu, tab*COL,row*ROW,CHK_OFF,CHK_ON,rgn_noMagicDamage(r),5);

	gui_addButton(menu,10*COL,(row + 2)*ROW,BTN_APPLY_UP,BTN_APPLY_DOWN,r + 100);
	gui_show(menu,chr);
}

public regioncp_cback(const menu, const chr, const btn)
{
	if(btn == 0) return;
	new reg = btn - 100;

	rgn_setGuarded(reg,gui_getProperty(menu,MP_CHECK,0));
	rgn_setRecall(reg,gui_getProperty(menu,MP_CHECK,1));
	rgn_setMark(reg,gui_getProperty(menu,MP_CHECK,2));

	new weather[5];
	gui_getProperty(menu,MP_UNI_TEXT,3,weather);
	if(!strcmp(weather,"sun")) rgn_setWeather(reg,WEATHER_SUN);
	else 	if(!strcmp(weather,"rain")) rgn_setWeather(reg,WEATHER_RAIN);
		else 	if(!strcmp(weather,"snow")) rgn_setWeather(reg,WEATHER_SNOW);
			else chr_message(chr,_,"Invalid weather %s",weather);

	rgn_setGate(reg,gui_getProperty(menu,MP_CHECK,4));
	rgn_setMagicDamage(reg,gui_getProperty(menu,MP_CHECK,5));

	chr_message(chr,_,"Region properties updated");
}

/*! }@ */