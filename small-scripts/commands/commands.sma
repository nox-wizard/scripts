#include "small-scripts/commands/area.sma"

#include "small-scripts/commands/add.sma"
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

/*!
\defgroup script_commands commands
This group of scripts contains all the ingame commands scripts.<br>
The commandlevel management is done internally, in the sources, but you can 
define, modify all the commands you want by editing the existing scripts.<br>

\section commandsplayerinterface Player interface
Players can use ingame commands, that is, they can send commands to the server to make various things.
Not all commands are available to all players, every command needs a certain authorization to be used, this authorization
is the "command level" or "privlevel".<br>
The privlevel is a number, this number defines if a command is usable by a player or not.<br>
To use a command the player has to write:<br>
'[commandname] <br>
for example:<br>
'wipe 'kill 'invul <br>
are all commands.<br>
<br>
Usually a command takes some parameters wich specify how the command should work:<br>
'invul on<br>
'kill target<br>
are examples.

\section usingcommands Using commands
Using commands is easy, simpy type the command (with his parameters) and the follow the instructions that
appear as messages in the bottom left corner of the screen.<br>
Usually a command requires to target a character or item, in that case the target pointer will appear
with a prompt saying what you should target.
When a command requires parameters, there always some default values for the most used values.<br>
When a parameter has a default value tou can ommit it in the command call, and the default will be assumed.<br>
If you want to specify a parameter, you have to specify all the preceding parameters, or you will get errors.<br>
In the commands documentation, it is always written the dafault value for every parameter.

\section commandareas Command areas
A player who can use the 'area command, can set "command area".<br>
This is needed sometimes when you have to aplly a command to a large number of items/characters
and it would be boring to write the command many times.<br>
See the \ref script_command_area for more details.

\section customizability Customizability
You can define all commands you want, modify the privlevels, modify/erase existing commands, in other words,
you can do everything you want with commands!<br>
You can add a command by adding its name in __commands[][] array (in small-scripts/commands/constants.sma) and then you
have to write a public function with the following proptotype:

\code
	public cmd_commandname(const chr)
\endcode

The function name MUST be cmd_ + "command name" or your command won't be recognized and you won't have
any warning of that. SO for example if you want to add a 'killme command you must enter "killme" in __commands[][]
(the place is not important, but leaving blank spaces in the array affects performance) and the declare:

\code
	public cmd_killme(cons chr)
\endcode

in one of your included files.
Once you set the command nme and fucntion you can edit the privlevel simply by modifying the value in __commands[][] (see default
commands for example).

Tip: If you don't want to directly modify the file commands.sma (because you would have to update it every
time you download new scripts), remeber that you can modify it at
runtime, as it is not declared as const. So you can modify commands with a script.
The helper function addCommand(name[],priv) is intended for this purpose. 
*/

/*
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

/*
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

/*
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
