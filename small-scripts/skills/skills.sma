// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts (override.sma/amx)                               ||
// || Created by Luxor                                                    ||
// || Last Update 2002-09-13                                              ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This files contains NoX-Wizard skills handling functions            ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


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



/**********************************************************************************************
 FUNCTION : __nxw_sk_main
 AUTHOR   : Luxor
 *********************************************************************************************/
public __nxw_sk_main(const s, const skill_num)
{
	if ( !isValidSocket( s ) || skill_num < 0 ) return;

	new cc = getCharFromSocket(s)
	
	if ( !chr_isGM( cc ) && chr_getProperty(cc, CP_SKILLDELAY) > getCurrentTime() ) {
		ntprintf(s, "You must wait a few moments before using another skill.");
		return;
	}
	if (chr_getProperty(cc, CP_DEAD) == 1) {
		ntprintf(s, "You cannot do that as a ghost.");
		return;
	}

	switch (skill_num)
	{
		case SK_ANATOMY:
			__nxw_sk_anatomy(s);
		case SK_EVALUATINGINTEL:
			__nxw_sk_evint(s);
		case SK_INSCRIPTION:
			__nxw_sk_inscript(s);
		case SK_TASTEID:
			__nxw_sk_tasteid(s);
		case SK_TRACKING:
			__nxw_sk_tracking(s);
		default:
			return;
	}
}
