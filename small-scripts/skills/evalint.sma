// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts                                                  ||
// || Created by Luxor                                                    ||
// || Last Update 13-sep-2002                                             ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This file contains NoX-Wizard functions to support Ev. Intelligence ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

/**********************************************************************************************
 FUNCTION : __evintTarget
 AUTHOR   : Luxor
 *********************************************************************************************/
public __evintTarget(const s, const target, const item)
{
	if (s < 0) return;
	if (target < 0) {
		ntprintf(s, "Target invalid");
		return;
	}
	new cc = getCharFromSocket(s);
	if (cc == target) {
		ntprintf(s, "You cannot analize yourself!");
		return;
	}
	if (chr_distance(cc, target) >= 10) {
		ntprintf(s, "You need to be closer to find out more about them");
		return;
	}
	if (!chr_checkSkill(cc, SK_EVALUATINGINTEL, 0, 1000)) {
                ntprintf (s, "You are not certain..");
                return;
        }
	new int = chr_getInt(target);
	new intDes[60];
	if (int > 100) strunpack(intDes, "superhumanly intelligent in a manner you cannot comprehend");
	else {
		switch(int)
		{
			case 0..10:
				strunpack(intDes, "slightly less intelligent than a rock.");
			case 11..20:
				strunpack(intDes, "fairly stupid");
			case 21..30:
				strunpack(intDes, "not the brightest");
			case 31..40:
				strunpack(intDes, "about average");
			case 41..50:
				strunpack(intDes, "moderately intelligent");
			case 51..60:
				strunpack(intDes, "very intelligent");
			case 61..70:
				strunpack(intDes, "extraordinarily intelligent");
			case 71..80:
				strunpack(intDes, "like a formidable intellect, well beyond the ordinary");
			case 81..90:
				strunpack(intDes, "like a definite genius");
			case 91..100:
				strunpack(intDes, "superhumanly intelligent in a manner you cannot comprehend");
			default:
				strunpack(intDes, "of unknown intelligence");
		}
	}

	ntprintf(s, "That person looks %s.", intDes);

	if (chr_getSkill(cc, SK_EVALUATINGINTEL) < 950) return;

	new mana = chr_getMana(target);
	new prc = mana*100/int;

	switch(prc/10)
	{
		case 0:
			ntprintf(s, "He/She is completely tired [%d%%]", prc);
 		case 1:
			ntprintf(s, "He/She is extremely tired [%d%%]", prc);
		case 2:
			ntprintf(s, "He/She is very much tired [%d%%]", prc);
		case 3:
			ntprintf(s, "He/She is very tired [%d%%]", prc);
		case 4:
			ntprintf(s, "He/She is tired [%d%%]", prc);
		case 5:
			ntprintf(s, "He/She is slightly tired [%d%%]", prc);
		case 6:
			ntprintf(s, "He/She is not tired [%d%%]", prc);
		case 7:
			ntprintf(s, "He/She is slightly fresh [%d%%]", prc);
		case 8:
			ntprintf(s, "He/She is almost fresh [%d%%]", prc);
		case 9:
			ntprintf(s, "He/She is fresh [%d%%]", prc);
		case 10:
			ntprintf(s, "He/She is fully fresh [%d%%]", prc);
		default:
			ntprintf(s, "He/She is at %d%% mana", prc);
	}
}

/**************************************************************************************************************
 FUNCTION : __nxw_sk_evint
 AUTHOR   : Luxor
 PURPOSE  : This function is called by Nox-Wizard when a char clicks Evaluating Intelligence on the skills list
 *************************************************************************************************************/
public __nxw_sk_evint(const s)
{
	if (s < 0) return;
	getTarget(s, funcidx("__evintTarget"), "Whom shall I examine?");
}

