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
	new bp = itm_getCharBackPack( cc );
	    
	new logs = itm_createByDef( "$item_logs" );
	if (logs == -1) return;
	itm_setProperty( logs, IP_AMOUNT, _, NXW_LUMBERLOGS );
	itm_setContSerial( logs, bp );
	if (itm_getProperty(logs, IP_AMOUNT) > NXW_LUMBERLOGS) {
		ntprintf(s, "You place more logs in your pack.");
	} else {
		ntprintf(s, "You place some logs in your pack.");
	}

	itm_contPileItem( bp, logs ); 
}

