/*!
\defgroup script_command_sysm 'sysm
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_sysm(const chr)
\brief sends a message to all online staff

<B>syntax:</B> 'sysm message
*/
public cmd_sysm(const chr)
{
	new message[200],name[50];

	chr_getSpeech(chr,message);
	
	chr_getProperty(chr,CP_STR_NAME,0,name);
	sprintf(message,"%s: %s",name,message);
	
	broadcast(message);
}

/*! }@ */