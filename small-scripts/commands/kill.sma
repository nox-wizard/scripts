/*!
\defgroup script_command_kill 'kill
\ingroup script_commands

@{
*/

/*!
\author Fax(const chr)
\fn cmd_kill
\brief kills a character

<B>syntax:<B> 'kill ["target"]
<B>command params:</B>
<UL>
<LI> "target": pass this paramter if you want to bypass the area effect
</UL>

If area effect is active, all characters in area will die.
If no area effect is active, or if you pass "target", a target will appear and only 
the targetted char will be killed
*/
public cmd_kill(const chr)
{
	new target = false;
	
	if(!strcmp(__cmdParams[0],"target"))
		target = true;
	
	new area = chr_getCmdArea(chr);
	new i = 0, chr2;
	//apply command to all characters in area
	if(area_isValid(area) && !target)
	{
		area_useCommand(area);
		for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
		{
				chr2 = set_getChar(area_chars(area));
				if(chr2 != chr) chr_setHitPoints(chr2,0);
		}
		
		chr_message(chr,_,"%d characters killed",i);	
		area_refresh(area);			
		return;
	}

	chr_message(chr,_,"Select a character to kill");
	target_create(chr,area,_,_,"cmd_kill_targ");
}

/*!
\author Fax
\fn cmd_kill_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and killing
*/
public cmd_kill_targ(target, chr, object, x, y, z, unused, area)
{
	if(isChar(object))
	{
		chr_setHitPoints(object,0);
		area_refresh(area);	
	}
	else chr_message(chr,_,"You must target a character");
}

/*! }@ */