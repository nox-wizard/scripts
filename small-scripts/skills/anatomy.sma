// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts                                                  ||
// || Created by Luxor                                                    ||
// || Last Update 10-mar-2003                                             ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This file contains NoX-Wizard functions to support Anatomy          ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

/*!
\ingroup script_skills
\fn __nxw_sk_anatomy(const chr)
\param chr the character who used anatomy
\author Luxor
\brief called by __nxw_sk_main, gets a target for anatomy
*/
public __nxw_sk_anatomy( const chr )
{
	chr_message( chr, _, msg_sk_anatomyDef[0]);
	target_create( chr, _, _, _, "__anatomyTarget" );
}

/*!
\ingroup script_skills
\fn  __anatomyTarget( const t, const cc, const target, const x, const y, const z, const model, const param1 )
\author Luxor
\param t,cc,x,y,z,model,param1 standard target callback parameters
\brief target callback for anatomy
*/
public __anatomyTarget( const t, const cc, const target, const x, const y, const z, const model, const param1 )
{
	if (target < 0) 
	{
		chr_message( cc, _, msg_sk_anatomyDef[1]);
		return;
	}

	if (cc == target) 
	{
		chr_message( cc, _, msg_sk_anatomyDef[2]);
		return;
	}
	
	
	if (chr_distance(cc, target) >= 10) 
	{
		chr_message( cc, _, msg_sk_anatomyDef[3]);
		return;
	}
	
	if (!chr_checkSkill(cc, SK_ANATOMY, 0, 1000)) 
	{
	        chr_message( cc, _, msg_sk_anatomyDef[4]);
	        return;
    	}

	new str = chr_getStr(target);
	new dex = chr_getDex(target);
	new strDes[60];
	new dexDes[60];
	if (str > 90) strunpack(dexDes, msg_sk_anatomyDef[5]);
	else {
		switch(str)
		{
			case 0..10:
				strunpack(strDes, msg_sk_anatomyDef[6]);
			case 11..20:
				strunpack(strDes, msg_sk_anatomyDef[7]);
			case 21..30:
				strunpack(strDes, msg_sk_anatomyDef[8]);
			case 31..40:
				strunpack(strDes, msg_sk_anatomyDef[9]);
			case 41..50:
				strunpack(strDes, msg_sk_anatomyDef[10]);
			case 51..60:
				strunpack(strDes, msg_sk_anatomyDef[11]);
			case 61..70:
				strunpack(strDes, msg_sk_anatomyDef[12]);
			case 71..80:
				strunpack(strDes, msg_sk_anatomyDef[13]);
			case 81..90:
				strunpack(strDes, msg_sk_anatomyDef[14]);
			default:
				strunpack(strDes, msg_sk_anatomyDef[15]);
		}
	}

	if (dex > 90) strunpack(dexDes, msg_sk_anatomyDef[16]);
	else {
		switch(dex)
		{
			case 0..10:
				strunpack(dexDes, msg_sk_anatomyDef[17]);
			case 11..20:
				strunpack(dexDes, msg_sk_anatomyDef[18]);
			case 21..30:
				strunpack(dexDes, msg_sk_anatomyDef[19]);
			case 31..40:
				strunpack(dexDes, msg_sk_anatomyDef[20]);
			case 41..50:
				strunpack(dexDes, msg_sk_anatomyDef[21]);
			case 51..60:
				strunpack(dexDes, msg_sk_anatomyDef[22]);
			case 61..70:
				strunpack(dexDes, msg_sk_anatomyDef[23]);
			case 71..80:
				strunpack(dexDes, msg_sk_anatomyDef[24]);
			case 81..90:
				strunpack(dexDes, msg_sk_anatomyDef[25]);
			default:
				strunpack(dexDes, msg_sk_anatomyDef[26]);
		}
	}

	chr_message( cc, _, msg_sk_anatomyDef[27], strDes, dexDes);

	if (chr_getSkill(cc, SK_ANATOMY) < 950) return;

	new stm = chr_getStamina(target);
	new prc = stm*100/dex;

	switch(prc/10)
	{
		case 0:
			chr_message( cc, _, msg_sk_anatomyDef[28], prc);
 		case 1:
			chr_message( cc, _, msg_sk_anatomyDef[29], prc);
		case 2:
			chr_message( cc, _, msg_sk_anatomyDef[30], prc);
		case 3:
			chr_message( cc, _, msg_sk_anatomyDef[31], prc);
		case 4:
			chr_message( cc, _, msg_sk_anatomyDef[32], prc);
		case 5:
			chr_message( cc, _, msg_sk_anatomyDef[33], prc);
		case 6:
			chr_message( cc, _, msg_sk_anatomyDef[34], prc);
		case 7:
			chr_message( cc, _, msg_sk_anatomyDef[35], prc);
		case 8:
			chr_message( cc, _, msg_sk_anatomyDef[36], prc);
		case 9:
			chr_message( cc, _, msg_sk_anatomyDef[37], prc);
		case 10:
			chr_message( cc, _, msg_sk_anatomyDef[38], prc);
		default:
			chr_message( cc, _, msg_sk_anatomyDef[39], prc);
	}
}



