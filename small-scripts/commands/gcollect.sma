/*!
\defgroup script_command_gcollect 'gcollect
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_gcollect(const chr)
\brief gcollects accounts/XSS/commands

<B>syntax:</B> 'gcollect
*/
public cmd_gcollect(chr)
{
	garbageCollection(seconds);
	chr_message(chr,_,"Done");
}

/*! }@ */