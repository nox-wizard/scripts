/*!
\defgroup script_command_resend 'resend
\ingroup script_commands

@{
*/

/*!
\author Fax(const chr)
\fn cmd_resend
\brief resends a character

<B>syntax:<B> 'resend 
<B>command params:</B>
<UL>

</UL>

If area effect is active, all characters in area will die.
If no area effect is active, or if you pass "target", a target will appear and only 
the targetted char will be resended
*/
public cmd_resend(const chr)
{
	readCommandParams(chr);



	new area = chr_getCmdArea(chr);
	new i = 0;
	//apply command to all characters in area
	if(area_isValid(area))
	{
		area_useCommand(area);
		for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
			chr_update(set_getChar(area_chars(area)));
			
		chr_message(chr,_,msg_commandsDef[215],i);		
		return;
	}

	chr_message(chr,_,msg_commandsDef[216]);
	target_create(chr,area,_,_,"cmd_resend_targ");
}

/*!
\author Fax
\fn cmd_resend_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and resending
*/
public cmd_resend_targ(target, chr, object, x, y, z, unused, area)
{
	if(isChar(object))
		chr_update(object);
	else chr_message(chr,_,msg_commandsDef[32]);
}

/*! }@ */