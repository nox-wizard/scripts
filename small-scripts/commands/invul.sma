/*!
\author Fax
\fn cmd_invul
\brief makes a character vulnerable or invulnerable

<B>syntax:<B> 'invul ["on"/"off"] ["target"]
<B>command params:</B>
<UL>
<LI> 
	<UL>
	<LI> "on": make invulnerable (default)
	<LI> "off": make vulnerable
	</UL>
<LI> "target" pass this paramter if you want to bypass the area effect 
</UL>

If area effect is active, all characters in area will be affec.
If no area effect is active, or if you pass "target", a target will appear and only 
the targetted char will be affected.
*/
public cmd_invul(const chr)
{
	new makeinvul = false;
	new target = false;
	
	if(!strlen(__cmdParams[0]))
	{
		chr_message(chr,_,"You must specify on or off");
		return;
	}
	
	if(!strcmp(__cmdParams[0],"on"))
		makeinvul = true;
	else if(strcmp(__cmdParams[0],"off"))
		{
			chr_message(chr,_,"You must specify 'on' 'off' or 'target' as first parameter");
			return;	
		}

	if(!strcmp(__cmdParams[1],"target"))
		target = true;
	
	
	//apply command to all characters in area
	new area = chr_getCmdArea(chr)
	if(area_isValid(area) && !target)
	{
		new i,chr2;
		if(makeinvul)
		{
			for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
			{
					chr2 = set_getChar(area_chars(area));
					if(chr2 != chr) chr_makeInvul(chr2);
			}
			chr_message(chr,_,"%d characters invulnerabilized",i);
		}		
		else 
		{
			for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
			{
					chr2 = set_getChar(area_chars(area));
					if(chr2 != chr) chr_makeVulnerable(chr2);
			}
			chr_message(chr,_,"%d characters vulnerabilized",i);
		}
		
		area_useCommand(area);				
		return;
	}

	chr_message(chr,_,"Choose a character");
	target_create(chr,makeinvul,_,_,"cmd_invul_targ");	
}

/*!
\author Fax
\fn cmd_invul_targ(target, chr, object, x, y, z, unused, makeinvul)
\params all standard target callback params
\brief handles single character targetting and sets invulnerability
*/
public cmd_invul_targ(target, chr, object, x, y, z, unused, makeinvul)
{
	if(isChar(object))
		if(makeinvul)
			chr_makeInvul(object);
		else chr_makeVulnerable(object);
	else chr_message(chr,_,"You must target a character");		
}