/*!
\defgroup script_commands_constants constants
\ingroup script_commands

@{
*/

#define _USE_SOURCE_CMDSYS_ 1	//!< set to 1 if you want to use the source code command system, 0 if you want the Small scripted one.
#define _CMD_DEBUG_  1		//!< command system debug switch set to 1 to have debug messages shown, 0 else.
#define _CMD_SHOWLIST_ 1	//!< set to 1 if you want to see a list of available commands at startup
#define _CMD_SHOW_MSG 1		//!< set to 1 if you want users to be warned when they try to use commands they are not authorized to use or that not exist
#define __MAX_PARAMS 6		//!< maximum number of parameters a command can have
#define __MAX_PARAM_LENGTH 20	//!< maximum number of character a parameter can be made of
#define __CMD_COUNT 30		//!< number of available commands

enum
{
	PRIV_PLAYER = 0,
	PRIV_CNS = 64,
	PRIV_GM = 128,
	PRIV_SCRIPTER = 192,
	PRIV_ADMIN = 255
};//!< predefined privlevels, insert you own privs between existing ones


enum __cmdEntry
{
	__cmdPriv,
	__cmdName: 15, //do not increase this value !!
	__cmdFunc: 20
};//!< command data structure, first field is command name, second is command privlevel


//insert your custom commands here.
new __commands[__CMD_COUNT][__cmdEntry] =
{
	{PRIV_GM,	"add",		""},
	{PRIV_CNS,	"area",		""},
	{PRIV_CNS,	"freeze",	""},
	{PRIV_SCRIPTER,	"func",		""},
	{PRIV_CNS,	"hiding",	""},
	{PRIV_CNS,	"invul",	""},
	{PRIV_CNS,	"kill",		""},
	{PRIV_ADMIN,	"make",		""},
	{PRIV_CNS,	"move",		""},
	{PRIV_CNS,	"options",	""},

	{PRIV_PLAYER,	"playerlist",	""},
	{PRIV_PLAYER,	"skills",	""},
	{PRIV_PLAYER,	"stats",	""},
	{PRIV_CNS,	"tweak",	""},
	{PRIV_CNS,	"where",	""},
	{PRIV_CNS,	"wipe",		""},
	{PRIV_CNS,	"polimorph",	""},
	{PRIV_ADMIN,	"setpriv",	""},
	{PRIV_GM,	"dupe",		""},
	{0,"",""},
	
	{0,"",""},{0,"",""},{0,"",""},{0,"",""},{0,"",""},
	{0,"",""},{0,"",""},{0,"",""},{0,"",""},{0,"",""}
}; //!< names of commands, are used to create function names. Due to the 19 characters function name limit, command names are limited to 15 characters in length.

new __cmdParams[__MAX_PARAMS][__MAX_PARAM_LENGTH]; //!< array that is filled with paramters when a command is called

//command system error codes
#define CMD_ERROR -1
#define CMD_OK 0

/*! @} */
