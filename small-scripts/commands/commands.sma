#include "small-scripts/nxw_lib2.sma"
#include "small-scripts/commands/constant.sma"

//here are all command scripts (Horian: test cvs)
#include "small-scripts/commands/area.sma"
#include "small-scripts/commands/action.sma"
#include "small-scripts/commands/accountscp.sma"
#include "small-scripts/commands/add/add.sma"
#include "small-scripts/commands/align.sma"
#include "small-scripts/commands/buy.sma"
#include "small-scripts/commands/cset.sma"
#include "small-scripts/commands/csetxyz.sma"
#include "small-scripts/commands/dupe.sma"
#include "small-scripts/commands/damage.sma"
#include "small-scripts/commands/decay.sma"
#include "small-scripts/commands/dye.sma"
#include "small-scripts/commands/flip.sma"
#include "small-scripts/commands/freeze.sma"
#include "small-scripts/commands/fullstats.sma"
#include "small-scripts/commands/func.sma"
#include "small-scripts/commands/gcollect.sma"
#include "small-scripts/commands/gmopen.sma"
#include "small-scripts/commands/go/go.sma"
#include "small-scripts/commands/gy.sma"
#include "small-scripts/commands/heal.sma"
#include "small-scripts/commands/hiding.sma"
#include "small-scripts/commands/hunger.sma"
#include "small-scripts/commands/help/help.sma"
#include "small-scripts/commands/imore.sma"
#include "small-scripts/commands/invul.sma"
#include "small-scripts/commands/iset.sma"
#include "small-scripts/commands/jail.sma"
#include "small-scripts/commands/kill.sma"
#include "small-scripts/commands/kick.sma"
#include "small-scripts/commands/killbeard.sma"
#include "small-scripts/commands/killhair.sma"
#include "small-scripts/commands/loaddefaults.sma"
#include "small-scripts/commands/lightlevel.sma"
#include "small-scripts/commands/mana.sma"
#include "small-scripts/commands/make.sma"
#include "small-scripts/commands/move.sma"
#include "small-scripts/commands/npcwander.sma"
#include "small-scripts/commands/page/onlinegm.sma"
//#include "small-scripts/commands/options/options.sma" removed
#include "small-scripts/commands/page/pagelist.sma"
#include "small-scripts/commands/page/page.sma"
#include "small-scripts/commands/page/pages.sma"
#include "small-scripts/commands/pdump.sma"
#include "small-scripts/commands/playerlist.sma"
#include "small-scripts/commands/polymorph.sma"
#include "small-scripts/commands/popup.sma"
#include "small-scripts/commands/possess.sma"
#include "small-scripts/commands/posttype.sma"
#include "small-scripts/commands/racelang.sma"
#include "small-scripts/commands/random.sma"
#include "small-scripts/commands/regioncp.sma"
#include "small-scripts/commands/reload.sma"
//#include "small-scripts/commands/reloadsmall.sma" removed
#include "small-scripts/commands/resend.sma"
#include "small-scripts/commands/respawn.sma"
#include "small-scripts/commands/resurrect.sma"
#include "small-scripts/commands/save.sma"
#include "small-scripts/commands/sell.sma"
//#include "small-scripts/commands/setdir.sma" replaced by 'iset dir
#include "small-scripts/commands/setmoreb12.sma"
#include "small-scripts/commands/setmoreb34.sma"
//#include "small-scripts/commands/setmorexyz.sma" replaced by imore
#include "small-scripts/commands/setpriv.sma"
#include "small-scripts/commands/settype.sma"
#include "small-scripts/commands/showbank.sma"
#include "small-scripts/commands/shutdown.sma"
#include "small-scripts/commands/skills/skills.sma"
#include "small-scripts/commands/skills/setskills.sma"
#include "small-scripts/commands/page/solvepage.sma"
#include "small-scripts/commands/spawnkill.sma"
#include "small-scripts/commands/stamina.sma"
#include "small-scripts/commands/stats/stats.sma"
#include "small-scripts/commands/stats/setstats.sma"
#include "small-scripts/commands/summon.sma"
#include "small-scripts/commands/sysm.sma"
#include "small-scripts/commands/tell.sma"
#include "small-scripts/commands/tile.sma"
#include "small-scripts/commands/tweak/tweak.sma"
#include "small-scripts/commands/unjail.sma"
#include "small-scripts/commands/where.sma"
#include "small-scripts/commands/wipe.sma"
#include "small-scripts/commands/gmhide.sma"

