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
	
	broadcast("World will be saved in %d seconds",timeout);
	
	if(timeout < 10)
		tempfx_activate(_,chr,chr,0,timeout,funcidx("cmd_save_cback")); //means instant worldsave after <timeout> seconds
	else
		tempfx_activate(_,chr,chr,timeout - 10,10,funcidx("cmd_save_cback")); //means worldsave check after 10 seconds
}

public cmd_save_cback(const chr1, const chr2, const timeout, const mode)
{
	if(mode != TFXM_END) return;
	
	if(!timeout) //timeout is now 0 or lower
	{
		new time = getCurrentTime();
		world_save()
		time = getCurrentTime() - time;
		log_message("Save time: %dms",time);
		chr_message(chr1,_,"Save time: %dms",time);
		return;
	}
	
	broadcast("World will be saved in %d seconds",timeout);
	
	if(timeout < 10)
		tempfx_activate(_,chr1,chr1,0,timeout,funcidx("cmd_save_cback")); //next cycle
	else
		tempfx_activate(_,chr1,chr1,timeout - 10,10,funcidx("cmd_save_cback"));
}
/*! @}*/