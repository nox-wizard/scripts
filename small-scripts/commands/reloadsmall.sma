/*!
\defgroup script_command_recompile_small 'recompile_small
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_recompile_small(const chr)
\brief recompiles small scripts

<B>syntax:</B> 'recompile_small

<br>
*/
public cmd_recompile_small(chr)
{
	new name[50];
	chr_getProperty(chr,CP_STR_NAME,0,name);
	
	//let's warn everyone that someone is recompiling
	log_message("%s(%d) is recompiling Small scripts",name,chr);
	log_warning("%s(%d) is recompiling Small scripts",name,chr);
	
	//recompile scripts
	new time = getSystemTime();
	recompileSmall();
	time = getSystemTime() - time;
	
	log_message("Recompiled in %ds",time);
	chr_message(chr,_,"Recompiled in %ds",time);
}

/*! }@ */