/*!
\defgroup script_command_lightlevel 'lightlevel
\ingroup script_commands

@{
*/

/*!
\author Fax(const chr)
\fn cmd_lightlevel
\brief sets the light level of the world

<B>syntax:<B> 'lightlevel [value] 
<B>command params:</B>
<UL>
<LI> value: the light level value 0 (brightest) to 15 (darkest) or -1 (day/night cycle)

</UL>

*/
public cmd_lightlevel(const chr)
{
	readCommandParams(chr);

	new level;

	if(!isStrInt(__cmdParams[0]))
	{
		chr_message(chr,_,"you must specify 0-15 or -1");
		return;
	}
	
	level = str2Int(__cmdParams[0]);
	
	setLightLevel(level);

}

/*! }@ */