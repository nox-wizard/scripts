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
	new speech[200],message[200],temp[20];

	chr_getProperty(chr,CP_STR_SPEECH,0,speech);
	str2Token(speech,temp,0,message,0);

	broadcast(message);
}

/*! }@ */