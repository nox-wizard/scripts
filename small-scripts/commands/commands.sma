#include "small-scripts/commands/area.sma"
#include "small-scripts/commands/add/add.sma"
#include "small-scripts/commands/align.sma"
#include "small-scripts/commands/dupe.sma"
#include "small-scripts/commands/damage.sma"
#include "small-scripts/commands/decay.sma"
#include "small-scripts/commands/dye.sma"
#include "small-scripts/commands/freeze.sma"
#include "small-scripts/commands/func.sma"
#include "small-scripts/commands/go/go.sma"
#include "small-scripts/commands/hiding.sma"
#include "small-scripts/commands/help/help.sma"
#include "small-scripts/commands/invul.sma"
#include "small-scripts/commands/kill.sma"
#include "small-scripts/commands/make.sma"
#include "small-scripts/commands/move.sma"
#include "small-scripts/commands/lightlevel.sma"
#include "small-scripts/commands/options/options.sma"
#include "small-scripts/commands/playerlist.sma"
#include "small-scripts/commands/regioncp.sma"
#include "small-scripts/commands/resurrect.sma"
#include "small-scripts/commands/setdir.sma"
#include "small-scripts/commands/setmorexyz.sma"
#include "small-scripts/commands/setpriv.sma"
#include "small-scripts/commands/settype.sma"
#include "small-scripts/commands/skills/skills.sma"
#include "small-scripts/commands/stats/stats.sma"
#include "small-scripts/commands/tile.sma"
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

	//build command function name as: cmd_commandname or read the function to call if it has been specified
	new function[20];
	if(strlen(__commands[cmd][__cmdFunc]))
		strcpy(function,__commands[cmd][__cmdFunc]);
	else sprintf(function,"cmd_%s",command);
	
	#if _CMD_DEBUG_
		new name[50];
		chr_getProperty(chr,CP_STR_NAME,0,name);
		log_message("DEBUG: %s is using command: %s",name,command);
		log_message("^t->calling function: %s",function);
	#endif


	//call command function
	callFunction1P(funcidx(function),chr);
#endif
}

public readCommandParams(const chr)
{
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
			log_message("^t->param %d: %s",param,__cmdParams[param]);
		#endif
		
		param++;
	}
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
	
	log_message("Command '%s (priv:%d func:%s) succesfully added",__commands[i][__cmdName],__commands[i][__cmdPriv],__commands[i][__cmdFunc]);
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
		log_warning("Unable to delete '%s command. Invalid command",name);
		return CMD_ERROR;
	}
	
	strcpy(__commands[cmd][__cmdName],"");
	__commands[cmd][__cmdPriv] = PRIV_ADMIN;
	strcpy(__commands[cmd][__cmdFunc],"");
	
	log_message("Command '%s succesfully deleted",name);
	return CMD_OK
}
//#endif

/*!
\author Fax
\fn initCommandSystem()
\since 0.82
\brief initializes command system

Prints a message saying wich system is active.<br>
Executes any needed startup function for the command system, put a function call here if some of
your commands needs setup functions.
Loads needed XSS data.<br>
\return nothing
*/
public initCommandSystem()
{
	//Command system type message
	#if _CMD_DEBUG_
		#if _USE_SOURCE_CMDSYS_
			log_message("^nSOURCE command system selected^n^n");
		#else
			log_message("^nSMALL command system selected^n^n");
		#endif
	#endif
		
	//command system test
	#if _CMD_DEBUG_
		commandSystemTest();
	#endif
	
	//Commands list, you can switch this off setting _CMD_SHOWLIST_ to 0
	#if _CMD_SHOWLIST_
		showCommandsList();
	#endif
	
	//setup 'area command
	resetCmdAreas(); //DO NOT REMOVE!! this initializes data for command areas
	
	//setup 'go command
	//loadLocations();
	
	//setup 'help command
	loadHelpTopics();
}
	
/*!
\author Fax
\fn startCommandSystem(const chr)
\param chr: the character
\since 0.82
\brief starts the scripted command system for the given character

This funciton checks if the scripted command system's localVars are already set, and sets them if needed.<br>
Usually this function will be completely executed only at the first character login.
\return nothing
*/
public startCommandSystem(const chr)
{
	printf("^n");
	if(!chr_isaLocalVar(chr,CLV_PRIVLEVEL))
	{
		log_message("Creating privlevel (CLV_PRIVLEVEL) for character %d ... ",chr);
		
		//enter as a player
		chr_addLocalIntVar(chr,CLV_PRIVLEVEL,PRIV_PLAYER);
		
		if(chr_getLocalVarErr() != VAR_ERROR_NONE)
		{
			log_error("Unable to create local int var CLV_PRIVLEVEL - error: %d",chr_getLocalVarErr());
			return;
		}
		
		//set PRIV_ADMIN to the admins		
		if(chr_getProperty(chr, CP_ACCOUNT)== 0)
		{
			chr_setLocalIntVar(chr,CLV_PRIVLEVEL,PRIV_ADMIN);
			
			if(chr_getLocalVarErr() != VAR_ERROR_NONE)
			{
				log_error("Unable to set local int var CLV_PRIVLEVEL - error: %d",chr_getLocalVarErr());
				return;
			}
			
			chr_message(chr,_,"You have been set admin");
			chr_makeGM(chr);
			chr_makeInvul(chr);
			new name[20];
			chr_getProperty(chr,CP_STR_NAME,0,name);
			log_message("%s has been set admin",name);
		}
	}
	
	if(!chr_isaLocalVar(chr,CLV_CMDTEMP))
	{
		log_warning("Creating command temp var (CLV_CMDTEMP) for character %d ... ",chr);
		
		chr_addLocalIntVar(chr,CLV_CMDTEMP,INVALID);
		
		if(chr_getLocalVarErr() != VAR_ERROR_NONE)
		{
			log_error("Unable to create CLV_CMDTEMP- error: %d",chr_getLocalVarErr());
			return;
		}
	}
	
	log_message("Scripted command system check succesful");
	printf("^n");
}

/*!
\author Fax
\fn commandSystemTest()
\param chr: the character
\since 0.82
\brief tests command system functions

This funciton tries to create and delete all possible commands and prints the result on the console
\return nothing
*/
public commandSystemTest()
{
	printf("^n");
	log_message("DEBUG: Testing command system");
	log_message("^tYou should see some commands added and an error message at the end");
	printf("^n");
	new result = CMD_OK;
	new name[15];
	for(new i = 0; i <  __CMD_COUNT && result == CMD_OK; i++)
	{
		sprintf(name,"testCmd%d",i);
		result = addCommand(name,5,"");
	}
	
	
	
	log_message("^tNow you should see some commands removed and an error message at the end");
	log_message("^tDeleted commands must be the same that were added before");
	printf("^n");
	result = CMD_OK;
	for(new i = 0; i < __CMD_COUNT && result == CMD_OK; i++)
	{
		sprintf(name,"testCmd%d",i);
		result = deleteCommand(name);
	}
	
	log_message("^tEnd of command system test");
	printf("^n");
}

/*!
\author Fax
\fn showCommandsList()
\param chr: the character
\since 0.82
\brief shows a list of available commands
\return nothing
*/
public showCommandsList()
{
	printf("^n");
	log_message("Available commands:")
	for(new i = 0; i < __CMD_COUNT ; i++)
	if(strlen(__commands[i][__cmdName]))
		log_message("^t%d - '%s (priv:%d)",i,__commands[i][__cmdName],__commands[i][__cmdPriv]);
	printf("^n");
}
/*! @} */ //end of scripts_commands_system