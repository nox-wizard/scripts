// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts (lumberjacking.sma -> override.amx)              ||
// || Maintained by Luxor, Xanathar, Ummon                                ||
// || Last Update (17-dec-01)                                             ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This file contains NoX-Wizard functions to support lumberjacking    ||
// || If you want a different lumberjacking system, change this.          ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

const NXW_LUMBERLOGS = 10;


/****************************************************************************
 FUNCTION : __nxw_sk_lumber
 AUTHOR   : Luxor
 PURPOSE  : This function is called by Nox-Wizard engine after tree control
 ****************************************************************************/
public __nxw_sk_lumber(const s)
{
	if ( s < 0 || s >= getSocketCount() ) {
		printf ("WARNING: SOCKET PASSED TO __nxw_sk_lumber IS UNVALID");
		return;
	}
	new cc = getCharFromSocket(s);

	new logs = itm_createInBpDef( "$item_logs", cc, NXW_LUMBERLOGS );
	if (logs == INVALID) 
		return;
	
	if( itm_getProperty(logs, IP_AMOUNT) > NXW_LUMBERLOGS ) {
		ntprintf(s, "You place more logs in your pack.");
	} else {
		ntprintf(s, "You place some logs in your pack.");
	}

}

