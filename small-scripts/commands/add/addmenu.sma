/*!
\defgroup script_commands_add_menu menu
\ingroup script_commands_add

@{
*/

//======================== EDITABLE SECTION ====================================//
#define DEFAULT_LANGUAGE 0 //0:english - 1:german - 2:italian - 3:french
static standardFunction[] = "addgui_standard";	//!< standard function to call to draw menus
#define MAX_ADD_SUBMENUS 16	//!< maximum number of submenus
#define MAX_PAGES_PER_SUBMENU 16	//!< maximum number of pages per each submenu
#define MAX_TITLE_LENGTH 16	//!< maximum title lenght, both submenu and page titles
#define MAX_ADDMENU_ITEMS 1500	//!< maximum overall number of loadable items
#define ITEMS_PER_ROW 4	//!< items (submenus - pages) in a header row. This changes the submenus width

//==============================================================================//
//strings are set to "ERROR: add menu string not loaded" because with that we can see if a
//string is not loaded from addmenu.xss 
new msg_add_addingModeCont[100] = "ERROR: add menu string not loaded";
new msg_add_addingModeSingle[100] = "ERROR: add menu string not loaded";
new msg_add_reload[100] = "ERROR: add menu string not loaded";
new msg_add_createItemsInBackpack[100] = "ERROR: add menu string not loaded";
new msg_add_itemCreated[100] = "ERROR: add menu string not loaded";
new msg_add_click2PositionTheItem[100] = "ERROR: add menu string not loaded";
new msg_add_click2PositionTheChar[100] = "ERROR: add menu string not loaded";
new msg_add_WARNING[100] = "ERROR: add menu string not loaded";
new msg_add_itemsNotLoaded[100] = "ERROR: add menu string not loaded";
new msg_add_itemType[100] = "ERROR: add menu string not loaded";
new msg_add_material[100] = "ERROR: add menu string not loaded";
new msg_add_subtype[100] = "ERROR: add menu string not loaded";
new msg_add_openmenu[100] = "ERROR: add menu string not loaded";
new msg_add_architecture1[100] = "ERROR: add menu string not loaded";
new msg_add_architecture2[100] = "ERROR: add menu string not loaded";
new msg_add_architecture3[100] = "ERROR: add menu string not loaded";
new msg_add_architecture4[100] = "ERROR: add menu string not loaded";
new msg_add_architecture5[100] = "ERROR: add menu string not loaded";
new msg_add_notDefined[100] = "ERROR: add menu string not loaded";
new msg_add_loadingAddMenu[100] = "Loading 'add menu"; //this string is used before XSS loading
new msg_add_unable2OpenFile[100] = "ERROR: add menu string not loaded";
new msg_add_itemsLoaded[100] = "ERROR: add menu string not loaded";
new msg_add_mustBeInteger[100] = "ERROR: add menu string not loaded";
new msg_add_mustBeHex[100] = "ERROR: add menu string not loaded";
new msg_add_tooManyItems[100] = "ERROR: add menu string not loaded";

//======================== GLOBAL VARIABLES AND ARRAYS =========================//
//DO NOT edit this section unless you know what you are doing!
static addmenu_xss_path[] = "small-scripts/commands/add/"; //!< XSS file path
static addmenu_xss[100]; //!< XSS file to load
new currentAddmenuLanguage = DEFAULT_LANGUAGE;
static pageDataIdx; //!< moving index in pageData[][]
static listIdx;	//!< moving index in addMenuList[][]
static submenuCount; //!< number of loaded submenus
static error; //!< true if an error occurred during the script

enum submenuStruct
{
	__pageDataIdx,		//!< index in pageData[][] at wich start submenu data
	__numPages,		//!< number of pages in the submenu
	__height,		//!< number of lines in the menu body
	__submenuTitle: MAX_TITLE_LENGTH,	//!< submenu title
	__submenuFunction: AMX_FUNCTION_LENGTH	//!< submenu function
}//!< submenuData[][] structure
public submenuData[MAX_ADD_SUBMENUS][submenuStruct]; //!< submenu data

enum pageStruct
{
	__submenu,	//!< the submenu the page belongs to
	__listIdx,	//!< index in addMenuList[][] at wich items data start
	__numItems,	//!< number of listed items
	__addGui_tab,	//!< columns spacing
	__addGui_interline,	//!< rows spacing
	__showPic,	//!< true if the pic is to be shown
	__showLabel,	//!< true if the label has to be shown
	__pageFunction: AMX_FUNCTION_LENGTH,	//!< page function for custom pages
	__pageTitle: MAX_TITLE_LENGTH	//!< page title
}//!< pageData[][] structure
public pageData[MAX_ADD_SUBMENUS*MAX_PAGES_PER_SUBMENU][pageStruct];


enum addMenuListStruct
{
	__addGui_type,		//!< type ofobject NPC or ITEM
	__addGui_ID,		//!< ID from gumpart.mul
	__addGui_def: 50,	//!< XSS define
	__addGui_name: 50	//!< name
}//!< addMenuList[][] structure
public addMenuList[MAX_ADDMENU_ITEMS][addMenuListStruct]; //!< main data structure,contains all items data
//===================================================================================//

