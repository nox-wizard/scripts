/*!
\defgroup script_commands_constants constants
\ingroup script_commands

@{
*/

#define _USE_SOURCE_CMDSYS_ 1	//!< set to 1 if you want to use the source code command system, 0 if you want the Small scripted one.
#define _CMD_DEBUG_  0		//!< command system debug switch set to 1 to have debug messages shown, 0 else.
#define _CMD_SHOWLIST_ 1	//!< set to 1 if you want to see a list of available commands at startup
#define _CMD_SHOW_MSG 1		//!< set to 1 if you want users to be warned when they try to use commands they are not authorized to use or that not exist
#define __MAX_PARAMS 8		//!< maximum number of parameters a command can have
#define __MAX_PARAM_LENGTH 20	//!< maximum number of character a parameter can be made of
#define __CMD_COUNT 60		//!< number of available commands

enum
{
	PRIV_GUEST = 0,
	PRIV_PLAYER = 50,
	PRIV_CNS = 100,
	PRIV_SEER = 150,
	PRIV_GM = 200,
	PRIV_ADMIN = 255
};//!< predefined privlevels, insert you own privs between existing ones

#if !_USE_SOURCE_CMDSYS_
enum __cmdEntry
{
	__cmdPriv,
	__cmdName: 16, //do not increase this value !!
	__cmdFunc: 20
};//!< command data structure, first field is command privlevel, second is command name, third is function to call

//filled with commands.txt entries
new __commands[__CMD_COUNT][__cmdEntry];
#endif

new __cmdParams[__MAX_PARAMS][__MAX_PARAM_LENGTH]; //!< array that is filled with paramters when a command is called

//command system error codes
#define CMD_ERROR -1
#define CMD_OK 0

/*! @} */
