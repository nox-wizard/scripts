/*!
\defgroup script_command_area 'area
\ingroup script_commands

\brief sets a command area for a character

\b syntax: 'area [R][include][ncommands]
- R: the area radius (default = VISRANGE)
- include:
	-# "itm": include items only
	-# "chr": include chr only (default)
	-# "all": include all 
- ncommands: number of commands that will be affected from the area effect. (default = 1000000000) 

Calling 'area with no parameters will result in a default area to be set, centered at the 
character's position and with the values specified in the script.\n
If the character already had a command area set, calling 'area with no parameters
will only delete the area, and no new area is set.

\section command_areas Command areas
The 'area command is used to set command areas, a command area is a set of objects in a certain map area.\n
When a command area is set, all commands will act on every object in the area as if you used the
command on each object separately.\n
This is useful when you want to apply the same command on a big amount of objects and you don't 
want to waste time retyping the command and targetting every single object.\n
If you define the number of commands the command area will be cleared after the given number 
of commanda have been used.\n
Not all commands support command areas, and every command that supports them has an optional last
parameter ("t") that allows you to bypass the command area for that command, when passing "t" to a
command as last parameter the command works as if the command area was not set, allowing you to aplly
a command to a single object without having to clear and reset the area.\n
@{
*/

/*!
\defgroup script_command_area_class command area system
@{
*/

#define INCLUDE_CHR 0x1 //!< include character in the area
#define INCLUDE_ITM 0x2 //!< include items in the area 
#define INCLUDE_ALL 0x3 //!< incllude all

#define DEFAULT_R VISRANGE		//!< default value for the area radius
#define DEFAULT_INCLUDE INCLUDE_ALL	//!< default value for the objects to include in an area
#define DEFAULT_CMDS 50000	//!< default area duration (number of commands)

#define AREA_INVALID -1 //!< invalid area serial
/*!
\brief used by the area_ functions to address the main data structure

This enum contains constants to address the areas[][] array, you should never directly
use the areas[][] array and this enum, as they are private, used only for the command area 
system definition
*/
enum areaParams
	{
		area_user,	//!< the character this command area is assigned to
		area_chrs,      //!< set with all charcaters in the area
		area_itms,      //!< set with all the items in the area
		area_R,         //!< area Radius
		area_x,         //!< area's center x coordinate
		area_y,         //!< area's center y coordinate
		area_incl,	//!< what objects should be included in the area
		area_cmdsLeft   //!< number of comands left for this area
	};

/*!
Main area system data structure, this array contains all the areas and their data, can be modified only
by the area_ functions
*/
static areas[MAX_AREAS][areaParams]; 

/*!
\author Fax
\fn resetCmdAreas()
\brief initializes data in areas[][] 
*/
public resetCmdAreas()
{
	#if _CMD_DEBUG_
		log_message("^t->Resetting command areas");
	#endif

	new area;
	for(area = 0; area < MAX_AREAS; area++)
		areas[area][area_user] = INVALID;
}

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
	if(areas[area][area_cmdsLeft] == 0)
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

	//delete old sets
	set_delete(areas[area][area_chrs]);
	set_delete(areas[area][area_itms]);

	areas[area][area_chrs] = set_create();
	areas[area][area_itms] = set_create();

	//reload objects in the lists
	if(areas[area][area_incl] & INCLUDE_CHR)
	{
		set_addNpcsNearXY(area_chars(area),areas[area][area_x],areas[area][area_y],areas[area][area_R]);
		set_addOnPlNearXY(area_chars(area),areas[area][area_x],areas[area][area_y],areas[area][area_R]);
	}

	if(areas[area][area_incl] & INCLUDE_ITM)
		set_addItemsNearXY(area_items(area),areas[area][area_x],areas[area][area_y],areas[area][area_R],false);
}

/*!
\author Fax
\fn area_include(const area)
\brief gets the included objects in an area
\return INCLUDE_CHR, INCLUDE_ITM, INCLUDE_ALL 
*/
public area_include(const area)
{
	if(area < 0 || area > MAX_AREAS) return INVALID;
	return areas[area][area_incl];
}

/*!
\author Fax
\fn area_itemsIncluded(const area)
\brief checks if the command area includes items
\return true if items are included, false if not 
*/
public area_itemsIncluded(const area)
{
	return area_include(area) & INCLUDE_ITM;
}

/*!
\author Fax
\fn area_charsIncluded(const area)
\brief checks if the command area includes characters
\return true if characters are included, false if not 
*/
public area_charsIncluded(const area)
{
	return area_include(area) & INCLUDE_CHR;
}

/*!
\author Fax
\fn area_items(const area)
\brief returns the characters set of an area 
\return the items set serial
*/
public area_items(const area)
{
	if(area < 0 || area > MAX_AREAS) return INVALID;
	return areas[area][area_itms];
}

/*!
\author Fax
\fn area_chars(const area)
\brief returns the characters set of an area 
\return the charcaters set serial
*/
public area_chars(const area)
{
	if(area < 0 || area > MAX_AREAS) return INVALID;
	return areas[area][area_chrs];
}