//=========================== USEFUL DEFINES ========================================//
#define PICW 30	//!< pic width, needed to correctly space text after pics
#define INPUT_AMOUNT 0	//!< amount inputfiled ID
#define INPUT_MATERIAL 1	//!< material inputfield ID
#define INPUT_MAGIC_SUFFIX 100	//!< magic suffix inputfield ID

#define CHK_ITEMSINBACKPACK 0	//!< items in backpack checkbox ID
//===================================================================================//

//==================================================================================//
//                            ADD MENU MAIN PAGE                                    //
//==================================================================================//
/*!
\author Fax
\fn addMenu(const chr)
\param chr: the character
\since 0.82
\brief main 'add menu function

This function shows the main add menu page, you can configure the page's contents and 
functions the functions that draw other pages by editing the contents of __addMenuItems[][] array
\return the menu serial
*/
public addMenu(const chr, const startx, const starty)
{	                  
	//calculate menu dimensions
	new ROWS = submenuCount/ITEMS_PER_ROW + (submenuCount%ITEMS_PER_ROW > 0 ? 1 : 0)
	new COLS = ITEMS_PER_ROW*MAX_TITLE_LENGTH;
	new tab = (COLS - 2)/ITEMS_PER_ROW;
	cursor_setProperty(CRP_TAB,tab);
	
	#if _CMD_DEBUG_
	log_message("^t->drawing add menu");
	#endif
	
	//create a framed menu with a 1-row body
	createFramedMenu(startx,starty,ROWS,1,COLS,"addgui_cback");
	menu_storeValue(0,startx);
	menu_storeValue(1,starty);
	cursor_setProperty(CRP_TAB,tab);
	
	//draw buttons for submenus
	for(new i = 1; i <= submenuCount; i++)
	{
		menu_addLabeledButton(i,submenuData[i - 1][__submenuTitle]);
		cursor_tab();
		
		if(i%ITEMS_PER_ROW == 0 && i != 0) cursor_newline();
	}
	
	//move down in the body
	cursor_back();
	cursor_down(3);
	
	//draw "adding mode" button
	if(chr_isaLocalVar(chr,CLV_CONTINUOUS_ADDING_MODE))
		menu_addLabeledButton(1000,msg_add_addingModeCont);
	else 
		menu_addLabeledButton(2000,msg_add_addingModeSingle);
	
	cursor_tab(3);
	menu_addLabeledButton(3000,msg_add_reload);
	
	//show menu
	menu_show(chr);
}

/*!
\author Fax
\fn addgui_cback(menu,chr,btn)
\param all: standard menu callback params
\since 0.82
\brief callback for weapon menu

Handles main add menu buttons, toggles adding mode and calls functions to draw menus
\return nothing
*/
public addgui_cback(menu,chr,btn)
{
	//if menu was closed
	if(!btn) 
	{	
		//closing add menu deletetes localvars
		chr_delLocalVar(chr,CLV_CONTINUOUS_ADDING_MODE);
		return;
	}
	
	//continuous adding mode on/off
	switch(btn)
	{
		case 1000: chr_delLocalVar(chr,CLV_CONTINUOUS_ADDING_MODE);
		case 2000: chr_addLocalIntVar(chr,CLV_CONTINUOUS_ADDING_MODE);	
		case 3000: loadAddMenu(chr);
	}
	
	//show main menu again
	addMenu(chr,menu_readValue(menu,0),menu_readValue(menu,1));
	
	//this means we didn't press a submenu button
	if(btn >= 1000) return;
	
	btn--;
#if _CMD_DEBUG_
	log_message("^t->calling function: %s",submenuData[btn][__submenuFunction]);
#endif
	//call appropriate function, addgui_standard must be called with diferent parameters
	if(strcmp(submenuData[btn][__submenuFunction],"addgui_standard"))
		callFunction2P(funcidx(submenuData[btn][__submenuFunction]),chr,btn);
	else 
	{
		chr_setTempIntVec(chr,CLV_CMDTEMP,false,1);
		callFunction3P(funcidx(submenuData[btn][__submenuFunction]),INVALID,chr,(btn << 16) + 1);
		//addgui_standard(INVALID,chr,btn << 16);	
	}
}

