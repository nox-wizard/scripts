
#include "small-scripts/API/set.api"

/*!
\defgroup script_API_gui_menu menu library
\ingroup script_API_gui
@{
*/
enum
{
	MP_BUTTON_UP = 0,  	//!< buttons up gump
	MP_BUTTON_DOWN,		//!< buttons down gump
	MP_BUTTON_WIDTH,	//!< button width,in pixels
	
	MP_PAGEBUTTON_UP,	//!< page buttons up gump
	MP_PAGEBUTTON_DOWN,	//!< page buttons down gump
	MP_PAGEBUTTON_WIDTH,	//!< page button width, in pixels
	
	MP_CHECKBOX_OFF,	//!< checkboxes off gump
	MP_CHECKBOX_ON,		//!< checkboxes off gump
	MP_CHECKBOX_WIDTH,	//!< checkboxes width
	
	MP_APPLY_UP,		//!< apply button up gump
	MP_APPLY_DOWN,		//!< apply button down gump
	
	MP_CANCEL_UP,		//!< cancel button up gump
	MP_CANCEL_DOWN,		//!< cancel button down gump
	
	MP_OK_UP,		//!< ok button up gump
	MP_OK_DOWN,		//!< ok button down gump
	
	MP_BACKGROUND,		//!< background resize gump
	MP_FOREGROUND,		//!< foreground resize gump
	
	MP_TITLE_COLOR,		//!< title text color
	MP_TEXT_COLOR,		//!< normal text color
	
	MP_COUNT
}


static mp[MP_COUNT]; //!< menu properties array

/*!
standard properties values, each menu gets this set of properties when created
*/
static mp_0[MP_COUNT] =
{
	0x4B9, //0x29F4,  	
	0x4BA, //0x29F6,		
	20,		
	
	0x0827,		
	0x0827,		
	15,		
	
	0x138b,
	0x138a,
	25,
	
	0x084A,
	0x084B,
	
	0x0849,
	0x0848,

	0x0850,
	0x0851,
		
	0x13bE,
	0x0dac,
	
	33,
	1310
}; 


static currentMenu; //!< current menu serial

/*!
\author Fax
\fn createMenu(startx,starty,callback[])
\param startx,starty: top left corner coords
\param callback[]: menu callback
\since 0.82
\brief creates a menu

Creates a menu object, with no graphics on it, 
use this function if you want to create a fully customized menu
\return the menu serial
*/
stock createMenu(startx,starty,callback[])
{
	currentMenu = gui_create(startx,starty,true,true,true,callback);
	
	//reset properties
	for(new p = 0; p < MP_COUNT; p++)
		mp[p] = mp_0[p];
		
	return currentMenu;
}

/*!
\author Fax
\fn menu_delete()
\since 0.82
\brief deletes current menu

If the menu was shown to someone it will not be closed! This function is to be used if you
want to delete a menu wich will never be shown.
\return nothing
*/
stock menu_delete()
{
	gui_delete(currentMenu);
	currentMenu = INVALID;
}
/*!
\author Fax
\fn menu_drawStandardFrame(rows1,rows2,cols)
\param rows1: header rows
\param rows2: body rows
\param cols: width
\since 0.82
\brief draws a standard menu frame

A standard menu frame is for example the 'add menu frame.<BR>
It's formed by:
 - header: the part that usually contains the menu title
 - body: the rest of the menu
 - background: a background that contains both the header and the body
 
This functions sets the menu interline and grid to the standard values.<BR>
After the function call the cursor is in the top left corner of the header.
<br>
Modify this function to give to all yourmenus the standard apearance you prefer, here
you can define the menu styleof your shard's menus
\return nothing
*/
static menu_drawStandardFrame(rows1,rows2,cols)
{
	new grid_x = cursor_getProperty(CRP_GRID_X);
	new grid_y = cursor_getProperty(CRP_GRID_Y);
	new startx = cursor_getProperty(CRP_START_X);
	new starty = cursor_getProperty(CRP_START_Y);
	
	cursor_setProperty(CRP_START_X,startx + 3*grid_x + grid_x/2);
	cursor_setProperty(CRP_START_Y,starty + grid_y + grid_y/2);
	cursor_reset();
	
	new n = 5;
	if(rows2 == 0) n = 3;
	gui_addResizeGump(currentMenu,startx,starty,mp[MP_BACKGROUND],(cols + 7)*grid_x,(rows1 + rows2 + n + 1)*grid_y);
	gui_addResizeGump(currentMenu,startx + grid_x ,starty + grid_y/2,mp[MP_FOREGROUND],(cols + 5)*grid_x,(rows1 + 2)*grid_y);
	if(rows2 > 0)	gui_addResizeGump(currentMenu,startx + grid_x ,starty + grid_y/2 + (rows1 + 2)*grid_y,mp[MP_FOREGROUND],(cols + 5)*grid_x,(rows2 + 2)*grid_y);
	
	cursor_move(0,(rows1 + rows2 + n - 2)*grid_y);
	
	new noxTag[] = "NOX Wizard 0.82"
	if(!cursor_right(cols/2 - 3 - strlen(noxTag)/2))
		menu_addTitle(noxTag);
		
	cursor_setProperty(CRP_MAX_X,cursor_getProperty(CRP_START_X) + cols*grid_x);
	cursor_setProperty(CRP_MAX_Y,cursor_getProperty(CRP_START_Y) + (rows1 + rows2 + n - 4)*grid_y);
	
	cursor_reset();
}

