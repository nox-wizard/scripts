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
	new x,y,z;
	if(!strlen(__cmdParams[0]))
	{
		locationsMenu(chr);
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
			new s = set_create();
			set_addAllOnlinePl(s);
			set_rewind(s);
			for(new c;  !set_end(s) && c < n; c++)
				chr2 = set_getChar(s);
							
			chr_getPosition(chr2,x,y,z);
		}
	else if(!strcmp(__cmdParams[0],"s"))
		{//'go s serial
			if(!isStrInt(__cmdParams[1]))
			{
				chr_message(chr,_,"you must specify a character serial");
				return;
			}
			
			new chr2 = str2Int(__cmdParams[1]);
			
			if(!isChar(chr2))
			{
				chr_message(chr,_,"you must specify a valid character serial");
				return;
			}
			
			chr_getPosition(chr2,x,y,z);
		}
		else
		{//'go "name"
			
			//handle multi word names (john smith the cool guy)
			for(new i = 1; i < __MAX_PARAMS; i++)
				if(strlen(__cmdParams[i]))
					sprintf(__cmdParams[0],"%s %s",__cmdParams[0],__cmdParams[i]);
			
			new chr2, name[50];
			new s = set_create();
			set_addAllOnlinePl(s);
			for(set_rewind(s); !set_end(s); )
			{
				chr2 = set_getChar(s);
				chr_getProperty(chr2,CP_STR_NAME,0,name);
				if(!strcmp(__cmdParams[0],name)) break;
			}
			
			chr_getPosition(chr2,x,y,z);
		}
		
		//move char to the target
		if(x < 0 || y < 0)
		{
			chr_message(chr,_,"Invalid map location");
			return;
		}
		
		chr_moveTo(chr,x,y,z);	
}

/*! }@ */