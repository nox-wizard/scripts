/*!
\author Fax
\fn cmd_wipe
\brief wipes items or characters or both

<B>syntax:<B> 'wipe ["itm"/"chr"/"target"]
<B>command params:</B>
<UL>
<LI> needed only if area effect is active:
	<UL>
	<LI> "itm": wipe items only
	<LI> "chr": wipe chr only
	<LI> "target": wipe item 
	<LI>  empty: wipe everythig
	</UL>
</UL>

If area effect is active, all objects in area will be removed.
If no area effect is active, or if you pass "target", a target will appear and only the targetted
object will be removed
\todo make this function work when commands are done in sources
*/
public cmd_wipe(const chr)
{	
	//TODO: set "target" properly
	new area = chr_getCmdArea(chr)
	new target = true;
	
	//if character activated a command area
	if(area_isValid(area) && !target)
	{
		new what = INCLUDE_ALL;
		
		//set "what" properly depending on params, 0 means "target"
		
		//wipe items if required
		if(area_include(area) & INCLUDE_CHR)
			for(set_rewind(area_items(area)); !set_end(area_items(area));)
			{
				new itm = set_getItem(area_items(area));
				itm_remove(itm);	
			}
			
		//wipe chars if required
		if(area_include(area) & INCLUDE_ITM)
			for(set_rewind(area_chars(area)); !set_end(area_chars(area));)
			{
				new chr2 = set_getChar(area_chars(area));
				if(chr_isNpc(chr2)) chr_remove(chr);	
			}
		
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
public cmd_wipe_targ(target, chr, object, x, y, z)
{
	//remove object and print messages
	if(isItem(object))
		itm_remove(object);
	else 	if(isChar(object))
			if(chr_isNpc(object)
				chr_remove(object);
			else { chr_message(chr,_,"You can't remove a player!"); return; }
		else { chr_message(chr,_,"You must target a removable object"); return; }
	chr_message(chr,_,"Object removed");
	
	area_refresh(area);
}