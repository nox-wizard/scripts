// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts (tannering.sma -> override.amx)                  ||
// || Maintained by Luxor   	                                          ||
// || Last Update (31-jan-03)                                             ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This file contains NoX-Wizard functions to support tannering skill  ||
// || If you want a different tannering system, change this.              ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 

/*************************************************************************************
 AUTHOR:	Endymion
 DESCRIPTION:	In this file you can change the tannering system.
 ************************************************************************************/




/*----------------------------------------------------------------------------------------*\
Begin Customizable Hides
\*----------------------------------------------------------------------------------------*/

enum {
	NORMAL_HIDE = 0, ALL_HIDES
};

//Hides define
static hides[ALL_HIDES][] = {
"$item_hide"
};

enum {
	NORMAL_LEATHER = 0, ALL_LEATHERS
};

//Skill value required to work a leather
static leatherSkill[] = {
0   // NORMAL_LEATHER
};

//Make menu for that leather
static leatherMakeMenu[] = {
40   // NORMAL_LEATHER
};

//Leathers define
static leathers[ALL_LEATHERS][] = {
"$item_leather_piece"
};

/*----------------------------------------------------------------------------------------*\
End Customizable Hides
\*----------------------------------------------------------------------------------------*/
                                                                                            

static hidesDef[ALL_HIDES];
static leathersDef[ALL_LEATHERS];


public checkInitTannering() {

	static init=false;
	if( !init ) {
		for( new h=0; h<ALL_HIDES; ++h ) {
			hidesDef[h]=getIntFromDefine( hides[h] );
		}
		for( new l=0; l<ALL_LEATHERS; ++l ) {
			leathersDef[l]=getIntFromDefine( leathers[l] );
		}
		init=true;		
	}
	
}


public _doLeatherPiece( const s, const hide ) {

	checkInitTannering();

	new scriptid = itm_getProperty( hide, IP_SCRIPTID );
	new type=INVALID;
	for( new i=0; i<ALL_HIDES; ++i ) {
		if( scriptid==hidesDef[i] ) {
			type=i;
			break;
		}
	}
	
	if(type == INVALID) {
		printf ("WARNING: _doLeatherPiece received an unknown hide");
		return;
	}
	

	if( itm_getProperty( hide, IP_AMOUNT )<0 ) {
		itm_remove( hide );
		return;
	}

	new chr = getCharFromSocket(s);
	chr_sound( chr, 0x0248 );

	new bp = itm_getCharBackPack( chr );
	new leather = itm_createByDef( leathers[type] );
	itm_setProperty( leather, IP_AMOUNT, _, 2 );
	itm_contPileItem( bp, leather );
	itm_reduceAmount( hide, 1 );
	
}





/*****************************************************************************************
 FUNCTION :	__nxw_sk_tannering
 AUTHOR   :	Endymion
 ****************************************************************************************/
public __nxw_sk_tannering(const s, const itm)
{

	checkInitTannering();

	if (s < 0) {
		printf ("WARNING: SOCKET PASSED TO __nxw_sk_tannering IS INVALID");
		return;
	}

	if (itm < 0) {
		printf ("WARNING: ITEM PASSED TO __nxw_sk_tannering IS INVALID");
		return;
	}
	
	//At this point, we're already sure that we're analyzing an leather, because the engine did the check for us.
	new cc = getCharFromSocket(s);
	new type = INVALID;
	new skill = chr_getSkill(cc, SK_TAILORING);
	new scriptid = itm_getProperty( itm, IP_SCRIPTID );

	for( new index = 0; index < ALL_LEATHERS; index++) {
		if (leathersDef[index] == scriptid) {
			type = index;
		}
	}
	if (type == INVALID) {
		printf ("WARNING: __nxw_sk_tannering received an unknown leather");
		return;
	}
	if (skill < leatherSkill[type]) {
		ntprintf(s, "You are not skilled enough for this kind of material.");
		return;
	}
	chr_skillMakeMenu(cc, leatherMakeMenu[type], SK_TAILORING);
}
