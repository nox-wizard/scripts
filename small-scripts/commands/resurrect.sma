/*!
\defgroup script_command_freeze 'freeze
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_resurrect(const chr)
\brief resurrects a character

<B>syntax:<B> 'resurrect ["target"]
<B>command params:</B>
<UL>
<LI> "target": pass this paramter if you want to bypass the area effect
</UL>

If area effect is active, all characters in area will be resurrected.
If no area effect is active, or if you pass "target", a target will appear and only 
the targetted char will be resurrected
*/
public cmd_resurrect(const chr)
{
	new target = false;
		
	//parameters handling, if no parameters are given, keep defaults, else
	//read them
	
	if(!strcmp(__cmdParams[0],"target"))
		target = true;
			
	new area = chr_getCmdArea(chr);
	new chr2,i = 0;
	//apply command to all characters in area if an area is defined
	if(area_isValid(area) && !target)
	{
		area_useCommand(area);
		for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
		{
				chr2 = set_getChar(area_chars(area));
				if(chr2 != chr) chr_resurrect(chr2);
		}
		
		chr_message(chr,_,"%d characters unfrozen",i);
		return;
	}

	//if we are here it means we need a target
	chr_message(chr,_,"Select a character to resurrect");
	target_create(chr,_,_,_,"cmd_resurrect_targ");
}

/*!
\author Fax
\fn cmd_resurrect_targ(target, chr, object, x, y, z, unused, freeze)
\params all standard target callback params
\brief handles single character targetting and freezing
*/
public cmd_resurrect_targ(target, chr, object, x, y, z, unused, unused2)
{
	if(isChar(object))
	{	
		chr_resurrect(object);
		chr_message(chr,_,"charcater resurrectd");		
	}
	else chr_message(chr,_,"You must target a character");
}

/*! }@ */