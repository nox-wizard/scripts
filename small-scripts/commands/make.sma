/*!
\defgroup script_command_make 'make
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_make(const chr)
\brief makes a character GM, counselor or player

<B>syntax:<B> 'make ["GM"/"cns"/"player"]
<B>command params:</B>
<UL>
<LI> 
	<UL>
	<LI> "GM": make the charcater a GM
	<LI> "cns": make tha charcater a counselor (default)
	<LI> "player": make the character a player
	</UL> 
</UL>

Doesn't support command areas
*/
public cmd_make(const chr)
{
	new makewhat = 1;
	
	if(!strcmp(__cmdParams[0],"GM"))
		makewhat = 0;
	else 	if(!strcmp(__cmdParams[0],"cns"))
			makewhat = 0;
		else 	if(!strcmp(__cmdParams[0],"player"))
				makewhat = 0;
			else
			{
				chr_message(chr,_,"You must specify 'GM', 'cns' or 'player'");
				return;
			}
		
	switch(makewhat)
	{	
		case 0: chr_message(chr,_,"Choose a player to make GM");
		case 1: chr_message(chr,_,"Choose a player to make counselor");
		case 2: chr_message(chr,_,"Choose a GM or couselor to make player");
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
		chr_message(chr,_,"You must target a character");
		return;
	}	
	
	switch(makewhat)
	{	
		case 0: 
		{
			chr_makeGM(object);
			chr_setLocalIntVar(chr,CLV_PRIVLEVEL,PRIV_GM);
		}
		case 1:
		{ 
			chr_makeCounselor(object);
			chr_setLocalIntVar(chr,CLV_PRIVLEVEL,PRIV_CNS);
		}
		case 2: 
		{
			chr_makePlayer(object);
			chr_setLocalIntVar(chr,CLV_PRIVLEVEL,PRIV_PLAYER);
		}
	}
}

/*! }@ */