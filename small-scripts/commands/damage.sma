/*!
\defgroup script_command_damage 'damage
\ingroup script_commands
\brief damages a character

\b syntax:'damage amount stat ["t"]
- amount: how much damage you want to do
- stat: the stat to damage
	
	-# "hp": decrease HP (default)
	-# "stam": decrease stamina
	-# "mana": decrease mana
	
- "t": bypass command area and get a target

If area effect is active, all characters in area will be damaged.

@{
*/

/*!
\author Fax
\fn cmd_damage(const chr)
\param chr: the character who used the command
\since 0.82
\brief 'damage command start function

This function is called by sources on 'damage command detection.\n
You can change it in commands.txt.

*/
public cmd_damage(const chr)
{
	readCommandParams(chr);

	new stat = STAT_HP;
	new amount = 0;

	//parameters handling, if no parameters are given, keep defaults, else
	//read them

	if(!isStrInt(__cmdParams[0]))
	{
		chr_message(chr,_,msg_commandsDef[112]);
		return;
	}

	amount = str2Int(__cmdParams[0]);
	if(!strcmp(__cmdParams[1],"stam"))
		stat = STAT_STAMINA;
	else 	if(!strcmp(__cmdParams[1],"mana"))
			stat = STAT_MANA;
		else if(strcmp(__cmdParams[1],"hp"))
		{
			chr_message(chr,_,msg_commandsDef[113]);
			return;
		}


	new area = chr_getCmdArea(chr);
	new chr2,i = 0;
	//apply command to all characters in area if an area is defined
	if(area_isValid(area) && __cmdParams[2][0] != 't')
	{
		area_useCommand(area);
		for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
		{
				chr2 = set_getChar(area_chars(area));
				if(chr2 != chr) 
					chr_applyDamage(chr2,amount,DAMAGE_PURE,stat);
		}

		chr_message(chr,_,msg_commandsDef[114],i);

		return;
	}

	//if we are here it means we need a target
	chr_addLocalIntVar(chr,CLV_CMDTEMP,stat);
	chr_message(chr,_,msg_commandsDef[115]);
	target_create(chr,amount,_,_,"cmd_damage_targ");
}

/*!
\author Fax
\fn cmd_damage_targ(target, chr, object, x, y, z, unused, damage)
\params all standard target callback params
\brief handles single character targetting and freezing
*/
public cmd_damage_targ(target, chr, object, x, y, z, unused, damage)
{
	if(isChar(object))
	{
		chr_applyDamage(object,damage,DAMAGE_PURE,chr_getLocalIntVar(chr,CLV_CMDTEMP));
		chr_delLocalVar(chr,CLV_CMDTEMP);
	}
	else chr_message(chr,_,msg_commandsDef[31]);
}

/*! }@ */