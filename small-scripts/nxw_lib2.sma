#if defined _nxw_lib2_included_
	#endinput
#endif
#define _nxw_lib2_included_

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


//=========================================================================================//
//                                 SET HELP FUNCTIONS                                      //
//=========================================================================================//

/*!
\author Fax
\fn set_remove(const set,const value)
\param set: the set
\param value: the value to be removed
\since 0.82
\brief removes a value from a set

Removes a value from a set, if the value is found more than once, all occurrencies will be removed.
\return nothing
*/
stock set_remove(const set,const value)
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
public process_line(file,line)
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
public file_scan(filename[], callback[], exclude[])
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
public file_getScanLine(line[FILE_SCAN_BUFFER_SIZE])
{
	strcpy(line,__fileScanBuffer);
}

new currentXssSectionType[FILE_SCAN_BUFFER_SIZE];
new currentXssSection;
new currentXssCommand[FILE_SCAN_BUFFER_SIZE];
new currentXssValue[FILE_SCAN_BUFFER_SIZE];

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
public xss_scanFile(filename[],callback[])
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
		for(file_read(file,__fileScanBuffer); !file_eof(file); file_read(file,__fileScanBuffer))
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
	
	return section;
}

//=========================================================================================//
//                              CHARACTER HELP FUNCTIONS                                   //
//=========================================================================================//
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