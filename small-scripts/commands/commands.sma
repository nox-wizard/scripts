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
	bypass();
	if (!isChar(chr)) return; 

	new speech[150];	 
	new command[30]; 
	
	chr_getProperty(chr, CP_STR_SPEECH, 0, speech);
			 	
	speech[0]=' ';	//delete ' 							
	ltrim(speech); 							

	//read command
	str2Token(speech, command, 0,speech,0);
	trim(command);
	trim(speech);
	str2lower(command); 
	
	#if _CMD_DEBUG_
		new name[50];
		chr_getProperty(chr,CP_STR_NAME,0,name);
		printf("^nDEBUG: %s using command: %s^n",name,command);
	#endif
	
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
			chr_message(chr,_,"You are nt authorized to use that command");
		#endif
		
		return;
	}	 
	
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
	
	//build command function name as: cmd_commandname
	new function[20];
	sprintf(function,"cmd_%s",command);
	
	#if _CMD_DEBUG_
		printf("^t->calling function: %s^n",function);
	#endif
	
	//call command function
	callFunction1P(funcidx(function),chr);
}

/*!
\author Fax
\since 0.82
\fn addCommand(name[],priv)
\param name[]: the command name
\param priv: the command privlevel
\brief Adds a new command

This is an helper function that can be called by scripts to add commands at runtime. 
*/
public addCommand(name[],priv)
{
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
	
	printf("Command '%s (priv:%d) succesfully added^n",__commands[i][__cmdName],__commands[i][__cmdPriv]);
	return CMD_OK;
}

/*!
\author Fax
\since 0.82
\fn deleteCommand(name[])
\param name[]: the command name
\brief Deletes a command

This is an helper function that can be called by scripts to delete commands at runtime. 
*/
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
	
	printf("Command '%s succesfully deleted^n",name);
	return CMD_OK
}

/*! @} */ //end of scripts_commands_system