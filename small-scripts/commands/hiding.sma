/*!
\author Fax
\fn cmd_hide(const chr)
\brief hides a character

<B>syntax:<B> 'hiding ["on"/"off"][mode]["target"]
<B>command params:</B>
<UL>
<LI>	<UL>
	<LI>"on": hides character
	<LI>"off": unhides character
	</UL>
<LI> mode
	<UL>
	<LI>"skill": hides by skill
	<LI>"spell": hides by spell
	<LI>"perma": permanantly hidden (default)
	</UL>
<LI> "target": pass this paramter if you want to bypass the area effect
</UL>

If area effect is active, all characters in area will be hidden.
If no area effect is active, or if you pass "target", a target will appear and only 
the targetted char will be hidden.
Passing no paramteres will toggle the charcater's hiding staus between permahidden/unhidden
\todo make this function work when commands are done in sources
*/
public cmd_hide(const chr)
{
	new target = true;
	new mode = 2; //0:skill 1:spell 2:perma
	new action = -1; //1:on 0:off -1:toggle
	
	//TODO:set parameters properly
	new area = chr_getCmdArea(chr);
	
	//apply command to all characters in area
	if(area_isValid(area) && !target)
	{	//swich on action: toggle, unhide, hide
		switch(action)
		{
			case -1: //toggle, TODO: have a chr_isHidden(chr) function
			{
				break;
				/*for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
				{
					chr2 = set_getChar(area_chars(area));
					if(chr2 != chr) 
						if(chr_isHidden(chr))
							chr_permahide(chr);
						else chr_unhide(chr);
				}*/	
			}
		
			case 0: //unhide
			{
				for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
				{
					chr2 = set_getChar(area_chars(area));
					if(chr2 != chr) chr_unhide(chr);
				}	
			}
			
			case 1: //hide
			{
				for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
				{
					chr2 = set_getChar(area_chars(area));
					switch(mode)
					{
						case 0: //hide by skill
							if(chr2 != chr) chr_hide(chr,1);
						case 1: //hide by spell
							if(chr2 != chr) chr_hide(chr,2);
						case 2: //permanently hidden
							if(chr2 != chr) chr_permahide(chr);
					}		
				}	
			}
		}	
		area_useCommand(area);			
		return;
	}

	switch(action)
	{
		case -1: chr_message(chr,_,"Select a character to toggle hiding action ");
		case 0: chr_message(chr,_,"Select a character to unhide");
		case 1: chr_message(chr,_,"Select a character to hide");
	}
	
	target_create(chr,action,mode,_,"cmd_kill_targ");
}

/*!
\author Fax
\fn cmd_hide_targ(target, chr, object, x, y, z, unused, action)
\params all standard target callback params
\brief handles single character targetting and hiding
*/
public cmd_hide_targ(target, chr, object, x, y, z, unused, action)
{
	if(isChar(object))
	{
		switch(action)
		{
			case -1: //toggle, TODO: have a chr_isHidden(chr) function
				break;
		
			case 0: //unhide
				chr_unhide(object);
			
			case 1: //hide
				switch(mode)
					{
						case 0: //hide by skill
							chr_hide(object,1);
						case 1: //hide by spell
							chr_hide(object,2);
						case 2: //permanently hidden
							chr_permahide(object);
					}		
		}		
	}
	else chr_message(chr,_,"You must target a character");
}