// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts                                                  ||
// || Created by Luxor                                                    ||
// || Last Update 10-mar-2003                                             ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This file contains NoX-Wizard functions to support Anatomy          ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

/**********************************************************************************************
 FUNCTION : __anatomyTarget
 AUTHOR   : Luxor
 *********************************************************************************************/
public __anatomyTarget(const cc, const target, const item)
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
	if (!chr_checkSkill(cc, SK_ANATOMY, 0, 1000)) {
                chr_message( cc, _, "You are not certain..");
                return;
        }
	new str = chr_getStr(target);
	new dex = chr_getDex(target);
	new strDes[60];
	new dexDes[60];
	if (str > 90) strunpack(dexDes, "superhumanly strong");
	else {
		switch(str)
		{
			case 0..10:
				strunpack(strDes, "rather feeble");
			case 11..20:
				strunpack(strDes, "somewhat weak");
			case 21..30:
				strunpack(strDes, "to be of normal strength");
			case 31..40:
				strunpack(strDes, "somewhat strong");
			case 41..50:
				strunpack(strDes, "very strong");
			case 51..60:
				strunpack(strDes, "extremely strong");
			case 61..70:
				strunpack(strDes, "extraordinarily strong");
			case 71..80:
				strunpack(strDes, "as strong as an ox");
			case 81..90:
				strunpack(strDes, "like one of the strongest people you have ever seen");
			default:
				strunpack(strDes, "of unknown strenght");
		}
	}

	if (dex > 90) strunpack(dexDes, "superhumanly agile");
	else {
		switch(dex)
		{
			case 0..10:
				strunpack(dexDes, "very clumsy");
			case 11..20:
				strunpack(dexDes, "somewhat uncoordinated");
			case 21..30:
				strunpack(dexDes, "moderately dexterous");
			case 31..40:
				strunpack(dexDes, "somewhat agile");
			case 41..50:
				strunpack(dexDes, "very agile");
			case 51..60:
				strunpack(dexDes, "extremely agile");
			case 61..70:
				strunpack(dexDes, "extraordinarily agile");
			case 71..80:
				strunpack(dexDes, "like they move like quicksilver");
			case 81..90:
				strunpack(dexDes, "like one of the fastest people you have ever seen");
			default:
				strunpack(dexDes, "of unknown dexterity");
		}
	}

	chr_message( cc, "That person looks %s and %s.", strDes, dexDes);

	if (chr_getSkill(cc, SK_ANATOMY) < 950) return;

	new stm = chr_getStamina(target);
	new prc = stm*100/dex;

	switch(prc/10)
	{
		case 0:
			chr_message( cc, _, "He/She is completely tired [%d%%]", prc);
 		case 1:
			chr_message( cc, _, "He/She is extremely tired [%d%%]", prc);
		case 2:
			chr_message( cc, _, "He/She is very much tired [%d%%]", prc);
		case 3:
			chr_message( cc, _, "He/She is very tired [%d%%]", prc);
		case 4:
			chr_message( cc, _, "He/She is tired [%d%%]", prc);
		case 5:
			chr_message( cc, _, "He/She is slightly tired [%d%%]", prc);
		case 6:
			chr_message( cc, _, "He/She is not tired [%d%%]", prc);
		case 7:
			chr_message( cc, _, "He/She is slightly fresh [%d%%]", prc);
		case 8:
			chr_message( cc, _, "He/She is almost fresh [%d%%]", prc);
		case 9:
			chr_message( cc, _, "He/She is fresh [%d%%]", prc);
		case 10:
			chr_message( cc, _, "He/She is fully fresh [%d%%]", prc);
		default:
			chr_message( cc, _, "He/She is at %d%% stamina", prc);
	}
}

/**********************************************************************************************
 FUNCTION : __nxw_sk_anatomy
 AUTHOR   : Luxor
 PURPOSE  : This function is called by Nox-Wizard when a char clicks Anatomy on the skills list
 *********************************************************************************************/
public __nxw_sk_anatomy( const chr )
{
	chr_message( chr, _, "Whom shall I examine?");
	getTarget(s, funcidx("__anatomyTarget"), 
}

