#include "small-scripts/commands/skills/skillsmenu.sma"

/*!
\defgroup script_command_skills 'skills
\ingroup script_commands

@{
*/
/*!
\author Fax
\fn
\param chr: the character
\since 0.82
\brief showscharacter's skills
<b>Syntax</b>: 'skills

\return nothing
*/
public cmd_skills(chr)
{
	menu_skills_char( chr, chr, false );
}

/*! }@ */
