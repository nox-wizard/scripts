/*!
\defgroup script_command_summon 'summon
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_summon(const chr)
\brief summons objects

<B>syntax:<B> 'summon x y ["abs"/"rel"] or 'summon me or 'summon here or 'summon loc or 'summon here [name]

<B>command params:</B>
<UL>
<LI> me: if command is called as 'summon me, the character is teleported in a targetted location
When using this option no other parameters are needed.<br>
<LI> here: if command is called as 'summon here, the targetted character is teleported to the command user<br>
<LI> x: x summonment
<LI> y : y summonment
<LI> 
	<UL>
	<LI> "abs": x and y are intended as absolute (non-negative) coordinates, new position is x,y
	<LI> "rel": x and y are intended as relative summonment, new position is oldx + x, oldy + y (default)
	</UL> 
</UL>

this command supports command areas only in "rel" mode, in that case all items in the area are
summond to new positions.
If you don't pass any parameter, you will be prompted to target both the object to summon
and the destination
*/
public cmd_summon(const chr)
{
	readCommandParams(chr);

	if(strlen(__cmdParams[0]))
	{
		//handle multi word names (john smith the cool guy)
		for(new i = 1; i < __MAX_PARAMS; i++)
			if(strlen(__cmdParams[i]))
				sprintf(__cmdParams[0],"%s %s",__cmdParams[0],__cmdParams[i]);
				
		new chr2 = getOnlineCharFromName(__cmdParams[0]);
		
		if(!isChar(chr2))
		{
			chr_message(chr,_,msg_commandsDef[5],__cmdParams[0]);
			return;
		}
		
		new x,y,z;
		chr_getPosition(chr,x,y,z);
		chr_moveTo(chr2,x + 1,y,z);
	}
}
	

/*! }@ */