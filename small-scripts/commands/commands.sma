#include "small-scripts/commands/area.sma"

#include "small-scripts/commands/add.sma"
#include "small-scripts/commands/dupe.sma"
#include "small-scripts/commands/freeze.sma"
#include "small-scripts/commands/func.sma"
#include "small-scripts/commands/hiding.sma"
#include "small-scripts/commands/invul.sma"
#include "small-scripts/commands/kill.sma"
#include "small-scripts/commands/make.sma"
#include "small-scripts/commands/move.sma"
#include "small-scripts/commands/options/options.sma"
#include "small-scripts/commands/playerlist.sma"
#include "small-scripts/commands/skills/skills.sma"
#include "small-scripts/commands/stats/stats.sma"
#include "small-scripts/commands/tweak/tweak.sma"
#include "small-scripts/commands/where.sma"
#include "small-scripts/commands/wipe.sma"
#include "small-scripts/commands/polymorph.sma"

/** \defgroup script_commands_system system functions
 *  \ingroup script_commands
 *  @{
 */

/*!
\author Fax
\since 0.82
\fn detectCommand(const chr)
\param chr: the character who used the command
\brief: handles speech override for command management

This function is called every time a player says the command control character (default is ')
and handles command function calling.<br>
You don't need to modify this functions as all settings can be done in small-scripts/commands/constants.sma
*/

public detectCommand(const chr)
{
	
//bypass only if Small command system is active
#if !_USE_SOURCE_CMDSYS_
	bypass();
#endif

	new speech[150];	 
	new command[30]; 
	
	chr_getProperty(chr, CP_STR_SPEECH, 0, speech);
			 	
	speech[0]=' ';	//delete ' 							
	ltrim(speech); 							
	
	//read command
	str2Token(speech, command, 0,speech,0);
	trim(speech);
	 
	trim(command);
	str2lower(command);

#if _CMD_DEBUG_
	new name[50];
	chr_getProperty(chr,CP_STR_NAME,0,name);
	printf("^nDEBUG: %s using command: %s^n",name,command);
#endif

//Small command system is bypassed if source command system is selected
#if !_USE_SOURCE_CMDSYS_

	//search command in __commands[][]
	new cmd = 0;	
	for(;strcmp(command,__commands[cmd][__cmdName]) && cmd < __CMD_COUNT; cmd++)
	{}
 
 	//if the command has not been found, return
	if(cmd == __CMD_COUNT)
	{ 
		#if _CMD_SHOW_MSG
			chr_message(chr,_,"That command does not exist!");
		#endif
		
		return; 
	}
	
	//privlevel check
	if(chr_getLocalIntVar(chr,CLV_PRIVLEVEL) < __commands[cmd][__cmdPriv])
	{
		
		#if _CMD_SHOW_MSG
			chr_message(chr,_,"You are not authorized to use that command");
		#endif
		
		return;
	}	 
#endif

	//read parameters and store them in __params[][]
	new param = 0;
	for(new i = 0; i < __MAX_PARAMS; i++)
		__cmdParams[i] = "";
	
	while(param < __MAX_PARAMS && strlen(speech))
	{
		str2Token(speech,__cmdParams[param],0,speech,0);
		str2lower(__cmdParams[param]);
		trim(__cmdParams[param]);
		trim(speech);
		
		
		#if _CMD_DEBUG_
			printf("^t->param %d: %s^n",param,__cmdParams[param]);
		#endif
		
		param++;
	}
	
//Small command system is bypassed if source command system is selected
#if !_USE_SOURCE_CMDSYS_

	//build command function name as: cmd_commandname or read the function to call if it has been specified
	new function[20];
	if(strlen(__commands[cmd][__cmdFunc]))
		strcpy(function,__commands[cmd][__cmdFunc]);
	else sprintf(function,"cmd_%s",command);
	
	#if _CMD_DEBUG_
		printf("^t->calling function: %s^n",function);
	#endif


	//call command function
	callFunction1P(funcidx(function),chr);
#endif
}


/*!
\author Fax
\since 0.82
\fn addCommand(name[],priv,func[])
\param name[]: the command name
\param priv: the command privlevel
\param func[]: the function to be called, pass "" if you want a standard cmd_commandname function to be called
\brief Adds a new command

This is an helper function that can be called by scripts to add commands at runtime.<br>
Usually you can  use this function like this:
\code
addCommand("mycommand",mypriv,"");
\endcode
and cmd_mycommand will be called on command use.

\note: this function is a native function if the source coded command system is selected, else this is a normal public function
*/
/*#if _USE_SOURCE_CMDSYS_
	native addCommand(name[],priv,func[]);
#else*/
public addCommand(name[],priv, func[])
{
	if(!strlen(name))
	{
		log_warning("addCommand called with empty command name");
		return CMD_ERROR;
	}
	
	//seek an empty cell
	new i = 0;
	for(i = 0; i < __CMD_COUNT && strlen(__commands[i][__cmdName]); i++)
	{ }
	
	if(i == __CMD_COUNT)
	{
		log_warning("__commands[][] array is full! increase its size in order to add more commands");
		return CMD_ERROR;
	}
	
	strcpy(__commands[i][__cmdName],name);
	__commands[i][__cmdPriv] = priv;
	
	if(strlen(func))
		strcpy(__commands[i][__cmdFunc],func);
	else sprintf(__commands[i][__cmdFunc],"cmd_%s",name);
	
	printf("Command '%s (priv:%d func:%s) succesfully added^n",__commands[i][__cmdName],__commands[i][__cmdPriv],__commands[i][__cmdFunc]);
	return CMD_OK;
}
//#endif

/*!
\author Fax
\since 0.82
\fn deleteCommand(name[])
\param name[]: the command name
\brief Deletes a command

This is an helper function that can be called by scripts to delete commands at runtime. 
\note: this function is a native function if the source coded command system is selected, else this is a normal public function
*/
/*#if _USE_SOURCE_CMDSYS_
	native deleteCommand(name[]);
#else*/
public deleteCommand(name[])
{
	//seek command
	new cmd = 0;	
	for(;strcmp(name,__commands[cmd][__cmdName]) && cmd < __CMD_COUNT; cmd++)
	{}
	
	if(cmd == __CMD_COUNT)
	{
		log_warning("Unable to delete '%s command. Invalid command^n",name);
		return CMD_ERROR;
	}
	
	strcpy(__commands[cmd][__cmdName],"");
	__commands[cmd][__cmdPriv] = PRIV_ADMIN;
	strcpy(__commands[cmd][__cmdFunc],"");
	
	printf("Command '%s succesfully deleted^n",name);
	return CMD_OK
}
//#endif


/*! @} */ //end of scripts_commands_system