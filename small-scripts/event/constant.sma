// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard	: Embedded Small Scripts			||
// || Maintained by	: Luxor, Sparhawk				||
// || Last Update	: 06-apr-2003					||
// || Designed for NXW 	: 0.82						||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#if defined _nxw_event_constant_
  #endinput
#endif
#define _nxw_event_constant_

/** \defgroup script_const_effects Effect constants
 *  \ingroup script_API_effects
 *  @{
 */


const TRIG_ABORT = 1;
const TRIG_CONTINUE = 0;

const ITEM_DONTUSE = 0;
const ITEM_CANUSE = 1;

enum
{
	ITEM_USE_UNKNOWN = 0,
	ITEM_USE_WEAR = 1,
	ITEM_USE_CHECKEQUIP = 2,
	ITEM_USE_DBLCLICK = 3
};

const SKILLADV_DONTRAISE = 0;
const SKILLADV_RAISE = 1;

enum
{
	DISPELTYPE_UNKNOWN = 0,
	DISPELTYPE_DISPEL = 1,
	DISPELTYPE_TIMEOUT = 2,
	DISPELTYPE_GMREMOVE = 3
};

enum
{
	STATCAP_CAP = 0,
	STATCAP_STR = 1,
	STATCAP_DEX = 2,
	STATCAP_INT = 3
};

const REPUTATION_KARMA = 1;
const REPUTATION_FAME = 2;

const DECAYTYPE_UNKNOWN = 0;
const DECAYTYPE_DECAY = 1;
const DECAYTYPE_GMREMOVE = 2;





enum
{
	POISON_NONE = 0,
	POISON_LESSER = 1,
	POISON_STANDARD = 2,
	POISON_GREATER = 3,
	POISON_DEADLY = 4
};

const BANKBOX_BANK = 0;
const BANKBOX_WARE = 1;
const BANKBOX_SPECIAL = 1;

const EVENTTYPE_STATIC = 0;
const EVENTTYPE_DYNAMIC = 1;

enum
{
	EVENT_ITM_ONSTART = 0,
        EVENT_ITM_ONDAMAGE,
        EVENT_ITM_ONEQUIP,
        EVENT_ITM_ONUNEQUIP,
        EVENT_ITM_ONCLICK,
        EVENT_ITM_ONDBLCLICK,
        EVENT_ITM_ONPUTINBACKPACK,
        EVENT_ITM_ONDROPINLAND,
        EVENT_ITM_ONCHECKCANUSE,
        EVENT_ITM_ONTRANSFER,
        EVENT_ITM_ONSTOLEN,
        EVENT_ITM_ONPOISONED,
        EVENT_ITM_ONDECAY,
        EVENT_ITM_ONREMOVETRAP,
        EVENT_ITM_ONLOCKPICK,
        EVENT_ITM_ONWALKOVER,
        EVENT_ITM_ONPUTITEM,
        EVENT_ITM_ONTAKEFROMCONTAINER,
        ALLITEMEVENTS
};

enum
{
	EVENT_CHR_ONDEATH = 0,
	EVENT_CHR_ONWOUNDED,
	EVENT_CHR_ONHIT,
	EVENT_CHR_ONHITMISS,
	EVENT_CHR_ONGETHIT,
	EVENT_CHR_ONREPUTATIONCHG,
	EVENT_CHR_ONDISPEL,
	EVENT_CHR_ONRESURRECT,
	EVENT_CHR_ONFLAGCHG,
	EVENT_CHR_ONWALK,
	EVENT_CHR_ONADVANCESKILL,
	EVENT_CHR_ONADVANCESTAT,
	EVENT_CHR_ONBEGINATTACK,
	EVENT_CHR_ONBEGINDEFENSE,
	EVENT_CHR_ONTRANSFER,
	EVENT_CHR_ONMULTIENTER,
	EVENT_CHR_ONMULTILEAVE,
	EVENT_CHR_ONSNOOPED,
	EVENT_CHR_ONSTOLEN,
	EVENT_CHR_ONPOISONED,
	EVENT_CHR_ONREGIONCHANGE,
	EVENT_CHR_ONCASTSPELL,
	EVENT_CHR_ONGETSKILLCAP,
	EVENT_CHR_ONGETSTATCAP,
	EVENT_CHR_ONBLOCK,
	EVENT_CHR_ONSTART,
	EVENT_CHR_ONHEARTBEAT,
	EVENT_CHR_ONBREAKMEDITATION,
	EVENT_CHR_ONCLICK,
	EVENT_CHR_ONMOUNT,
	EVENT_CHR_ONDISMOUNT,
	EVENT_CHR_ONKILL,
	EVENT_CHR_ONHEARPLAYER,
	EVENT_CHR_ONDOCOMBAT,
	EVENT_CHR_ONCOMBATHIT,
	EVENT_CHR_ONSPEECH,
	EVENT_CHR_ONCHECKNPCAI,
	EVENT_CHR_ONDIED,
	EVENT_CHR_MAX
};
