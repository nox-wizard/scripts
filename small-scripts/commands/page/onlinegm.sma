#include "small-scripts/commands/page/constants.sma"

/*!
\defgroup script_commands_onlinegm
\ingroup script_commands

@{
*/

/*!
\author Fax
\since 0.82
\fn cmd_onlinegm(const chr)
\brief shows a list of online GMs

<B>syntax:<B> 'onlinegm text

Shows a list of online GMsand counselors to the player
*/
public cmd_onlinegm(const chr)
{
	if(set_size(__onlineStaff) == 0)
	{
		chr_message(chr,_,"There are no pageable GMs or counselors online");
		return;
	}

	chr_message(chr,_,"Online pageable staff is:");
	new chr2,name[30];
	set_rewind(__onlineStaff);
	while(!set_end(__onlineStaff))
	{
		chr2 = set_getChar(__onlineStaff);
		chr_getProperty(chr2,CP_STR_NAME,0,name);
		chr_message(chr,_,"%s",name);
	}
}
/*! @}*/