#if defined _nxw_lib2_included_
	#endinput
#endif
#define _nxw_lib2_included_
/** \defgroup script_helper_nxwlib2
 *  @{
 */
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
stock cmd_tile_targ(target, chr, object, x, y, z, unused, nXnYnZ)
{
	getMapLocation(object,x,y,z);	
}
\endcode
this will fill x y z with a valid map location even if an item or character has been targetted.
\return INVALID if no valid map location can be retrieved.
*/
stock getMapLocation(object,&x,&y,&z)
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
stock callback(chr,x0,y0,x1,y1)
\endcode
x0,y0 are the top left corner coords<br>
x1,y1 are the bottom right corner coords<br>
It's always x0 <= x1 && y0 <= y1.
\return nothing
*/
stock getRectangle(const chr, callback[])
{
	chr_delLocalVar(chr,CLV_TEMP1);
	chr_addLocalStrVar(chr,CLV_TEMP1,callback);
	
	chr_message(chr,_,msg_nxwlibDef[0]);
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
new rect_z;
new rect_object;
public rectangle_cback_1(target, chr, object, x, y, z, staticid, unused1)
{
	//get xyz no matter if item, char or object was targeted
	if(getMapLocation(object,x,y,z) == INVALID)
	{
		chr_message(chr,_,msg_nxwlibDef[1]);
		return;
	}
	
	rect_z = z;
	rect_object = object;
	//we have 32bit for storing x1,y1 and z1, we use 16 for x, 16 for y
	//and basic z we store in ...?
	new xy = (x << 16) + y;
	chr_message(chr,_,msg_nxwlibDef[2]);
	
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
public rectangle_cback_2(target, chr, object1, x, y, z, unused, xy)
{
	if(getMapLocation(object1,x,y,z) == INVALID)
	{
		chr_message(chr,_,msg_nxwlibDef[1]);
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
	
	new xy0=(x0 << 16) + y0;
	new xy1=(x1 << 16) + y1;
	new z0=rect_z;
	new z1=z;
	
	new callback[AMX_FUNCTION_LENGTH + 1];
	chr_getLocalStrVar(chr,CLV_TEMP1,callback);
	chr_delLocalVar(chr,CLV_TEMP1);
	
	callFunction6P(funcidx(callback),chr,xy0,xy1,z0,z1,rect_object);
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
stock callback(chr,x0,y0,x1,y1)
\endcode
x0,y0 are the top left corner coords<br>
x1,y1 are the bottom right corner coords<br>
It's always x0 <= x1 && y0 <= y1.
\return nothing
*/
stock getRectangleTop(const chr, callback[])
{
	//printf("enter rect^n");
	chr_delLocalVar(chr,CLV_TEMP1);
	chr_addLocalStrVar(chr,CLV_TEMP1,callback);
	
	chr_message(chr,_,msg_nxwlibDef[0]);
	target_create(chr,_,_,_,"rectangleTop_cback_1");
}
/*!
\author Fax
\fn rectangleTop_cback_1(target, chr, object, x, y, z, unused, unused1)
\param all: standard target callback params
\since 0.82
\brief first callback to get the rectangle
Gives the top of the target for adding stuff on top of other items
You shouldn't need to look edit this function
\return nothing
*/
public rectangleTop_cback_1(target, chr, object, x, y, z, itemid, unused1)
{
	//get xyz no matter if item, char or object was targeted
	if(getMapLocation(object,x,y,z) == INVALID)
	{
		chr_message(chr,_,msg_nxwlibDef[1]);
		return;
	}
	
	//printf("staticid is %d^n", itemid);
	
	new height;
	new worldstone_loc = createResourceMap( RESOURCEMAP_LOCATION, 1, "worldstone_loc");
	
	if(itemid != -1)
	{
		if(0x0<=itemid<=0x1770)
			height = getResourceLocationValue(worldstone_loc, 1, itemid, 1 ); //region exists (value of y=id is height)
		else if(0x1771<=itemid<=0x2EE0)
			height = getResourceLocationValue(worldstone_loc, 2, itemid, 1 ); //region exists (value of y=id is height)
		else if(0x2EE1<=itemid<=0x4650)
			height = getResourceLocationValue(worldstone_loc, 3, itemid, 1 ); //region exists (value of y=id is height)
		//always put it for errors in rendering 1 higher on floor tiles
		if( height == 0) height = 1;
	}
	else height = 0;
	
	//printf("height is %d, z0 in rectangle is: %d^n", height, z);
	rect_z = z+height;	
	//we have 32bit for storing x1,y1 and z1, we use 16 for x, 16 for y
	//and basic z we store in ...?
	//printf("z0 in rectangle after height check is: %d^n", rect_z);
	new xy = (x << 16) + y;
	chr_message(chr,_,msg_nxwlibDef[2]);
	
	target_create(chr,xy,_,_,"rectangleTop_cback_2");
}

/*!
\author Fax, Horian
\fn rectangleTop_cback_2(target, chr, object, x, y, z, unused, unused1)
\param all: standard target callback params
\since 0.82
\brief second callback to get the rectangle
Gives the top of the target for adding stuff on top of other items
You shouldn't need to look edit this function
\return nothing
*/
public rectangleTop_cback_2(target, chr, object, x, y, z, itemid, xy)
{
	if(getMapLocation(object,x,y,z) == INVALID)
	{
		chr_message(chr,_,msg_nxwlibDef[1]);
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
	
	new xy0=(x0 << 16) + y0;
	new xy1=(x1 << 16) + y1;
	new z0=rect_z;
	
	new height;
	new worldstone_loc = createResourceMap( RESOURCEMAP_LOCATION, 1, "worldstone_loc");
	
	if(itemid != -1)
	{
		if(0x0<=itemid<=0x1770)
			height = getResourceLocationValue(worldstone_loc, 1, itemid, 1 ); //region exists (value of y=id is height)
		else if(0x1771<=itemid<=0x2EE0)
			height = getResourceLocationValue(worldstone_loc, 2, itemid, 1 ); //region exists (value of y=id is height)
		else if(0x2EE1<=itemid<=0x4650)
			height = getResourceLocationValue(worldstone_loc, 3, itemid, 1 ); //region exists (value of y=id is height)
		//always put it for errors in rendering 1 higher on floor tiles
		if( height == 0) height = 1;
	}
	else height = 0;
	
	new z1=z+height;
	
	new callback[AMX_FUNCTION_LENGTH + 1];
	chr_getLocalStrVar(chr,CLV_TEMP1,callback);
	chr_delLocalVar(chr,CLV_TEMP1);
	
	callFunction5P(funcidx(callback),chr,xy0,xy1,z0,z1);
}

//=========================================================================================//
//                                 SET HELP FUNCTIONS                                      //
//=========================================================================================//
/*!
\author Fax
\fn set_Delove(const set,const value)
\param set: the set
\param value: the value to be removed
\since 0.82
\brief removes a value from a set
Removes a value from a set, if the value is found more than once, all occurrencies will be removed.
\return nothing
*/
stock set_Delove(const set,const value)
{
	new t,tset = set_create();
	for(set_rewind(set);!set_end(set);)
	{
		t = set_get(set);
		if(t != value)	set_add(tset,t);
	}
	
	set_clear(set);
	for(set_rewind(tset);!set_end(tset);)
		set_add(set,set_get(tset));
	set_delete(tset);
}
//=======================================================================================//
//                              FILE HELP FUNCTIONS                                      //
//=======================================================================================//
#define FILE_SCAN_BUFFER_SIZE 512
static __fileScanBuffer[FILE_SCAN_BUFFER_SIZE]; //!< global variable used to read the scanned line in file scanning functions
/*!
\author Fax
\fn file_scan(file[], callback[], exclude[])
\param file[]: the file to be scanned, path starts from NOX folder.
\param callback[]: the function to be called for each line
\param exclude[]: list of "comment" charatcers
\since 0.82
\brief scans a file and calls the callback for every line
The file is scanned line by line and calls the callback for each line.<BR>
If the line starts with one of the tokens specified in the
exclude string, the line is skipped, this allows toput comments in files.<BR>
The callback will be passed the file handle and the line number, read the line with file_getScanLine().<BR>
line number = INVALID means EOF (End Of File).
A typical callback will be structured as follows:
\code
stock process_line(file,line)
{
	if(line == INVALID)
	{ 
		printf("EOF^n");
		return;
	}
	
	printf("scanning line %d^n",line);
	
	new line[FILE_SCAN_BUFFER_SIZE];
	file_getScanLine(line);
}
\endcode
\example file_scan(file,"process_line","//")
\return the number of scanned lines or INVALID if file does not exist
*/
stock file_scan(filename[], callback[], exclude[])
{
	new file = file_open(filename,"r");
	if(file == INVALID) return INVALID;
	
	new line,token[50];
	
	for(file_read(file,__fileScanBuffer); !file_eof(file); file_read(file,__fileScanBuffer))
	{
		line++
		
		if(!strlen(__fileScanBuffer)) continue;
		
		substring(__fileScanBuffer,0,strlen(exclude)-1,token,0);
		
		if(!strcmp(token,exclude)) continue;
		
		callFunction2P(funcidx(callback),file,line);
	}
	
	//call the callback with EOF line
	callFunction2P(funcidx(callback),file,INVALID);
	file_close(file);
	return line;
}
/*!
\author Fax
\fn file_getScanLine(line[FILE_SCAN_BUFFER_SIZE])
\param line[]: a preallocated string
\since 0.82
\brief returns the scanned line filling line[]
Use this function at the beginning of your callback to read the scan line
\note you can directly use __file_scan_buffer[] if you want
\return nothing
*/
stock file_getScanLine(line[FILE_SCAN_BUFFER_SIZE])
{
	strcpy(line,__fileScanBuffer);
}
new currentXssSectionType[FILE_SCAN_BUFFER_SIZE];
new currentXssSection;
new currentXssCommand[FILE_SCAN_BUFFER_SIZE];
new currentXssValue[FILE_SCAN_BUFFER_SIZE];
new skipXssSection;
/*!
\author Fax
\fn file_scanXss(file[], callback[])
\param file[]: the file to be scanned, path starts from NOX folder.
\param callback[]: the function to be called for each XSS command
\since 0.82
\brief scans an XSS file and calls the callback for every command
The file is scanned line by line and calls the callback for each XSS command<BR>
The callback will be passed the file handle and the line number.<BR>
You can read XSS section type, section number, command and value with:<BR>
	- currentXssSectionType[]
	- currentXssSection
	- currentXssCommand[]
	- currentXssValue[]
	
\return the number of scanned sections or INVALID if file does not exist
*/
stock xss_scanFile(filename[],callback[])
{
	new file = file_open(filename,"r");
	if(file == INVALID) return INVALID;
	
	new line,section,token[50];
	
	for(file_read(file,__fileScanBuffer); !file_eof(file); file_read(file,__fileScanBuffer))
	{		
		line++
		trim(__fileScanBuffer);
		
		if(!strlen(__fileScanBuffer)) continue;
		
		//skip comments
		if(__fileScanBuffer[0] == '/' && __fileScanBuffer[1] == '/') continue;
		
		//seek "SECTION"
		str2Token(__fileScanBuffer,token,0,__fileScanBuffer,0)
		
		//#include
		if(!strcmp(token,"#include"))
		{
			str2Token(__fileScanBuffer,token,0,__fileScanBuffer,0)
			xss_scanFile(token,callback);
		}
		
		if(strcmp(token,"SECTION")) continue;
		
		//store the section type
		str2Token(__fileScanBuffer,currentXssSectionType,0,token,0)
		
		//read section number
		if(isStrInt(token)) currentXssSection = str2Int(token);
		else 	if(isStrHex(token)) currentXssSection = str2Hex(token);
			else	currentXssSection = getIntFromDefine(token);
		
		//seek first non empty line
		for(file_read(file,__fileScanBuffer); !file_eof(file); file_read(file,__fileScanBuffer))
		{
			trim(__fileScanBuffer);
			if(__fileScanBuffer[0] == 0) continue;
			break;
		}
		
		if(file_eof(file))
		{
			log_error("%s(%d): unexpected end of file - '{' expected",filename,line);
			file_close(file);
			return INVALID;
		}
		
		if(__fileScanBuffer[0] != '{')
		{
			log_error("%s(%d): expected token '{', found %s",filename,line,__fileScanBuffer);
			file_close(file);
			return INVALID;
		}
		
		//read XSS commands
		skipXssSection = false;
		for(file_read(file,__fileScanBuffer); !file_eof(file) && !skipXssSection; file_read(file,__fileScanBuffer))
		{
			line++;
			trim(__fileScanBuffer);
			if(__fileScanBuffer[0] == 0) continue; //skip empty lines
			if(__fileScanBuffer[0] == '/' && __fileScanBuffer[1] == '/') continue; //skip comments
			if(__fileScanBuffer[0] == '}') break; //end of section
						
			str2Token(__fileScanBuffer,currentXssCommand,0,currentXssValue,0);
			trim(currentXssValue);
			
			callFunction2P(funcidx(callback),file,line);
		}
		
		if(file_eof(file))
		{
			log_error("%s(%d): unexpected end of file - '}' expected",filename,line);
			file_close(file);
			return INVALID;
		}
		
		section++;	
	}
	
	file_close(file);
	return section;
}
stock str2ScriptID(string[])
{
	if(isStrInt(string))
		return str2Int(string);
	return getIntFromDefine(string,true);
}
//=========================================================================================//
//                              CHARACTER HELP FUNCTIONS                                   //
//=========================================================================================//
/*!
\author Fax
\fn getOnlineCharFromName(name[])
\param name[]: the name
\since 0.82
\brief returns character with given name
\return character serial or INVALID if character is not online
*/
stock getOnlineCharFromName(name[])
{
	new chr2, name1[50];
	new s = set_create(),found = false;
	set_addAllOnlinePl(s);
	for(set_rewind(s); !set_end(s) && !found; )
	{
		chr2 = set_getChar(s);
		chr_getProperty(chr2,CP_STR_NAME,0,name1);
		if(!strcmp(name1,name)) found = true;
	}
	
	set_delete(s);
	if(found)
		return chr2;
	return INVALID;
}
/*!
\author Fax
\fn chr_getRace(const chr)
\param chr: the character
\since 0.82
\brief returns race of character
This functions has been written to simplify custom race definition.<BR>
All scripts use this function to get the race, so if you modify this function all scripts
will work with your races.
\return the charatcer's race
*/
stock chr_getRace(const chr)
{
	return chr_getProperty(chr,CP_RACE);
}
/*!
\author Fax
\fn chr_getClass(const chr)
\param chr: the character
\since 0.82
\brief returns class of character
This functions has been written to simplify custom class definition.<BR>
All scripts use this function to get the class, so if you modify this function all scripts
will work with your classes.
\return the charatcer's race
*/
stock chr_getClass(const chr)
{
	return 0; //standard classes hasn't been defined yet
}
/*!
\author Horian
\fn chr_getSkillsum(const chr, skillsum[])
\param chr: the character
\param skillsum: the characters skillsum
\since 0.82
\brief returns skillsum of character in a string
\return the skillsum
*/
stock chr_getSkillsum(const chr, skillsum[])
{
	new skillsumStr[10];
	new sum = chr_getSkillCap(chr);
	sprintf(skillsumStr,"%d",sum);
	return sum;
}
/*!
\author Fax
\fn chr_copy(const chr)
\param chr: the character to be copied
\since 0.82
\brief copies a character
This function creates a new character with the same scriptID of the given one, note that
the new character will have properties set to the standard value given in the XSS definition
\see chr_duplicate(const chr)
\return copied character's serial
*/
stock chr_copy(const chr)
{
	return chr_addNPC(chr_getProperty(chr,CP_SCRIPTID),1,1,0);
}
/*!
\author Fax
\fn chr_duplicate(const chr)
\param chr: the character
\since 0.82
\brief duplicates a character
The returned character will have all the properties set to the starting character's.<br>
The starting character's equipment is copied and equipped to the new character.
\see chr_copy(const chr)
\return new character's serial
*/
stock chr_duplicate(const chr)
{
	new subprop;
	new copy = chr_copy(chr);
	//copy properties, only those really needed
	chr_setProperty(copy,CP_CANTRAIN,_,chr_getProperty(chr,CP_CANTRAIN));
	chr_setProperty(copy,CP_TAMED,_,chr_getProperty(chr,CP_TAMED));
	chr_setProperty(copy,CP_SHOPKEEPER,_,chr_getProperty(chr,CP_SHOPKEEPER));
	chr_setProperty(copy,CP_FROZEN,_,chr_getProperty(chr,CP_FROZEN));
	chr_setProperty(copy,CP_DIR,_,chr_getProperty(chr,CP_DIR));
	chr_setProperty(copy,CP_DIR2,_,chr_getProperty(chr,CP_DIR2));
	chr_setProperty(copy,CP_FLAG,_,chr_getProperty(chr,CP_FLAG));
	chr_setProperty(copy,CP_FLY_STEPS,_,chr_getProperty(chr,CP_FLY_STEPS));
	chr_setProperty(copy,CP_HIDDEN,_,chr_getProperty(chr,CP_HIDDEN));
	chr_setProperty(copy,CP_NPCWANDER,_,chr_getProperty(chr,CP_NPCWANDER));
	chr_setProperty(copy,CP_OLDNPCWANDER,_,chr_getProperty(chr,CP_OLDNPCWANDER));
	chr_setProperty(copy,CP_PRIV2,_,chr_getProperty(chr,CP_PRIV2));
	chr_setProperty(copy,CP_REACTIVEARMORED,_,chr_getProperty(chr,CP_REACTIVEARMORED));
	chr_setProperty(copy,CP_REGION,_,chr_getProperty(chr,CP_REGION));
	chr_setProperty(copy,CP_SPEECH,_,chr_getProperty(chr,CP_SPEECH));
	for(subprop = DAMAGE_PURE; subprop < MAX_RESISTANCE_INDEX; subprop++)
		chr_setProperty(copy,CP_RESISTS,subprop,chr_getProperty(chr,CP_RESISTS,subprop));
	chr_setProperty(copy,CP_PRIV,_,chr_getProperty(chr,CP_PRIV));
	chr_setProperty(copy,CP_DAMAGETYPE,_,chr_getProperty(chr,CP_DAMAGETYPE));
	chr_setProperty(copy,CP_ATT,_,chr_getProperty(chr,CP_ATT));
	chr_setProperty(copy,CP_DEF,_,chr_getProperty(chr,CP_DEF));
	for(subprop = CP2_EFF; subprop <= CP2_ACT; subprop++)
		chr_setProperty(copy,CP_DEXTERITY,subprop,chr_getProperty(chr,CP_DEXTERITY,subprop));
		chr_setProperty(copy,CP_FAME,_,chr_getProperty(chr,CP_FAME));
	for(subprop = CP2_X; subprop <= CP2_Z; subprop++)
	{
		chr_setProperty(copy,CP_FPOS1_NPCWANDER,subprop,chr_getProperty(chr,CP_FPOS1_NPCWANDER,subprop)); 
		chr_setProperty(copy,CP_FPOS2_NPCWANDER,subprop,chr_getProperty(chr,CP_FPOS2_NPCWANDER,subprop)); 
	}
	chr_setProperty(copy,CP_FTARG,_,chr_getProperty(chr,CP_FTARG));
	chr_setProperty(copy,CP_HIDAMAGE,_,chr_getProperty(chr,CP_HIDAMAGE));
	chr_setProperty(copy,CP_HOLDGOLD,_,chr_getProperty(chr,CP_HOLDGOLD));
	for(subprop = CP2_EFF; subprop <= CP2_ACT; subprop++)
		chr_setProperty(copy,CP_INTELLIGENCE,subprop,chr_getProperty(chr,CP_INTELLIGENCE,subprop));
		chr_setProperty(copy,CP_KARMA,_,chr_getProperty(chr,CP_KARMA));
	chr_setProperty(copy,CP_LODAMAGE,_,chr_getProperty(chr,CP_LODAMAGE));
	chr_setProperty(copy,CP_NPCAI,_,chr_getProperty(chr,CP_NPCAI));
	chr_setProperty(copy,CP_OWNSERIAL,_,chr_getProperty(chr,CP_OWNSERIAL));
	chr_setProperty(copy,CP_POISON,_,chr_getProperty(chr,CP_POISON));
	chr_setProperty(copy,CP_REATTACKAT,_,chr_getProperty(chr,CP_REATTACKAT));
	chr_setProperty(copy,CP_REGENRATE,_,chr_getProperty(chr,CP_REGENRATE));
	chr_setProperty(copy,CP_SPLIT,_,chr_getProperty(chr,CP_SPLIT));
	chr_setProperty(copy,CP_SPLITCHNC,_,chr_getProperty(chr,CP_SPLITCHNC));
	for(subprop = CP2_EFF; subprop <= CP2_ACT; subprop++)
		chr_setProperty(copy,CP_STRENGTH,subprop,chr_getProperty(chr,CP_STRENGTH,subprop));
		chr_setProperty(copy,CP_TAMING,_,chr_getProperty(chr,CP_TAMING));
	chr_setProperty(copy,CP_BASESKILL,_,chr_getProperty(chr,CP_BASESKILL));
	new string[100];
	for(new prop = CP_STR_DISABLEDMSG; prop < CP_STR_TITLE; prop++)
	{
		chr_getProperty(chr,prop,0,string);
		chr_setProperty(copy,prop,0,string);
	}
	//remove all weared items
	new s = set_create();
	set_addItemWeared(s,copy);
	for(set_rewind(s); !set_end(s);)
		itm_remove(set_getItem(s));
	//duplicate original char's weared items and equip them to new char
	set_delete(s);
	s = set_create();
	set_addItemWeared(s,chr);
	new i;
	for(set_rewind(s); !set_end(s);)
	{
		i = itm_duplicate(set_getItem(s));
		chr_equip(copy,i);
	}
	
	set_delete(s);
	return copy;
}
/*!
\author Fax
\fn chr_canReachItem(const chr, const itm);
\param chr: the character
\param itm: the item
\since 0.82
\brief checks if a character can reach an item
The character can reach the item if this is within 1 tile from the character
\return true or false
\todo add Z check?
*/
stock chr_canReachItem(const chr, const itm)
{
	new x,y,z,itmx,itmy,itmz;
	itm_getPosition(itm,itmx,itmy,itmz);
	chr_getPosition(chr,x,y,z);
	//printf("char is %d and at: %d, %d, item is %d and at: %d, %d^n", chr,x,y,itm,itmx,itmy);
	if(-1 <= x - itmx <= 1 && -1 <= y - itmy <= 1)
		return true;
	return false;
}
/*!
\author Fax
\fn chr_getMaxWeight(chr)
\param chr: the character
\since 0.82
\brief returns the maximum weight a character can handle
\return max weight, in tenths of stone
*/
stock chr_getMaxWeight(chr)
{
	return chr_getProperty(chr,CP_STRENGTH,CP2_STR)*35;
}
/*!
\author Fax
\fn chr_canMoveItem(const chr, const itm, const msg)
\param chr: the character
\param itm: the item
\param msg: true to activate messages
\since 0.82
\brief checks if a character can move an item
If msg == true then the character will receive messages in case the check fails,
explaining why he can't move the item.<br>
If the item is too far the function returns -1, if it can't be moved by the character the function returns 0,
if it can be moved the function returns a number > 0.<br>
In case of success the returned value is the ratio between the maximum weight the character can handle
and the item's weight, in tenths (10 = 1, 15 = 1.5, 34 = 3.4 and so on).<br>
See cmd_flip(const chr) for an example of how is this used.<br>
\return -1, 0 or weight ratio
*/
stock chr_canMoveItem(const chr, const itm, const msg)
{
	if(!chr_canReachItem(chr,itm)) 
	{
		chr_message(chr,_,msg_nxwlibDef[3]);
		return -1;
	}
	
	new ratio = (chr_getMaxWeight(chr)*10)/itm_getProperty(itm,IP_WEIGHT)
	if(msg)
		switch(ratio)
		{
			case 0..5: {chr_message(chr,_,msg_nxwlibDef[4]); return 0;}
			case 6..9: {chr_message(chr,_,msg_nxwlibDef[5]); return 0;}
			case 10..14: {chr_message(chr,_,"You moved that"); return ratio;}
			default: {chr_message(chr,_,"You easily moved that"); return ratio;}
		}
	
	return ratio;
}
enum
{
	SIDE_FRONTRIGHT = -3,
	SIDE_RIGHT = -2, 
	SIDE_BACKRIGHT = -1, 
	SIDE_BACK = 0, 
	SIDE_BACKLEFT = 1, 
	SIDE_LEFT = 2, 
	SIDE_FRONTLEFT = 3, 
	SIDE_FRONT = 4 
}//!< values returned by chr_getHitSide()
/*!
\author Keldan
\fn chr_getHitSide (const defender, const attacker)
\param chr: the character
\since 0.82
\brief returns the hit side of a character
The hit side is the defender's side hit by the attacker
The return value is one of the SIDE_* constants
\return SIDE_* constants
*/
stock chr_getHitSide (const defender, const attacker) 
{ 
	new Diff = chr_getProperty(attacker, CP_DIR, 0) - chr_getProperty(defender, CP_DIR, 0); //get dir of defender 
	switch(Diff) 
	{ 
		case -7 : Diff = 1; 
		case -6 : Diff = 2; 
		case -5 : Diff = 3; 
		case -4 : Diff = 4; 
		case 5 : Diff = -3; 
		case 6 : Diff = -2; 
		case 7 : Diff = -1; 
	} 
	return Diff; 
}

enum
{
	MOVE_STANDING = 0,      //the character is not moving 
	MOVE_WALKING = 1,      //the character is walking without mount 
	MOVE_RUNNING = 2,      //the character is running without mount 
	MOVE_MOUNTEDSTANDING = 3, //the character is standing on a mount
	MOVE_TROTING = 4,      //the character is walking with a mount 
	MOVE_GALLOPING = 5   //the character is running with a mount 
}//!< values returned by chr_getMove()
/*!
\author Keldan
\fn chr_getMove(const chr)
\param chr: the character
\since 0.82
\brief gets the moving status of a character
\return MOVE_STANDING, MOVE_WALKING, MOVE_RUNNING,MOVE_HORSESTANDING, MOVE_TROTING, MOVE_GALLOPING
*/
stock chr_getMove(const chr)   
{
	if ( (getCurrentTime() - chr_getProperty(chr, CP_LASTMOVETIME, 0)) < 1000) 
       		return MOVE_WALKING + (chr_getProperty(chr, CP_ONHORSE, 0)*2) + min(chr_getProperty(chr, CP_RUNNING, 0),1); 
   	return MOVE_STANDING; 
}
/*!
\author Horian
\fn chr_getRelation(const chr1, const chr2)
\param chr1 the character looking at someone
\param chr2 the character chr1 looks at
\brief gets the characters relation depending on murderer, criminal, guild alliance, karma etc.
\return the value that defines what relation chr2 towards chr1 has
*/
stock chr_getRelation(const chr1, const chr2)
{
	new guild1 = chr_getProperty(chr1, CP_GUILDNUMBER);
	new guild2 = chr_getProperty(chr2, CP_GUILDNUMBER);
	new flag=0;
	
	if( chr_isMurderer(chr2))
		flag = 1; //red
	else if( chr_isCriminal(chr2))
		flag = 2; //grey
	else if( (guild1>0) && (guild2 > 0)) //both are guild member
	{
		if( ((guild1 != guild2) && (guild_hasAllianceWith( guild1, guild2 ))) || (guild1 == guild2) ) //we are in alliance or same guild -> green
			flag = 8; //green
		else if( (guild1 != guild2) && (guild_hasWarWith( guild1, guild2 )) ) //we are in war -> orange
			flag = 10; //orange
	}
	else flag = chr_getProperty( chr2, CP_FLAG);
	return flag;
}
//===============================================================================//
//                             ITEM HELP FUNCTIONS                               //
//===============================================================================//
/*!
\author Fax
\fn itm_flip(itm)
\param itm:the item
\since 0.82
\brief flips an item
The flip peditem's scriptID is stored in the itm's local var $localvar_flipitem 
(defined in scripts/symbols/items/items.xss).<br>
\return nothing
*/
stock itm_flip(itm)
{
	//check if item can be flipped
	new var = getIntFromDefine("$localvar_flipitem");
	if(!itm_isaLocalVar(itm,var)) return;
	
	//get the flippeditem scriptID and create a new item with the same properties as the previous
	new scriptID = itm_getLocalIntVar(itm,var);
	printf("flip happens now, new item is %d^n", scriptID);
	new flippedItem = itm_create(scriptID);
	itm_copyProperties(itm,flippedItem);
	
	//move flipped item to old item's position
	new x,y,z;
	itm_getPosition(itm,x,y,z);
	itm_moveTo(flippedItem,x,y,z);
	
	//remove old item and set flipped item's serial to old item's serial
	itm_remove(itm);
	//itm_setProperty(flippedItem,IP_SERIAL,_,itm);
}
/*!
\author Fax
\fn itm_copy(const item)
\param item: the item to be copied
\since 0.82
\brief copies an item
This function creates a new item with the same scriptID of the given item, note that
the new item will have properties set to the standard value given in the XSS definition
\see itm_duplicate(const item)
\return copied item's serial
*/
stock itm_copy(const item)
{
	return itm_create(itm_getProperty(item,IP_SCRIPTID));
}
/*!
\author Fax
\fn itm_copyProperties(const item, const copy)
\param item: the item the properties are copied from
\param copy: the item the properties are copied to
\since 0.82
\brief copies an item's properties to another
Use this function to transfer all properties from an item to another.<br>
Not all properties are copied (because not all properties can be copied).<br>
\return nothing
*/
stock itm_copyProperties(const item, const copy)
{
	for(new prop = IP_DOORDIR; prop <= IP_AUXDAMAGETYPE; prop++)
		if(	//These properties must not be copied
			106 <= prop <= 109 ||
			prop == 116 || prop == 119 )
			continue;
		else itm_setProperty(copy,prop,_,itm_getProperty(item,prop));
	for(new prop = IP_ATT; prop <= IP_AMMOFX; prop++)
		if(	//These properties must not be copied
			prop == 210 ||
			prop == IP_POSITION ||
			prop == IP_SERIAL ||
			prop == IP_AMXFLAGS ||
			prop == IP_ANIMID ||
			prop == IP_SCRIPTID ||
			prop == IP_TIME_UNUSED ||
			prop == IP_TIME_UNUSEDLAST)
			continue;
		else itm_setProperty(copy,prop,_,itm_getProperty(item,prop));
	for(new prop = IP_AMOUNT; prop < IP_ID; prop++)
		itm_setProperty(copy,prop,_,itm_getProperty(item,prop));
	new string[100];
	for(new prop = IP_STR_CREATOR; prop < IP_STR_NAME2; prop++)
	{
		itm_getProperty(item,prop,0,string);
		itm_setProperty(copy,prop,0,string);
	}
}
/*!
\author Fax
\fn itm_duplicate(const item)
\param item: the item
\since 0.82
\brief duplicates an item
The returned item will have all the properties set to the starting item's ones
\see itm_copy(const item)
\return new item's serial
*/
stock itm_duplicate(const item)
{
	new copy = itm_copy(item)
	itm_copyProperties(item,copy);
	return copy;
}
//=============================== LOCAL VARS ===================================================//
/*!
\author Horian
\fn chr_LocalVarMaker(const chr, const vartype, const varnum)
\param chr: the char
\param vartype: the vartype, String is 1, integer is 0
\param varnum: the localvar number
\since 0.82
\brief checks if a localvar already exists, throws an error if yes and applys the wanted one
*/
stock chr_LocalVarMaker(const chr, const vartype, const varnum, const Integer=INVALID, const String[]="")
{
	if(chr_isaLocalVar( chr, varnum, VAR_TYPE_ANY ) == 0 ) //0 means no var at globalVar
        {
        	if(vartype == 0)
        		chr_addLocalIntVar( chr, varnum, Integer);
        	else chr_addLocalStrVar( chr, varnum, String);
        }
        else if((chr_isaLocalVar( chr, varnum, VAR_TYPE_STRING ) == 1) && (vartype==0)) //there already is a string variable (shouldn't happen)
        {
        	chr_delLocalVar(chr, varnum, VAR_TYPE_STRING);
        	chr_addLocalIntVar( chr, varnum, Integer );
        	log_error("Char %d got int var %d, but before already had a string var at this place that now was deleted!^n", chr, varnum);
        }
        else if((chr_isaLocalVar( chr, varnum, VAR_TYPE_INTEGER ) == 1) && (vartype==1)) //there already is a integer variable (shouldn't happen)
        {
        	chr_delLocalVar(chr, varnum, VAR_TYPE_INTEGER);
        	chr_addLocalStrVar( chr, varnum, String );
        	log_error("Char %d got string var %d, but before already had an integer var at this place that now was deleted!^n", chr, varnum);
        }
}

/*!
\author Horian
\fn itm_LocalVarMaker(const itm, const vartype, const varnum)
\param itm: the Item
\param vartype: the vartype, String is 1, integer is 0
\param varnum: the localvar number
\since 0.82
\brief checks if a localvar already exists, throws an error if yes and applys the wanted one
*/
stock itm_LocalVarMaker(const itm, const vartype, const varnum, const Integer=INVALID, const String[]="")
{
	if(itm_isaLocalVar( itm, varnum, VAR_TYPE_ANY ) == 0 ) //0 means no var at globalVar
        {
        	if(vartype == 0)
        		itm_addLocalIntVar( itm, varnum, Integer);
        	else itm_addLocalStrVar( itm, varnum, String);
        }
        else if((itm_isaLocalVar( itm, varnum, VAR_TYPE_STRING ) == 1) && (vartype==0)) //there already is a string variable (shouldn't happen)
        {
        	itm_delLocalVar(itm, varnum, VAR_TYPE_STRING);
        	itm_addLocalIntVar( itm, varnum, Integer );
        	log_error("Item %d got int var %d, but before already had a string var at this place that now was deleted!^n", itm, varnum);
        }
        else if((itm_isaLocalVar( itm, varnum, VAR_TYPE_INTEGER ) == 1) && (vartype==1)) //there already is a integer variable (shouldn't happen)
        {
        	itm_delLocalVar(itm, varnum, VAR_TYPE_INTEGER);
        	itm_addLocalStrVar( itm, varnum, String );
        	log_error("Item %d got string var %d, but before already had an integer var at this place that now was deleted!^n", itm, varnum);
        }
}
/*!
\author Fax
\fn chr_setTempIntVar(chr,var,value)
\param chr: the character
\param var: the variable index
\param value: the value to store
\since 0.82
\brief sets a temporary local int var
You don0t need to create the variable, this function already allocates it
\return nothing
*/
stock chr_setTempIntVar(chr,var,value)
{
	chr_delLocalVar(chr,var);
	chr_addLocalIntVar(chr,var,value);
}
/*!
\author Fax
\fn chr_getTempIntVar(chr,var)
\param chr: the character
\param var: the variable index
\since 0.82
\brief gets a temporary local int var
The variable is deleted after reading.
\return nothing
*/
stock chr_getTempIntVar(chr,var)
{
	new v = chr_getLocalIntVar(chr,var);
	chr_delLocalVar(chr,var);
	return v;
}
stock chr_setTempStrVar(chr,var,string[])
{
	chr_delLocalVar(chr,var);
	chr_addLocalStrVar(chr,var,string);
}
stock chr_getTempStrVar(chr,var,string[])
{
	chr_getLocalStrVar(chr,var,string);
	chr_delLocalVar(chr,var);
}
stock chr_setTempIntVec(chr,var,...)
{
	chr_delLocalVar(chr,var);
	new l = numargs() - 2;
	chr_addLocalIntVec(chr,var,l);
	for(new i = 0; i < l; i++)
		chr_setLocalIntVec(chr,var,i,getarg(i + 2));
}
stock chr_getTempIntVec(chr,var,vec[])
{
	new l = chr_sizeofLocalVar(chr,var);
	for(new i = 0; i < l; i++)
		vec[i] = chr_getLocalIntVec(chr,var,i);
}
// ***************************************************************************
	//
	//             NOUVEL ESPOIR v3.0 (UO server powered by Nox)
	//
	// ***************************************************************************
	// This file has been created by the New Hope Script Team, for private use on
	// "Nouvel Espoir" server.
	// It is propriety of the entire "Nouvel Espoir" Skrypt Team, and can't be use
	// without express permission from original author or "Nouvel Espoir" Skrypt Team.
	// This file distributed "as it" and "Nouvel Espoir" Skrypt Team deny all
	// responsability in case of issues and problems they can result by the use
	// of this file.
	// Keep this copyright if you redistribute or edit this file.
	// http://www.nouvelespoir.com
	// ***************************************************************************
	//
	// FILE CREATED :     18/03/2003 20:32
// FILE LAST UPDATED: 18/03/2003 20:32
// AUTHOR=Keldan
	// NOX VERSION LAST USED WITH THIS FILE = 0.82 RC3
	//
	// DESCRIPTION OF THIS FILE : Manage the dynamic vectors
//
/*!
\author Keldan
\fn DVct_Create(const chr, const AmxID)
\param chr: the character
\param var: the variable index
\since 0.82
\brief creates a dynamic vector.
\return 1 if succes, else 0
*/
#if defined _KLD_DYNAMIC_VECTOR_ 
  #endinput 
#endif 
#define _KLD_DYNAMIC_VECTOR_ 
//physical segment size of dynamic vector
const DVCT_GROWTHSIZE = 10;
//symbolic number to mark end of vector. Take care to don't use equal element...
const DVCT_END = 0x7FFFFFFF;
stock DVct_Create(const chr, const AmxID)
{
	if (!chr_isaLocalVar(chr, AmxID))
	{
		chr_addLocalIntVec(chr, AmxID, DVCT_GROWTHSIZE+1, DVCT_END);
		return 1;
	}
	return 0;
}
/*!
\author Keldan
\fn DVct_Delete(const chr, const AmxID)
\param chr: the character
\param var: the variable index
\since 0.82
\brief delete the dynamic vector.
\return 1 if succes, else 0
*/
stock DVct_Delete(const chr, const AmxID)
{
	if (chr_isaLocalVar(chr, AmxID))
	{
		chr_delLocalVar(chr, AmxID);
		return 1;
	}
	return 0;
}
/*!
\author Keldan
\fn DVct_GetSize(const chr, const AmxID)
\param chr: the character
\param var: the variable index
\since 0.82
\brief return the (virtual) size of the dynamic vector
\return return the size or -1 if invalid vector
*/
stock DVct_GetSize(const chr, const AmxID)
{
	if (!chr_isaLocalVar(chr, AmxID))
	return -1;
	new counter;
	new PhySize = chr_sizeofLocalVar(chr, AmxID);
	for (counter = 0; counter < PhySize; counter++)
	{
		if (chr_getLocalIntVec(chr, AmxID, counter) == DVCT_END)
			return counter;
	}
	return -1;
}
/*!
\author Keldan
\fn DVct_SearchElement(const chr, const AmxID, const element)
\param chr: the character
\param var: the variable index
\since 0.82
\brief return position of first occurence of element in vector
\return position of first occurence of element in vector, -1 if no occurence found
*/
stock DVct_SearchElement(const chr, const AmxID, const element)
{
	if (!chr_isaLocalVar(chr, AmxID))
		return -1;
	new PhySize = chr_sizeofLocalVar(chr, AmxID);
	for (new counter = 0; counter < PhySize; counter++)
	{
		if (chr_getLocalIntVec(chr, AmxID, counter) == element)
			return counter;
		else if (chr_getLocalIntVec(chr, AmxID, counter) == DVCT_END)
			return -1;
	}
	return -1;
}
/*!
\author Keldan
\fn DVct_GetElement(const chr, const AmxID, const index)
\param chr: the character
\param var: the variable index
\since 0.82
\brief return the element at the given index
\return return the element at the given index, -1 if no occurence found
*/
stock DVct_GetElement(const chr, const AmxID, const index)
{
	if (!chr_isaLocalVar(chr, AmxID))
		return -1;
	if (index >= chr_sizeofLocalVar(chr, AmxID))
		return -1;
	new element = chr_getLocalIntVec(chr, AmxID, index);
	if (element == DVCT_END)
		return -1;
	return element;
}
/*!
\author Keldan
\fn DVct_AddElement(const chr, const AmxID, const element)
\param chr: the character
\param var: the variable index
\since 0.82
\brief add element at the end of vector
\return -1 if invalid
*/
stock DVct_AddElement(const chr, const AmxID, const element)
{
	if (!chr_isaLocalVar(chr, AmxID))
		return -1;
	new size = DVct_GetSize(chr, AmxID);
	if (size%DVCT_GROWTHSIZE == 0)//if no more free slot, grow physical size
		DVct_Grow(chr, AmxID);
	chr_setLocalIntVec(chr, AmxID, size, element);
	chr_setLocalIntVec(chr, AmxID, size+1, DVCT_END);
	return 1;
}
/*!
\author Keldan
\fn DVct_DelElement(const chr, const AmxID, const element)
\param chr: the character
\param var: the variable index
\since 0.82
\brief remove the fist occurence of element
\return -1 if invalid, 0 if not found, 1 if success
*/
stock DVct_DelElement(const chr, const AmxID, const element)
{
	if (!chr_isaLocalVar(chr, AmxID))
		return -1;
	new ret=-1;
	new mode = 0;//0 => search, 1 => resize
	new PhySize = chr_sizeofLocalVar(chr, AmxID);
	for (new counter = 0; (counter < PhySize) && (ret == -1); counter++)
	{
		if (mode)
		{
			chr_setLocalIntVec(chr, AmxID, counter-1,chr_getLocalIntVec(chr, AmxID, counter));
			if (chr_getLocalIntVec(chr, AmxID, counter-1) == DVCT_END)
				ret = 1;
		}
		else if (chr_getLocalIntVec(chr, AmxID, counter) == element)
			mode = 1;
		else if (chr_getLocalIntVec(chr, AmxID, counter) == DVCT_END)
			ret = 0;
	}
	if (DVct_GetSize(chr, AmxID)%DVCT_GROWTHSIZE == 0)
		DVct_Reduce(chr, AmxID);
	return ret;
}
/*!
\author Keldan
\fn DVct_DelIndex(const chr, const AmxID, const index)
\param chr: the character
\param var: the variable index
\since 0.82
\brief remove the element at the given index
\return -1 if invalid, 1 if success
*/
stock DVct_DelIndex(const chr, const AmxID, const index)
{
	if (!chr_isaLocalVar(chr, AmxID))
		return -1;
	new ret=-1;
	new PhySize = chr_sizeofLocalVar(chr, AmxID);
	if (index >= PhySize)
		return -1;
	for (new counter = index+1; (counter < PhySize) && (ret == -1); counter++)
	{
		chr_setLocalIntVec(chr, AmxID, counter-1, chr_getLocalIntVec(chr, AmxID, counter));
		if (chr_getLocalIntVec(chr, AmxID, counter-1) == DVCT_END)
			ret = 1;
	}
	if (DVct_GetSize(chr, AmxID)%DVCT_GROWTHSIZE == 0)
	DVct_Reduce(chr, AmxID);
	return ret;
}
/*!
\author Keldan
\fn DVct_SetElement(const chr, const AmxID, const index, const element)
\param chr: the character
\param var: the variable index
\since 0.82
\brief set element at given index, changing the old value
\return 1 if successful, -1 if invalid
*/
stock DVct_SetElement(const chr, const AmxID, const index, const element)
{
	if (!chr_isaLocalVar(chr, AmxID))
		return -1;
	if (index >= DVct_GetSize(chr, AmxID))
		return -1;
	chr_setLocalIntVec(chr, AmxID, index, element);
		return 1;
}
/*!
\author Keldan
\fn DVct_Grow(const chr, const AmxID)
\param chr: the character
\param var: the variable index
\since 0.82
\brief made grow the dynamic vector by DVCT_GROWTHSIZE (private use only)
\return -1 if invalid
*/
stock DVct_Grow(const chr, const AmxID)
{
	if (!chr_isaLocalVar(chr, AmxID))
		return -1;
	new PhySize = chr_sizeofLocalVar(chr, AmxID);
	new TmpArray[2048];
	//transfert vector element in temp array
	for (new counter = 0; counter < PhySize; counter++)
		TmpArray[counter] = chr_getLocalIntVec(chr, AmxID, counter);
	chr_delLocalVar(chr, AmxID);
	chr_addLocalIntVec(chr, AmxID, PhySize+DVCT_GROWTHSIZE, DVCT_END);
	for (new counter = 0; counter < PhySize; counter++)
		chr_setLocalIntVec(chr, AmxID, counter, TmpArray[counter]);
	return 1;
}
/*!
\author Keldan
\fn DVct_Reduce(const chr, const AmxID)
\param chr: the character
\param var: the variable index
\since 0.82
\brief reduce the dynamic vector by DVCT_GROWTHSIZE (private use only)
\return -1 if invalid
*/
stock DVct_Reduce(const chr, const AmxID)
{
	if (!chr_isaLocalVar(chr, AmxID))
		return -1;
	new NewSize = chr_sizeofLocalVar(chr, AmxID) - DVCT_GROWTHSIZE;
	new TmpArray[2048];
	//transfert vector element in temp array
	for (new counter = 0; counter < NewSize; counter++)
		TmpArray[counter] = chr_getLocalIntVec(chr, AmxID, counter);
	chr_delLocalVar(chr, AmxID);
	chr_addLocalIntVec(chr, AmxID, NewSize, DVCT_END);
	for (new counter = 0; counter < NewSize; counter++)
		chr_setLocalIntVec(chr, AmxID, counter, TmpArray[counter]);
	return 1;
}

/* Example usage of Dynamic Vector System:
const AMX_VECTOR = 1000;
stock Test_Noob (const chr)
{
	printf("^n################^nCreation^n");
	DVct_Create(chr, AMX_VECTOR);
	printf("size (0) : %d^n", DVct_GetSize(chr, AMX_VECTOR));
	
	DVct_AddElement(chr, AMX_VECTOR, 0);
	DVct_AddElement(chr, AMX_VECTOR, 1);
	DVct_AddElement(chr, AMX_VECTOR, 2);
	DVct_AddElement(chr, AMX_VECTOR, 3);
	DVct_AddElement(chr, AMX_VECTOR, 4);
	DVct_AddElement(chr, AMX_VECTOR, 5);
	DVct_AddElement(chr, AMX_VECTOR, 6);
	DVct_AddElement(chr, AMX_VECTOR, 7);
	DVct_AddElement(chr, AMX_VECTOR, 8);
	printf("first show^n");
	DisplayVector(chr);
	
	DVct_AddElement(chr, AMX_VECTOR, 9);
	DVct_AddElement(chr, AMX_VECTOR, 10);
	DVct_AddElement(chr, AMX_VECTOR, 11);
	DVct_AddElement(chr, AMX_VECTOR, 12);
	printf("second show^n");
	DisplayVector(chr);
	
	DVct_DelElement(chr, AMX_VECTOR, 2);
	DVct_DelElement(chr, AMX_VECTOR, 4);
	DVct_DelElement(chr, AMX_VECTOR, 6);
	DVct_DelElement(chr, AMX_VECTOR, 8);
	printf("third show^n");
	DisplayVector(chr);
	
	DVct_DelIndex(chr, AMX_VECTOR, 0);
	DVct_DelIndex(chr, AMX_VECTOR, 0);
	DVct_DelIndex(chr, AMX_VECTOR, 0);
	DVct_DelIndex(chr, AMX_VECTOR, 0);
	printf("fourth show^n");
	DisplayVector(chr);
	
	DVct_SetElement(chr, AMX_VECTOR, 0, 20)
	DVct_SetElement(chr, AMX_VECTOR, 1, 30)
	DVct_SetElement(chr, AMX_VECTOR, 2, 40)
	DVct_SetElement(chr, AMX_VECTOR, 3, 50)
	printf("fifst show^n");
	DisplayVector(chr);
	
	printf("^nDestruction^n################^n");
	DVct_Delete(chr, AMX_VECTOR);
}
	
stock DisplayVector(const chr)
{
	printf("size : %d^n", DVct_GetSize(chr, AMX_VECTOR));
	
	printf("Element #0 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 0));
	printf("Element #1 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 1));
	printf("Element #2 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 2));
	printf("Element #3 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 3));
	printf("Element #4 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 4));
	printf("Element #5 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 5));
	printf("Element #6 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 6));
	printf("Element #7 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 7));
	printf("Element #8 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 8));
	printf("Element #9 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 9));
	printf("Element #10 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 10));
	printf("Element #11 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 11));
	printf("Element #12 : %d^n", DVct_GetElement(chr, AMX_VECTOR, 12));
	
	printf("pos of 0 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 0));
	printf("pos of 1 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 1));
	printf("pos of 2 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 2));
	printf("pos of 3 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 3));
	printf("pos of 4 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 4));
	printf("pos of 5 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 5));
	printf("pos of 6 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 6));
	printf("pos of 7 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 7));
	printf("pos of 8 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 8));
	printf("pos of 9 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 9));
	printf("pos of 10 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 10));
	printf("pos of 11 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 11));
	printf("pos of 12 : %d^n", DVct_SearchElement(chr, AMX_VECTOR, 12));
}
*/



/** @} */