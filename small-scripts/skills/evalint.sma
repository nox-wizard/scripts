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
	chr_message( chr, _, msg_sk_anatomyDef[0] );
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
		chr_message( cc, _, msg_sk_anatomyDef[1]);
		return;
	}

	if (cc == target) {
		chr_message( cc, _, msg_sk_anatomyDef[2]);
		return;
	}
	if (chr_distance(cc, target) >= 10) {
		chr_message( cc, _, msg_sk_anatomyDef[3]);
		return;
	}
	if (!chr_checkSkill(cc, SK_EVALUATINGINTEL, 0, 1000)) {
        chr_message( cc, _, msg_sk_anatomyDef[4]);
        return;
    }
        
	new int = chr_getInt(target);
	new intDes[60];
	if (int > 100) strunpack(intDes, msg_sk_evalintDef[5]);
	else {
		switch(int)
		{
			case 0..10:
				strunpack(intDes, msg_sk_evalintDef[6]);
			case 11..20:
				strunpack(intDes, msg_sk_evalintDef[7]);
			case 21..30:
				strunpack(intDes, msg_sk_evalintDef[8]);
			case 31..40:
				strunpack(intDes, msg_sk_evalintDef[9]);
			case 41..50:
				strunpack(intDes, msg_sk_evalintDef[10]);
			case 51..60:
				strunpack(intDes, msg_sk_evalintDef[11]);
			case 61..70:
				strunpack(intDes, msg_sk_evalintDef[12]);
			case 71..80:
				strunpack(intDes, msg_sk_evalintDef[13]);
			case 81..90:
				strunpack(intDes, msg_sk_evalintDef[14]);
			case 91..100:
				strunpack(intDes, msg_sk_evalintDef[5]);
			default:
				strunpack(intDes, msg_sk_evalintDef[16]);
		}
	}

	chr_message( cc, _, msg_sk_evalintDef[17], intDes);

	if (chr_getSkill(cc, SK_EVALUATINGINTEL) < 950) return;

	new mana = chr_getMana(target);
	new prc = mana*100/int;

	switch(prc)
	{
		case 0..9:
			chr_message( cc, _, msg_sk_anatomyDef[28], prc);
 		case 10..19:
			chr_message( cc, _, msg_sk_anatomyDef[29], prc);
		case 20..29:
			chr_message( cc, _, msg_sk_anatomyDef[30], prc);
		case 30..39:
			chr_message( cc, _, msg_sk_anatomyDef[31], prc);
		case 40..49:
			chr_message( cc, _, msg_sk_anatomyDef[32], prc);
		case 50..59:
			chr_message( cc, _, msg_sk_anatomyDef[33], prc);
		case 60..69:
			chr_message( cc, _, msg_sk_anatomyDef[34], prc);
		case 70..79:
			chr_message( cc, _, msg_sk_anatomyDef[35], prc);
		case 80..89:
			chr_message( cc, _, msg_sk_anatomyDef[36], prc);
		case 90..99:
			chr_message( cc, _, msg_sk_anatomyDef[37], prc);
		case 100:
			chr_message( cc, _, msg_sk_anatomyDef[38], prc);
		default:
			chr_message( cc, _, msg_sk_evalintDef[29], prc);
	}
}



