/*!
\defgroup script_command_posttype 'posttype
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_posttype(const chr)
\brief posttypes a character

<B>syntax:<B> 'posttype type ["t"]
<B>command params:</B>
<UL>
<LI> type: the post type (0 local - 1 regional - 2 global)
<LI> "t": bypass command area and get a target
</UL>

If area effect is active, all characters in area will have post type set.
If no area effect is active, or if you pass "target", a target will appear and only 
the targetted char will be affected
*/
public cmd_posttype(const chr)
{
	readCommandParams(chr);

	new type = 0;
	
	if(!isStrInt(__cmdParams[0]))
	{
		chr_message(chr,_,"You must specify the type of post (0:local 1:regional 2:global)");
		return;
	}

	type = str2Int(__cmdParams[0]);
	
	new area = chr_getCmdArea(chr);
	new chr2,i = 0;
	//apply command to all characters in area if an area is defined
	if(area_isValid(area) && __cmdParams[1][0] != 't')
	{
		area_useCommand(area);
		for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
		{
				chr2 = set_getChar(area_chars(area));
				if(chr2 != chr) 
					chr_setPostType(chr2,type);
		}

		chr_message(chr,_,"%d characters affected",i);

		return;
	}

	//if we are here it means we need a target
	chr_message(chr,_,"Select a character to set post type");
	target_create(chr,type,_,_,"cmd_posttype_targ");
}

/*!
\author Fax
\fn cmd_posttype_targ(target, chr, object, x, y, z, unused, posttype)
\params all standard target callback params
\brief handles single character targetting and freezing
*/
public cmd_posttype_targ(target, chr, object, x, y, z, unused, posttype)
{
	if(isChar(object))
		chr_setPostType(object,posttype);
	else chr_message(chr,_,"You must target a character");
}

/*! }@ */