/*!
\defgroup script_command_wipe 'wipe
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_wipe
\brief wipes items or characters or both

<B>syntax:<B> 'wipe ["rect"/"target"]

If area effect is active, all objects included in area will be removed.
If no area effect is active, or if you pass "target", a target will appear and only the targetted
object will be removed
If you pass "rect" as parameter, then you will be asked to target 2 map locations wich will be
the corners of a rectangular area that will be wiped.
*/
public cmd_wipe(const chr)
{
	readCommandParams(chr);

	if(!strcmp(__cmdParams[0],"rect"))
	{
		getRectangle(chr,"cmd_wipe_rect");
		return;
	}

	new area = chr_getCmdArea(chr)


	//if character activated a command area
	if(area_isValid(area))
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

public cmd_wipe_rect(chr,x0,y0,x1,y1)
{
	#if _CMD_DEBUG_
		log_message("^t->deleting items in rectangle %d %d %d %d",x0,y0,x1,y1);
	#endif

	new s = set_create();
	new x,y;
	for(x = x0; x <= x1; x++)
		for(y = y0; y <= y1; y++)
			set_addItemsNearXY(s,x,y,1);

	new itm;
	for(set_rewind(s);!set_end(s);)
	{
		itm = set_getItem(s);
		itm_remove(itm);

		#if _CMD_DEBUG_
			log_message("^t->item %d removed",itm);
		#endif

	}
	chr_message(chr,_,"Items removed");
}
/*! }@ */