/*!
\defgroup script_command_gcollect 'gcollect
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_gcollect(const chr)
\brief garbage collection at shard

<B>syntax:</B> 'gcollect
*/
public cmd_gcollect(chr)
{
	garbageCollection();
	chr_message(chr,_,"Done");
}

/*! }@ */