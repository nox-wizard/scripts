/*!
\defgroup script_command_gmopen 'gmopen
\ingroup script_commands

@{
*/

/*!
\author Fax(const chr)
\fn cmd_gmopen
\brief opens a character's backpack

<B>syntax:<B> 'gmopen 

the targetted character's backpack will be opened
*/
public cmd_gmopen(const chr)
{
	chr_message(chr,_,"Select a character to open his backpack");
	target_create(chr,_,_,_,"cmd_gmopen_targ");
}

/*!
\author Fax
\fn cmd_gmopen_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and gmopening
*/
public cmd_gmopen_targ(target, chr, object, x, y, z, unused, unused1)
{
	if(isChar(object))
	{
		new bp = chr_getBackpack(object);
		if(!isItem(bp))
		{
			chr_message(chr,_,"That character does not have a backpack");
			return;
		}

		itm_showContainer(bp,chr);
	}
	else chr_message(chr,_,"You must target a character");
}

/*! }@ */