//==================================================================================//
//                              STANDARD MENU                                       //
//==================================================================================//
/*!
\author Fax
\fn addgui_standard(chr,submenu,...)
\param chr: the character
\param submenu: the submenu to draw
\param 3: true if items are to be created in backpack
\param 4: how many items we need
\since 0.82
\brief standard menu function

Draws a standard add menu, with a list of pages in the header and a list of items
for each page.<br> 
The ... in the params is needed because this function is called at first
time by addgui_cback with only 2 params and then called by itself with 4 params.<br>
Custompages are supported, the page function will be called for each page, and will
be passed the submenu and the current submenu page (index in pageData[][]), so prototype must be:
\code
	public callback(submenu,page)
\endcode

\return nothing
*/
public addgui_standard(menu,chr,submenuPage)
{
	if(submenuPage == 0) 
		return;
	submenuPage--;
	
	new submenu = submenuPage >> 16;
	new page = submenuPage & 0xFFFF;
	
#if _CMD_DEBUG_
	log_message("^t->drawing submenu %d - page %d",submenu,page);
#endif
	
	//read additional params, amount is 1 by default
	new startx,starty;
	new itemsInBackpack = chr_getLocalIntVec(chr,CLV_CMDTEMP,0);
	new amount = chr_getLocalIntVec(chr,CLV_CMDTEMP,1);
	chr_delLocalVar(chr,CLV_CMDTEMP);
	
	//calculate header size
	new ROWS = 2 + submenuData[submenu][__numPages]/ITEMS_PER_ROW + (submenuData[submenu][__numPages]%ITEMS_PER_ROW > 0 ? 1 : 0)
	new COLS = ITEMS_PER_ROW*MAX_TITLE_LENGTH;
	new tab = (COLS - 2)/ITEMS_PER_ROW;
	cursor_setProperty(CRP_TAB,tab);
	
	//create a framed menu
	createFramedMenu(startx,starty,ROWS,submenuData[submenu][__height],COLS,"addgui_standard_cback");
	//offset is the index at wich submenu data strats in submenuData[][]
	new offset = submenuData[submenu][__pageDataIdx];
	
	for(new p; p < submenuData[submenu][__numPages]; p++)
	{
		if(p%ITEMS_PER_ROW == 0 && p != 0) cursor_newline();
		
		//call addgui_standard to draw the other pages when needed
		menu_addLabeledButtonFn((submenu << 16) + p,"addgui_standard",pageData[offset + p][__pageTitle]);
		cursor_tab();		
	}
	cursor_newline();
	
	//add "create items in backpack" checkbox
	menu_addLabeledCheckbox(itemsInBackpack,CHK_ITEMSINBACKPACK,msg_add_createItemsInBackpack);
	
	cursor_newline();
	
	//add amount input field
	new amountstr[20];
	sprintf(amountstr,"%d",amount);
	
	menu_addLabeledInputField(INPUT_AMOUNT,amountstr,5,"Amount: ");
	
	//go down in the body
	cursor_newline(3);

	new idx;	//current index in pageData[][]
	new startIdx;	//start index in addMenuList[][]
	new stopIdx;	//stop index in addMenuList[][]
	starty = cursor_y(); //store start row
	
	//draw page
	idx = offset + page;
	cursor_newline();
	cursor_goto(cursor_x(),starty);
	
	//draw a custom page if a function is declared
	if(strlen(pageData[idx][__pageFunction]))
		callFunction2P(funcidx(pageData[idx][__pageFunction]),submenu,idx);
	else
	{
	
		//otherwise draw a standard page
		//collect data to draw the page
		startIdx = pageData[idx][__listIdx];
		stopIdx = startIdx + pageData[idx][__numItems];
		cursor_setProperty(CRP_TAB,pageData[idx][__addGui_tab]);
		cursor_setProperty(CRP_INTERLINE,pageData[idx][__addGui_interline]);
		
		//draw the itemslist
		addItemList(startIdx,stopIdx,pageData[idx][__showPic],pageData[idx][__showLabel]);
	}
	
	//store submenu and page because the callback will need it
	menu_storeValue(0,submenu);
	menu_storeValue(1,page);
	
	//show menu
	menu_show(chr);
	
	//send error popup
	handleError(chr);
}

/*!
\author Fax
\fn addgui_standard_cback(menu,chr,btncode)
\param all: standard menu callback params
\since 0.82
\brief callback for standard menu

Creates the items selected in the gump
\return nothing
*/
public addgui_standard_cback(menu,chr,btncode)
{
	if(!btncode)	return;
	
	//read amount and checkbox
	new n,itemsInBackpack;
	getAmountAndChk(menu,n,itemsInBackpack);
	//btncode > 0 ==> item
	//btncode < 0 ==> NPC
	
	//if the items is to be created in backpack
	if(btncode > 0 && itemsInBackpack)
	{
		new item; 
		
		//create an item
		item = itm_createInBp(btncode,chr);
		
		//pileable items only have amount set to the correct value
		if(itm_getProperty(item,IP_PILEABLE))
		{
			itm_createInBp(btncode,chr,n - 1);
			chr_message(chr,_,msg_add_itemCreated,item);
		}
		else	//for non-pileable items we have to create n - 1 items more
			for(new i = 0; i < n - 1; i++)
			{
				item = itm_createInBp(btncode,chr);
				chr_message(chr,_,msg_add_itemCreated,item);
			}
		
		//rebuild and show the menu
		chr_setTempIntVec(chr,CLV_CMDTEMP,itemsInBackpack,n);
		new submenu = menu_readValue(menu,0);
		new page = menu_readValue(menu,1);
		addgui_standard(INVALID,chr,(submenu << 16) + page);
	}

	else
	{	//store amount for cmd_add_* functions
		chr_setTempIntVar(chr,CLV_CMDTEMP,n);
		
		//distinguish between items and NPC
		if(btncode > 0)
		{
			chr_message(chr,_,msg_add_click2PositionTheItem);
			target_create(chr,btncode,_,_,"cmd_add_itm_targ");
		}
		else
		{
			chr_message(chr,_,msg_add_click2PositionTheChar);
			target_create(chr,-1*btncode,_,_,"cmd_add_npc_targ");
		}
	}
}

