
static filename[] = "small-scripts/commands/go/locations.xss";
enum locationStruct
{
	__locX,
	__locY,
	__locZ,
	__locName: 50
}      

#define MAX_LOCATIONS 200
new NUM_LOCATIONS
new __locations[MAX_LOCATIONS][locationStruct];

/*!
\defgroup script_commands_go 'go
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_go(const chr)
\brief moves objects

<B>syntax:<B> 'go [x y z / x y / n / "name" / s serial]

<B>command params:</B>
<UL>
<LI> me: if command is called as 'move me, the character is teleported in a targetted location
When using this option no other parameters are needed.<br>
<LI> x,y,z: where you want to be moved
<LI> n: charcater you want to be moved to, n is the login order number (5 is the 5th charcater logged in)
<LI> "name": the name of the character you want to bemoved to
<LI> s serial: this means s 1,s 2,s 345 ... s followed by the serial of the character you want to be moved to
</UL>

*/
#include "small-scripts/commands/go/locationsMenu.sma"

public cmd_go(const chr)
{
	readCommandParams(chr);

	new x,y,z;
	if(!strlen(__cmdParams[0]))
	{
		locationsMenu(chr,chr);
		return;
	}

	if(isStrInt(__cmdParams[0]))
		if(isStrInt(__cmdParams[1]))
			if(isStrInt(__cmdParams[2]))
			{	//'go x y z
				x = str2Int(__cmdParams[0]);
				y = str2Int(__cmdParams[1]);
				z = str2Int(__cmdParams[2]);
			}
			else //'go x y
			{
				x = str2Int(__cmdParams[0]);
				y = str2Int(__cmdParams[1]);
				z = map_getZ(x,y);
			}
		else
		{
			//'go n
			new chr2;
			new n = str2Int(__cmdParams[0]);
	
			//seek in the online players list the nth player connected
			new c,s = set_create();
			set_addAllOnlinePl(s);
			set_rewind(s);
			for(c = 0;  !set_end(s) && c < n; c++)
				chr2 = set_getChar(s);
	
	
			if(set_end(s) && c >= n)
			{
				chr_message(chr,_,msg_commandsDef[2]);
				return;
			}
	
			chr_getPosition(chr2,x,y,z);
		}
	else if(!strcmp(__cmdParams[0],"s"))
		{//'go s serial
			if(!isStrInt(__cmdParams[1]))
			{
				chr_message(chr,_,msg_commandsDef[3]);
				return;
			}
	
			new chr2 = str2Int(__cmdParams[1]);
	
			if(!isChar(chr2))
			{
				chr_message(chr,_,msg_commandsDef[4]);
				return;
			}
	
			chr_getPosition(chr2,x,y,z);
		}
		else if(!strcmp(__cmdParams[0],"d"))
			{	
				if(!isStrInt(__cmdParams[1]))
					return;
				new l = str2Int(__cmdParams[1]);
				
				if(l < 0 || l >= NUM_LOCATIONS)
					return;
					
				__locations[l][__locX] = -1;
				chr_message(chr,_,msg_commandsDef[269],l);
				
				cmd_go_writeFile();
				NUM_LOCATIONS = 0;
				xss_scanFile(filename,"cmd_go_scan");
				return;
		
			}
			else if(!strcmp(__cmdParams[0],"m"))
				{
					if(NUM_LOCATIONS == MAX_LOCATIONS)
					{
						chr_message(chr,_,msg_commandsDef[267],MAX_LOCATIONS);
						return;
					}
					
					new temp[5],speech[100];
					chr_getSpeech(chr,speech);
					
					str2Token(speech,temp,0,speech,0);
					trim(speech);
					
					chr_getPosition(chr,x,y,z);
					
					__locations[NUM_LOCATIONS][__locX] = x;
					__locations[NUM_LOCATIONS][__locY] = y;
					__locations[NUM_LOCATIONS][__locZ] = y;
					strcpy(__locations[NUM_LOCATIONS][__locName],speech);
					
					chr_message(chr,_,msg_commandsDef[268],NUM_LOCATIONS,x,y,z,speech);
					
					NUM_LOCATIONS++;
					
					cmd_go_writeFile();
					return;
				}
				else
				{//'go "name"
		
					new name[50];
					chr_getSpeech(chr,name)
					new chr2 = getOnlineCharFromName(name);
			
					if(!isChar(chr2))
					{
						chr_message(chr,_,msg_commandsDef[5],name);
						return;
					}
			
					chr_getPosition(chr2,x,y,z);
				}

		//move char to the target
		if(x < 0 || y < 0)
		{
			chr_message(chr,_,msg_commandsDef[6]);
			return;
		}
	
		new x1 = x, y1 = y, z1 = z; //No,I'm not stupid... this is to prevent a bug in the API
		chr_moveTo(chr,x1,y1,z1);
}

