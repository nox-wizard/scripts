/*!
\defgroup script_commands_constants constants
\ingroup script_commands

@{
*/

#define _CMD_DEBUG_  0		//!< command system debug switch set to 1 to have debug messages shown, 0 else.
#define _CMD_SHOWLIST_ 1	//!< set to 1 if you want to see a list of available commands at startup
#define _CMD_SHOW_MSG 1		//!< set to 1 if you want users to be warned when they try to use commands they are not authorized to use or that not exist
#define __MAX_PARAMS 7		//!< maximum number of parameters a command can have
#define __MAX_PARAM_LENGTH 50	//!< maximum number of character a parameter can be made of

enum
{
	PRIV_GUEST = 0,
	PRIV_PLAYER = 50,
	PRIV_CNS = 100,
	PRIV_SEER = 150,
	PRIV_GM = 200,
	PRIV_ADMIN = 255
};//!< predefined privlevels, insert you own privs between existing ones

new __cmdParams[__MAX_PARAMS][__MAX_PARAM_LENGTH]; //!< array that is filled with paramters when a command is called

/*! @} */
