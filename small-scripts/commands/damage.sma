/*!
\defgroup script_command_freeze 'freeze
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_freeze(const chr)
\brief freezes a character

<B>syntax:<B> 'damage [amount]["hp"/"stam"/"mana"]
<B>command params:</B>
<UL>
<LI> amount: hoe much damage you want to do
	<UL>
	<LI> "hp": decrease HP (default)
	<LI> "stam": decrease stamina
	<LI> "mana": decrease mana
	</UL>

</UL>

If area effect is active, all characters in area will be damaged.
If no area effect is active, or if you pass "target", a target will appear and only 
the targetted char will be damaged.
*/
public cmd_damage(const chr)
{
	readCommandParams(chr);

	new stat = 0;
	new amount = STAT_HP;

	//parameters handling, if no parameters are given, keep defaults, else
	//read them

	if(!isStrInt(__cmdParams[0]))
	{
		chr_message(chr,_,"You must specify the amount of damage to do");
		return;
	}

	amount = str2Int(__cmdParams[0]);
	if(!strcmp(__cmdParams[1],"stam"))
		stat = STAT_STAMINA;
	else 	if(!strcmp(__cmdParams[1],"mana"))
			stat = STAT_MANA;
		else if(strcmp(__cmdParams[1],"hp"))
		{
			chr_message(chr,_,"You must specify the stat to be damaged: hp stam or mana");
			return;
		}


	new area = chr_getCmdArea(chr);
	new chr2,i = 0;
	//apply command to all characters in area if an area is defined
	if(area_isValid(area))
	{
		area_useCommand(area);
		for(set_rewind(area_chars(area)); !set_end(area_chars(area)); i++)
		{
				chr2 = set_getChar(area_chars(area));
				if(chr2 != chr) 
					chr_applyDamage(chr2,amount,DAMAGE_PURE,stat);
		}

		chr_message(chr,_,"%d characters damaged",i);

		return;
	}

	//if we are here it means we need a target
	chr_setLocalIntVar(chr,CLV_CMDTEMP,stat);
	chr_message(chr,_,"Select a character to damage");
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
		chr_applyDamage(object,damage,DAMAGE_PURE,chr_getLocalIntVar(chr,CLV_CMDTEMP));
	else chr_message(chr,_,"You must target a character");
}

/*! }@ */