// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts (lumberjacking.sma -> override.amx)              ||
// || Maintained by Luxor, Xanathar, Ummon                                ||
// || Last Update (17-dec-01)                                             ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This file contains NoX-Wizard functions to support lumberjacking    ||
// || If you want a different lumberjacking system, change this.          ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

const NXW_LUMBERLOGS = 10;


/*!
\ingroup script_skills
\fn __nxw_sk_lumber(const cc)
\param cc the character
\author Luxor
\brief This function is called by Nox-Wizard engine after tree control
*/
public __nxw_sk_lumber(const cc )
{

	new logs = itm_createInBpDef( "$item_logs", cc, NXW_LUMBERLOGS );
	if (logs == INVALID) 
		return;
	
	if( itm_getProperty(logs, IP_AMOUNT) > NXW_LUMBERLOGS ) {
		chr_message( cc, _, "You place more logs in your pack.");
	} else {
		chr_message( cc, _, "You place some logs in your pack.");
	}

}

