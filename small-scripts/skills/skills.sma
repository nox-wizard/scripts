// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts (override.sma/amx)                               ||
// || Created by Luxor                                                    ||
// || Last Update 2002-09-13                                              ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This files contains NoX-Wizard skills handling functions            ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

/*!
\defgroup script_skills Skills
@{
*/

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



/*!
\fn __nxw_sk_main(const cc, const skill_num)
\author Luxor
\brief manages skill scripts calling

This function is called by the engine when one of the scripted skills is used by a player.
It works only for the skills with the blue button.
Checks for the skill delay and for dead characters.
The function called is stored in skillFunctions[][]
*/
public __nxw_sk_main(const cc, const skill_num)
{
	//check for valid skill number
	if ( skill_num < 0 ) return;

	//check for skill delay
	if ( !chr_isGM( cc ) && chr_getProperty(cc, CP_SKILLDELAY) > getCurrentTime() ) {
		chr_message( cc, _, "You must wait a few moments before using another skill.");
		return;
	}
	
	//check for dead characters
	if (chr_getProperty(cc, CP_DEAD) == 1) {
		chr_message( cc, _, "You cannot do that as a ghost.");
		return;
	}
	
	//read the function to call in skillFunctions[skill_num] and call it
	callFunction1P(funcidx(skillFunctions[skill_num]),cc);
	
	
	//old system: to restore it take out comments and comment out previous line
	/*switch (skill_num)
	{
		case SK_ANATOMY:
			__nxw_sk_anatomy(cc);
		case SK_EVALUATINGINTEL:
			__nxw_sk_evint(cc);
		case SK_INSCRIPTION:
			__nxw_sk_inscript(cc);
		case SK_TASTEID:
			__nxw_sk_tasteid(cc);
		case SK_TRACKING:
			__nxw_sk_tracking(cc);
		default:
			return;
	}*/
}

/*!  @}*/
