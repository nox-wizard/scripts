/*!
\defgroup script_commands_setmorexyz 'setmorexyz
\ingroup script_commands

@{
*/

/*!
\author fax + Horian
\fn cmd_setmorexyz(const chr)
\brief sets different setmorexyz properties of an item

<B>syntax:<B> 'setmorexyz x y z ["t"] 
<B>command params:</B>
<UL>
	<LI> x: more x
	<LI> y: more y
	<LI> z: more z
	<LI> "t": bypass the area effect and get a target
</UL>

Passing '_' means "keepold value" so:<br>
setmorexyz _ 23 _<br>
will set only morey and keep old morex and morez values.
*/

public cmd_setmorexyz(const chr)
{
	readCommandParams(chr);
	
	new more;
	new morex = str2Int(__cmdParams[0]);
	new morey = str2Int(__cmdParams[1]);
	new morez = str2Int(__cmdParams[2]);
	
	//these flags are true if we want tokeep the old value
	new keep_morex = __cmdParams[0][0] == '_';
	new keep_morey = __cmdParams[1][0] == '_';
	new keep_morez = __cmdParams[2][0] == '_';
	
	new area = chr_getCmdArea(chr);
	new i = 0, item;
	//apply command to all items in area
	if(area_isValid(area) && __cmdParams[3][0] != 't')
	{
		area_useCommand(area);
		for(set_rewind(area_items(area)); !set_end(area_items(area)); i++)
		{
			item = set_getItem(area_items(area));
			more = itm_getProperty(item,IP_MORE);
			
			//update the value only if it is different from '_'
			morex = keep_morex ? (more >> 16) & 0xFF : morex;
			morey = keep_morey ? (more >> 8) & 0xFF : morey;
			morez = keep_morez ? more & 0xFF : morez;
			
			more = (morex << 16) + (morey << 8) + morez;
			itm_setProperty(item,IP_MORE,_,more);
		}
		chr_message(chr,_,msg_commandsDef[160],__cmdParams[0],i);		
		return;
	}
		
	//store the parameters to set
	chr_setTempIntVec(chr,CLV_CMDTEMP,morex,morey,morez,keep_morex,keep_morey,keep_morez);
	
	chr_message(chr,_,msg_commandsDef[161],__cmdParams[0]);
	target_create(chr,_,_,_,"cmd_setmorexyz_targ");
}

/*!
\author Fax
\fn cmd_setdir_targ(target, chr, item, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and setdiring
*/
public cmd_setmorexyz_targ(target, chr, item, x, y, z, unused, unused1)
{
	new m[6]; 	//m[0] to m[2] -> morex,morey,morez
			//m[3] to m[5] -> keep_ flags
	new more;
	chr_getTempIntVec(chr,CLV_CMDTEMP,m);
	
	if(isItem(item))
	{
		more = itm_getProperty(item,IP_MORE);
			
		//update the value only if it is different from '_'
		m[0] = m[3] ? (more >> 16) & 0xFF : m[0];
		m[1] = m[4] ? (more >> 8) & 0xFF : m[1];
		m[2] = m[5] ? more & 0xFF : m[2];
		
		more = (m[0] << 16) + (m[1] << 8) + m[2];
		itm_setProperty(item,IP_MORE,_,more);
		
		itm_refresh(item);
		chr_message(chr,_,msg_commandsDef[279]);
	}
	else chr_message(chr,_,msg_commandsDef[2]);
}

/*! }@ */