// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts                                                  ||
// || Created by Luxor                                                    ||
// || Last Update 13-sep-2002                                             ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This file contains NoX-Wizard functions to support Ev. Intelligence ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

/*!
\ingroup scripts_skill
\fn  __nxw_sk_evint(const chr)
\author Luxor
\brief called by __nxw_sk_main, gets a target for evalint. Called on evalint button press
*/
public __nxw_sk_evint( const chr )
{
	chr_message( chr, _, "Whom shall I examine?" );
	target_create( chr, _, _, _, "__evintTarget" );
}

/*!
\ingroup script_skills
\fn __evintTarget( const t, const cc, const target, const x, const y, const z, const model, const param1 )
\param all standard target callback params
\author Luxor
\brief evalint target callback
*/
public __evintTarget( const t, const cc, const target, const x, const y, const z, const model, const param1 )
{

	if (target < 0) {
		chr_message( cc, _, "Target invalid");
		return;
	}

	if (cc == target) {
		chr_message( cc, _, "You cannot analize yourself!");
		return;
	}
	if (chr_distance(cc, target) >= 10) {
		chr_message( cc, _, "You need to be closer to find out more about them");
		return;
	}
	if (!chr_checkSkill(cc, SK_EVALUATINGINTEL, 0, 1000)) {
        chr_message( cc, _, "You are not certain..");
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

	chr_message( cc, _, "That person looks %s.", intDes);

	if (chr_getSkill(cc, SK_EVALUATINGINTEL) < 950) return;

	new mana = chr_getMana(target);
	new prc = mana*100/int;

	switch(prc)
	{
		case 0..9:
			chr_message( cc, _, "He/She is completely tired [%d%%]", prc);
 		case 10..19:
			chr_message( cc, _, "He/She is extremely tired [%d%%]", prc);
		case 20..29:
			chr_message( cc, _, "He/She is very much tired [%d%%]", prc);
		case 30..39:
			chr_message( cc, _, "He/She is very tired [%d%%]", prc);
		case 40..49:
			chr_message( cc, _, "He/She is tired [%d%%]", prc);
		case 50..59:
			chr_message( cc, _, "He/She is slightly tired [%d%%]", prc);
		case 60..69:
			chr_message( cc, _, "He/She is not tired [%d%%]", prc);
		case 70..79:
			chr_message( cc, _, "He/She is slightly fresh [%d%%]", prc);
		case 80..89:
			chr_message( cc, _, "He/She is almost fresh [%d%%]", prc);
		case 90..99:
			chr_message( cc, _, "He/She is fresh [%d%%]", prc);
		case 100:
			chr_message( cc, _, "He/She is fully fresh [%d%%]", prc);
		default:
			chr_message( cc, _, "He/She is at %d%% mana", prc);
	}
}



