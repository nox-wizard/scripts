// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts                                                  ||
// || Created by Luxor                                                    ||
// || Last Update 13-sep-2002                                             ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This file contains NoX-Wizard functions to support TasteID          ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

/*!
\fn  __nxw_sk_tasteid(const chr)
\param chr the character using tasteID
\author Luxor
\brief called by __nxw_sk_main, gets a target for taste ID
*/
public __nxw_sk_tasteid(const chr)
{
	chr_message( chr, _, msg_sk_tasteDef[0]);
	target_create( chr, _, _, _, "__tasteIDTarget" );
}

/*!
\fn  __tasteIDTarget( const t, const cc, const item, const x, const y, const z, const model, const param1 )
\param all standard target callback params
\author Luxor
\brief target callback for tasteID
*/
public __tasteIDTarget( const t, const cc, const item, const x, const y, const z, const model, const param1 )
{
	if (!isItem(item)) 
	{
		chr_message( cc, _, msg_sk_tasteDef[1]);
		return;
	}

	if (chr_checkSkill(cc, SK_TASTEID, 250, 500, 1)) 
	{
		new poisonLvl = itm_getProperty(item, IP_POISONED);
		if (poisonLvl > 0) 
			chr_message( cc, _, msg_sk_tasteDef[2]);
		 else 
			chr_message( cc, _, msg_sk_tasteDef[3]);
		
	} 
	else 	chr_message( cc, _, msg_sk_tasteDef[4]);
}