/*!
\author Fax
\fn createFramedMenu(startx,starty,rows1,rows2,cols,callback[])
\param startx,starty: top left corner coords
\param rows1:header rows
\param rows2: body rows
\param cols: width in columns
\param callback[]: menu callback
\since 0.82
\brief draws a standard framed menu

This function draws a menu with a standard frame, after the function call the cursor is in the top
left corner of the header
\return the menu serial
*/
stock createFramedMenu(startx,starty,rows1,rows2,cols,callback[])
{
	cursor_setProperty(CRP_START_X,startx);
	cursor_setProperty(CRP_START_Y,starty);
	createMenu(startx,starty,callback);
	menu_drawStandardFrame(rows1,rows2,cols);
	return currentMenu;
}

/*!
\author Fax
\fn createStdMenu(startx,starty,rows,cols,title[],callback[])
\param startx,starty: top left corner coords
\param rows: body rows
\param cols: width in columns
\param title[]: menu title
\param callback[]: menu callback
\since 0.82
\brief draws a standard menu

A standard menu has a standard frame with a 1-line header wich contains the title, after the function call the
cursor is in the to left corner of the body and the cursor CRP_START_Y is set to the top of the body
so calling cursor_reset() the cursor will be put in the top left corner of the body.
\return the menu serial
*/
stock createStdMenu(startx,starty,rows,cols,title[],callback[])
{
	createFramedMenu(startx,starty,1,rows,max(cols,strlen(title) + 2),callback);
	cursor_right(cols/2 - strlen(title)/2);
	menu_addTitle(title);
	cursor_newline(3)
	cursor_setProperty(CRP_START_Y,cursor_y());
	return currentMenu;
}

/*!
\author Fax
\fn createPopupMenu(title[],message[])
\param title[]: popup title
\param message[]: popup message
\since 0.82
\brief creates a popup menu

A popup menu is a standard menu wich contains a title and a message,it can only be closed by the user.<BR>
The menu will be automatically sized to fit the message, you can use newline characters ('^n') in the message
and they will be correctly read.
\return the menu serial
*/
stock createPopupMenu(title[],message[])
{
	//count newlines and find the longest line
	new lines = 0;
	new maxl,lastn,l = strlen(message);
	for(new i = 0; i <= l; i++)
		if(message[i] == '^n' || message[i] == 0)
		{ 
			lines++;
			if(i - lastn + 1 > maxl) maxl = i - lastn + 1;
			lastn = i;
		}
	
	createStdMenu(100,100,lines,maxl,title,"popup_cback");
	
	replaceStr(message," ","_"); //we must do this or we won't be able to tokenize the string correctly
	
	new token[512],temp[512];
	strcpy(temp,message);
	while(strlen(temp))
	{
		str2Token(temp,token,0,temp,0);
		replaceStr(token,"_"," ");
		menu_addText(token);
		cursor_newline();
	}
	
	return currentMenu;
}

/*!
brief standard callback for popups, empty
*/
public popup_cback()
{
	return;	
}


/*!
\author Fax
\fn createMessageBox(title[],message[],okCallback[],cancelCalback[])
\param title[]: the message box title
\param message[]: the message box text
\param callback[]: the menu callback
\since 0.82
\brief creates a message box with

A message box consists in a popup menu with an OK and a CANCEL button.<br>
The return codes for the 2 buttons are:
- OK: 2
- CANCEL: 1

\return nothing
*/
public createMessageBox(title[],message[],callback[])
{
	new msg[512];
	sprintf(msg,"%s^n^n",message);
	createPopupMenu(title,msg);
	
	cursor_back();
	new middle = (cursor_getProperty(CRP_MAX_X) + cursor_x())/2;
	cursor_goto(middle,cursor_y());
	cursor_left(8);
	menu_addOkButton(2);
	
	cursor_right(9)
	menu_addCancelButton(1);	
}

