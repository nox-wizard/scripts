/*!
\defgroup script_command_hiding 'hiding
\ingroup script_commands

@{
*/

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
\todo make a chr_isHidden function
*/
public cmd_hiding(const chr)
{
	readCommandParams(chr);
	
	new target = false;
	new mode = 2; //0:skill 1:spell 2:perma
	new action = -1; //0:on 1:off 2:toggle
	
	if(!strlen(__cmdParams[0]))
	{
		chr_message(chr,_,"You must specify at least the first parameter (on,off,toggle), other params are optional");	
		return;
	}
	
	if(!strcmp(__cmdParams[0],"on"))
		action = 0;
	else 	if (!strcmp(__cmdParams[0],"off"))
			action = 1;	
		else 	if (!strcmp(__cmdParams[0],"toggle"))
				action = 2;
			else
			{
				chr_message(chr,_,"You must specify 'on','off' or 'toggle' as first parameter");	
				return;
			}	
	
	if(strlen(__cmdParams[1]))
	{
		if(!strcmp(__cmdParams[1],"skill"))
			mode = 0;
		else 	if (!strcmp(__cmdParams[1],"spell"))
				mode = 1;	
			else 	if (!strcmp(__cmdParams[1],"perma"))
					mode = 2;
	}
	
	if(!strcmp(__cmdParams[2],"target"))
		target = true;
		
	new area = chr_getCmdArea(chr);
	new i=0, chr2,txt[15];
	//apply command to all characters in area
	if(area_isValid(area) && !target)
	{	//swich on action: toggle, unhide, hide
		switch(action)
		{
			case 2: //toggle, TODO: have a chr_isHidden(chr) function
			{
				
				/*for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
				{
					chr2 = set_getChar(area_chars(area));
					if(chr2 != chr) 
						if(chr_isHidden(chr))
							chr_permahide(chr);
						else chr_unhide(chr);
				}*/	
			}
		
		
			case 1: //unhide
			{
				for(set_rewind(area_chars(area)); !set_end(area_chars(area)); )
				{
					chr2 = set_getChar(area_chars(area));
					if(chr2 != chr) 
					{
						i++
						if(chr_isPermahidden(chr2))
							chr_unpermahide(chr2);
						
						chr_setProperty(chr,CP_HIDDEN,_,0);
						chr_update(chr2);
					}					
				}
				sprintf(txt,"unhidden");	
			}
			
			case 0: //hide
			{
				for(set_rewind(area_chars(area)); !set_end(area_chars(area));)
				{
					chr2 = set_getChar(area_chars(area));
					if(chr2 != chr)
					{
						i++
						switch(mode)
						{
							case 0: //hide by skill
								chr_hide(chr2,1);
							case 1: //hide by spell
								chr_hide(chr2,2);
							case 2: //permanently hidden
								chr_permahide(chr2);
						}
					chr_update(chr2);
					}		
				}
				sprintf(txt,"hidden");	
			}
		}	
		
		chr_message(chr,_,"%d characters %s",i,txt);
		area_useCommand(area);			
		return;
	}

	switch(action)
	{
		case 2: chr_message(chr,_,"Select a character to toggle hiding satus");
		case 1: chr_message(chr,_,"Select a character to unhide");
		case 0: chr_message(chr,_,"Select a character to hide");
	}
	
	target_create(chr,10*action + mode,_,_,"cmd_hide_targ");
}

/*!
\author Fax
\fn cmd_hide_targ(target, chr, object, x, y, z, unused, action)
\params all standard target callback params
\brief handles single character targetting and hiding
*/
public cmd_hide_targ(target, chr, object, x, y, z, unused, param)
{
	new action = param/10;
	new mode = param%10;
	
	if(isChar(object))
	{
		switch(action)
		{
			case 2: //toggle, TODO: have a chr_isHidden(chr) function
				{ }
		
			case 1: //unhide
				{
					if(chr_isPermahidden(object))
						chr_unpermahide(object);
					
					chr_setProperty(chr,CP_HIDDEN,_,0);
					chr_message(chr,_,"Character unhidden");
				}
			
			case 0: //hide
				{
				switch(mode)
					{
						case 0: //hide by skill
							chr_hide(object,1);
						case 1: //hide by spell
							chr_hide(object,2);
						case 2: //permanently hidden
							chr_permahide(object);
					}
				chr_message(chr,_,"Character hidden");
				}		
		}
		
	chr_update(object);		
	}
	
	else chr_message(chr,_,"You must target a character");
}

/*! }@ */