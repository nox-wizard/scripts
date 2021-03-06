/*!
\defgroup script_command_reload 'reload
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_reload(const chr)
\brief reloads accounts/XSS/commands

<B>syntax:</B> 'reload what
<UL>
	<LI>what: "commands" or "XSS" or "accounts" or "Small"
<UL>

<br>
*/
public cmd_reload(chr)
{
	getCommandParams(chr);
	
	new message[10];
	switch(__cmdParams[0][0])
	{
		case 'c': {reload_commands(); strcpy(message,"commands"); }
		case 'x': {reload_scripts(); strcpy(message,"scripts"); }
		case 'a': {reload_accounts(); strcpy(message,"accounts"); }
		case 's': {recompileSmall(); strcpy(message,"Small"); }
	}
	
	//let's warn everyone that someone is recompiling
	new name[50];
	chr_getProperty(chr,CP_STR_NAME,0,name);
	log_message("%s(%d) is reloading %s",name,chr,message);
	log_warning("%s(%d) is reloading %s",name,chr,message);
}

/*! }@ */