/*!
\author Fax
\fn createListMenu(startx,starty,rows,cols,nitems,title[],callback[],menuCallback[])
\param startx,starty: top left corner coords
\param rows: menu body height in rows
\param cols: menu width in columns
\param nitems: total number of lines
\param title[]: menu title
\param callback[]: line callback
\param menuCAllback[]:generalmenu callback
\since 0.82
\brief creates a menu with a list

This is a very powerful function!<BR>
A list menu is a framed menu with a 2-lines header and a custom body.<BR>
In the body will appear the list<BR>
What is to be listed is up to you to decide, the menu works as follows:
'nitems' defines the total number of list entries, the gump will automatically add pages if the list
can't fit in one and will provide 'next' and 'prev' buttons to browse the pages.<BR>
The items are added top to bottom and right to left, the spacing is given by the cursor interline
and tab.<BR>
The list appearance is not defined: for each list item the function will call the 'callback',
a function provided by you that will draw the item.<BR>
The callback prototype must be:
\code
public callback(page,line,col,i)
\endcode
where:<BR>
- page: is the current page in the menu
- line: is the current line in the page
- col: is the current column
- i: is the current list line, 0 based
To better understand how this works take a look at the locationsMenu.sma script or addmenu.sma.<BR>
The 'menuCallback' is the real menu callback,that one that is called on menu events.<br>
After every callback call the cursor is moved to the next line.
\return the menu serial
*/
stock createListMenu(startx,starty,rows,cols,nitems,title[],callback[],menuCallback[])
{
	
	createFramedMenu(startx,starty,2,rows,cols,menuCallback);
		
	cursor_right(cols/2 - strlen(title)/2);
	menu_addTitle(title);
	cursor_newline();
	cursor_setProperty(CRP_START_Y,cursor_y());
	cursor_newline(3);
	new p=1;
	menu_addPage(p);
	
	
	new line,col;
	for(new i; i < nitems; i++)
	{
		callFunction4P(funcidx(callback),p,line,col,i);
		if(cursor_down())
		{
			cursor_top();
			line = 0;
			
			if(cursor_tab())
			{	
				cursor_back();
				col = 0;
				cursor_right(cols/2 + 2);
				++p;
				menu_addLabeledPageButton(p,"next");
				
				cursor_left(10);
				menu_addPage(p);
				menu_addLabeledPageButton(p - 1,"prev");
				
				cursor_back();				
			}
			else col++
			
			cursor_down(3);
			
		}
		else line++;
	}
	return currentMenu;
}

/*!
\author Fax
\fn createListMenu1(startx,starty,rows,cols,nitems,title[],callback[],menuCallback[])
\param startx,starty: top left corner coords
\param rows: menu body height in rows
\param cols: menu width in columns
\param nitems: total number of lines
\param title[]: menu title
\param callback[]: line callback
\param menuCallback[]:general menu callback
\since 0.82
\brief creates a menu with a simple list

This function creates a list in "client safe" mode (without crashing it)<br>
The usage is similar to createListMenu() except that:
- each item should occupy a single row
- the callback prototype is:<br>
\code
	public callback(idx);
	//idx: the current item index
\endcode

This function is less powerful than createListMenu() because you can only draw items that fit 
a single row (or they will go out of the menu boudaries) and each page contains a single column of items.<br> 
You can obtain the same result using createListMenu() and drawing single line items (eg: labeled buttons).<br>
The advantage of using this function is that each page is a separated menu and only that menu is sent to the client,
so ou can build huge lists without crashing the client (as would happen with createListMenu()).<br>
For lists with less of about 200 gump items (text, buttons, pics) you can use createListMenu(), for bigger
menus use createSimpleListMenu().

\return the menu serial
*/
stock createListMenu1(startx,starty,rows,cols,nitems,title[],callback[],menuCallback[])
{
	//create a temporary menu, just to call drawSimpleListMenu() as if it was called by
	//one of the "prev" "next" buttons
	new m = createFramedMenu(startx,starty,2,rows,cols,menuCallback);
	menu_addTitle(title);
	
	//store parameters so the function can draw the menu
	menu_storeValue(0,startx);
	menu_storeValue(1,starty);
	menu_storeValue(2,rows);
	menu_storeValue(3,cols);
	menu_storeValue(4,nitems);
	menu_storeString(0,title);
	menu_storeString(1,callback);
	menu_storeString(2,menuCallback);
	
	//draw the first page
	return drawSimpleListMenuPage(m,INVALID,(rows > nitems ? nitems : rows) - 1);	
}

