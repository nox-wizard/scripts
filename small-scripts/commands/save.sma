/*!
\defgroup script_commands_save 'save
\ingroup script_commands

@{
*/

/*!
\author Fax
\since 0.82
\fn cmd_save(const chr)
\brief saves the world

<b> syntax: </b> 'save

*/
public cmd_save(const chr)
{
	readCommandParams(chr);
	
	new timeout = 1;
	if(isStrInt(__cmdParams[0]))
		timeout = str2Int(__cmdParams[0]);
	
	if(timeout > 1)
		broadcast("World will be saved in %d seconds",timeout);
	tempfx_activate(_,chr,chr,0,timeout,funcidx("cmd_save_cback"));
}

public cmd_save_cback(const chr1, const chr2, const power, const mode)
{
	if(mode != TFXM_END) return;

	world_save();
}
/*! @}*/