/*!
\defgroup script_command_jail 'jail
\ingroup script_commands

@{
*/

/*!
\author Fax(const chr)
\fn cmd_jail
\brief jails a character

<B>syntax:<B> 'jail [d][h][m]
<B>command params:</B>
<UL>
<LI> d: number of days the character will be jailed
<LI> h: number of hours the character will be jailed
<LI> m: number of minutes the character will be jailed
</UL>

the targetted character will be jailed,if you do not pass any parameters the character
will be jailed for ever (until someone unjails him).
*/
public cmd_jail(const chr)
{
	readCommandParams(chr);

	new secs = 0;

	if(isStrInt(__cmdParams[0]))
	{
		secs += str2Int(__cmdParams[0])*86400;
		if(isStrInt(__cmdParams[1]))
		{
			secs += str2Int(__cmdParams[1])*3600;
			if(isStrInt(__cmdParams[2]))
				secs += str2Int(__cmdParams[2])*60;
		}
	}
	else secs = 1000000000; //let's jail him forever ...

	chr_message(chr,_,msg_commandsDef[164]);
	target_create(chr,secs,_,_,"cmd_jail_targ");
}

/*!
\author Fax
\fn cmd_jail_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and jailing
*/
public cmd_jail_targ(target, chr, object, x, y, z, unused, secs)
{
	if(isChar(object))
		chr_jail(chr,object,secs);
	else chr_message(chr,_,msg_commandsDef[32]);
}

/*! }@ */