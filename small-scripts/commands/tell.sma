/*!
\defgroup script_command_tell 'tell
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_tell(const chr)
\brief sends a message to all online staff

<B>syntax:</B> 'tell serial message
*/
public cmd_tell(const chr)
{
	new message[200],serial[10],name[50];

	chr_getSpeech(chr,message);
	
	str2Token(message,serial,0,message,0);
	
	chr_getProperty(chr,CP_STR_NAME,0,name);
	sprintf(message,"%s: %s",name,message);
	
	new chr2 = str2Int(serial);
	
	if(isChar(chr2))
		chr_message(chr2,_,message);
	else chr_message(chr,_,msg_commandsDef[275]);
}

/*! }@ */