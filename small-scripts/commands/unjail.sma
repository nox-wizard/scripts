/*!
\defgroup script_command_unjail 'unjail
\ingroup script_commands

@{
*/

/*!
\author Fax(const chr)
\fn cmd_unjail
\brief unjails a character

<B>syntax:<B> 'unjail 

the targetted character will be unjailed
*/
public cmd_unjail(const chr)
{
	chr_message(chr,_,"Select a character to unjail");
	target_create(chr,_,_,_,"cmd_unjail_targ");
}

/*!
\author Fax
\fn cmd_unjail_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and unjailing
*/
public cmd_unjail_targ(target, chr, object, x, y, z, unused, unused1)
{
	if(isChar(object))
		chr_unjail(chr,object);
	else chr_message(chr,_,"You must target a character");
}

/*! }@ */