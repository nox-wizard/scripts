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
	new speech[200],message[200],temp[20];

	chr_getProperty(chr,CP_STR_SPEECH,0,speech);
	str2Token(speech,temp,0,message,0);

	new chr2 = INVALID;
	for(set_rewind(__onlineStaff);!set_end(__onlineStaff);)
	{
		chr2 = set_getChar(__onlineStaff);
		chr_message(chr2,_,message);
	}
}

/*! }@ */