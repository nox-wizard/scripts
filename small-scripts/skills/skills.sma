// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts (override.sma/amx)                               ||
// || Created by Luxor                                                    ||
// || Last Update 2002-09-13                                              ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This files contains NoX-Wizard skills handling functions            ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

//extended skillsystem
#include "small-scripts/skills/extendedSkillsystem.sma"
//Anatomy
#include "small-scripts/skills/anatomy.sma"
//Evaluating Intelligence
#include "small-scripts/skills/evalint.sma"
//Inscription
#include "small-scripts/skills/inscription.sma"
//Lumberjacking
#include "small-scripts/skills/lumberjacking.sma"
//Mining
#include "small-scripts/skills/mining.sma"
//Tailoring
#include "small-scripts/skills/tailoring.sma"
//Tannering
#include "small-scripts/skills/tannering.sma"
//Taste Identification
#include "small-scripts/skills/tasteid.sma"
//Tracking
#include "small-scripts/skills/tracking.sma"
//cooking
#include "small-scripts/skills/cooking.sma"
//Meditation
#include "small-scripts/skills/meditation.sma"
//taming
#include "small-scripts/skills/taming.sma"
//fishing
#include "small-scripts/skills/fishing.sma"
//Alchemy
#include "small-scripts/skills/alchemy.sma"
//hiding
#include "small-scripts/skills/hiding.sma"
//detect hidden
#include "small-scripts/skills/detecthidden.sma"


/*!
\author: Luxor, modified by someone else
\fn __nxw_sk_main(const chr, const skill_num)
\param chr: the character who is using the skill
\param skill_num: the skill used, one of the SK_* constants
\brief Handles skill usage

This function is called by the engine every time a skill is used by clicking
the blue button on the skills gump.<br>
This means that only those skills can be managed 
\todo test when the source has been fixed
*/
public __nxw_sk_main(const chr, const skill_num)
{
	#if _SKILLS_DEBUG_
		printf("DEBUG: Skill use detected - character %d - skill %d^n",chr,skill_num);
	#endif
	
	if ( skill_num < 0 ) return;
	
	if ( !chr_isGM( chr ) && chr_getProperty(chr, CP_SKILLDELAY) > getCurrentTime() ) 
	{
		chr_message( chr, _, msg_sk_mainDef[0]);
		return;
	}
	
	if (chr_getProperty(chr, CP_DEAD) == 1) 
	{
		chr_message( chr, _, msg_sk_mainDef[1]);
		return;
	}
	
	#if _SKILLS_DEBUG_
		printf("^tCalling function %s^n",__skillFunctions[skill_num]);
	#endif
	
	if(funcidx(__skillFunctions[skill_num]) >= 0)
	{
		callFunction1P(funcidx(__skillFunctions[skill_num]),chr);
		bypass();
	}
}

public __nxw_sk_animalLore(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_itemId(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_armsLore(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_begging(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_peace(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_camping(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_cartography(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_cooking(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_enticement(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_healing(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_forensic(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_herding(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_provocat(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_lockpick(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_magery(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_magicRes(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_tactics(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_snooping(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_musician(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_poisoning(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_archery(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_spiritSp(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_stealing(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_tinkering(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_veterinary(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_sword(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_mace(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_fencing(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_wrestling(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_lumberjack(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_meditation(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_stealth(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}

public __nxw_sk_removeTrap(const chr)
{
	chr_message(chr,_,msg_sk_mainDef[2]);
}