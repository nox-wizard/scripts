/*!
\defgroup script_command_house 'house
\ingroup script_commands

@{
*/

/*
\author Horian
\fn
\brief house gui

<B>syntax:</B> 'house
Shows the ingame house gui that allows all kinds of modifications<BR>
\todo rename this function when commands are done in sources to cmd_tweak
<br>
*/

const BUTTON_APPLY=11
const housepages=3; //one line for one page, two rows for one page
const housepic1 = 5002;
const housepic2 = 5003;

enum house_buttons
{ 
newhous1,
oldhouse1,
newhous2,
oldhouse2,
newhous3,
oldhouse3
};

static houseButton[housepages][house_buttons] = {
{5003, 5209, 5209, 5003, 5209, 5003},
{5209, 5003, 5003, 5209, 5209, 5003},
{5209, 5003, 5209, 5003, 5003, 5209}
};

public housestart(const itm, const chr)
{
	house_getProperty(itm, HP_SERIAL);
	menu_house(chr, 1);
}

public menu_house(const chr, const house, const pagenumber)
{
	new tempStr[100];
	new house_cllbck[50];
	new checklev = 0;
	sprintf( house_cllbck,"houseBck%d",pagenumber);
	new houseMenu = gui_create( 10,10,1,1,1,house_cllbck );

	gui_setProperty( houseMenu,MP_BUFFER,0,PROP_CHARACTER );
	gui_setProperty( houseMenu,MP_BUFFER,3,BUTTON_APPLY );

	gui_addResizeGump(houseMenu,0,0,2600,507,384);
	gui_addResizeGump(houseMenu,93,82,5100,0,0);
	gui_addResizeGump(houseMenu,41,60,5100,437,23);

	gui_addPage(houseMenu,0);
	new arrayline = pagenumber-1;
	gui_addText(houseMenu,58,61,33,"Info");
	gui_addButton(houseMenu,100,63,houseButton[arrayline][newhous1],houseButton[arrayline][oldhouse1],1);
	gui_addText(houseMenu,202,61,33,"Friends");
	gui_addButton(houseMenu,299,62,houseButton[arrayline][newhous2],houseButton[arrayline][oldhouse2],2);
	gui_addText(houseMenu,366,60,33,"Options");
	gui_addButton(houseMenu,423,62,houseButton[arrayline][newhous3],houseButton[arrayline][oldhouse3],3);

if( pagenumber ==1)
{
	gui_addText(houseMenu,184,125,33,"Owner is");
	gui_addText(houseMenu,43,162,33,"Number of locked down items");
	gui_addText(houseMenu,44,190,33,"Number of secure container");
	gui_addText(houseMenu,44,220,33,"This house is properly placed.");
	gui_addText(houseMenu,43,251,33,"This house is of classical design.");
	gui_addText(houseMenu,46,309,33,"Change the house-name");
	gui_addText(houseMenu,46,280,33,"activate Autoban");
	
	gui_addCheckbox(houseMenu,190,213, housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,281,224,housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,281,254,housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,281,284,housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,281,312,housepic1,housepic2,checklev,1);
}
//friends & owner
else if(pagenumber ==2)
{
	gui_addText(houseMenu,45,139,33,"Add a Co-Owner");
	gui_addText(houseMenu,45,166,33,"Remove a Co-Owner");
	gui_addText(houseMenu,44,196,33,"Delete all Co-Owner");
	gui_addText(houseMenu,134,227,33,"Ban someone from the house");
	gui_addText(houseMenu,134,296,33,"Unban somone");
	gui_addText(houseMenu,134,274,33,"View list of banned people");
	gui_addText(houseMenu,45,111,33,"List of Co-Owner");
	gui_addText(houseMenu,264,111,33,"List of Friends");
	gui_addText(houseMenu,264,139,33,"Add a Friend");
	gui_addText(houseMenu,264,166,33,"Remove a Friend");
	gui_addText(houseMenu,264,196,33,"Delete all Friends");
	gui_addText(houseMenu,134,251,33,"Eject someone from the house");
	
	gui_addCheckbox(houseMenu,28,114,housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,28,142,housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,28,169,housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,28,199,housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,247,199,housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,247,169,housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,247,142,housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,247,114,housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,116,230,housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,116,254,housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,116,277,housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,116,299,housepic1,housepic2,checklev,1);
}
//options
else if(pagenumber ==3)
{
	gui_addText(houseMenu,138,139,33,"Transform house back into a deed");
	gui_addText(houseMenu,138,166,33,"Change the house locks");
	gui_addText(houseMenu,138,196,33,"Declare this house a public");
	gui_addText(houseMenu,138,237,33,"Access your bank account");
	gui_addText(houseMenu,138,111,33,"Transfer ownership of the house");
	gui_addText(houseMenu,138,212,33,"- its not lockable then!");
	
	gui_addCheckbox(houseMenu,117,114,housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,117,142,housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,117,170,housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,117,202,housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,117,238,housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,428,347,housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,100,63,housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,299,62,housepic1,housepic2,checklev,1);
	gui_addCheckbox(houseMenu,423,62,housepic1,housepic2,checklev,1);
}
gui_show(houseMenu, chr);
}

public houseBck1(const houseMenu, const chrsource, const buttonCode)
{
	switch(buttonCode)
	{
		case 1,2,3: viewHouseMenu(chrsource, buttonCode);
		default: printf("unknown button");
	}
}		

public houseBck2(const houseMenu, const chrsource, const buttonCode)
{
	switch(buttonCode)
	{
		case 1,2,3: viewHouseMenu(chrsource, buttonCode);
		default: printf("unknown button");
	}
}

public houseBck3(const houseMenu, const chrsource, const buttonCode)
{
	switch(buttonCode)
	{
		case 1,2,3: viewHouseMenu(chrsource, buttonCode);
		default: printf("unknown button");
	}
}

public viewHouseMenu(const chrsource, const buttonCode)
{
	//printf("enter viewHouseMenu, page: %d", buttonCode);
	switch(buttonCode)
	{
		case 1: menu_house(chrsource, 1);
		case 2: menu_house(chrsource, 2);
		case 3: menu_house(chrsource, 3);
	}
}
