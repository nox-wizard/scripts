/*!
\defgroup script_command_make 'make
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_make(const chr)
\brief makes a character GM, counselor or player

<B>syntax:<B> 'make ["gm"/"gmpageable"/"cns"/"player"]
<B>command params:</B>
<UL>
<LI> 
	<UL>
	<LI> "gm": make the charcater a GM
	<LI> "gmpageable":make the charcater a pageable GM
	<LI> "cns": make tha charcater a counselor (default)
	<LI> "player": make the character a player
	</UL> 
</UL>

Doesn't support command areas
*/
public cmd_make(const chr)
{
	readCommandParams(chr);

	new makewhat = 2;

	if(!strcmp(__cmdParams[0],"gm"))
		makewhat = 0;
	else 	if(!strcmp(__cmdParams[0],"cns"))
			makewhat = 1;
		else 	if(!strcmp(__cmdParams[0],"player"))
				makewhat = 2;
			else 	if(!strcmp(__cmdParams[0],"gmpageable"))
					makewhat = 3;
				else
				{
					chr_message(chr,_,msg_commandsDef[170]);
					return;
				}

	switch(makewhat)
	{
		case 0: chr_message(chr,_,msg_commandsDef[171]);
		case 1: chr_message(chr,_,msg_commandsDef[172]);
		case 2: chr_message(chr,_,msg_commandsDef[173]);
		case 3: chr_message(chr,_,msg_commandsDef[174]);
	}

target_create(chr,makewhat,_,_,"cmd_make_targ");
}

/*!
\author Fax
\fn cmd_make_targ(target, chr, object, x, y, z, unused, makewhat)
\params all standard target callback params
\brief handles targetting and sets the status
*/
public cmd_make_targ(target, chr, object, x, y, z, unused, makewhat)
{
	if(!isChar(object))
	{
		chr_message(chr,_,msg_commandsDef[32]);
		return;
	}

	switch(makewhat)
	{
		case 0: 
		{
			chr_makeGM(object);
			chr_setProperty(object,CP_PRIVLEVEL,_,PRIV_GM);
		}
		case 1:
		{ 
			chr_makeCounselor(object);
			chr_setProperty(object,CP_PRIVLEVEL,_,PRIV_CNS);
		}
		case 2: 
		{
			chr_makePlayer(object);
			chr_setProperty(object,CP_PRIVLEVEL,_,PRIV_PLAYER);
		}
		case 3: 
		{
			chr_makeGM(object);
			chr_makeGMPageable(object);
			chr_setProperty(object,CP_PRIVLEVEL,_,PRIV_GM);
		}
	}

	chr_message(chr,_,msg_commandsDef[175],chr_getProperty(object,CP_PRIVLEVEL));
}

/*! }@ */