/*!
\author Fax
\fn handleError(chr)
\param chr: the character
\since 0.82
\brief handles error messages in add menu

Shows a popup sayng that an error occurred
\return nothing
*/
static handleError(chr)
{
	if(error) 
		popupMenu(chr,msg_add_WARNING,msg_add_itemsNotLoaded);
		
	error = 0;
}

/*!
\author Fax
\fn addItemList(startIdx,stopIdx,pic,label)
\param startIdx: first item index in addMenuList[][]
\param stopIdx: last item index in addMenuList[][]
\param pic: true if the pic has to be shown
\param label: true if the label (item name) has to be shown
\since 0.82
\brief draws the item list in standard pages

The list will automatically fit the menu body height but it may go out of the menu width.
\return nothing
*/
static addItemList(startIdx,stopIdx,pic,label)
{
	new scriptID;
	new starty = cursor_y(); //store starting position so we can return back to it
	
	//cycle through all items
	for(new idx = startIdx; idx < stopIdx; idx++)
	{
		//read and validate scriptID, invalid scriptIDs have an 'x' instead of the button
		scriptID = getIntFromDefine(addMenuList[idx][__addGui_def],false);
		if(scriptID > 0)
		{
			menu_addButton(addMenuList[idx][__addGui_type]*scriptID);
		}
		else 
		{
			menu_addText("x");
			error = 1;
		}
		
		//move aside position the cursor after the button
		cursor_move(menu_getProperty(MP_BUTTON_WIDTH),0);
		
		//handle pic and label drawing
		if(pic)
			if(label)
				menu_addLabeledTilePic(addMenuList[idx][__addGui_ID],PICW,addMenuList[idx][__addGui_name]);
			else
				menu_addTilePic(addMenuList[idx][__addGui_ID]);
		else
			menu_addText(addMenuList[idx][__addGui_name]);
		
		//restore cursor position
		cursor_move(-1*menu_getProperty(MP_BUTTON_WIDTH),0);	
	
		//move to next line, and to next column if the we are at the bottom
		if(cursor_down()) 
		{ 
			cursor_tab(); 
			cursor_goto(cursor_x(),starty); 
		}
	}
	
	//restore cursor position
	cursor_reset();
}

/*!
\author Fax
\fn getAmountAndChk(menu,&n,&chk)
\param menu: the menu
\param &n: amount
\param &chk: checkbox value
\since 0.82
\brief reads amount input field and "items in backpack" checkbox
\return nothing
*/
static getAmountAndChk(menu,&n,&chk)
{
	new amount[10];
	gui_getProperty(menu,MP_UNI_TEXT,INPUT_AMOUNT,amount);

	if(!isStrInt(amount))
		n = 1
	else n = str2Int(amount);
	chk = gui_getProperty(menu,MP_CHECK,CHK_ITEMSINBACKPACK);
}

//===========================================================================//
//				 NON STANDARD MENUS                          //
//===========================================================================//

enum
{
	P_PLATEMAIL = 0,
	P_CHAINMAIL,
	P_RINGMAIL,
	P_STUDDED,
	P_LEATHER,
	P_BONE,
	P_HELMS,
	P_SHIELDS,
	P_AXES,
	P_SWORDS,
	P_BLADES,
	P_OTHER
};
//==================================================================================//
//                            COMBAT ITEMS MENU                                    //
//==================================================================================//
/*!
\author Fax
\fn addgui_combat(chr,itemsInBackpack,amount)
\param chr: the character
\param itemsInBackpack: true if items are to be created in backpack
\amount:how many items we need
\since 0.82
\brief combat items page

\return nothing
\todo Activate amount input box in combat menu
*/
public addgui_combat(submenu,page)
{
	
	new starty = cursor_y();
	
	//relative offset with respect to the starting page of the submenu
	new armor = page - submenuData[submenu][__pageDataIdx];
	
	new material[5] = "iron";
	if(armor == P_LEATHER || armor == P_STUDDED || armor == P_BONE)
		sprintf(material,"");
	
	//draw checkboxes
	new startIdx = pageData[page][__listIdx];
	new stopIdx = startIdx + pageData[page][__numItems];
	for(new i = startIdx; i < stopIdx; i++)
	{
		menu_addCheckBox(false,i); cursor_right();
		menu_addLabeledTilePic(addMenuList[i][__addGui_ID],PICW,addMenuList[i][__addGui_name]);
		
		cursor_newline(2);
	}
	
	cursor_goto(cursor_x(),starty);
	cursor_tab(2);
	
	menu_addLabeledInputField(INPUT_MATERIAL + 10*page,material,15,"Material:"); cursor_down();
	menu_addLabeledInputField(INPUT_MAGIC_SUFFIX + 10*page,"",15,"Magic suffix:"); cursor_down(4);
	
	menu_addLabeledButtonFn((submenu << 18) + (page << 2) + 2,"addgui_combat_cback","create in backpack"); cursor_down();
	menu_addLabeledButtonFn((submenu << 18) + (page << 2) + 1,"addgui_combat_cback","Equip"); cursor_down();
	menu_addLabeledButtonFn((submenu << 18) + (page << 2) + 0,"addgui_combat_cback","Equip to character");
}

