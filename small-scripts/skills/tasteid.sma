// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts                                                  ||
// || Created by Luxor                                                    ||
// || Last Update 13-sep-2002                                             ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This file contains NoX-Wizard functions to support TasteID          ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

/**********************************************************************************************
 FUNCTION : __nxw_sk_tasteid
 AUTHOR   : Luxor
 *********************************************************************************************/
public __tasteIDTarget(const s, const target, const item)
{
	if (s < 0) return;
	if (item < 0) {
		ntprintf(s, "Target invalid");
		return;
	}
	new cc = getCharFromSocket(s);
	if (chr_checkSkill(cc, SK_TASTEID, 250, 500, 1)) {
		new poisonLvl = itm_getProperty(item, IP_POISONED);
		if (poisonLvl > 0) {
			ntprintf(s, "This item is poisoned!");
		} else {
			ntprintf(s, "This item shows no poison");
		}
	} else {
		ntprintf(s, "You do not understand if this item is poisoned or not");
	}
}

/**********************************************************************************************
 FUNCTION : __nxw_sk_tasteid
 AUTHOR   : Luxor
 PURPOSE  : This function is called by Nox-Wizard when a char clicks TasteID on the skills list
 *********************************************************************************************/
public __nxw_sk_tasteid(const s)
{
	if (s < 0) return
	getTarget(s, funcidx("__tasteIDTarget"), "What do you want to taste?");
}

