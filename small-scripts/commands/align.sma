/*!
\defgroup script_command_align 'align
\ingroup script_commands

\brief alignes an object to another

\b syntax: 'align x/y/z
- x/y/z: the coordinate you want to align 

This command does not support command areas.\n

Character is prompted to target something wich will be taken as reference.\n
Then it will be prompted to target an object tah will be aligned to the reference,
the reference can be an object or a map location

@{
*/

/*!
\author Fax
\fn cmd_align(const chr)
\param chr: the character who used the command
\since 0.82
\brief 'align command start function

This function is called by sources on 'align command detection.\n
You can change it in commands.txt.
*/
public cmd_align(const chr)
{
	readCommandParams(chr);
	
	//param is mandatory
	if(!strlen(__cmdParams[0]))
	{
		chr_message(chr,_,msg_commandsDef[81]);
		return;
	}
	
	//parse param
	new d = 0;
	switch(__cmdParams[0][0])
	{
		case 'x': d = CP2_X;
		case 'y': d = CP2_Y;
		case 'z': d = CP2_Z;
		default:
		{
			chr_message(chr,_,msg_commandsDef[82]);
			return;
		}
	}

	chr_message(chr,_,msg_commandsDef[83]);
	target_create(chr,d,_,_,"cmd_align_targ_ref");
}

/*!
\author Fax
\since 0.82
\fn cmd_align_targ_ref(target, chr, object, x, y, z, unused, dir)
\params all standard target callback params
\brief handles first targetting in 'move command with no params

The forst targetted object is the reference
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
				chr_message(chr,_,msg_commandsDef[84]);
				return;
			}
		}

	chr_message(chr,_,msg_commandsDef[85]);
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
			case CP2_X: newx = pos;
			case CP2_Y: newy = pos;
			case CP2_Z: newz = pos;
		}
		itm_moveTo(object,newx,newy,newz);

	}
	else if(isChar(object))
		{
			chr_getPosition(object,newx,newy,newz);
			switch(dir)
			{
				case CP2_X: newx = pos;
				case CP2_Y: newy = pos;
				case CP2_Z: newz = pos;
			}
			chr_moveTo(object,newx,newy,newz);
		}
		else
		{
			chr_message(chr,_,msg_commandsDef[86]);
			return;
		}

	chr_message(chr,_,msg_commandsDef[87],newx,newy,newz);
}

/*! }@ */