//==============  EXPERIMENTAL XSS LOADING FUNCTIONS ==============
/*!
\author Fax
\fn
\param chr: the character
\since 0.82
\brief
\return nothing
*/

public loadGoLocations()
{
	NUM_LOCATIONS = 0;
	log_message("Loading locations for 'go command ...");
	if(xss_scanFile(filename,"cmd_go_scan")==INVALID)
	{
		log_error("Unable toread from %s",filename);
		return;
	}
	
	log_message("%d locations loaded^n",NUM_LOCATIONS);
	
}

public cmd_go_scan(file,line)
{
	if(strcmp(currentXssSectionType,"LOCATION"))
	{
		skipXssSection = true;
		return;
	}
	
	if(currentXssSection >= MAX_LOCATIONS)
	{
		log_warning("%s(%d): there are only %d available locations",filename,line,MAX_LOCATIONS);
		skipXssSection = true;
		return;
	}
	
	new loc = currentXssSection;
	
	if(!strcmp(currentXssCommand,"NAME"))
	{
		strcpy(__locations[loc][__locName],currentXssValue)
		NUM_LOCATIONS++;
		return;
	}
	
	if(!strcmp(currentXssCommand,"X"))
	{
		if(!isStrInt(currentXssValue))
		{
			log_error("%s(%d): must be an integer",filename,line);
			skipXssSection = true;
			return;
		}
		
		__locations[loc][__locX] = str2Int(currentXssValue);
		return;
	}
	
	if(!strcmp(currentXssCommand,"Y"))
	{
		if(!isStrInt(currentXssValue))
		{
			log_error("%s(%d): must be an integer",filename,line);
			skipXssSection = true;
			return;
		}
		
		__locations[loc][__locY] = str2Int(currentXssValue);
		return;
	}
	
	if(!strcmp(currentXssCommand,"Z"))
	{
		if(!isStrInt(currentXssValue))
		{
			log_error("%s(%d): must be an integer",filename,line);
			skipXssSection = true;
			return;
		}
		
		__locations[loc][__locZ] = str2Int(currentXssValue);
		return;
	}
	
	log_warning("%s(%d): Unrecognized command '%s'",filename,line,currentXssCommand);
}

static cmd_go_writeFile()
{
	new f = file_open(filename,"w+");
	
	if(f == INVALID)
	{
		log_error("Unable to write %s",filename);
		return;
	}
	
	new buffer[100]
	new d;
	for(new l = 0; l < NUM_LOCATIONS; l++)
	{
		if(__locations[l][__locX] == -1)
		{
			d++;
			continue;
		}
		
		sprintf(buffer,"SECTION LOCATION %d^n{^n",l - d)
		file_write(f,buffer);
		
		sprintf(buffer,"^tNAME %s^n",__locations[l - d][__locName])
		file_write(f,buffer);
		
		sprintf(buffer,"^tX %d^n",__locations[l - d][__locX])
		file_write(f,buffer);
		
		sprintf(buffer,"^tY %d^n",__locations[l - d][__locY])
		file_write(f,buffer);
		
		sprintf(buffer,"^tZ %d^n",__locations[l - d][__locZ])
		file_write(f,buffer);
		
		file_write(f,"}^n^n");
	}
	
	file_write(f,"//EOF: leave this line at the end of the file");
	file_close(f);
}
/*! }@ */