/*!
\author Fax
\fn cmd_freeze(const chr)
\brief freezes a character

<B>syntax:<B> 'freeze ["target"]
<B>command params:</B>
<UL>
	<UL>
	<LI> "on": freeze (default)
	<LI> "off": off
	</UL>
<LI> "target": pass this paramter if you want to bypass the area effect
</UL>

If area effect is active, all characters in area will be frozen.
If no area effect is active, or if you pass "target", a target will appear and only 
the targetted char will be frozen
\todo make this function work when commands are done in sources
*/
public cmd_freeze(const chr)
{
	new target = true;
	new freeze = true;
	//TODO:set target and freeze by reading parameters
	new area = chr_getCmdArea(chr);
	
	//apply command to all characters in area
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
			chr_message(chr,_,"charcater frozen");		
		}
		else 
		{
			chr_unfreeze(object);
			chr_message(chr,_,"charcater unfrozen");		
		}
	else chr_message(chr,_,"You must target a character");
}