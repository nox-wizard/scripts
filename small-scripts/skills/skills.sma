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
//cooking
#include "small-scripts/skills/cooking.sma"
//Meditation
#include "small-scripts/skills/meditation.sma"
//taming
#include "small-scripts/skills/taming.sma"
//fishing
#include "small-scripts/skills/fishing.sma"
//hiding
#include "small-scripts/skills/hiding.sma"
//detect hidden
#include "small-scripts/skills/detecthidden.sma"



/**********************************************************************************************
 FUNCTION : __nxw_sk_main
 AUTHOR   : Luxor
 *********************************************************************************************/
public __nxw_sk_main(const cc, const skill_num)
{
	if ( skill_num < 0 ) return;
	
	if ( !chr_isGM( cc ) && chr_getProperty(cc, CP_SKILLDELAY) > getCurrentTime() ) {
		chr_message( cc, _, "You must wait a few moments before using another skill.");
		return;
	}
	if (chr_getProperty(cc, CP_DEAD) == 1) {
		chr_message( cc, _, "You cannot do that as a ghost.");
		return;
	}

	switch (skill_num)
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
		case SK_TAMING:
		        __nxw_sk_taming(cc);
		case SK_HIDING:
			__nxw_sk_hiding(cc);
		case SK_DETECTINGHIDDEN:
		        __nxw_sk_dtchidden(cc);
		default:
			return;
	}
}
