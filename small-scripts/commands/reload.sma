/*!
\defgroup script_command_reload 'reload
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_reload(const chr)
\brief reloads accounts/XSS/commands/small

<B>syntax:</B> 'reload what
<UL>
	<LI>what: "commands" or "XSS" or "accounts" or "Small"
<UL>

<br>
*/
public cmd_reload(chr)
{
	readCommandParams(chr);
	
	new message[10];
	new time = getSystemTime();
	chr_addLocalIntVar(chr,CLV_CMDTEMP,time); //needed because variables are reset during recompile 
	
	switch(__cmdParams[0][0])
	{
		case 'c': {reload_commands(); strcpy(message,"commands"); }
		case 'x': {reload_scripts(); strcpy(message,"scripts"); }
		case 'a': {reload_accounts(); strcpy(message,"accounts"); }
		case 's': {recompileSmall(); strcpy(message,"Small"); }
	}
	
	time = getCurrentTime() - chr_getLocalIntVar(chr,CLV_CMDTEMP);
	chr_delLocalVar(chr,CLV_CMDTEMP);
	
	//let's warn everyone that someone is reloading something
	new name[50];
	chr_getProperty(chr,CP_STR_NAME,0,name);
	log_message("%s(%d) reloaded %s (time: %ds)",name,chr,message,time);
	log_warning("%s(%d) reloaded %s (time: %ds)",name,chr,message,time);
	chr_message(chr,_,"Reloaded %s in %ds",message,time);
}

/*! }@ */