//COMMANDS DOCUMENTATION
/*!
\defgroup script_commands commands

\section what_are_commands What are commands
As any other emulator NOXwizard supports \b ingame commands.\n
Ingame commands are special spech strings that are not shown as normal speech but are processed internally
by the server.\n
To mark a speech string as a command string it must be prefixed by the \b command prefix, 
wich by default is ' (the apix), so any speech tring that starts with the command prefix will not
be shown as speech but taken as a command.\n
You can change the special commands character in server.cfg by setting the COMMANDPREFIX option.\n

\section commands_user_interface User interface
Commands have a command line based user interface: users type the command, press enter and the server answers in some way.\n
Many commands require some more interaction with the user so after sending the command you will be prompted to target something
or you will be shown a menu.\n
If something goes wrong the server sends a sysmessage to the user, so always keep an eye at the bottom left corner of the screen when
using commands.\n

\section commands_syntax Syntax
Marking a string as a command is not sufficient to tell the emulator what to do, so typing in "'I want 200000 gp" will be surely
taken as a command string, but will not be correctly processed, and surely you won't get 200000 gp, instead you will get
a sysmessage saying something like "I is not a valid command".\n
After this try you probably have understood that not all strings are valid command strings, and this is true because command strings must follow
a strict syntax.\n
The syntax is simple:\n\n
'\c commandname [\c params]
\n\n
Let's analyze it word by word:
- ' : is the command prefix, you ned it tomark the string as a command
- \c commandname: is the comand name, a word that identifies the command, usually it is a meaningful word that suggests what the command does
- \c params: are the command parameters, a list of strings separated by blanks. These will usually be numbers or characters. The square brackets mean that the parameters are optional, not all commands take parameters.
\n
Here are some examples of the above syntax:\n
'kill
'freeze on
'move +4 0 -1

\section commands_privlevel The privlevel
All commands need an authorization in order to be used because many of them can be quite harmful for the shard if used by
normal shard players (imagine all users creating tons of gp or setting their strength to 3000 ...).\n
This authorization is called the \b privlevel : a number associated with each user and with each command that defines wich commands he can accesses by a user, 
to access the command the user must have a privlevel higher than the command privlevel.\n
\n
There are some predefined privlevels you can use in scripts, they are defined in small-scripts/commands/constant.sma:
- PRIV_GUEST = 0
- PRIV_PLAYER = 50
- PRIV_CNS = 100
- PRIV_SEER = 150
- PRIV_GM = 200
- PRIV_ADMIN = 255

\section commands_callback The callback
From the scripter's point of view a command is a common \c public function called by source (a callback).\n
The commands callback prototype is:\n
\code
	public cmd_command(chr)
\endcode
\n
\c chr :is the character that used the command.\n
Strandard commands callback names start with cmd_ but this is only a convention.\n
All the standard commands callbacks are in the small-scripts/commands folder.\n

\section commands_customization Customization
The reason because commands were ported to Small (before they were hardcoded) is customizability,
with scripted commands you can modify how the server reacts to every command.\n
The simplest customization is to modify the callback so it fills your needs, to do that open the
command file (usually commandname.sma) and modify it, that's all.\n
Usually shard scripters need to add new commands rather than modify existing ones, but doing so requires some more work.\n

\subsection commands_txt The commands.txt file
The core of the command system is the small-scripts/commands.txt file wich associates speech 
strings with callbacks and privlevels and is parsed on the server startup.\n
In this file you can declare new commands as well as modify the existing callback associations 
and privlevels, the syntax is simple:\n\n

\c commandname,privlevel,\c callback
\n\n
- \c commandname : is the comand name, the word that will trigger the command, without the command prefix
- privlevel : is an integer number in the range 0-255 that defines thecommand privlevel
- \c callback: is the Small function that will be called on command triggering

You can put C-style coments to the file (//)

\subsection adding_new_command Adding a new command
Here are the steps to add a new command:
- open commands.txt
- add a new line following the syntax explained above.
- add a Small \c public function with prototype explained in \ref commands_callback section and with the name you specified in the commands.txt entry.
- write some code in the callback body.
- restart the emulator or use "'reload commands" command in game

Remember that
- the command name should be meaningful, the 'aksjhfd command works but it's not a meaningful name.
- critical commands should have an higher privlevel
- commands callback names usually start with cmd_

\subsection commands_params Parameters
The commands.txt file does not contain information about the command parameters because this relates to how
the callback interprets the command string.\n
Once the server receives a command string, it takes the first word as the command name and all other words as parameters,
you can then read the parameters with the CP_STR_PARAMS character property.\n
Actually you don't have to bother with that property because there already is a little scripted support
for reading params.\n
If your command needs parameters simply put this line at the very beginning of you callback body:\n
\code
	readCommandParams(chr);
\endcode
\n
this will correctly read CP_STR_PARAMS and put the parameters in the global array __cmdParams[][] declared
in small-scripts/commands/constant.sma.\n
So after calling readCommandParams(chr) you can access the n-th parameter by reading __cmdParams[n].\n
Note that __cmdParams[n] is a string with unknown content, you can't know what the user wrote so
you have to check it for validity before using it.\n
\n
Also note that __cmdParams[][] is a global variable set by readCommandsParams() so each call to that
function modifies the array, this means that you have to use it \b before any other command is processed, or
you will loose the data.\n
So the \b only place in wich __cmdParams[][] is valid is the \b callback body.
Actually you could use it in functions directly called by the callback, but this is not wise.\n
\n
This problem rises when you are adding commands that require a target, in fact your command callback will
process parameters and then require a target to the user with target_create() and this will stop your script
until the user cliks something, then your script will restart from the \b target callback you specified in target_create().\n
You can't know when the user will use the target, it can be after 2 seconds or after 2 hours, so you do not have
control on when the target callback will be called, and when it will come the time to execute the target callback
__cmdParams[][] won't be valid anymore because surely there have been other commands calls inbetween.\n
If you read __cmdParams[][] in the callback you will get undefined strings and surely this will lead to errors.\n
The only way to safely pass parameters to the callback is to use the target buffer or a local var 
(provided that the local var is not used in the time between the target creation and its triggering)

\section commands_system Overall system description
The above descriptions do not give an idea of how the overall system works, here we'll see the system from
a higher point of view.\n
First of all the emulator loads the file commands.txt in memory, this is done on the server startup
and can be redone whenever you want using "'reload commands".
Once the file commands.txt is loaded in memory the server knows the links between commands and callbacks.\n
Once the Small scripts are compiled, the initCommandSystem() function is called as OnStart override and
performs all needed initializations, you can follow the progress in the console, all that is between "Starting command system ..."
and "command system, startup completed" comes from initCommandSystem().\n
When a character logs in the startCommandSystem(chr) function is called as StartChar override to check for admin logins, if the
admin logs in it's privlevel is reset to 255, this is to prevent problems if the admin changes his privelevel accidentally.\n
Nothing happens until a character types something in the client.\n
When a character speaks the speech is intercepted by the commands parser before any other processing occurs and checked
to see if the forst character is the command prefix, if not the string is processed as normal speech.\n
If the string starts with the command prefix then the string is tokenized (divided in words) and the
first word is checked to see if it corresponds to one of the loaded commands, if not an error message is
sent to the client.\n
If a valid command is recognized then the emulator checks the privlevel to see if the character can access
the command, if not an error message is sent.\n
If the character can access the command the sources call the associated callback after setting 
CP_STR_PARAM values, then the control passes to the Small script wich processes the 
parameters and does something.\n

\section commands_scripts Scripts organization
All the functions of the comand system are in the small-scripts/commands folder.\n
Every command is scripted in the file or folder named after it.\n
The file commands.sma contains the system scripts (startup, parameters reading ...) and the
constants.sma file contains the command system constants.\n

\subsection commands_docs Documentation
In this documentation every command has its own section containing functions documentation and the
command description (name, parameters ...).\n
The commands docmentations follow a simple syntax:\n
\code
	syntax: 'commandname parameters
\endcode
\n
- commandname: the command name
- parameters: the parameters list, [param] means optional parameter, "text" means you have to type the specified text.



 *  @{
 */

