#include "small-scripts/commands/skills/skillsmenu.sma"

/*!
\defgroup script_command_setskills 'setskills
\ingroup script_commands

@{
*/
/*!
\author Fax
\fn
\param chr: the character
\since 0.82
\brief sets character's skills
<b>syntax</b> 'setskills [skill][value]
<UL>
<LI> skill: the skill to be set
<LI> value: the skill value
</UL>

if no params are given the setskill menu is opened.<br>
If skill is greater then the number of available skills then all skills will be set to "value"
\return nothing
*/
public cmd_setskills( const caller )
{
	readCommandParams(caller);
	
	new skill = INVALID, value = INVALID, skillValue = INVALID;
	
	if(strlen(__cmdParams[0]) || strlen(__cmdParams[1]))
		if(!isStrInt(__cmdParams[0]) || !isStrInt(__cmdParams[1]))
		{
			chr_message(caller,_,"You must give the skill and value as integers");
			return;
		}
		else
		{
			skill = str2Int(__cmdParams[0]);
			value = str2Int(__cmdParams[1]);
			
			if(skill < 0 || value < 0)
			{
				chr_message(caller,_,"skill and value must be positive");
				return;
			}
			skillValue = (skill << 16) + value;
		}
	
	chr_message(caller, _, "Select character.. "); 
	target_create( caller,skillValue , _, _, "target_setskills");
}

public target_setskills( const target, const caller, const chr,x,y,z,unused,skillValue)
{
	if(!isChar(chr)) 
	{
		chr_message(caller,_ , "You must target a character" );
		return;
	}
	
	//opengump if no params are given
	if(skillValue == INVALID)
	{
		menu_skills_char( caller, chr, true );
		return;
	}
	
	new skill = skillValue >> 16;
	new value = skillValue & 0xFFFF;
	
	//if skill Z SK_COUNT set all skills to value
	if(skill < SK_COUNT)
		chr_setSkill(chr,skill,value);
	for(new sk; sk < SK_COUNT; sk++)
		chr_setSkill(chr,sk,value);
}
/*! }@ */