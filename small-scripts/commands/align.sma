/*!
\defgroup script_command_align 'align
\ingroup script_commands

@{
*/

/*!
\author Fax
\since 0.82
\fn cmd_align(const chr)
\brief alignes one object to another

<B>syntax:<B> 'align x/y/z

<B>command params:</B>
<UL>
<LI> x/y/z: the coordinate you want to align 
</UL>

This command does not support command areas
*/
public cmd_align(const chr)
{	
	if(!strlen(__cmdParams[0]))
		
	new dir = 0; //0:x 1:y 2:z
	
	switch(__cmdParams[0][0])
	{
		case 'x': dir = CP2_X;
		case 'y': dir = CP2_Y;
		case 'z': dir = CP2_Z;	
		default:
		{
			chr_message(chr,_,"Alignment direction MUST be x y or z");
			return;
		}
	}
	
	chr_message(chr,_,"Select reference item or character");
	target_create(chr,dir,_,_,"cmd_align_targ_ref");	
}

/*!
\author Fax
\since 0.82
\fn cmd_align_targ_ref(target, chr, object, x, y, z, unused, dir)
\params all standard target callback params
\brief handles first targetting in 'move command with no params
*/
public cmd_align_targ_ref(target, chr, object, x, y, z, unused, dir)
{
	new pos;
	
	if(isItem(object))
		pos = itm_getProperty(object,IP_POSITION,dir);
	else if(isChar(object))
		pos = chr_getProperty(object,CP_POSITION,dir);
	else
		switch(dir)
		{
			case CP2_X: pos = x;
			case CP2_Y: pos = y;
			case CP2_Z: pos = z;
			default:
			{
				log_error("Invalid value for variable dir in align.sma - dir = %d",dir);
				chr_message(chr,_,"An error occurred!");
				return;
			}
		}
	
	chr_message(chr,_,"Select the object to be moved");
	target_create(chr,dir*100000 + pos,_,_,"cmd_align_targ");
}

/*!
\author Fax
\fn cmd_align_targ(target, chr, object, x, y, z, unused, posAndDir)
\params all standard target callback params
\brief moves the selected object to the reference object's position
\since 0.82
*/
public cmd_align_targ(target, chr, object, x, y, z, unused, posAndDir)
{
	new dir = posAndDir/100000;
	new pos = posAndDir%100000;
	new newx,newy,newz;
		
	if(isItem(object))
	{
		itm_getPosition(object,newx,newy,newz);
		switch(dir)
		{
			case CP2_X: newx += pos;
			case CP2_Y: newy += pos;
			case CP2_Z: newz += pos;
		}
		itm_moveTo(object,newx,newy,newz);
	
	}
	else if(isChar(object))
	{
		chr_getPosition(object,newx,newy,newz);
		switch(dir)
		{
			case CP2_X: newx += pos;
			case CP2_Y: newy += pos;
			case CP2_Z: newz += pos;
		}
		chr_moveTo(object,newx,newy,newz);
	}
	else
	{
		chr_message(chr,_,"You must select an item or a character");
		return;
	}
	
	chr_message(chr,_,"Object moved to %d %d %d",newx,newy,newz);	
}

/*! }@ */