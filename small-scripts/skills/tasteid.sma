// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts                                                  ||
// || Created by Luxor                                                    ||
// || Last Update 13-sep-2002                                             ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This file contains NoX-Wizard functions to support TasteID          ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

/**********************************************************************************************
 FUNCTION : __tasteIDTarget
 AUTHOR   : Luxor
 *********************************************************************************************/
public __tasteIDTarget( const t, const cc, const item, const x, const y, const z, const model, const param1 )
{

	if (item < 0) {
		chr_message( cc, _, "Target invalid");
		return;
	}

	if (chr_checkSkill(cc, SK_TASTEID, 250, 500, 1)) {
		new poisonLvl = itm_getProperty(item, IP_POISONED);
		if (poisonLvl > 0) {
			chr_message( cc, _, "This item is poisoned!");
		} else {
			chr_message( cc, _, "This item shows no poison");
		}
	} else {
		chr_message( cc, _, "You do not understand if this item is poisoned or not");
	}
}

/**********************************************************************************************
 FUNCTION : __nxw_sk_tasteid
 AUTHOR   : Luxor
 PURPOSE  : This function is called by Nox-Wizard when a char clicks TasteID on the skills list
 *********************************************************************************************/
public __nxw_sk_tasteid(const chr)
{
	chr_message( chr, _, "What do you want to taste?");
	target_create( chr, _, _, _, "__tasteIDTarget" );
}

