/*!
\defgroup script_commands_constants constants
\ingroup script_commands

@{
*/

#define _USE_SOURCE_CMDSYS_ 1	//!< set to 1 if you want to use the source code command system, 0 if you want the Small scripted one.
#define _CMD_DEBUG_  0		//!< command system debug switch set to 1 to have debug messages shown, 0 else.
#define _CMD_SHOWLIST_ 1	//!< set to 1 if you want to see a list of available commands at startup
#define _CMD_SHOW_MSG 1		//!< set to 1 if you want users to be warned when they try to use commands they are not authorized to use or that not exist
#define __MAX_PARAMS 6		//!< maximum number of parameters a command can have
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

enum __cmdEntry
{
	__cmdPriv,
	__cmdName: 16, //do not increase this value !!
	__cmdFunc: 20
};//!< command data structure, first field is command privlevel, second is command name, third is function to call

//insert your custom commands here.
new __commands[__CMD_COUNT][__cmdEntry] =
{
	{PRIV_SEER,	"add",	""},
	{PRIV_CNS,	"align",	""},
	{PRIV_CNS,	"area",	""},
	{PRIV_GM,	"cset",	""},
	{PRIV_SEER,	"csetxyz",	""},
	{PRIV_SEER,	"damage",	""},
	{PRIV_SEER,	"decay",	""},
	{PRIV_SEER,	"dye",	""},
	{PRIV_SEER,	"dupe",	""},
	{PRIV_CNS,	"freeze",	""},
	{PRIV_GM,	"fullstats",	""},
	{PRIV_GM,	"func",	""},
	{PRIV_GM,	"gmopen",	""},
	{PRIV_CNS,	"go",	""},
	{PRIV_CNS,	"gy",	""},
	{PRIV_CNS,	"hiding",	""},
	{PRIV_GM,	"heal",	""},
	{PRIV_CNS,	"help",	""},
	{PRIV_CNS,	"invul",	""},
	{PRIV_GM,	"iset",	""},
	{PRIV_CNS,	"jail",	""},
	{PRIV_CNS,	"kill",	""},
	{PRIV_CNS,	"lightlevel",	""},
	{PRIV_ADMIN,	"make",	""},
	{PRIV_GM,	"mana",	""},
	{PRIV_CNS,	"move",	""},
	{PRIV_GUEST,	"onlinegm",	""},
	{PRIV_CNS,	"options",	""},
	{PRIV_GUEST,	"page",	""},
	{PRIV_CNS,	"pages",	""},
	{PRIV_CNS,	"pagelist",	""},
	{PRIV_PLAYER,	"playerlist",	""},
	{PRIV_CNS,	"polymorph",	""},
	{PRIV_SEER,	"regioncp",	""},
	{PRIV_PLAYER,	"resend",	""},
	{PRIV_CNS,	"resurrect",	""},
	{PRIV_SEER,	"setdir",	""},
	{PRIV_SEER,	"setmorexyz",	""},
	{PRIV_ADMIN,	"setpriv",	""},
	{PRIV_GM,	"setskills",	""},
	{PRIV_SEER,	"settype",	""},
	{PRIV_GM,	"showbank",	""},
	{PRIV_GUEST,	"skills",	""},
	{PRIV_CNS,	"solvepage",	""},
	{PRIV_GM,	"stamina",	""},
	{PRIV_GUEST,	"stats",	""},
	{PRIV_CNS,	"sysm",	""},
	{PRIV_SEER,	"tile",	""},
	{PRIV_CNS,	"tweak",	""},
	{PRIV_GM,	"unjail",	""},
	{PRIV_CNS,	"where",	""},
	{PRIV_CNS,	"wipe",	""},

	{0,	"",	""},
	{0,	"",	""},
	{0,	"",	""},
	{0,	"",	""},
	{0,	"",	""},
	{0,	"",	""},
	{0,	"",	""},
	{0,	"",	""}
}; //!< names of commands, are used to create function names. Due to the 19 characters function name limit, command names are limited to 15 characters in length.

new __cmdParams[__MAX_PARAMS][__MAX_PARAM_LENGTH]; //!< array that is filled with paramters when a command is called

//command system error codes
#define CMD_ERROR -1
#define CMD_OK 0

/*! @} */
