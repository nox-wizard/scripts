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
/*
public loadLocations()
{
	log_message("Loading locations.xss for 'go command ...");

	xss_parseFile(__locationsFile,"LOCATION","loadXssEntry");

	new error,i = 0, section = 0,name[50];
	while(i < NUM_LOCATIONS)
	{
		section++;

		__locations[i][__locX] = xss_getProperty(__locationsFile,"LOCATION",section,"X");
		error = xss_getError(); 
		if(error == XSS_OK)
		{
			strcpy(__locations[i][__locName],name);
			xss_getStrProperty(__locationsFile,"LOCATION",section,"//",__locations[i][__locName]);
			__locations[i][__locY] = xss_getProperty(__locationsFile,"LOCATION",section,"Y");
			__locations[i][__locZ] = xss_getProperty(__locationsFile,"LOCATION",section,"Z");
	
			i++;
		}
		else
		{ 
			xss_getErrorMsg();
			if(error != XSS_SECTION_NOT_FOUND) return;
		}
	}

	log_message("%d locations loaded",i);
	printf("^n");
}

public loadXssEntry(scriptID,value)
{
	static idx,lastScriptID;

	new prop[20];
	xss_getCurrentProp(prop[]);
}
*/
/*! }@ */