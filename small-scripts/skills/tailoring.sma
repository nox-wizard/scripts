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
30   //NORMAL_CLOTH
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

public _doCloth( const chr, const cloth ) {

	checkInitTailoring();
	
	new scriptid = itm_getProperty( cloth, IP_SCRIPTID );
	//new color = itm_getProperty( cloth, IP_COLOR );  Fax 28-11-03: color is unused.. why?
	
	new type=INVALID;
	for( new i=0; i<ALL_BOLTS_CLOTH; ++i ) {
		if(	scriptid==boltsclothDef[i] ) {
			type=i;
			break;
		}
	}
	
	if(type == INVALID) {
		printf ("WARNING: _doCloth received an unknown bolt of cloth");
		return;
	}
	
	if( itm_getProperty( cloth, IP_AMOUNT )<0 ) {
		itm_remove(cloth);
		return;
	}
	
	chr_sound( chr, 0x0248 );

	new cutcloth = itm_createInBpDef( cloths[type], chr, 40 );
	if(cutcloth == INVALID) {
		printf ("WARNING: _doCloth can't create cutcloths^n");
		return;
	}
	itm_reduceAmount( cloth, 1 );

}


                                                                                            
/*****************************************************************************************
 FUNCTION :	__nxw_sk_tailoring
 AUTHOR   :	Endymion
 ****************************************************************************************/
public __nxw_sk_tailoring(const cc, const itm)
{
	checkInitTailoring();
	
	if (cc < 0) {
		printf ("WARNING: CHARACTER PASSED TO __nxw_sk_tailoring IS INVALID");
		return;
	}

	if (itm < 0) {
		printf ("WARNING: ITEM PASSED TO __nxw_sk_tailoring IS INVALID");
		return;
	}
	
	//At this point, we're already sure that we're analyzing an cloth, because the engine did the check for us.
	new type = INVALID;
	new skill = chr_getSkill(cc, SK_TAILORING);
	//new color = itm_getProperty(itm, IP_COLOR);  Fax 28-11-03: color is unused.. why?
	new scriptid = itm_getProperty( itm, IP_SCRIPTID );

	for( new index = 0; index < ALL_CLOTHS; index++) {
		if( clothsDef[index] == scriptid ) {
			type = index;
			break;
		}
	}
	if (type == INVALID) {
		printf ("WARNING: __nxw_sk_tailoring received an unknown cloth");
		return;
	}
	if (skill < clothSkill[type]) {
		chr_message( cc, _, msg_sk_tailorDef[0]);
		return;
	}
	chr_skillMakeMenu(cc, clothMakeMenu[type], SK_TAILORING, itm);
}