/*!
\author Fax
\fn addgui_armor_cback(menu,chr,armor)
\param menu,chr,armor: standard menu callback params
\since 0.82
\brief callback for armor menu

Looks at the values given in the armor menu and creates the XSS def of the items to create and creates them
\return nothing
*/
public addgui_combat_cback(menu,chr,submenuPageAction)
{
	if(!submenuPageAction)	return;
	
	new submenu = submenuPageAction >> 18;
	new page = (submenuPageAction >> 2) & 0xFFFF;
	new action = submenuPageAction & 0x3;
	
	new material[20],suffix[30];
	gui_getProperty(menu,MP_UNI_TEXT,INPUT_MATERIAL + 10*page,material);
	if(strlen(material)) sprintf(material,"_%s",material);

	gui_getProperty(menu,MP_UNI_TEXT,INPUT_MAGIC_SUFFIX + 10*page,suffix);
	if(strlen(suffix)) sprintf(suffix,"_of_%s",suffix);

	new itm;
	new startIdx = pageData[page][__listIdx];
	new stopIdx = startIdx + pageData[page][__numItems];
	new def[100],token[20],temp[100];
	
	if(action == 0)
		chr_addLocalIntVec(chr,CLV_CMDTEMP,stopIdx - startIdx,INVALID);
	
	for(new i = startIdx; i < stopIdx; i++)
		if(gui_getProperty(menu,MP_CHECK,i)) 
		{
			//replace * with material name and add suffix
			strcpy(temp,addMenuList[i][__addGui_def]);
			replaceStr(temp,"*"," ");
			str2Token(temp,token,0,def,0);
			ltrim(def);
			sprintf(def,"%s%s%s%s",token,material,def,suffix);
			if(getIntFromDefine(def) <= 0 ) continue;
			
			switch(action)
			{
				case 0:
				{
					itm = itm_createByDef(def);
					chr_setLocalIntVec(chr,CLV_CMDTEMP,i - startIdx,itm);
				}
		
				case 1:
				{
					itm = itm_createByDef(def);
					chr_equip(chr,itm);
				}
				case 2: itm_createInBpDef(def,chr);
			}

		}

	if(action == 0)
	{
		target_create(chr,menu,_,_,"equip2char_targ");
		return;
	}
	new n,itemsInBackpack;
	getAmountAndChk(menu,n,itemsInBackpack);
	
	chr_setTempIntVec(chr,CLV_CMDTEMP,itemsInBackpack,n);
	addgui_standard(INVALID,chr,(submenu << 16) + page);
}

/*!
\author Fax
\fn equip2char_targ(t,chr,obj,x,y,z,unused,menu)
\param all: standard target callback params
\since 0.82
\brief equips created items to a selected character
\return nothing
*/
public equip2char_targ(t,chr,obj,x,y,z,unused,menu)
{
	if(!isChar(obj))
	{
		chr_message(chr,_,"You must target a charatcer");
		return;
	}

	new l = chr_sizeofLocalVar(chr,CLV_CMDTEMP);
	for(new i = 0; i < l; i++)
		if(isItem(chr_getLocalIntVec(chr,CLV_CMDTEMP,i)))
			chr_equip(obj,chr_getLocalIntVec(chr,CLV_CMDTEMP,i));

	chr_delLocalVar(chr,CLV_CMDTEMP);
}

//===========================================================================//
//                               ARCHITECTURE MENU                           //
//===========================================================================//
/*!
\author Fax
\fn addgui_architecture(chr,itemsInBackpack,amount)
\param chr: the character
\param itemsInBackpack: true if items are to be created in backpack
\amount:how many items we need
\since 0.82
\brief architecture page

\return nothing
*/

public addgui_architecture(chr,itemsInBackpack,amount)
{
	if(!isChar(chr)) return;

	#if _CMD_DEBUG_
	log_message("^t->drawing architecture menu");
	#endif

	createFramedMenu(0,0,4,20,70,"addgui_arch_cback");

	menu_addLabeledInputField(0,"wall",10,msg_add_itemType);
	cursor_newline();
	
	menu_addLabeledInputField(1,"stone",10,msg_add_material);
	cursor_newline();
	
	menu_addLabeledInputField(2,"1",10,msg_add_subtype);
	cursor_newline();
	
	menu_addLabeledButton(1,msg_add_openmenu);

	cursor_down(3);
	
	menu_addText(msg_add_architecture1);
	menu_addText(msg_add_architecture2);
	
	menu_addText(msg_add_architecture3);	
	
	menu_addText(msg_add_architecture4);				
	menu_addText("wall: stone, brick, log, marble, rattan, hide, tent, ruined^n");	
	menu_addText("      sandstone, wooden, bamboo, plaster, cave, dungeon^n");	
	menu_addText("stairs: marble, stone, sandstone, wooden, carpeted, cave^n");	
	menu_addText("floor: alchemical, marble, sandstone, planks, boards, logs, bricks^n");
	menu_addText("       tiles, flagstones, cobblestones, cave^n");			
	menu_addText("roof: stone, slate, tiles, palm, logs, tent, thatch^n");		
	menu_addText("door: metal, wooden, rattan^n");					
	menu_addText("gate: iron, wooden^n^n");						
	
	menu_addText(msg_add_architecture5);

	menu_show(chr);
}

