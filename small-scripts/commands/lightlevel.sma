/*!
\defgroup script_command_lightlevel 'lightlevel
\ingroup script_commands

@{
*/

/*!
\author Fax(const chr)
\fn cmd_lightlevel
\brief sets the light level of a character

<B>syntax:<B> 'lightlevel [value] ["target"]
<B>command params:</B>
<UL>
<LI> value: the light level value
<LI> "target": pass this paramter if you want to bypass the area effect
</UL>

If area effect is active, all characters in area will have the given light level.
If no area effect is active, or if you pass "target", a target will appear and only 
the targetted char will be affected
*/
public cmd_lightlevel(const chr)
{
	readCommandParams(chr);
	
	new level,target = false;
	
	if(!isStrInt(__cmdParams[0]))
	{
		chr_message(chr,_,"you must specify a number");
		return;
	}
	
	if(!strcmp(__cmdParams[1],"target"))
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
				chr_setProperty(chr2,CP_FIXEDLIGHT,_,level);
		}
		
		chr_message(chr,_,"%d characters affected",i);	
		area_refresh(area);			
		return;
	}

	chr_message(chr,_,"Select a character to set the light level to");
	target_create(chr,level,_,_,"cmd_lightlevel_targ");
}

/*!
\author Fax
\fn cmd_lightlevel_targ(target, chr, object, x, y, z, unused, level)
\params all standard target callback params
\brief handles single character targetting
*/
public cmd_lightlevel_targ(target, chr, object, x, y, z, unused, level)
{
	if(isChar(object))
		chr_setProperty(object,CP_FIXEDLIGHT,_,level);
	else chr_message(chr,_,"You must target a character");
}

/*! }@ */