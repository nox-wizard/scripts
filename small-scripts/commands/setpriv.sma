/*!
\defgroup script_command_setpriv 'setpriv
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_setpriv(const chr)
\brief sets the privlevel of a character

<B>syntax:<B> 'setpriv [priv]["target"]
<B>command params:</B>
<UL>
	<UL>
	<LI> priv: the priv value
	</UL>
<LI> "target": pass this parameter if you want to bypass the area effect
</UL>

If area effect is active, all characters in area will be set the privlevel.
If no area effect is active, or if you pass "target", a target will appear and only 
the targetted char will be affected
*/
public cmd_setpriv(const chr)
{
	new target = false;
	new priv = PRIV_PLAYER;
	
	//parameters handling, if no parameters are given, keep defaults, else
	//read them
	if(!strlen(__cmdParams[0]))
	{
		chr_message(chr,_,"You must enter the privlevel to set");
		return;
	}
	
	if(!isStrInt(__cmdParams[0]))
	{
		chr_message(chr,_,"privlevel must be number");
		return;
	}
	
	priv = str2Int(__cmdParams[0]);
	if(!strcmp(__cmdParams[1],"target"))
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
				if(chr2 != chr) chr_setLocalIntVar(chr2,CLV_PRIVLEVEL,priv);
		}

		chr_message(chr,_,"Privlevel set to %d characters ",i);		
		return;
	}

	//if we are here it means we need a target
	chr_message(chr,_,"Select a character");
	target_create(chr,priv,_,_,"cmd_setpriv_targ");
}

/*!
\author Fax
\fn cmd_setpriv_targ(target, chr, object, x, y, z, unused, freeze)
\params all standard target callback params
\brief handles single character targetting
*/
public cmd_setpriv_targ(target, chr, object, x, y, z, unused, priv)
{
	if(isChar(object))
	{
		chr_setLocalIntVar(object,CLV_PRIVLEVEL,priv);
		chr_message(chr,_,"Privlevel set to %d",chr_getLocalIntVar(object,CLV_PRIVLEVEL));
		chr_message(object,_,"Your privlevel has been modified,now it's %d",chr_getLocalIntVar(object,CLV_PRIVLEVEL));
		log_message("Charcter %d privlevel changed, now it's %d",object,chr_getLocalIntVar(object,CLV_PRIVLEVEL));
	}
	else chr_message(chr,_,"You must target a character");
}

/*! }@ */