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
	new name[100];
	rgn_getName(r,name);
	
	createStdMenu(0,0,8,25,name,"regioncp_cback");
	
	menu_addLabeledCheckbox(rgn_isGuarded(r),0,"Guarded");
	cursor_newline();
	
	menu_addLabeledCheckbox(rgn_canRecall(r),1,"Can recall");
	cursor_newline();
	
	menu_addLabeledCheckbox(rgn_canMark(r),2,"Can mark");
	cursor_newline();
	
	new weather = rgn_getWeather(r);
	switch(weather)
	{
		case WEATHER_SUN: menu_addLabeledInputField(3,"sun",10,"Weather:  ");
		case WEATHER_RAIN:menu_addLabeledInputField(3,"rain",10,"Weather:  ");
		case WEATHER_SNOW:menu_addLabeledInputField(3,"snow",10,"Weather:  ");
	}
	cursor_newline();

	menu_addLabeledCheckbox(rgn_canGate(r),4,"Can gate");
	cursor_newline();
	
	menu_addLabeledCheckbox(rgn_noMagicDamage(r),5,"No magic damage");
	cursor_newline(2);
	cursor_right(8);
	menu_addApplyButton(r + 100);
	menu_show(chr);
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