public addgui_arch_cback(menu,chr,btncode)
{
	if(!btncode) return;
	
	new title[50],def[100],basedef[100],type[20],material[20],subtype[2];
	if(menu != INVALID)
	{
		gui_getProperty(menu,MP_UNI_TEXT,0,type);
		gui_getProperty(menu,MP_UNI_TEXT,1,material);
		gui_getProperty(menu,MP_UNI_TEXT,2,subtype);
	
		sprintf(title,"%s %s %s",material,type,subtype);
		sprintf(type,"_%s",type);
		if(strcmp(material,"")) sprintf(material,"_%s",material);
		if(!strcmp(subtype,"0")) sprintf(subtype,"");
	
		sprintf(basedef,"$item%s%s%s",material,type,subtype);

		chr_delLocalVar(chr,CLV_TEMP1);
		chr_addLocalStrVar(chr,CLV_TEMP1,basedef);
	}
	else 
		chr_getLocalStrVar(chr,CLV_TEMP1,basedef);
		
	sprintf(def,"%s_1",basedef);
	
	if(getIntFromDefine(def,false) <= 0)
	{
		chr_message(chr,_,msg_add_notDefined,def);
		return;
	}

	new tabx = 8;

	if(isStrContainedInStr("floor",def) || isStrContainedInStr("roof",def))
		tabx = 7;
	
	cursor_setProperty(CRP_TAB,tabx);
	
	new scriptID = 0,itm,ID,i=1,p=1;
	new cols = 7;
	new rows = 30;
	createFramedMenu(325,0,2,rows,cols,"addgui_arch_cback2");
	cursor_setProperty(CRP_START_Y,cursor_y());
	cursor_newline(4);
	
	menu_addPage(p);
	
	while(getIntFromDefine(def,false) != 0)
	{
		scriptID = getIntFromDefine(def,false);
		itm = itm_create(scriptID);
		ID = itm_getProperty(itm,IP_ID);
		itm_remove(itm);

		menu_addTilePic(ID);
		menu_addButton(scriptID);

		sprintf(def,"%s_%d",basedef,++i);
		
		if(cursor_down(5))
		{	
			cursor_reset();
			++p;
			menu_addLabeledPageButton(p,"next");
			
			cursor_down();
			menu_addPage(p);
			menu_addLabeledPageButton(p - 1,"prev");
			
			cursor_down(3);
		}
		
	}
	
	menu_show(chr);
	cursor_setProperty(CRP_TAB,10);
	cursor_setProperty(CRP_GRID_Y,18);
	
}

public addgui_arch_cback2(menu,chr,btncode)
{
	if(!btncode)
	{
		chr_delLocalVar(chr,CLV_TEMP1);
		return;
	}

	chr_message(chr,_,msg_add_click2PositionTheItem);
	target_create(chr,btncode,_,_,"cmd_add_itm_targ");
	addgui_arch_cback(INVALID,chr,1)

}


//==================================================================================//
//                                  TODO MENUS                                      //
//==================================================================================//
/*!
\author Fax
\fn addgui_deeds(chr,unused,unused2)
\param chr: the character
\param itemsInBackpack: true if items are to be created in backpack
\amount:how many items we need
\since 0.82
\brief SPAWNERS page

\return nothing
*/

public addgui_special(chr,unused,unused2)
{
	popupMenu(chr,"Work in progress","Special items menu is not yet^navailable");
}

public addgui_shard(chr,unused,unused2)
{
	popupMenu(chr,"Shard section","This section is for your shard's items,^nyou have to build it by yourself");
}

public addgui_treasure(chr,unused,unused2)
{
	popupMenu(chr,"Work in progress","Treasure items menu is not yet^navailable");
}

//===========================================================================//
//			DATA LOADING FUNCTIONS                               //
//===========================================================================//
//These functions are used to load addmenu.xss