public drawSimpleListMenuPage(menu,chr,btncode)
{
	if(!btncode) return INVALID;
	
	printf("ciao^n");
	//read data to draw the menu
	new startx = menu_readValue(menu,0);
	new starty = menu_readValue(menu,1);
	new rows = menu_readValue(menu,2);
	new cols = menu_readValue(menu,3);
	new nitems = menu_readValue(menu,4);
	new title[100];
	
	printf("bu^n");
	menu_readString(menu,0,title);
	new callback[AMX_FUNCTION_LENGTH];
	menu_readString(menu,1,callback);
	new menuCallback[AMX_FUNCTION_LENGTH]
	menu_readString(menu,2,menuCallback);
	
	printf("%s %s %s^n",title,callback,menuCallback);
	
	//delete old menu (only needed to get rid of the first temp menu)
	menu_delete();
	
	//create new menu (that will be actually shown)
	new m = createFramedMenu(startx,starty,2,rows,cols,menuCallback);
	menu_addTitle(title);
	
	//store parameters so we can redraw the menu in the next calls to this function
	menu_storeValue(0,startx);
	menu_storeValue(1,starty);
	menu_storeValue(2,rows);
	menu_storeValue(3,cols);
	menu_storeValue(4,nitems);
	menu_storeString(0,title);
	menu_storeString(1,callback);
	menu_storeString(2,menuCallback);
	
	printf("riciao^n");
	
	//the "prev" "next" buttons return code (btncode) contains information about
	//the starting and ending items to be drawn
	new startIdx = btncode >> 16;
	new stopIdx = btncode & 0xFFFF;
	
	printf("startIdx:%d - stopIdx:%d^n",startIdx,stopIdx);
	
	cursor_newline();
	
	//if this is not the first page add the "prev" button
	if(startIdx > rows) 
	{
		new idx1 = startIdx - rows;
		new idx2 = startIdx - 1;
		menu_addLabeledButtonFn((idx1 << 16) + idx2,"drawSimpleListMenuPage","Prev");
	}
	
	//if this is not the last page add the "next" button
	if(stopIdx < nitems - 1)
	{
		new idx1 = stopIdx;
		new idx2 = stopIdx + rows;
		if(idx2 >= nitems) idx2 = nitems - 1;
		menu_addLabeledButtonFn((idx1 << 16) + idx2,"drawSimpleListMenuPage","Next");
	}
	
	//go down to the menu body
	cursor_newline(3);
	
	//draw items by calling the callback
	for(new idx = startIdx; idx < stopIdx; idx++)
	{
		callFunction1P(funcidx(callback),idx); //the callback will only add text on the right of the button
		cursor_newline();
	}
	
	//chr == INVALID on the first call, because it's called from createSimpleListMenu()
	if(isChar(chr))
		menu_show(chr);
	
	return m;	
}

static setListCallback[AMX_FUNCTION_LENGTH],setListSet;

/*!
\author Fax
\fn createSetListMenu(startx,starty,rows,cols,set,title[],callback[],menuCback[])
\param startx,starty: top left corner coords
\param rows: menu body height in rows
\param cols: menu width in columns
\param set: the set
\param title[]: menu title
\param callback[]: line callback
\param menuCAllback[]:generalmenu callback
\since 0.82
\brief creates a menu with a list whose lines are taken from a set

This function creates a list menu whose items are taken from a set<BR>
The total number of items is the set size and each time the callback prototype must be:
\code
public callback(page,line,col,i,set)
\endcode
where:<BR>
- page: is the current page in the menu
- line: is the current line in the page
- col: is the current column
- i: is the current list line
- set: the set
To better understand how this works take a look at the pageMenu.sma script.<BR>
\note remember to advance the set index in the callback or you will get a loop
\return the menu serial
*/
stock createSetListMenu(startx,starty,rows,cols,set,title[],callback[],menuCback[])
{
	strcpy(setListCallback,callback);
	setListSet = set;
	set_rewind(setListSet);
	return createListMenu(startx,starty,rows,cols,set_size(set),title,"createSetListCback",menuCback)
}

public createSetListCback(p,l,c,i)
{
	callFunction5P(funcidx(setListCallback),p,l,c,i,setListSet);
}

/*!
\author Fax
\fn menu_getProperty(prop)
\param prop: the property to be read
\since 0.82
\brief reads a menu property
\return the property value
*/
stock menu_getProperty(prop)
{
	return mp[prop];
}

/*!
\author Fax
\fn menu_setProperty(prop,value)
\param prop: the property to be set
\param value: the value
\since 0.82
\brief sets a menu property

Use this function to change the menu appearance, make all you property modifications
BEFORE starting to build the menu
\return the property value
*/
stock menu_setProperty(prop,value)
{
	mp[prop] = value;
}

