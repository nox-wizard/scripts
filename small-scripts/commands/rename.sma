/*!
\defgroup script_command_rename 'rename
\ingroup script_commands

@{
*/

/*!
\author Horian(const obj)
\fn cmd_rename
\brief renames an item or char

<B>syntax:<B> 'rename [name]

the targetted object will be renamed
*/
static tempStr[512] 

public cmd_rename(const chr)
{
	chr_getSpeech(chr, tempStr);
	trim(tempStr);
	
	chr_message(chr,_,"Rename whom or what?");
	target_create(chr,_,_,_,"cmd_rename_targ");
}

/*!
\author Horian
\fn cmd_rename_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and renameing
*/
public cmd_rename_targ(target, chr, object, x, y, z, unused, unused2)
{
	if(isChar(object))
	{
		chr_setProperty(object, CP_STR_NAME, _,tempStr);
	}
	else itm_setProperty(object, IP_STR_NAME, _, tempStr);
}

/*! }@ */