/*!
\defgroup script_command_setpriv 'setpriv
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_setpriv(const chr)
\brief sets the privlevel of a character

<B>syntax:<B> 'setpriv [priv]["t"]
<B>command params:</B>
<UL>
	<UL>
	<LI> priv: the priv value
	</UL>
<LI> "target": pass this parameter if you want to bypass the area effect
</UL>

If area effect is active, all characters in area will be set the privlevel.
*/
public cmd_setpriv(const chr)
{
	readCommandParams(chr);

	new priv = PRIV_PLAYER;

	//parameters handling, if no parameters are given, keep defaults, else
	//read them
	if(!strlen(__cmdParams[0]))
	{
		chr_message(chr,_,msg_commandsDef[236]);
		return;
	}

	if(!isStrInt(__cmdParams[0]))
	{
		chr_message(chr,_,msg_commandsDef[237]);
		return;
	}

	priv = str2Int(__cmdParams[0]);


	new area = chr_getCmdArea(chr);
	new chr2,i = 0;
	//apply command to all characters in area if an area is defined
	if(area_isValid(area) && __cmdParams[1][0] != 't')
	{
		area_useCommand(area);

		for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
		{
				chr2 = set_getChar(area_chars(area));
				if(chr2 != chr) chr_setProperty(chr2,CP_PRIVLEVEL,_,priv);
		}

		chr_message(chr,_,msg_commandsDef[238],i);
		return;
	}

	//if we are here it means we need a target
	chr_message(chr,_,msg_commandsDef[239]);
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
		chr_setProperty(object,CP_PRIVLEVEL,_,priv);
		chr_message(chr,_,msg_commandsDef[240],chr_getProperty(object,CP_PRIVLEVEL));
		chr_message(object,_,msg_commandsDef[241],chr_getProperty(object,CP_PRIVLEVEL));
	}
	else chr_message(chr,_,msg_commandsDef[32]);
}

/*! }@ */