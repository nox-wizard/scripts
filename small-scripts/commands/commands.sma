#include "small-scripts/nxw_lib2.sma"
#include "small-scripts/commands/constant.sma"

//here are all command scripts
#include "small-scripts/commands/area.sma"
#include "small-scripts/commands/action.sma"
#include "small-scripts/commands/add/add.sma"
#include "small-scripts/commands/align.sma"
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
#include "small-scripts/commands/gmopen.sma"
#include "small-scripts/commands/go/go.sma"
#include "small-scripts/commands/gy.sma"
#include "small-scripts/commands/heal.sma"
#include "small-scripts/commands/hiding.sma"
#include "small-scripts/commands/hunger.sma"
#include "small-scripts/commands/help/help.sma"
#include "small-scripts/commands/invul.sma"
#include "small-scripts/commands/iset.sma"
#include "small-scripts/commands/jail.sma"
#include "small-scripts/commands/kill.sma"
#include "small-scripts/commands/killbeard.sma"
#include "small-scripts/commands/killhair.sma"
#include "small-scripts/commands/mana.sma"
#include "small-scripts/commands/make.sma"
#include "small-scripts/commands/move.sma"
#include "small-scripts/commands/npcwander.sma"
#include "small-scripts/commands/lightlevel.sma"
#include "small-scripts/commands/page/onlinegm.sma"
//#include "small-scripts/commands/options/options.sma" removed
#include "small-scripts/commands/page/pagelist.sma"
#include "small-scripts/commands/page/page.sma"
#include "small-scripts/commands/page/pages.sma"
#include "small-scripts/commands/playerlist.sma"
#include "small-scripts/commands/polymorph.sma"
#include "small-scripts/commands/popup.sma"
#include "small-scripts/commands/possess.sma"
#include "small-scripts/commands/racelang.sma"
#include "small-scripts/commands/regioncp.sma"
#include "small-scripts/commands/resend.sma"
#include "small-scripts/commands/resurrect.sma"
#include "small-scripts/commands/save.sma"
//#include "small-scripts/commands/setdir.sma" removed
#include "small-scripts/commands/setmoreb12.sma"
#include "small-scripts/commands/setmoreb34.sma"
#include "small-scripts/commands/setmorexyz.sma"
#include "small-scripts/commands/setpriv.sma"
#include "small-scripts/commands/settype.sma"
#include "small-scripts/commands/showbank.sma"
#include "small-scripts/commands/skills/skills.sma"
#include "small-scripts/commands/skills/setskills.sma"
#include "small-scripts/commands/stamina.sma"
#include "small-scripts/commands/stats/stats.sma"
#include "small-scripts/commands/stats/setstats.sma"
#include "small-scripts/commands/summon.sma"
#include "small-scripts/commands/sysm.sma"
#include "small-scripts/commands/tile.sma"
#include "small-scripts/commands/tweak/tweak.sma"
#include "small-scripts/commands/unjail.sma"
#include "small-scripts/commands/where.sma"
#include "small-scripts/commands/wipe.sma"
#include "small-scripts/commands/reloadsmall.sma"

/** \defgroup script_commands_system system functions
 *  \ingroup script_commands
 *  @{
 */

/*!
\author Fax
\fn readCommandParams(const chr)
\param chr: the character
\since 0.82
\brief reads command parameters

Reads command params from CP_STR_PARAMS and stores them in __cmdParams[].<br>
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
		log_message("Starting command system ....");
	#endif
	
	
	//print 
	#if _CMD_SHOWLIST_
	showCommandsList();
	#endif
		
	//setup 'area command
	resetCmdAreas(); //DO NOT REMOVE!! this initializes data for command areas

	//setup 'go command
	//loadLocations();

	//setup 'help command
	loadHelpTopics();

	log_message("Command system startup completed^n");
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
		log_warning("Unable to read ìsmall-scripts/commands.txt'!");
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