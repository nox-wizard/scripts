//=========================================================================================//
//                              TARGET HELP FUNCTIONS                                      //
//=========================================================================================//
/*!
\author Fax
\fn getMapLocation(object,&x,&y,&z)
\param object: the item or char
\param x,y,z: x y z
\since 0.82
\brief returns the map location corresponding to the object

Tis function is designed to be used to find out the targetted map location from the parameters of
a target callback,this is to be used this way:<br>
\code
public cmd_tile_targ(target, chr, object, x, y, z, unused, nXnYnZ)
{
	getMapLocation(object,x,y,z);	
}
\endcode
this will fill x y z with a valid map location even if an item or character has been targetted.
\return INVALID if no valid map location can be retrieved.
*/
public getMapLocation(object,&x,&y,&z)
{
	if(isItem(object))
		itm_getPosition(object,x,y,z);
	else 	if(isChar(object))
			chr_getPosition(object,x,y,z);
	
	if(x == INVALID || y == INVALID) return INVALID;	
	return OK;
}


/*!
\author Fax
\fn getRectangle(const chr, callback[])
\param chr: the character
\param callback[]: the function that will be called at the end of rectangle aquisition
\since 0.82
\brief ask the player to select a rectangle on the map by clicking two map locations that will be the corners of the rectangle.

This function is used to ask a player for a map rectangle, player hasto target 2 map locations 
(he can target items or characters, in that cas the object's position will be taken) and then the callback
will be called and it will be passed the rectangle.<br>
Callback proptotype must be:<br>
\code
public callback(chr,x0,y0,x1,y1)
\endcode
x0,y0 are the top left corner coords<br>
x1,y1 are the bottom right corner coords<br>
It's always x0 <= x1 && y0 <= y1.
\return nothing
*/
public getRectangle(const chr, callback[])
{
	chr_delLocalVar(chr,CLV_TEMP1);
	chr_addLocalStrVar(chr,CLV_TEMP1,callback);
	
	chr_message(chr,_,"Select first rectangle corner");
	target_create(chr,_,_,_,"rectangle_cback_1");
}

/*!
\author Fax
\fn rectangle_cback_1(target, chr, object, x, y, z, unused, unused1)
\param all: standard target callback params
\since 0.82
\brief first callback to get the rectangle

You shouldn't need to look edit this function
\return nothing
*/
public rectangle_cback_1(target, chr, object, x, y, z, unused, unused1)
{
	if(getMapLocation(object,x,y,z) == INVALID)
	{
		chr_message(chr,_,"Invalid map location!");
		return;
	}
	
	chr_message(chr,_,"Select second rectangle corner");
	new xy = (x << 16) + y;
	target_create(chr,xy,_,_,"rectangle_cback_2");

}


/*!
\author Fax
\fn rectangle_cback_2(target, chr, object, x, y, z, unused, unused1)
\param all: standard target callback params
\since 0.82
\brief second callback to get the rectangle

You shouldn't need to look edit this function
\return nothing
*/
public rectangle_cback_2(target, chr, object, x, y, z, unused, xy)
{
	if(getMapLocation(object,x,y,z) == INVALID)
	{
		chr_message(chr,_,"Invalid map location!");
		return;
	}
	
	new x1,x0 = xy >> 16;
	new y1,y0 = xy & 0xFFFF;
	
	if(x0 > x)
	{
		x1 = x0;
		x0 = x;
	}
	else x1 = x;
	
	if(y0 > y)
	{
		y1 = y0;
		y0 = y;
	}
	else y1 = y;
	
	new callback[AMX_FUNCTION_LENGTH + 1];
	chr_getLocalStrVar(chr,CLV_TEMP1,callback);
	chr_delLocalVar(chr,CLV_TEMP1);
	
	callFunction5P(funcidx(callback),chr,x0,y0,x1,y1);
}
