/*!
\defgroup script_command_possess 'possess
\ingroup script_commands

@{
*/

/*!
\author Fax(const chr)
\fn cmd_possess
\brief character possess an npc

This is NOT polymorph!
to unpossess use 'possess again and target yourself
<B>syntax:<B> 'possess
*/
public cmd_possess(const chr)
{
	chr_message(chr,_,"The command works but there's no way to swtich back possession at present, so it's better not to use it");
	
	//chr_message(chr,_,"Select a character to possess");
	//target_create(chr,_,_,_,"cmd_possess_targ");
}

/*!
\author Fax
\fn cmd_possess_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and possessing
*/
public cmd_possess_targ(target, chr, object, x, y, z, unused, unused1)
{
	if(isChar(object))
	{
		chr_possess(chr,object);
	}
	else chr_message(chr,_,"You must target a character");
}

/*! }@ */