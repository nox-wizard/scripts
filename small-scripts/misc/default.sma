// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts (default.sma -> override.amx)                    ||
// || Maintained by Xanathar, Ummon                                       ||
// || Last Update (25-aug-01)                                             ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This file contains NoX-Wizard standard overrides                    ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

/****************************************************************************
 FUNCTION : __get_milk_from_cow
 AUTHOR   : Xanathar
 PURPOSE  : implements milkable cows, through ITEMS $item_jar_for_milk and
            $item_a_jar_full_of_milk
 ****************************************************************************/
public __get_milk_target(const itm, const s)
{
    bypass();
    getTarget(s, funcidx("__get_milk_from_cow"), "Choose the cow to milk...");
}

public __get_milk_from_cow(const s, const c, const this_is_useless)
{
    //something wrong : goes out and drops trigging
    if ((c<0)||(s<0)) return;


    new cc = getCharFromSocket(s);

    new id = (chr_getProperty(c, CP_ID, 2)<<8) + chr_getProperty(c, CP_ID, 1);

    if ((id!=0xD8)&&(id!=0xE7)) {
        nprintf(s, "It's not  cow!!!");
        return;
    }

    new disabledtime = chr_getProperty(c, CP_DISABLED);
    if (disabledtime!=0) {
        nprintf(s, "It has been milked recently");
        return;
    }

    new jars = chr_countItems(cc, 0x1005);

    if (jars <= 0) {
        nprintf(s, "You have not jars");
        return;
    }

    itm_contDelAmount(itm_getCharBackPack(cc), 1, 0x1005);
    itm_createInBp( 199001, c);

    chr_setProperty(c, CP_DISABLED, 0 , getCurrentTime()+60000);
    chr_setProperty(c, CP_STR_DISABLEDMSG, 0, "It has been milked recently");

}



/****************************************************************************
 FUNCTION : anatomy_target
 AUTHOR   : Xanathar
 PURPOSE  : shows target stamina to GM anatomists
 ****************************************************************************/
public __anatomy_target(const s)
{
    new cc = getCharFromSocket(s);

    if (chr_getProperty(cc, CP_SKILL, SK_ANATOMY) < 950) return;

    //we are here so anatomy >= 95%, let's get target stamina and show it!

    new stm = chr_getProperty(getCharTarget(), CP_DEXTERITY, CP2_STAMINA);
    new dex = chr_getProperty(getCharTarget(), CP_DEXTERITY, CP2_DEX);

    new prc = stm*100/dex;

    switch(prc/10) {
        case 0:
            nprintf(s, "He/She is completely tired [%d%%]", prc);
        case 1:
            nprintf(s, "He/She is extremely tired [%d%%]", prc);
        case 2:
            nprintf(s, "He/She is very much tired [%d%%]", prc);
        case 3:
            nprintf(s, "He/She is very tired [%d%%]", prc);
        case 4:
            nprintf(s, "He/She is tired [%d%%]", prc);
        case 5:
            nprintf(s, "He/She is slightly tired [%d%%]", prc);
        case 6:
            nprintf(s, "He/She is not tired [%d%%]", prc);
        case 7:
            nprintf(s, "He/She is slightly fresh [%d%%]", prc);
        case 8:
            nprintf(s, "He/She is almost fresh [%d%%]", prc);
        case 9:
            nprintf(s, "He/She is fresh [%d%%]", prc);
        case 10:
            nprintf(s, "He/She is fully fresh [%d%%]", prc);
        default:
            nprintf(s, "He/She is at %d%% stamina", prc);
        }
}


/****************************************************************************
 FUNCTION : __crystBall
 AUTHOR   : Xanathar (originally coded in C++ by Blackwinds :))
 PURPOSE  : tells a player its reputation
 ****************************************************************************/
public __crystBall (const ball, const s)
{
    bypass();

    new cc = getCharFromSocket(s);

    new karma = chr_getProperty(cc, CP_KARMA, 1);
    new fame = chr_getProperty(cc, CP_FAME, 1);
    new kills = chr_getProperty(cc, CP_KILLS, 1);
    new deaths = chr_getProperty(cc, CP_DEATHS, 1);

    nprintf(s, "You have %d karma", karma);
    nprintf(s, "You have %d fame", fame);
    nprintf(s, "You have killed %d persons", kills);
    nprintf(s, "You have died %d times", deaths);

    itm_reduceAmount(ball, 1);
}


/****************************************************************************
 FUNCTION : __nxwGumps
 AUTHOR   : Juliunus
 PURPOSE  : support for user-scripted gumps
 ****************************************************************************/
public __nxwGumps(const s, const gump, const button, const radio)
{
//	printf("Gump: %d, Button: %d, S: %d", gump, button, s);
    switch (gump)
	{
	default: nprintf(s,"Warning : no behavior defined for button %d, from gump number %d, radio value %d",button, gump, radio);
	}
}


/****************************************************************************
 FUNCTION : __nxwBench
 AUTHOR   : Xanathar
 PURPOSE  : part of the start-up benchmark
 ****************************************************************************/
public __nxwBench()
{
    new i;
    for (i = 0; i<10000; i++) getNXWVersion();
}

/****************************************************************************
 FUNCTION : __smoke
 AUTHOR   : Rage
 PURPOSE  : makes a Char smoke
 ****************************************************************************/
public __smoke(const itm, const s)
{
	bypass();
    new c = getCharFromSocket(s);
    new container = itm_getMultiByteProperty(itm, IP_CONTAINERSERIAL);
	if (!container) itm_remove(itm);
	if (container) itm_contDelAmount(container, 1, itm_getDualByteProperty(itm, IP_ID), itm_getDualByteProperty(itm, IP_COLOR));
    nprintf(s, "You start smoking");
    timer_add(c, 5, 0, funcidx("__smoke_cback"), 0, 5, 0 );
}

public __smoke_cback(const c, const more1, const more2)
{
	chr_speech(NPC_EMOTE_ALL,-1,c,"*Coff Coff*",0);
}


