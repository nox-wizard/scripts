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
static clothName[NUM_CLOTHS][] = {
"Cloth"
};

/*----------------------------------------------------------------------------------------*\
End Customizable Cloths
\*----------------------------------------------------------------------------------------*/


public _doCloth( const s, const cloth ) {

	new amt = itm_getProperty( itm, IP_AMOUNT );
	chr_sound( chr, 0x0248 );
	new bp = itm_getCharBackPack( target );
	new stoffa = itm_createByDef( "$item_cut_cloth" );
	itm_setProperty( stoffa, IP_AMOUNT, _, 30 );
	itm_contPileItem( bp, stoffa );
	itm_setProperty( itm, IP_AMOUNT, _, ( (itm_getProperty( itm, IP_AMOUNT )) -1) );
	if ((itm_getProperty( itm, IP_AMOUNT )) == 0) {
		itm_remove(itm);
		return;
	}
/*
	new amt = 40;
	new color = itm_getProperty( itm, IP_COLOR );
	if( pi->amount>1 )
       	amt = (pi->amount*40);//-Frazurbluu- changed to reflect current OSI

	chr_sound( chr, 0x0248 );

	new bp = itm_getCharBackPack( chr );
	new cutcloth = itm_createByDef( "$item_cut_cloth" );
	itm_setProperty( ore, IP_AMOUNT, _, oreAmount );
	itm_setProperty( ore, IP_STR_NAME, 0, str );
	itm_setDualByteProperty( ore, IP_COLOR, oreColor[oreFound] );
	itm_setContSerial( cutcloth, bp );

	pcc->setColor( color );
    pcc->amount=amt;
	itm_contPileItem( bp, cutcloth );*/
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
	new clothNum = -1;
	new skill = chr_getSkill(cc, SK_TAILORING);
	new color = itm_getDualByteProperty(itm, IP_COLOR);
	new index;
	for (index = 0; index < NUM_CLOTHS; index++) {
		if (clothColor[index] == color) {
			clothNum = index;
		}
	}
	if (clothNum == -1) {
		printf ("WARNING: __nxw_sk_tailoring received an unknown cloth");
		return;
	}
	if (skill < clothSkill[clothNum]) {
		ntprintf(s, "You are not skilled enough for this kind of material.");
		return;
	}
	chr_skillMakeMenu(cc, clothMakeMenu[hideNum], SK_TAILORING);
}
