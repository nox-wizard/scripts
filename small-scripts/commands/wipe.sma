/*!
\defgroup script_command_wipe 'wipe
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_wipe
\brief wipes items or characters or both

<B>syntax:<B> 'wipe ["target"]
<B>command params:</B>
<UL>
<LI> needed only if area effect is active:
	<UL>
	<LI> "target": wipe targetted object  
	</UL>
</UL>

If area effect is active, all objects included in area will be removed.
If no area effect is active, or if you pass "target", a target will appear and only the targetted
object will be removed
\todo make this function work when commands are done in sources
*/
public cmd_wipe(const chr)
{	
	
	new area = chr_getCmdArea(chr)
	new target = false;
	
	if(!strcmp(__cmdParams[0],"target"))
		target = true;
	
	//if character activated a command area
	if(area_isValid(area) && !target)
	{	
		//wipe items if required
		new i = 0;
		if(area_itemsIncluded(area))
			for(set_rewind(area_items(area)); !set_end(area_items(area));i++)
			{
				new itm = set_getItem(area_items(area));
				itm_remove(itm);
				#if _CMD_DEBUG_
					printf("^titem %d removed^n",itm);
				#endif	
			}
			
		//wipe chars if required
		if(area_charsIncluded(area))
			for(set_rewind(area_chars(area)); !set_end(area_chars(area));i++)
			{
				new chr2 = set_getChar(area_chars(area));
				if(chr_isNpc(chr2)) chr_remove(chr2);
				#if _CMD_DEBUG_
					printf("^tcharacter %d removed^n",chr2);
				#endif	
			}
		
		chr_message(chr,_,"%d objects removed",i);
		area_refresh(area);
		area_useCommand(area);
		return;	
	}

//do a single object wipe
chr_message(chr,_,"Select an object to wipe");
target_create(chr,area,_,_,"cmd_wipe_targ");
}

/*!
\author Fax
\fn cmd_wipe_targ(target, chr, object, x, y, z)
\params all standard target callback params
\brief handles single object targetting and wiping
*/
public cmd_wipe_targ(target, chr, object, x, y, z, unused, area)
{
	//remove object and print messages
	if(isItem(object))
		itm_remove(object);
	else 	if(isChar(object))
			if(chr_isNpc(object))
				chr_remove(object);
			else 
			{	
				new s = set_create();
				new bp = chr_getBackpack(chr);
				set_addItemsInCont(s,bp);
				for(set_rewind(s);!set_end(s);)
					itm_remove(set_getItem(s));
				return; 
			}
		else { chr_message(chr,_,"You must target a removable object"); return; }
	chr_message(chr,_,"Object removed");
	
	area_refresh(area);
}

/*! }@ */