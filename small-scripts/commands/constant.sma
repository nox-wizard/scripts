/*!
\defgroup script_commands_constants constants
\ingroup script_commands

@{
*/

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
