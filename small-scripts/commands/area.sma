/*!
\defgroup script_command_area area command
\ingroup script_commands

@{
*/

/*!
\defgroup script_command_area_class command area system
\note MODIFYING THIS FILE MAY CAUSE THE INGAME COMMANDS NOT TO WORK PROPERLY!
@{
*/

const INCLUDE_CHR = 0x1; //!< include character in the area
const INCLUDE_ITM = 0x2; //!< include items in the area 
const INCUIDE_ALL = 0x3; //!< incllude all

const DEFAULT_R = VISRANGE;		//!< default value for the area radius
const DEFAULT_INCLUDE = INCLUDE_CHR;	//!< default value for the objects to include in an area
const DEFAULT_CMDS = 0xFFFFFFFF;	//!< default area duration (number of commands)

#define AREA_INVALID -1 //!< invalid area serial
/*!
\brief used by the area_ functions to address the main data structure

This enum contains constants to address the areas[][] array, you should never directly
use the areas[][] array and this enum, as they are private, used only for the command area 
system definition
*/
static enum areaParams
	{
		area_user,	//!< the character this command area is assigned to
		area_chrs,      //!< set with alla charcaters in the area
		area_itms,      //!< set with all the items in the area
		area_R,         //!< area Radius
		area_x,         //!< area's center x coordinate
		area_y,         //!< area's center y coordinate
		area_include,   //!< what objects should be included in the area
		area_cmdsLeft   //!< number of comands left for this area
	};

#define MAX_AREAS = 32;	//!< max number of areas, should be >= to the number of players that can access the 'area command

/*!
Main area system data structure, this array contains all the areas and their data, can be modified only
by the area_ functions
*/
static areas[MAX_AREAS][areaParams]; 



/*!
\author Fax
\fn chr_getCmdArea(const chr)
\brief returns the area used by a character 

Performs a sequential search in the area[][] array to see if it finds a match
between the given character and the areas users
\return the command area or AREA_INVALID

*/
public chr_getCmdArea(const chr)
{
	new area;
	for(area = 0; area < MAX_AREAS; area++)
		if(areas[area][area_user] == chr)
			return area;
	return AREA_INVALID;
}

/*!
\author Fax
\fn area_isValid(const area)
\brief checks if a number is a valid area serial
\return true if the number is avalid area serial, fale else
*/
public area_isValid(const area)
{
	return 0 <= area <= MAX_AREAS;
}

/*!
\author Fax
\fn cmds_getNewArea()
\brief gets a new area serial, logs a warning if the area[][] array is full
\return a valid command area serial
*/
public cmds_getNewArea()
{
	new area;
	for(area = 0; area < MAX_AREAS; area++)
		if(!isChar(areas[area][area_user]))
			return area;
	
	log_warning("No more command areas available!");
	return AREA_INVALID;
}

/*!
\author Fax
\fn area_useCommand(const area)
\brief decreases the available commands for the area effect and removes 
the area when no more commands are left
\return nothing
*/
public area_useCommand(const area)
{
	if(area < 0 || area > MAX_AREAS) return;
	areas[area][area_cmdsLeft]--;
	if(cmdsLeft == 0)
		areas[area][area_user] = INVALID;
}

/*!
\author Fax
\fn area_reset(const area)
\brief reloads objects in the area, needed when items/char are deleted/moved outside the area
\return nothing
*/
public area_refresh(const area)
{
	if(area < 0 || area > MAX_AREAS) return;
	
	//refresh objects in the lists
	if(areas[area][area_include] & INCLUDE_CHR)
	{
		set_addNpcsNearXY(area_chars(area),x,y,R);
		set_addOnPlNearXY(area_chars(area),x,y,R);
	}
	
	if(areas[area][area_include] & INCLUDE_ITM)
		set_addItemsNearXY(area_items,x,y,R,false);
}

/*!
\author Fax
\fn area_include(const area)
\brief gets the included objects in an area
\return INCLUDE_CHR, INCLUDE_ITM, INCLUDE_ALL 
*/
public area_include(const area)
{
	if(area < 0 || area > MAX_AREAS) return;
	return area[area][area_include];
}

/*!
\author Fax
\fn area_items(const area)
\brief returns the characters set of an area 
\return the items set serial
*/
public area_items(const area)
{
	if(area < 0 || area > MAX_AREAS) return;
	return area[area][area_itms];
}

/*!
\author Fax
\fn area_chars(const area)
\brief returns the characters set of an area 
\return the charcaters set serial
*/
public area_chars(const area)
{
	if(area < 0 || area > MAX_AREAS) return;
	return area[area][area_chrs];
}

/*! @} */  //end of script_command_area_class

/*!
\author Fax
\fn cmd_area(const chr)
\brief sets a command area for a character

<B>syntax:</B> 'area [R] [include] [duration]
<B>command params:</B>
<UL>
<LI> R: the area radius (default = VISRANGE)
<LI> include:
	<UL>
	<LI> "itm": include items only
	<LI> "chr": include chr only (default)
	<LI> "all": include all 
<LI> duration: number of commands that will be affected from the area effect. (default = unlimited (0xFFFFFFFF)) 
</UL>

If no params are specified and a command area is already active for the player, 
the area effect is stopped.<BR>
If no area effect is active, passing no params is like calling:<br>
\todo make this function work when commands are done in sources
*/
public cmd_area(const chr)
{
	new area = chr_getCmdArea(chr);
	
	//charcater has an active area, delete it
	if(area != -1)
	{
		areas[area][area_user] = INVALID;
		return;
	}
	
	//else create an area and assign it to character
	area = cmds_getNewArea();
	if(area == AREA_INVALID)
	{
		chr_message(chr,_,"No more command areas available");
		return;
	}
	areas[area][area_user] = chr;
	area_items = set_create();
	areas[area][area_itms] = set_create();
	
	//TODO: get R, objects to include and commands left from params
	areas[area][area_R] = DEFAULT_R;
	areas[area][area_include] = DEFAULT_INCLUDE;
	areas[area][area_cmdsLeft] = DEFAULT_CMDS;	
	
	chr_message(chr,_,"Target the area center");
	target_create(chr,area,_,_,"cmd_area_targ");
}

/*!
\author Fax
\fn cmd_area_targ(target, chr, object, x, y, z, unused1, area)
\brief handles the area targetting

This funciton is called as a target callback in the 'area command.<br>
It creates the command area and initializes it.
*/
public cmd_area_targ(target, chr, object, x, y, z, unused1, area)
{

	//if an object has been targetted, its position is the area centre
	if(isChar(object))
		chr_getPosition(chr,x,y,z);
	else 	if(isItem(object))
			itm_getPositionVec(itm,x,y,z);

	//include characters in area if required
	if(areas[area][area_include] & INCLUDE_CHR)
	{
		set_addNpcsNearXY(area_chars(area),x,y,R);
		set_addOnPlNearXY(area_chars(area),x,y,R);
	}
	
	//include items in area if required
	if(areas[area][area_include] & INCLUDE_ITM)
		set_addItemsNearXY(area_items,x,y,R,false);
	
	areas[area][area_x] = x;
	areas[area][area_y] = y;
}

/*! }@ */  //end of script_commad_area