/*!
\author Fax
\fn menu_storeValue(idx,value)
\param idx: index
\param value: value to be stored
\since 0.82
\brief stores a value in an array

Used to pass parameters to the callback, store values into the menu and then read them in the
callback with menu_readValue()
\return nothing
*/
stock menu_storeValue(idx,value)
{
	gui_setProperty(currentMenu,MP_BUFFER,idx,value);
}


/*!
\author Fax
\fn menu_storeValue(idx,string)
\param idx: index
\param string: string to be stored
\since 0.82
\brief stores a string in an array

Used to pass parameters to the callback, store strings into the menu and then read them in the
callback with menu_readString()
\return nothing
*/
stock menu_storeString(idx,string[])
{
	gui_setProperty(currentMenu,MP_STR_BUFFER,idx,string);
}

/*!
\author Fax
\fn menu_readValue(menu,idx)
\param menu: the menu
\param idx: index
\since 0.82
\brief reads a value from an array

Used to pass parameters to the callback,store values with menu_storeValue()
\return nothing
*/

stock menu_readValue(menu,idx)
{
	return gui_getProperty(menu,MP_BUFFER,idx);
}

/*!
\author Fax
\fn menu_readString(menu,idx,string[])
\param menu: the menu
\param idx: index
\param string[]: a preallocated string that will be filled
\since 0.82
\brief reads a string from an array

Used to pass parameters to the callback, store strings with menu_storeString()
\return nothing
*/

stock menu_readString(menu,idx,string[])
{
	return gui_getProperty(menu,MP_STR_BUFFER,idx,string);
}

/*!
\author Fax
\fn menu_setCurrent(menu)
\param menu:the newmenu serial
\since 0.82
\brief changes the current menu

With this function you can change the menu you are working on.<br>
All menu properties will be transferred to the new menu.<BR>
Make sure you have a backup of the old menu serial or you won't be able to retrieve it again.
\return nothing
*/
stock menu_setCurrent(menu)
{
	currentMenu = menu;
}


//=========================== MENU ITEMS ================================//

/*!
\author Fax
\fn menu_addText(text[],...)
\param text[]: the text to be added
\param 1: the color
\since 0.82
\brief adds color text to the menu

The text starts at cursor's position<BR>
You can specify the text color as additional parameter.<br>
If the last n characters are newlines ('^n') n cursor_newline() are called<br>
Note that only '^n' CHARACTERS as valid as newlines, not "^n" strings, so

\code
	menu_addText("hello^n") 
\endcode

will be printed as: <br>
hello^n<br><br>

while

\code
	new string[20];
	sprintf(string,"hello^n");
	menu_addText(string);	
\endcode

will be printed as:<br>
hello<br><br>

with a final cursor_newline() call

\return nothing
*/
stock menu_addText(text[],...)
{
	new color = mp[MP_TEXT_COLOR];
	if(numargs() > 1)
		color = getarg(1);
		
	gui_addText(currentMenu,cursor_x(),cursor_y(),color,text);
	for(new i = strlen(text); text[i - 1] == '^n'; i--) 
		cursor_newline();
}

/*!
\author Fax
\fn menu_addTitle(text[])
\param text[]: the text to be added
\since 0.82
\brief adds title text to the menu

The text starts at cursor position<BR>
The text will be colored with MP_TITLE_COLOR
\return nothing
*/
stock menu_addTitle(text[])
{
	menu_addText(text,mp[MP_TITLE_COLOR]);
}

/*!
\author Fax
\fn menu_addCheckBox(checked,id,...)
\param checked: true if the checkbox is checked by default
\param id: checkbox id
\param 3: gump on
\param 4: gump off
\since 0.82
\brief adds a checkbox to the menu

The checkbox is positioned at the cursor's position
If params 3 or 4 are set they override the standard on and off checkbox gumps
\return nothing
*/
stock menu_addCheckBox(checked,id,...)
{
	//handle custom gumps
	new gumpOn = mp[MP_CHECKBOX_ON];
	new gumpOff = mp[MP_CHECKBOX_OFF];
	if(numargs() > 2)
	{
		gumpOn = getarg(2);
		if(numargs() > 3)
			gumpOff = getarg(3);
	}
	gui_addCheckbox(currentMenu,cursor_x(),cursor_y(),gumpOn,gumpOff,checked,id);
}

/*!
\author Fax
\fn menu_addLabeledCheckbox(checked,id,label[],...)
\param checked: true if the checkbox is checked by default
\param id: checkbox id
\param label[]: the label
\param 4:
\param 5:
\since 0.82
\brief adds a labeled checkbox to the menu

The checkbox is positioned at the cursor's position, the label starts just after the checkbox
\return nothing
*/

