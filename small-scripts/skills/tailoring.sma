// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts (tailoring.sma -> override.amx)                  ||
// || Maintained by Luxor   	                                          ||
// || Last Update (31-jan-03)                                             ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This file contains NoX-Wizard functions to support tailoring skill  ||
// || If you want a different tailoring system, change this.              ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 

/*************************************************************************************
 AUTHOR:	Endymion
 DESCRIPTION:	In this file you can change the tailoring system.
 ************************************************************************************/




/*----------------------------------------------------------------------------------------*\
Begin Customizable Hides
\*----------------------------------------------------------------------------------------*/

enum {
	NORMAL_BOLT_CLOTH = 0, ALL_BOLTS_CLOTH
};

//Bolts of Cloth define
static boltscloth[ALL_BOLTS_CLOTH][] = {
"$item_bolts_of_cloth"
};

enum {
	NORMAL_CLOTH = 0, ALL_CLOTHS
};

//Skill value required to work an cloth
static clothSkill[] = {
0   //NORMAL_CLOTH
};

//Make menu for that cloth
static clothMakeMenu[] = {
40   //NORMAL_CLOTH
};

//Cloths define
static cloths[ALL_CLOTHS][] = {
"$item_cut_cloth"
};

/*----------------------------------------------------------------------------------------*\
End Customizable Cloths
\*----------------------------------------------------------------------------------------*/

static boltsclothDef[ALL_BOLTS_CLOTH];
static clothsDef[ALL_CLOTHS];

public checkInitTailoring() {

	static init=false;
	if( !init ) {
		for( new b=0; b<ALL_BOLTS_CLOTH; ++b ) {
			boltsclothDef[b]=getIntFromDefine( boltscloth[b] );
		}
		for( new c=0; c<ALL_CLOTHS; ++c ) {
			clothsDef[c]=getIntFromDefine( cloths[c] );
		}
		init=true;		
	}
	
}

public _doCloth( const s, const cloth ) {

	checkInitTailoring();
	
	new scriptid = itm_getProperty( cloth, IP_SCRIPTID );
	new color = itm_getProperty( cloth, IP_COLOR );
	
	new type=INVALID;
	for( new i=0; i<ALL_BOLTS_CLOTH; ++i ) {
		if(	scriptid==boltsclothDef[i] )
			type=i;
	}
	
	if(type == INVALID) {
		printf ("WARNING: _doCloth received an unknown bolt of cloth");
		return;
	}
	
	new amt = itm_getProperty( cloth, IP_AMOUNT );
	if( amt<0 ) {
		itm_remove(cloth);
		return;
	}
	
	amt=amt*40;
	
	new cutcloth = itm_createByDef( cloths[type] );

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
 AUTHOR   :	Endymion
 ****************************************************************************************/
public __nxw_sk_tailoring(const s, const itm)
{
	checkInitTailoring();
	
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
	new type = INVALID;
	new skill = chr_getSkill(cc, SK_TAILORING);
	new color = itm_getDualByteProperty(itm, IP_COLOR);
	new scriptid = itm_getProperty( itm, IP_SCRIPTID );

	for( new index = 0; index < ALL_CLOTHS; index++) {
		if( clothsDef[index] == scriptid ) {
			type = index;
		}
	}
	if (type == INVALID) {
		printf ("WARNING: __nxw_sk_tailoring received an unknown cloth");
		return;
	}
	if (skill < clothSkill[type]) {
		ntprintf(s, "You are not skilled enough for this kind of material.");
		return;
	}
	chr_skillMakeMenu(cc, clothMakeMenu[type], SK_TAILORING);
}
