// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts (tailoring.sma -> override.amx)                  ||
// || Maintained by Luxor   	                                          ||
// || Last Update (31-jan-03)                                             ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This file contains NoX-Wizard functions to support tailoring skill  ||
// || If you want a different tailoring system, change this.              ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 

/*************************************************************************************
 AUTHOR:	Luxor
 DESCRIPTION:	In this file you can change the tailoring system.
 ************************************************************************************/




/*----------------------------------------------------------------------------------------*\
Begin Customizable Hides
\*----------------------------------------------------------------------------------------*/

enum {
	NORMAL_CLOTH = 0
};

//How many cloths have we got?
const NUM_CLOTHS = 1;

//Skill value required to work an hide
static clothSkill[] = {
0   //Normal Cloth
};

//Colors of cloths
//Remember that you can't have two cloths with the same color
static clothColor[] = {
0x0000 //Normal cloth
};

//Make menu for that hide
static clothMakeMenu[] = {
40   //Normal cloth
};

//Cloths names
static clothDefine[NUM_CLOTHS][] = {
"$item_cut_cloth"
};

/*----------------------------------------------------------------------------------------*\
End Customizable Cloths
\*----------------------------------------------------------------------------------------*/


public _doCloth( const s, const cloth ) {

	new color = itm_getProperty( cloth, IP_COLOR );
	
	new type=NORMAL_CLOTH;
	for( new i=0; i<NUM_CLOTHS; ++i ) {
		if(	color==clothColor[i] )
			type=i;
	}
	
	new amt = itm_getProperty( cloth, IP_AMOUNT );
	if( amt<0 ) {
		itm_remove(cloth);
		return;
	}
	
	amt=amt*40;
	
	new cutcloth = itm_createByDef( clothDefine[type] );

	new chr = getCharFromSocket(s);
	chr_sound( chr, 0x0248 );

	new bp = itm_getCharBackPack( chr );
	itm_setProperty( cutcloth, IP_AMOUNT, _, amt );
	itm_contPileItem( bp, cutcloth );
	itm_remove(cloth);
	return;

}


                                                                                            
/*****************************************************************************************
 FUNCTION :	__nxw_sk_tailoring
 AUTHOR   :	Luxor
 ****************************************************************************************/
public __nxw_sk_tailoring(const s, const itm)
{
	if (s < 0) {
		printf ("WARNING: SOCKET PASSED TO __nxw_sk_tailoring IS INVALID");
		return;
	}

	if (itm < 0) {
		printf ("WARNING: ITEM PASSED TO __nxw_sk_tailoring IS INVALID");
		return;
	}
	
	//At this point, we're already sure that we're analyzing an cloth, because the engine did the check for us.
	new cc = getCharFromSocket(s);
	new clothNum = INVALID;
	new skill = chr_getSkill(cc, SK_TAILORING);
	new color = itm_getDualByteProperty(itm, IP_COLOR);
	new index;
	for (index = 0; index < NUM_CLOTHS; index++) {
		if (clothColor[index] == color) {
			clothNum = index;
		}
	}
	if (clothNum == INVALID) {
		printf ("WARNING: __nxw_sk_tailoring received an unknown cloth");
		return;
	}
	if (skill < clothSkill[clothNum]) {
		ntprintf(s, "You are not skilled enough for this kind of material.");
		return;
	}
	chr_skillMakeMenu(cc, clothMakeMenu[clothNum], SK_TAILORING);
}