/*!
\author Fax
\fn loadAddMenu(...)
\param 0: the character
\since 0.82
\brief loads add menu

if a parameter is passed this will be read as the calling character adn a message will be
sent to it sayng that the menu has been loaded.
\return nothing
*/
public loadAddMenu(...)
{
	//read additional params
	if(numargs() > 0)
		chr_message(getarg(0),_,msg_add_loadingAddMenu);
		
	log_message(msg_add_loadingAddMenu);
	
	//reset arrays and global variables, or new menu will be messed up
	reset();
	
	//create filename basing on choosen language
	switch(currentAddmenuLanguage)
	{
		case 0: sprintf(addmenu_xss,"%saddmenu_en.xss",addmenu_xss_path);
		case 1: sprintf(addmenu_xss,"%saddmenu_de.xss",addmenu_xss_path);
		case 2: sprintf(addmenu_xss,"%saddmenu_it.xss",addmenu_xss_path);
		case 3: sprintf(addmenu_xss,"%saddmenu_fr.xss",addmenu_xss_path);
	}
	
	//start XSS parsing routine
	if(xss_scanFile(addmenu_xss,"addgui_scan") == INVALID)
	{
		log_error(msg_add_unable2OpenFile,addmenu_xss);
		return;
	}
	
	//send info about th emenu loading
	log_message(msg_add_itemsLoaded,listIdx + 1,pageDataIdx + 1);
	
	if(numargs() > 0)
		chr_message(getarg(0),_,msg_add_itemsLoaded,listIdx + 1,pageDataIdx + 1);
}

/*!
\author Fax
\fn reset()
\since 0.82
\brief resets add menu script variables

Resets values in arrays and global vars as if the script was calledfor the first time
\return nothing
*/
static reset()
{
	submenuCount = 0;
	pageDataIdx = -1;
	listIdx = -1;
	
	for(new i = 0; i < MAX_ADD_SUBMENUS; i++)
	{
		submenuData[i][__pageDataIdx] = -1;
		submenuData[i][__numPages] = 0;
		submenuData[i][__height] = 0;
	}
	
	for(new i = 0; i < MAX_ADD_SUBMENUS*MAX_PAGES_PER_SUBMENU; i++)
	{
		pageData[i][__listIdx] = -1;
		pageData[i][__numItems] = 0;
		pageData[i][__submenu] = -1;
		pageData[i][__showPic] = 0;
		pageData[i][__showLabel] = 0;
	}	
}

/*!
\author Fax
\fn addgui_scan(file,line)
\since 0.82
\brief callback for XSS parsing function
\return nothing
*/
public addgui_scan(file,line)
{
	//parse SECTION MESSAGES
	if(!strcmp(currentXssSectionType,"MESSAGES"))
	{
		loadMessages(line);
		return;
	}
	
	//parse SECTION SUBMENU
	if(!strcmp(currentXssSectionType,"SUBMENU"))
	{
		loadSubmenu(line);
		return;
	}
	
	//parse SECTION PAGE
	if(!strcmp(currentXssSectionType,"PAGE"))
	{
		loadPage(line);
		return;
	}
}

/*!
\author Fax
\fn loadMessages(file,line)
\since 0.82
\brief loads add menu messages
\return nothing
*/
static loadMessages(line)
{
	
	new token[5];
	str2Token(currentXssValue,token,0,currentXssValue,0);
	ltrim(currentXssValue);
	
	//replace "^n" with '^n'
	new string[100];
	new j,l = strlen(currentXssValue);
	for(new i; i < l; i++,j++)
		if(currentXssValue[i] == '^^' && currentXssValue[i+1] == 'n')
		{
			string[j] = '^n';
			i++;
		}
		else string[j] = currentXssValue[i];
		
	
	if(!isStrInt(token))
	{
		log_error("%s(%d) - %s is not an integer value",addmenu_xss,line,token);
		return;	
	}	
	
	switch(str2Int(token))
	{
		case 0 : strcpy(msg_add_addingModeCont,string);
		case 1 : strcpy(msg_add_addingModeSingle,string);
		case 2 : strcpy(msg_add_reload,string);
		case 3 : strcpy(msg_add_createItemsInBackpack,string);
		case 4 : strcpy(msg_add_itemCreated,string);
		case 5 : strcpy(msg_add_click2PositionTheItem,string);
		case 6 : strcpy(msg_add_click2PositionTheChar,string);
		case 7 : strcpy(msg_add_WARNING,string);
		case 8 : strcpy(msg_add_itemsNotLoaded,string);
		case 9 : strcpy(msg_add_itemType,string);
		case 10: strcpy(msg_add_material,string);
		case 11: strcpy(msg_add_subtype,string);
		case 12: strcpy(msg_add_openmenu,string);
		case 13: strcpy(msg_add_architecture1,string);
		case 14: strcpy(msg_add_architecture2,string);
		case 15: strcpy(msg_add_architecture3,string);
		case 16: strcpy(msg_add_architecture4,string);
		case 17: strcpy(msg_add_architecture5,string);
		case 18: strcpy(msg_add_notDefined,string);
		case 19: strcpy(msg_add_loadingAddMenu,string);
		case 20: strcpy(msg_add_unable2OpenFile,string);
		case 21: strcpy(msg_add_itemsLoaded,string);
		case 22: strcpy(msg_add_mustBeInteger,string);
		case 23: strcpy(msg_add_mustBeHex,string);
		case 24: strcpy(msg_add_tooManyItems,string);
	}
}
/*!
\author Fax
\fn loadSubmenu(file,line)
\since 0.82
\brief loads a submenu declared in SECTION SUBMENU

Reads XSS commands and loads data into submenuData[][]
\return nothing
*/
static loadSubmenu(line)
{
	//store title and set the function the the standard one
	if(!strcmp(currentXssCommand,"TITLE"))
	{
		strcpy(submenuData[currentXssSection][__submenuTitle],currentXssValue);
		strcpy(submenuData[currentXssSection][__submenuFunction],standardFunction);
		submenuCount++;
		return;
	}
	
	//change the function to a custom one
	if(!strcmp(currentXssCommand,"FUNCTION"))
	{
		strcpy(submenuData[currentXssSection][__submenuFunction],currentXssValue);
		return;
	}
	
	//set menu body height
	if(!strcmp(currentXssCommand,"HEIGHT"))
	{
		if(!isStrInt(currentXssValue))
		{
			log_error(msg_add_mustBeInteger,addmenu_xss,line);
			return;
		}
		
		submenuData[currentXssSection][__height] = str2Int(currentXssValue);
		return;
	}
}