stock menu_addLabeledCheckbox(checked,id,label[],...)
{
	//handle custom gumps
	new gumpOn = mp[MP_CHECKBOX_ON];
	new gumpOff = mp[MP_CHECKBOX_OFF];
	if(numargs() > 3)
	{
		gumpOn = getarg(3);
		if(numargs() > 4)
			gumpOff = getarg(4);
	}
	
	gui_addCheckbox(currentMenu,cursor_x(),cursor_y(),gumpOn,gumpOff,checked,id);

	cursor_move(mp[MP_CHECKBOX_WIDTH],0);
	menu_addText(label);
	cursor_move(-1*mp[MP_CHECKBOX_WIDTH],0);
}

/*!
\author Fax
\fn menu_addInputField(id,text[],nchars)
\param id: input field id
\param text[]: the default text
\param nchars: input field length in characters
\since 0.82
\brief adds an input field to the menu

The input field starts at cursor position
\return nothing
*/
stock menu_addInputField(id,text[],nchars)
{
	new grid_x = cursor_getProperty(CRP_GRID_X);
	new grid_y = cursor_getProperty(CRP_GRID_Y);
	gui_addInputField(currentMenu,cursor_x(),cursor_y(),nchars*grid_x,grid_y,id,mp[MP_TEXT_COLOR],text);
}

/*!
\author Fax
\fn menu_addLabeledInputField(id,text[],nchars,label[])
\param id: input field id
\param text[]: the default text
\param nchars: input field length in characters
\param label[]: the label
\since 0.82
\brief adds a labeled input field to the menu

The label starts at cursor position,the input field comes just after the label
\return nothing
*/

stock menu_addLabeledInputField(id,text[],nchars,label[])
{
	menu_addText(label)
	cursor_right(strlen(label));
	menu_addInputField(id,text,nchars);
	cursor_right(-1*strlen(label));
}

/*!
\author Fax
\fn menu_addPage(page)
\param page: the page index
\since 0.82
\brief adds a page

Page 0 is the default page and is always visible, additional pages start from 1
\return nothing
*/
stock menu_addPage(page)
{
	gui_addPage(currentMenu,page);
}

/*!
\author Fax
\fn menu_addPageButton(page,...)
\param page: the page the button points to
\param 1: up gump
\param 2: down gump
\since 0.82
\brief adds a page button

The page button is put at cursor's position<br>
If you specify the up and down gumps they will override the MP_PAGEBUTTON_* properties.
\return nothing
*/
stock menu_addPageButton(page,...)
{
	//handle custom gumps
	new gumpUp = mp[MP_PAGEBUTTON_UP];
	new gumpDown = mp[MP_PAGEBUTTON_DOWN];
	if(numargs() > 1)
	{
		gumpUp = getarg(1);
		if(numargs() > 2)
			gumpDown = getarg(2);
	}
	
	gui_addPageButton(currentMenu,cursor_x(),cursor_y(),gumpUp,gumpDown,page);
}

/*!
\author Fax
\fn menu_addLabeledPageButton(page,label[])
\param page: the page the button points to
\param label[]: the label
\param 2: up gump
\param 3: down gump
\since 0.82
\brief adds a labeled page button

The label starts at cursor position,the page button is put just after the label
If you specify the up and down gumps they will override the MP_PAGEBUTTON_* properties.
\return nothing
*/

stock menu_addLabeledPageButton(page,label[],...)
{
	//handle custom gumps
	new gumpUp = mp[MP_PAGEBUTTON_UP];
	new gumpDown = mp[MP_PAGEBUTTON_DOWN];
	if(numargs() > 2)
	{
		gumpUp = getarg(2);
		if(numargs() > 3)
			gumpDown = getarg(3);
	}
	
	gui_addPageButton(currentMenu,cursor_x(),cursor_y(),gumpUp,gumpDown,page);
	cursor_move(mp[MP_PAGEBUTTON_WIDTH],0);
	menu_addText(label);
	cursor_move(-1*mp[MP_PAGEBUTTON_WIDTH],0);
}

/*!
\author Fax
\fn menu_addButton(btncode,...)
\param btncode: the button return code
\since 0.82
\brief adds a button to the menu

The button is added at cursor's position
\return nothing
*/
stock menu_addButton(btncode,...)
{
	//handle custom gumps
	new gumpUp = mp[MP_BUTTON_UP];
	new gumpDown = mp[MP_BUTTON_DOWN];
	if(numargs() > 1)
	{
		gumpUp = getarg(1);
		if(numargs() > 2)
			gumpDown = getarg(2);
	} 
	gui_addButton(currentMenu,cursor_x(),cursor_y(),gumpUp,gumpDown,btncode);
}


