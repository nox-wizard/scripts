#include "small-scripts/commands/page/constants.sma"

/*!
\defgroup script_command_gy 'gy
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_gy(const chr)
\brief sends a message to all online staff

<B>syntax:</B> 'gy message
*/
public cmd_gy(const chr)
{
	new message[200],name[50];

	chr_getSpeech(chr,message);
	chr_getProperty(chr,CP_STR_NAME,0,name);
	
	sprintf(message,"%s: %s",name,message);
	new chr2 = INVALID;
	for(set_rewind(__onlineStaff);!set_end(__onlineStaff);)
	{
		chr2 = set_getChar(__onlineStaff);
		chr_message(chr2,_,message);
	}
}

/*! }@ */