/*!
\author Fax
\fn readCommandParams(const chr)
\param chr: the character
\since 0.82
\brief reads command parameters

Reads command params from CP_STR_PARAMS and stores them in __cmdParams[].\n
The reason for this is that this way the command scripts don't have to call
chr_getProperty() to get the parameters but they have only to read a variable.
\return nothing
*/
public readCommandParams(const chr)
{
	for(new p = 1; p <= __MAX_PARAMS; p++)
	{
		//read params
		chr_getProperty(chr,CP_STR_PARAM,p,__cmdParams[p - 1]);
		
		//delete empty params
		if(__cmdParams[p - 1][0] == '_') __cmdParams[p - 1][0] = 0;
	}
}

/*!
\author Fax
\fn initCommandSystem()
\since 0.82
\brief initializes command system

Prints a message saying wich system is active.\n
Executes any needed startup function for the command system, put a function call here if some of
your commands needs setup functions.
Loads needed XSS data.\n
\return nothing
*/
public initCommandSystem()
{
	//Command system type message
	#if _CMD_DEBUG_
		log_message("Starting command system ....");
	#endif
	
	
	//print 
	#if _CMD_SHOWLIST_
	showCommandsList();
	#endif
		
	//setup 'area command
	resetCmdAreas(); //DO NOT REMOVE!! this initializes data for command areas

	//setup 'help command
	loadHelpTopics();
	
	//setup 'add command
	loadAddMenu();
	
	//setup 'go command
	loadGoLocations();

	log_message("Command system startup completed^n");
}