/*!
\author Fax
\fn menu_addLabeledButton(btncode,label[])
\param btncode: the button return code
\param label[]: the label
\param 2: up gump
\param 3: down gump
\since 0.82
\brief adds a labeled button to the menu

The label starts at cursor position,the button is put just after the label
\return nothing
*/
stock menu_addLabeledButton(btncode,label[],...)
{
	//handle custom gumps
	new gumpUp = mp[MP_BUTTON_UP];
	new gumpDown = mp[MP_BUTTON_DOWN];
	if(numargs() > 2)
	{
		gumpUp = getarg(2);
		if(numargs() > 3)
			gumpDown = getarg(3);
	}
	
	gui_addButton(currentMenu,cursor_x(),cursor_y(),gumpUp,gumpDown,btncode);
	cursor_move(mp[MP_BUTTON_WIDTH],0);
	menu_addText(label);
	cursor_move(-1*mp[MP_BUTTON_WIDTH],0);
}

/*!
\author Fax
\fn menu_addApplyButton(btncode)
\param btncode: the button's return code
\since 0.82
\brief adds an APPLY button to the menu

This is like any other button, but it uses the MP_APPLYBUTTON_* gump
\return nothing
*/
stock menu_addApplyButton(btncode)
{
	gui_addButton(currentMenu,cursor_x(),cursor_y(),mp[MP_APPLY_UP],mp[MP_APPLY_DOWN],btncode);
}

/*!
\author Fax
\fn menu_addCancelButton(btncode)
\param btncode: the button's return code
\since 0.82
\brief adds a CANCEL button to the menu

This is like any other button, but it uses the MP_CANCEL_* gumps
\return nothing
*/
stock menu_addCancelButton(btncode)
{
	gui_addButton(currentMenu,cursor_x(),cursor_y(),mp[MP_CANCEL_UP],mp[MP_CANCEL_DOWN],btncode);
}


/*!
\author Fax
\fn menu_addCancelButton(btncode)
\param btncode: the button's return code
\since 0.82
\brief adds an OK button to the menu

This is like any other button, but it uses the MP_OK_* gump
\return nothing
*/
stock menu_addOkButton(btncode)
{
	gui_addButton(currentMenu,cursor_x(),cursor_y(),mp[MP_OK_UP],mp[MP_OK_DOWN],btncode);
}

/*!
\author Fax
\fn menu_addTilePic(gump)
\param gump:gump index in art.mul
\since 0.82
\brief adds a tile pic to the menu

The pic is put at cursor position
\return nothing
*/
stock menu_addTilePic(gump)
{
	gui_addTilePic(currentMenu,cursor_x(),cursor_y(),gump);
}

/*!
\author Fax
\fn menu_addLabeledTilePic(gump,width,label[])
\param gump: gump index in art.mul
\param width: pic width in pixels
\param label[]: the label
\since 0.82
\brief adds a tile pic to the menu

The label starts at cursor position,the pic is put just after the label.<BR>
The width is needed to know how far the text should be put
\return nothing
*/

stock menu_addLabeledTilePic(gump,width,label[])
{
	gui_addTilePic(currentMenu,cursor_x(),cursor_y(),gump);
	cursor_move(width,0);
	menu_addText(label);
	cursor_move(-1*width,0);
}

/*!
\author Fax
\fn menu_addGump(gump,...)
\param gump: gump index in gumpart.mul
\param 1: color
\since 0.82
\brief adds a gump to the menu

The gump is put at cursor position, you can specify the color as additional parameter
\return nothing
*/
stock menu_addGump(gump,...)
{
	new color = 0;
	if(numargs() > 1)
		color = getarg(1);
		
	gui_addGump(currentMenu,cursor_x(),cursor_y(),gump,color)
}

/*!
\author Fax
\fn menu_addButtonFn(btncode,callback[])
\param btncode: the button return code
\param callback[]: the callback
\param 2: up gump
\param 3: down gump
\since 0.82
\brief adds a function button to the gump

The button is added at cursor's position
\return nothing
*/
stock menu_addButtonFn(btncode,callback[],...)
{
	//handle custom gumps
	new gumpUp = mp[MP_BUTTON_UP];
	new gumpDown = mp[MP_BUTTON_DOWN];
	if(numargs() > 2)
	{
		gumpUp = getarg(2);
		if(numargs() > 3)
			gumpDown = getarg(3);
	}
	
	gui_addButtonFn(currentMenu,cursor_x(),cursor_y(),gumpUp,gumpDown,btncode,true,callback);
}