/*! @} */  //end of script_command_area_class

/*!
\author Fax
\fn cmd_area(const chr)
\brief start function for 'area command

This function is called by sources on 'area command detection.\n
You can change it in commands.txt.
*/
public cmd_area(const chr)
{
	readCommandParams(chr);

	//get current character command area
	new area = chr_getCmdArea(chr);

	//if no params are passed and an area is set, delete it and return
	if(!strlen(__cmdParams[0]) && area != AREA_INVALID)
	{
		areas[area][area_user] = INVALID;
		chr_message(chr,_,msg_commandsDef[88]);
		return;
	}

	//if character doesn't have an active area yet, create one
	//else current area will be updated (thus removed)
	if(area == AREA_INVALID)
	{
		area = cmds_getNewArea();
		if(area == AREA_INVALID)
		{
			chr_message(chr,_,msg_commandsDef[89]);
			return;
		}
	}

	//handle no params call, set defaults
	if(!strlen(__cmdParams[0]))
	{
		areas[area][area_user] = chr;
		set_delete(area_chars(area));
		set_delete(area_items(area));
		areas[area][area_chrs] = set_create();
		areas[area][area_itms] = set_create();
		areas[area][area_R] = DEFAULT_R;
		areas[area][area_x] = chr_getProperty(chr,CP_POSITION,CP2_X);
		areas[area][area_y] = chr_getProperty(chr,CP_POSITION,CP2_Y);
		areas[area][area_incl] = DEFAULT_INCLUDE;
		areas[area][area_cmdsLeft] = DEFAULT_CMDS;
		area_refresh(area);
		chr_message(chr,_,msg_commandsDef[90]);

		#if _CMD_DEBUG_
			log_message("^tNew standard command area set for character %d^n",areas[area][area_user]);
			log_message("^tR:%d^n",areas[area][area_R]);
			log_message("^tx,y: %d,%d^n",areas[area][area_x],areas[area][area_y]);
			log_message("^tcommands:%d^n",areas[area][area_cmdsLeft]);
		#endif

		return;
	}

	//READ AND CHECK PARAMETERS

	//---------------  radius  ----------------------
	if(!isStrInt(__cmdParams[0]))
	{
		chr_message(chr,_,msg_commandsDef[91]);
		return;
	}

	new R = str2Int(__cmdParams[0]);
	if(R < 0)
	{
		chr_message(chr,_,msg_commandsDef[92]);
		return;
	}

	//set radius
	areas[area][area_R] = R;

	//---------------  include mode  ----------------------
	if(!strlen(__cmdParams[1]))
	{
		chr_message(chr,_,msg_commandsDef[93]);
		return;
	}

	if(!strcmp(__cmdParams[1],"itm"))
		areas[area][area_incl] = INCLUDE_ITM;

	else 	if(!strcmp(__cmdParams[1],"chr"))
			areas[area][area_incl] = INCLUDE_CHR;

		else if(!strcmp(__cmdParams[1],"all"))
			areas[area][area_incl] = INCLUDE_ALL;

			else
			{
				chr_message(chr,_,msg_commandsDef[94]);
				return;
			}

	//---------------  number of commands  -----------------
	if(!strlen(__cmdParams[2]))
	{
		chr_message(chr,_,msg_commandsDef[95]);
		return;
	}

	if(!strcmp(__cmdParams[2],"unlimited"))
		areas[area][area_cmdsLeft] = 1000000000;
	else 	if(!isStrInt(__cmdParams[2]))
		{
			chr_message(chr,_,msg_commandsDef[96]);
			return;
		}

		else areas[area][area_cmdsLeft] = str2Int(__cmdParams[2]);

	//recreate items and chars sets
	set_delete(area_items(area));
	areas[area][area_itms] = set_create();

	set_delete(area_chars(area));
	areas[area][area_chrs] = set_create();

	//ask for target
	chr_message(chr,_,msg_commandsDef[97]);
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

	if(x < 0 || y < 0)
	{
		chr_message(chr,_,msg_commandsDef[6]);
		return;
	}

	//if an object has been targetted, its position is the area centre
	//if a map location has been targetted x y and z are automatically set
	if(isChar(object))
		chr_getPosition(object,x,y,z);
	else 	if(isItem(object))
			itm_getPosition(object,x,y,z);

	//fill area with items or chars
	area_refresh(area);

	//set area center
	areas[area][area_x] = x;
	areas[area][area_y] = y;

	//finally we can assign area to character
	areas[area][area_user] = chr;

	chr_message(chr,_,msg_commandsDef[98]);
	#if _CMD_DEBUG_
		log_message("^tNew command area set for character %d^n",areas[area][area_user]);
		log_message("^tR:%d^n",areas[area][area_R]);
		log_message("^tx,y: %d,%d^n",areas[area][area_x],areas[area][area_y]);
		log_message("^tcommands:%d^n",areas[area][area_cmdsLeft]);
		log_message("^tinclude:%d^n",areas[area][area_incl]);
	#endif
}

/*! }@ */  //end of script_commad_area