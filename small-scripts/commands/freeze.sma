/*!
\defgroup script_command_freeze 'freeze
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_freeze(const chr)
\brief freezes a character

<B>syntax:<B> 'freeze ["on"/"off"]["target"]
<B>command params:</B>
<UL>
	<UL>
	<LI> "on": freeze
	<LI> "off": off
	</UL>
<LI> "target": pass this paramter if you want to bypass the area effect
</UL>

If area effect is active, all characters in area will be frozen.
If no area effect is active, or if you pass "target", a target will appear and only 
the targetted char will be frozen
*/
public cmd_freeze(const chr)
{
	new target = false;
	new freeze = false;
	
	//parameters handling, if no parameters are given, keep defaults, else
	//read them
	if(!strlen(__cmdParams[0]))
	{
		chr_message(chr,_,"You must specify on or off");
		return;
	}
	
	if(!strcmp(__cmdParams[0],"on"))
		freeze = true;
	else if(strcmp(__cmdParams[0],"off"))
		{
			chr_message(chr,_,"You must specify 'on' 'off' or 'target' as first parameter");
			return;	
		}

	if(!strcmp(__cmdParams[1],"target"))
		target = true;
		
	
	new area = chr_getCmdArea(chr);
	new chr2,i = 0;
	//apply command to all characters in area if an area is defined
	if(area_isValid(area) && !target)
	{
		area_useCommand(area);
		if(freeze)
		{
			for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
			{
					chr2 = set_getChar(area_chars(area));
					if(chr2 != chr) chr_freeze(chr2);
			}
	
			chr_message(chr,_,"%d characters frozen",i);
		}
		
		else	
		{
			for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
			{
					chr2 = set_getChar(area_chars(area));
					if(chr2 != chr) chr_unfreeze(chr2);
			}
			chr_message(chr,_,"%d characters unfrozen",i);
		}			
		
		return;
	}

	//if we are here it means we need a target
	chr_message(chr,_,"Select a character to freeze");
	target_create(chr,freeze,_,_,"cmd_freeze_targ");
}

/*!
\author Fax
\fn cmd_freeze_targ(target, chr, object, x, y, z, unused, freeze)
\params all standard target callback params
\brief handles single character targetting and freezing
*/
public cmd_freeze_targ(target, chr, object, x, y, z, unused, freeze)
{
	if(isChar(object))
		if(freeze)
		{
			chr_freeze(object);
			chr_message(chr,_,"character frozen");		
		}
		
		else 
		{
			chr_unfreeze(object);
			chr_message(chr,_,"charcater unfrozen");		
		}
	else chr_message(chr,_,"You must target a character");
}

/*! }@ */