/*!
\author Fax
\fn menu_addLabeledButtonFn(btncode,callback[],label[])
\param btncode: the button return code
\param callback[]: the callback
\param label[]: the label
\param 3: up gump
\param 4: down gump
\since 0.82
\brief adds a labeled function button to the gump

The label starts at cursor position,the button is put just after the label
\return nothing
*/
stock menu_addLabeledButtonFn(btncode,callback[],label[],...)
{
	//handle custom gumps
	new gumpUp = mp[MP_BUTTON_UP];
	new gumpDown = mp[MP_BUTTON_DOWN];
	if(numargs() > 3)
	{
		gumpUp = getarg(3);
		if(numargs() > 4)
			gumpDown = getarg(4);
	}
	
	gui_addButtonFn(currentMenu,cursor_x(),cursor_y(),gumpUp,gumpDown,btncode,true,callback);
	cursor_move(mp[MP_BUTTON_WIDTH],0);
	menu_addText(label);
	cursor_move(-1*mp[MP_BUTTON_WIDTH],0);
}

//=========================== MENU SHOWING =============================================//			

/*!
\author Fax
\fn menu_show(...)
\param ...: the characters
\since 0.82
\brief shows a menu to given characters

You can specify a variable number of characters that will be shown the menu.<br>
\return nothing
*/	
stock menu_show(...)
{
	new n = numargs();
	for(new a = 0; a < n; a++)
	{
		if(isChar(getarg(a)))	
			gui_show(currentMenu,getarg(a));	
	}
	
	currentMenu = INVALID;
	cursor_restoreDefaults();
}

/*!
\author Fax
\fn menu_show(s)
\param s: the set
\since 0.82
\brief shows a menu to characters in a set

You must take care of creating and deleting the set, see menu_broadcast() for an example.
\return nothing
*/	
stock menu_showSet(s)
{
	for(set_rewind(s); !set_end(s);)
		gui_show(currentMenu,set_getChar(s));
	
	currentMenu = INVALID;
	cursor_restoreDefaults();
}

/*!
\author Fax
\fn menu_broadcast()
\since 0.82
\brief shows a menu to all online players
\return nothing
*/	
stock menu_broadcast()
{
	new s = set_create();
	set_fillAllOnlinePl(s);	
	menu_showSet(s);
	set_delete(s);
}

/*!
\author Fax
\fn popupMenu(chr,title[],message[])
\param chr: the character
\param title[]: the popup title
\param message[]: the popup text
\since 0.82
\brief
\return nothing
*/
stock popupMenu(chr,title[],message[])
{
	createPopupMenu(title,message);
	menu_show(chr);
}

/*!
\author Fax
\fn messageBox(chr,title[],message[],callback[])
\param chr: the character
\param title[]: the message box title
\param message[]: the message box text
\param callback[]: the menu callback
\since 0.82
\brief
\return nothing
*/
stock messageBox(chr,title[],message[],callback[])
{
	createMessageBox(title,message,callback);
	menu_show(chr);
}

/*!
\author Fax
\fn broadcastPopup(title[],message[])
\param title[]: the popup title
\param message[]: the popup message
\since 0.82
\brief shows a popup to all online players
\return nothing
*/
stock broadcastPopup(title[],message[])
{
	createPopupMenu(title,message);
	new s = set_create();
	set_addAllOnlinePl(s);
	for(set_rewind(s);!set_end(s);)
		menu_show(set_getChar(s));
	set_delete(s);
}

//================================ MENU DATA READING ===========================================//

/*!
\author Fax
\fn menu_getInputField(menu,index,string[])
\param menu: the menu
\param index: the input field index
\param string: string that will be filled with the result
\since 0.82
\brief reads an input filed from given menu
\return nothing
*/
stock menu_getInputField(menu,index,string[])
{
	return gui_getProperty(menu,MP_UNI_TEXT,index,string);
}

/*!
\author Fax
\fn menu_getCheckbox(menu,index)
\param menu: the menu
\param index: the checkbox index
\since 0.82
\brief reads a checkbox value
\return the checkbox value
*/
stock menu_getCheckbox(menu,index)
{
	return gui_getProperty(menu,MP_CHECK,index);
}

/*!
\author Fax
\fn menu_getRadio(menu,index)
\param menu: the menu
\param index: the radio button index
\since 0.82
\brief reads a radio button value
\return the radio button value
*/
stock menu_getRadio(menu,index)
{
	return gui_getProperty(menu,MP_RADIO,index);
}

/*! @}*/ 