/*!
\author Fax
\fn loadPage(file,line)
\since 0.82
\brief loads a page declared in SECTION PAGE

Reads XSS commands and loads data into pageData[][] and addMenuList[][]
\return nothing
*/
static loadPage(line)
{
	//store the submenu the page belongs to
	if(!strcmp(currentXssCommand,"SUBMENU"))
	{
		if(!isStrInt(currentXssValue))
		{
			log_error(msg_add_mustBeInteger,addmenu_xss,line);
			skipXssSection = true;
			return;
		}		
		new submenu = str2Int(currentXssValue);
		
		
		//move pageData[][] index forward
		pageDataIdx++;
		
		//each time we find a SUBMENU command we must check if this is the first page
		//in the submenu
		if(submenuData[submenu][__pageDataIdx] == -1)
			submenuData[submenu][__pageDataIdx] = pageDataIdx;
		
		//increase number of pagesin the submenu
		submenuData[submenu][__numPages]++;
		
		strcpy(pageData[pageDataIdx][__pageFunction],"");
		return;
	}
	
	//store title
	if(!strcmp(currentXssCommand,"TITLE"))
	{
		strcpy(pageData[pageDataIdx][__pageTitle],currentXssValue);
		return;
	}
	
	//store title
	if(!strcmp(currentXssCommand,"FUNCTION"))
	{
		strcpy(pageData[pageDataIdx][__pageFunction],currentXssValue);
		return;
	}

	//store interline
	if(!strcmp(currentXssCommand,"INTERLINE"))
	{
		if(!isStrInt(currentXssValue))
		{
			log_error(msg_add_mustBeInteger,addmenu_xss,line);
			skipXssSection = true;
			return;
		}
		
		pageData[pageDataIdx][__addGui_interline] = str2Int(currentXssValue);
		return;
	}
	
	//store tab
	if(!strcmp(currentXssCommand,"TAB"))
	{
		if(!isStrInt(currentXssValue))
		{
			log_error(msg_add_mustBeInteger,addmenu_xss,line);
			skipXssSection = true;
			return;
		}
		
		pageData[pageDataIdx][__addGui_tab] = str2Int(currentXssValue);
		return;
	}	
	
	//store pic
	if(!strcmp(currentXssCommand,"PIC"))
	{
		pageData[pageDataIdx][__showPic] = 1;
		return;
	}
	
	//store label
	if(!strcmp(currentXssCommand,"LABEL"))
	{
		pageData[pageDataIdx][__showLabel] = 1;
		return;
	}	
	
	//load items
	if(!strcmp(currentXssCommand,"ITEM"))
	{
		loadObject(line,1);
		return;
	}
	
	//load NPCs
	if(!strcmp(currentXssCommand,"NPC"))
	{
		loadObject(line,-1);
		return;
	}
	
}

/*!
\author Fax
\fn loadObject(line,type)
\since 0.82
\brief loads objects in addMenuList[][]
\return nothing
*/
static loadObject(line,type)
{
	new token[200];

	//read ID and check if it's a valid Hex number, set to 0 the invalid IDs
	str2Token(currentXssValue,token,0,currentXssValue,0);
	sprintf(token,"0x%s",token);	
	if(!isStrHex(token))
	{
		log_error(msg_add_mustBeHex,addmenu_xss,line);
		sprintf(token,"0x0");
	}
	
	//increase index in addMenuList[][]
	listIdx++;
	
	//check boudaries of addMenuItems[][]
	if(listIdx >= MAX_ADDMENU_ITEMS)
	{
		log_warning(msg_add_tooManyItems);
		return;
	}
	
	//checkif this is the first page item
	if(pageData[pageDataIdx][__listIdx] == -1)
		pageData[pageDataIdx][__listIdx] = listIdx;
	
	//increase page items count
	pageData[pageDataIdx][__numItems]++;
	
	//load data into addMenuList[][]
	addMenuList[listIdx][__addGui_type] = type;
	addMenuList[listIdx][__addGui_ID] = str2Hex(token);
	str2Token(currentXssValue,addMenuList[listIdx][__addGui_def],0,addMenuList[listIdx][__addGui_name],0);
	return;
}

public test(chr,x,y)
{
	createFramedMenu(x,y,2,5,30,"addgui_arch_cback2");
	menu_show(chr);
}
/*! }@ */