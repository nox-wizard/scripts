// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts (tannering.sma -> override.amx)                  ||
// || Maintained by Luxor   	                                          ||
// || Last Update (31-jan-03)                                             ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This file contains NoX-Wizard functions to support tannering skill  ||
// || If you want a different tannering system, change this.              ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 

/*************************************************************************************
 AUTHOR:	Luxor
 DESCRIPTION:	In this file you can change the tannering system.
 ************************************************************************************/




/*----------------------------------------------------------------------------------------*\
Begin Customizable Hides
\*----------------------------------------------------------------------------------------*/

enum {
	NORMAL_HIDE = 0
};

//How many hides have we got?
const NUM_HIDES = 1;

//Skill value required to work an hide
static hideSkill[] = {
0   //Normal Hide
};

//Colors of hides
//Remember that you can't have two hides with the same color
static hideColor[] = {
0x0000 //Normal Hide
};

//Make menu for that hide
static hideMakeMenu[] = {
40   //Normal Hide
};

//Hides names
static hideDefine[NUM_HIDES][] = {
"$item_leather_piece"
};

/*----------------------------------------------------------------------------------------*\
End Customizable Hides
\*----------------------------------------------------------------------------------------*/
                                                                                            


public _doLeatherPiece( const s, const hide ) {

	new color = itm_getProperty( hide, IP_COLOR );
	new type=NORMAL_HIDE;
	for( new i=0; i<NUM_HIDES; ++i ) {
		if( color==hideColor[i] )
			type=i;
	}

	new amt=itm_getProperty( hide, IP_AMOUNT );
	if( amt<0 ) {
		itm_remove( hide );
		return;
	}

	new chr = getCharFromSocket(s);
	chr_sound( chr, 0x0248 );

	new bp = itm_getCharBackPack( chr );
	new leather = itm_createByDef( hideDefine[type] );
	itm_setProperty( leather, IP_AMOUNT, _, amt );
	itm_contPileItem( bp, leather );
	itm_remove( hide );
	
}





/*****************************************************************************************
 FUNCTION :	__nxw_sk_tannering
 AUTHOR   :	Luxor
 ****************************************************************************************/
public __nxw_sk_tannering(const s, const itm)
{
	if (s < 0) {
		printf ("WARNING: SOCKET PASSED TO __nxw_sk_tannering IS INVALID");
		return;
	}

	if (itm < 0) {
		printf ("WARNING: ITEM PASSED TO __nxw_sk_tannering IS INVALID");
		return;
	}
	
	//At this point, we're already sure that we're analyzing an hide, because the engine did the check for us.
	new cc = getCharFromSocket(s);
	new hideNum = INVALID;
	new skill = chr_getSkill(cc, SK_TAILORING);
	new color = itm_getDualByteProperty(itm, IP_COLOR);
	new index;
	for (index = 0; index < NUM_HIDES; index++) {
		if (hideColor[index] == color) {
			hideNum = index;
		}
	}
	if (hideNum == INVALID) {
		printf ("WARNING: __nxw_sk_tailoring received an unknown hide");
		return;
	}
	if (skill < hideSkill[hideNum]) {
		ntprintf(s, "You are not skilled enough for this kind of material.");
		return;
	}
	chr_skillMakeMenu(cc, hideMakeMenu[hideNum], SK_TAILORING);
}