/*!
\author Fax
\fn startCommandSystem(const chr)
\param chr: the character
\since 0.82
\brief starts the scripted command system for the given character

This funciton checks if the scripted command system's localVars are already set, and sets them if needed.\n
Usually this function will be completely executed only at the first character login.
\return nothing
*/
public startCommandSystem(const chr)
{
	//set account 0 players to admin, this is needed so if on accidentally
	//sets his priv to less than 255 he can restore it by logging in again
	if(chr_getProperty(chr, CP_ACCOUNT)== 0)
	{
		log_message("Admin login detected: resetting privlevel to PRIV_ADMIN");
		chr_setProperty(chr,CP_PRIVLEVEL,_,PRIV_ADMIN);
		chr_makeGM(chr);
		chr_makeInvul(chr);
	}	
}

/*!
\author Fax
\fn showCommandsList()
\since 0.82
\brief shows commands list

Reads commands.txt and prints the content to the console
\return nothing
*/
public showCommandsList()
{
	log_message("^t->COMMANDS LIST:");
	if(file_scan("small-scripts/commands.txt","printCommand","//") == INVALID)
		log_warning("Unable to read 'small-scripts/commands.txt'!");
	printf("^n");
	
}

/*!
\author Fax
\fn printCommand(file,linenum)
\since 0.82
\brief callback for showCommandsList()

Prints a single command on the console
\return nothing
*/
public printCommand(file,linenum)
{
	static c;
	
	if(linenum == INVALID)
	{ 
		c = 0;
		return;
	}
		
	//read scanned line
	new line[FILE_SCAN_BUFFER_SIZE];
	file_getScanLine(line);
	
	//replace , with blanks (so we can tokenize string)
	replaceStr(line,","," ");
	
	//read command
	new name[30]
	str2Token(line,name,0,line,0);
	
	//read priv
	new priv[10];
	str2Token(line,priv,0,line,0);

	//give privs a name if they are standard privs
	switch(str2Int(priv))
	{
		case 0: strcpy(priv,"GUEST");
		case 50: strcpy(priv,"PLAYER");
		case 100: strcpy(priv,"COUNSELOR");
		case 150: strcpy(priv,"SEER");
		case 200: strcpy(priv,"GM");
		case 255: strcpy(priv,"ADMIN");
	}
	
	//print command info
	log_message("^t%d - '%s - %s",c,name,priv);

	c++;
}
/*! @} */ //end of scripts_commands_system