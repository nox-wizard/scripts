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
<LI> value: teh skill value
</UL>

if no params are given the setskill menu is opened
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
			value =str2Int(__cmdParams[1]);
			skillValue = (skill << 16) + value;
		}
	
	chr_message(caller, _, "Select character.. "); 
	target_create( caller,skillValue , _, _, "target_setskills");
}

public target_setskills( const target, const caller, const chr,x,y,z,unused,skillValue)
{
	if(!isChar(chr)) 
	{
		chr_message(caller,_ , "Skills work only on character" );
		return;
	}
	
	//opengump if no params are given
	if(skillValue == INVALID)
	{
		//menu_skills_char( caller, chr, true );
		chr_message(caller,_,"Sorry, due to a little bug the 'setskills gump is not available, use 'setskills <skill> <value> instead");
		return;
	}
	
	new skill = skillValue >> 16;
	new value = skillValue & 0xFFFF;
	
	chr_setSkill(chr,skill,value);
}
/*! }@ */