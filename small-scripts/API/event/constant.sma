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

/*!
\brief constants for the type parameter in the @ONDISPEL event
*/
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

/*! \defgroup EVENT_ITM_ON_ item events
    \ingroup script_API_item_constants
    @{
*/
enum
{
	/*!
	<B>callback prototype:</B> <br>
	<UL>
	<LI>
	</UL>
	<B>called when:</B><br>
	<B>bypass:</B><br>
	<B>return:</B><br>
	<B>notes:</B>
	*/
	EVENT_ITM_ONSTART = 0,

        /*!
	<B>callback prototype:</B> public mycallback(itm, victim, damage, attacker)<br>
	<UL>
	<LI> itm: the item
	<LI> victim: the victim of the damage
	<LI> damage: damage amount
	<LI> attacker: the character who caused the damage
	</UL>
	<B>called when:</B> an item is damaging a character<br>
	<B>bypass:</B> avoids damage<br>
	<B>return:</B> the damage to be done<br>
	<B>notes:</B> called after EVENT_CHR_ONWOUNDED, returning 0 is better than bypassing
	*/
	EVENT_ITM_ONDAMAGE,

        /*!
	<B>callback prototype:</B> public mycallback(itm, chr)<br>
	<UL>
	<LI> itm: the item being equipped
	<LI> chr: the character equipping the item
	</UL>
	<B>called when:</B> an item is equipped<br>
	<B>bypass:</B> prevents the item from being equipped<br>
	<B>return:</B> nothing<br>
	<B>notes:</B>
	*/
	EVENT_ITM_ONEQUIP,

        /*!
	<B>callback prototype:</B> public mycallback(itm, chr)<br>
	<UL>
	<LI> itm: the item being unequipped
	<LI> chr: the character unequipping the item
	</UL>
	<B>called when:</B> an item is unequipped<br>
	<B>bypass:</B> keeps the item equipped<br>
	<B>return:</B> nothing<br>
	<B>notes:</B>
	*/
	EVENT_ITM_ONUNEQUIP,

        /*!
	<B>callback prototype:</B> public mycallback(itm, chr)<br>
	<UL>
	<LI> itm: the item clicked
	<LI> chr: the character who clicked
	</UL>
	<B>called when:</B> an item is clicked once<br>
	<B>bypass:</B> avoids the standard code<br>
	<B>return:</B> nothing<br>
	<B>notes:</B>
	*/
	EVENT_ITM_ONCLICK,

        /*!
	<B>callback prototype:</B> public mycallback(itm, chr)<br>
	<UL>
	<LI> itm: the item doubleclicked
	<LI> chr: the character who double clicked the item
	</UL>
	<B>called when:</B> a character doubleclicks an item<br>
	<B>bypass:</B> avoids standard code<br>
	<B>return:</B> nothing<br>
	<B>notes:</B>
	*/
	EVENT_ITM_ONDBLCLICK,

        /*!
	<B>callback prototype:</B><br>
	<UL>
	<LI>
	</UL>
	<B>called when:</B><br>
	<B>bypass:</B> <br>
	<B>return:</B> <br>
	<B>notes:</B>
	*/
	EVENT_ITM_ONPUTINBACKPACK,

        /*!
	<B>callback prototype:</B> <br>
	<UL>
	<LI>
	</UL>
	<B>called when:</B> <br>
	<B>bypass:</B> <br>
	<B>return:</B> <br>
	<B>notes:</B>
	*/
	EVENT_ITM_ONDROPINLAND,

        /*!
	<B>callback prototype:</B> <br>
	<UL>
	<LI>
	</UL>
	<B>called when:</B> <br>
	<B>bypass:</B> <br>
	<B>return:</B> <br>
	<B>notes:</B>
	*/
	EVENT_ITM_ONCHECKCANUSE,

        /*!
	<B>callback prototype:</B> public mycallback(itm, chr1, chr2)<br>
	<UL>
	<LI> itm: the item being transferred
	<LI> chr1: the old owner
	<LI> chr2: the new owner
	</UL>
	<B>called when:</B> an item is traded between two characters<br>
	<B>bypass:</B> the item is not tranferred<br>
	<B>return:</B> nothing<br>
	<B>notes:</B> when transfering a container this event is called for each item in the container
	*/
	EVENT_ITM_ONTRANSFER,

        /*!
	<B>callback prototype:</B> public mycallback(itm, chr, victim)<br>
	<UL>
	<LI> itm: the item being stolen
	<LI> chr: the thief
	<LI> victim: the victim
	</UL>
	<B>called when:</B> an item is stolen<br>
	<B>bypass:</B> avoids the stealing<br>
	<B>return:</B> nothing<br>
	<B>notes:</B>
	*/
	EVENT_ITM_ONSTOLEN,

        /*!
	<B>callback prototype:</B> public mycallback(itm, chr, poison)<br>
	<UL>
	<LI> itm: the item being poisoned
	<LI> chr: the poisoner
	<LI> poison: the type of poison
	</UL>
	<B>called when:</B> someone is applying poison to an item<br>
	<B>bypass:</B> avoids the standard code<br>
	<B>return:</B> the type of poison to be applied, one of the POISON_ constants<br>
	<B>notes:</B> returning POISON_NONE will delete the bottle
	*/
	EVENT_ITM_ONPOISONED,

        /*!
	<B>callback prototype:</B> public mycallback(itm, chr, decaytipe)<br>
	<UL>
	<LI> itm: the item dacaying
	<LI> chr: the character who clicked
	<LI> decaytipe: one of the DECAYTYPE_ constants
	</UL>
	<B>called when:</B> an item is decaying<br>
	<B>bypass:</B> avoids decay, not allowed if decaytype is DECAYTYPE_GMREMOVE<br>
	<B>return:</B> nothing<br>
	<B>notes:</B>
	*/
	EVENT_ITM_ONDECAY,

        /*!
	<B>callback prototype:</B> public mycallback(itm, chr)<br>
	<UL>
	<LI> itm: the item
	<LI> chr: the disarmer
	</UL>
	<B>called when:</B> someone tries to disarm a trap<br>
	<B>bypass:</B> NO<br>
	<B>return:</B> nothing<br>
	<B>notes:</B> used to implement custom traps
	*/
	EVENT_ITM_ONREMOVETRAP,

        /*!
	<B>callback prototype:</B> public mycallback(itm, chr)<br>
	<UL>
	<LI> itm: the item
	<LI> chr: the thief
	</UL>
	<B>called when:</B> someone tries to lockpick an item<br>
	<B>bypass:</B> avoids standard code<br>
	<B>return:</B> nothing<br>
	<B>notes:</B> called befor checking if the item is lockpickable
	*/
	EVENT_ITM_ONLOCKPICK,

        /*!
	<B>callback prototype:</B> public mycallback(itm, chr)<br>
	<UL>
	<LI> itm: the item
	<LI> chr: the character who walked on the item
	</UL>
	<B>called when:</B> someone is walking over an item<br>
	<B>bypass:</B> avoids the standard code<br>
	<B>return:</B> nothing<br>
	<B>notes:</B>
	*/
	EVENT_ITM_ONWALKOVER,

        /*!
	<B>callback prototype:</B> <br>
	<UL>
	<LI>
	</UL>
	<B>called when:</B> <br>
	<B>bypass:</B> <br>
	<B>return:</B> <br>
	<B>notes:</B>
	*/
	EVENT_ITM_ONPUTITEM,

        /*!
	<B>callback prototype:</B> <br>
	<UL>
	<LI>
	</UL>
	<B>called when:</B> <br>
	<B>bypass:</B> <br>
	<B>return:</B> <br>
	<B>notes:</B>
	*/
	EVENT_ITM_ONTAKEFROMCONTAINER,

	ALLITEMEVENTS
};
/* @} */

/*! \defgroup EVENT_CHR_ON_ EVENT_CHR_
    \ingroup script_API_character_constants
    @{
*/

/*!
<B>callback prototype:</B> public mycallback(chr)<br>
<UL>
<LI> chr: the character who's dieing
</UL>
<B>called when:</B> befor the death sequence<br>
<B>bypass:</B> avoids death, howewer you should remove the death's cause<br>
<B>return:</B> nothing<br>
<B>notes:</B> not called for pplayer vendors, dead characters and invulnerable characters
*/
const EVENT_CHR_ONDEATH		=  0;
const EVENT_CHR_ONBEFOREDEATH	=  0;

/*!
<B>callback prototype:</B> public mycallback(chr,damage,attacker)<br>
<UL>
<LI> chr: the character who's being wounded
<LI> damage: the damage amount
<LI> attacker: the character who is damaging chr
</UL>
<B>called when:</B> a character is damaged<br>
<B>bypass:</B> avoids the damage<br>
<B>return:</B> nothing<br>
<B>notes:</B>
*/
const EVENT_CHR_ONWOUNDED	=  1;

/*!
<B>callback prototype:</B> public mycallback(attacker, defender)<br>
<UL>
<LI> attacker: the character who attacks
<LI> defender: the character who defends
</UL>
<B>called when:</B> the attacker hits the defender<br>
<B>bypass:</B> avoids the hit<br>
<B>return:</B> nothing<br>
<B>notes: called right before EVENT_CHR_ONGETHIT and before any damage calculation</B>
*/
const EVENT_CHR_ONHIT		=  2;

/*!
<B>callback prototype:</B> public mycallback(attacker, defender)<br>
<UL>
<LI> attacker: the character who attacks
<LI> defender: the character who defends
</UL>
<B>called when:</B> the attacker misses the defender<br>
<B>bypass:</B> avoids sound effects and arrow/bolt firing<br>
<B>return:</B> nothing<br>
<B>notes:</B>
*/
const EVENT_CHR_ONHITMISS	=  3;

/*!
<B>callback prototype:</B> public mycallback(defender, attacker)<br>
<UL>
<LI> defender: the character who defends
<LI> attacker: the character who attacks
</UL>
<B>called when:</B> the defender is hit by the attacker<br>
<B>bypass:</B> avoids the hit<br>
<B>return:</B> nothing<br>
<B>notes: called right after EVENT_CHR_ONHIT and before any damage calculation</B>
*/
const EVENT_CHR_ONGETHIT	=  4;

/*!
<B>callback prototype:</B> public mycallback(character, amount, karmaorfame)<br>
<UL>
<LI> character: the character whose karma or fame changed
<LI> amount: change amount, can be negative
<LI> karmaorfame: what changed REPUTATION_KARMA or REPUTATION_FAME
</UL>
<B>called when:</B> character's karma or fame changes<br>
<B>bypass:</B> avoids karma/fame change messages<br>
<B>return:</B> nothing<br>
<B>notes: to avoid the change you should restore the old value by adding the change to the current karma/fame value</B>
*/
const EVENT_CHR_ONREPUTATIONCHG	=  5;

/*!
<B>callback prototype:</B> public mycallback(chr, dispeller, type)<br>
<UL>
<LI> chr: the character being dispelled
<LI> dispeller: the charater who's dispelling chr
<LI> type: one of \ref DISPELTYPE_
</UL>
<B>called when:</B> the char is being dispelled<br>
<B>bypass:</B> can't bypass if type is DISPEL_GMREMOVE, in other cases you should remove the dispel cause<br>
<B>return:</B> nothing<br>
<B>notes: on dispel spell this event is called befor checking if the creature is dispellable</B>
*/
const EVENT_CHR_ONDISPEL	=  6;

/*!
<B>callback prototype:</B> public mycallback(chr, healer)<br>
<UL>
<LI> chr: the character who is resurrecting
<LI> healer: the chartcater who is resurrecting chr, if present, else INVALID
</UL>
<B>called when:</B> chr resurrects<br>
<B>bypass:</B> avoids resurrection<br>
<B>return:</B> nothing<br>
<B>notes:</B>
*/
const EVENT_CHR_ONRESURRECT	=  7;

/*!
<B>callback prototype:</B> public mycallback(chr)<br>
<UL>
<LI> chr: the character whose flag is changing
</UL>
<B>called when:</B> the character's flag changes<br>
<B>bypass:</B> NO<br>
<B>return:</B> nothing<br>
<B>notes:</B>
\see \ref script_API_character_constants_flag
*/
const EVENT_CHR_ONFLAGCHG	=  8;

/*!
<B>callback prototype:</B> public mycallback(char, dir, sequence)<br>
<UL>
<LI> chr: the character walking
<LI> dir: the character's direction
<LI> sequence: the sequence number of the walk (used in network packets, generally useless)
</UL>
<B>called when:</B> the character walks or changes direction<br>
<B>bypass:</B> avoids the walk<br>
<B>return:</B> nothing<br>
<B>notes:</B> using this event can be very computationally expensive, pay attention on how you use it
*/
const EVENT_CHR_ONWALK		=  9;

/*!
<B>callback prototype:</B> public mycallback(chr, skill, skillused, default)<br>
<UL>
<LI> chr: the character whose skill should be advanced
<LI> skill: the skill that should be advanced
<LI> skillused: true if the skill was succesfully used
<LI> default: what NOX decided to do: SKILLADV_RAISE or SKILLADV_DONTRAISE
</UL>
<B>called when:</B> a skill is checked for advancement<br>
<B>bypass:</B> avoids skill increase and skill atrophy<br>
<B>return:</B> SKILLADV_RAISE to make the skill raise, SKILLADV_DONTRAISE to make it not raise<br>
<B>notes:</B> this event is not called if the skill is blocked or lowering, or if the skillcap is reached
*/
const EVENT_CHR_ONADVANCESKILL	= 10;

/*!
<B>callback prototype:</B> public mycallback(chr, stat, skillraised, act)<br>
<UL>
<LI> chr: the character whose stat should be advanced
<LI> stat: the stat that should be raised STATCAP_STR, STATCAP_DEX, STATCAP_INT
<LI> skillraised: the skill that caused the stat to increase
<LI> act: the actual value of the stat
</UL>
<B>called when:</B> a stat should have a value advance<br>
<B>bypass:</B> avoids stat advance, actually lose the stat point gained<br>
<B>return:</B> nothing<br>
<B>notes:</B>
*/
const EVENT_CHR_ONADVANCESTAT	= 11;

/*!
<B>callback prototype:</B> public mycallback(attacker, defender)<br>
<UL>
<LI> attacker: the character who is requesting an attack
<LI> defender: the character who is being attacked
</UL>
<B>called when:</B> a character attacks another in any way<br>
<B>bypass:</B> not recomended, bypass avoids reoputation stuff and unhiding<br>
<B>return:</B> nothing<br>
<B>notes:</B> this event is fired on EVERY attack request, even is the the attacked char reacts attacking the attacker
*/
const EVENT_CHR_ONBEGINATTACK	= 12;

/*!
<B>callback prototype:</B> public mycallback(defender, attacker)<br>
<UL>
<LI> defender: the character who is being attacked
<LI> attacker: the character who is requesting an attack
</UL>
<B>called when:</B> after the EVENT_CHR_ONBEGINATTACK<br>
<B>bypass:</B> no<br>
<B>return:</B> nothing<br>
<B>notes:</B> is alway called after EVENT_CHR_ONBEGINATTACK
*/
const EVENT_CHR_ONBEGINDEFENSE	= 13;

/*!
<B>callback prototype:</B> public mycallback(chr, newowner)<br>
<UL>
<LI> oldowner: the character that is being transferred
<LI> newowner: the new owner
</UL>
<B>called when:</B> a character is transferred<br>
<B>bypass:</B> avoids the transfer<br>
<B>return:</B> nothing<br>
<B>notes:</B> the event is raised before checking if the character is transferible
*/
const EVENT_CHR_ONTRANSFER	= 14;

/*!
<B>callback prototype:</B> public mycallback()<br>
<UL>
<LI>
</UL>
<B>called when:</B>Char enters a multi (the whole area that is part of the multi, not only inside)<br>
<B>bypass:</B> <br>
<B>return:</B> house serial, char serial, dir, sequence<br>
<B>notes:</B> this needs to be hooked to the HOUSE in house.xss, its not hooked at chars because it needs to be triggered at npc entering too to prevent fetch-exploit for house looting
*/
const EVENT_CHR_ONMULTIENTER	= 15;

/*!
<B>callback prototype:</B> public mycallback()<br>
<UL>
<LI>
</UL>
<B>called when:</B> <br>
<B>bypass:</B> <br>
<B>return:</B> <br>
<B>notes:</B>
*/
const EVENT_CHR_ONMULTILEAVE	= 16;

/*!
<B>callback prototype:</B> public mycallback(chr, snooper)<br>
<UL>
<LI> chr: the character being snooped
<LI> snooper: the character who is snooping chr
</UL>
<B>called when:</B> a charcater is snooped<br>
<B>bypass:</B> avoids the snooping<br>
<B>return:</B> nothing<br>
<B>notes:</B> called before checking if the victim is snoopable and if the snooper is skilled enough to snoop the victim
*/
const EVENT_CHR_ONSNOOPED	= 17;

/*!
<B>callback prototype:</B> public mycallback(chr, thief)<br>
<UL>
<LI> chr: the character being stolen something
<LI> thief: teh charcater who is stealing
</UL>
<B>called when:</B> a character is being stolen something<br>
<B>bypass:</B> avoids the stealing<br>
<B>return:</B> nothing<br>
<B>notes:</B> called after thief skill check. called after EVENT_ITM_ONSTOLEN
*/
const EVENT_CHR_ONSTOLEN	= 18;

/*!
<B>callback prototype:</B> public mycallback()<br>
<UL>
<LI>
</UL>
<B>called when:</B> <br>
<B>bypass:</B> <br>
<B>return:</B> <br>
<B>notes:</B>
*/
const EVENT_CHR_ONPOISONED	= 19;

/*!
<B>callback prototype:</B> public mycallback(chr, oldregion, newregion)<br>
<UL>
<LI> chr: the character who is changing region
<LI> oldregion: the region the character comes from
<LI> newregion: the region the charcater is entering
</UL>
<B>called when:</B> a character passes from a region to another<br>
<B>bypass:</B> NO<br>
<B>return:</B> nothing<br>
<B>notes:</B> called before the standard region change code
*/
const EVENT_CHR_ONREGIONCHANGE	= 20;

/*!
<B>callback prototype:</B> public mycallback(chr, spell, type, sphere)<br>
<UL>
<LI> chr: the charcater who is casting a spell
<LI> spell: the spell number
<LI> type: the type of spell (SPELL_BOOK, SPELL_SCROLL, SPELL_WAND, SPELL_NPC)
<LI> sphere: the sphere for NPC spells
</UL>
<B>called when:</B> a charcater casts a spell<br>
<B>bypass:</B> avoid casting<br>
<B>return:</B> nothing<br>
<B>notes:</B>
*/
const EVENT_CHR_ONCASTSPELL	= 21;

/*!
<B>callback prototype:</B> public mycallback(chr)<br>
<UL>
<LI> chr: the character
</UL>
<B>called when:</B> NOX checks for a custom skillcap<br>
<B>bypass:</B> NO<br>
<B>return:</B> the skill cap value (not multiplied by 10, so 700 for a 700 skillpoints cap you shuld return 700)<br>
<B>notes:</B>
*/
const EVENT_CHR_ONGETSKILLCAP	= 22;

/*!
<B>callback prototype:</B> public mycallback(chr, stat, default)<br>
<UL>
<LI> chr: the character
<LI> stat: the stat the engine wafnts to know a custom cap about (STATCAP_STR, STATCAP_DEX, STATCAP_INT, STATCAP_CAP)
<LI> dafault: the value the engine decided to aplly to the stat
</UL>
<B>called when:</B> a custom stat-cap is needed<br>
<B>bypass:</B> NO<br>
<B>return:</B> the cap value<br>
<B>notes:</B>
*/
const EVENT_CHR_ONGETSTATCAP	= 23;

/*!
<B>callback prototype:</B> public mycallback(chr, dir, newx, newy)<br>
<UL>
<LI> chr: the character
<LI> dir: the character's direction
<LI> newx: the x coordinate of the blocking cause
<LI> newy: the y coordinate of the blocking cause
<LI>
</UL>
<B>called when:</B> a character gest blocked while walking<br>
<B>bypass:</B> NO<br>
<B>return:</B> nothing<br>
<B>notes:</B>
*/
const EVENT_CHR_ONBLOCK		= 24;

/*!
<B>callback prototype:</B> public mycallback()<br>
<UL>
<LI>
</UL>
<B>called when:</B> <br>
<B>bypass:</B> <br>
<B>return:</B> <br>
<B>notes:</B>
*/
const EVENT_CHR_ONSTART		= 25;

/*!
<B>callback prototype:</B> public mycallback(chr, time)<br>
<UL>
<LI> chr: the character
<LI> time: the current time
</UL>
<B>called when:</B> on every engine loop when a character is doing something<br>
<B>bypass:</B> NO<br>
<B>return:</B> nothing<br>
<B>notes:</B> can slow down the server VERY much!! pay attention on what you are doing
*/
const EVENT_CHR_ONHEARTBEAT	= 26;

/*!
<B>callback prototype:</B> public mycallback(chr)<br>
<UL>
<LI> chr: the character whose meditation has been interrupted
</UL>
<B>called when:</B> somethiung interrupts a character's meditation<br>
<B>bypass:</B> keeps meditation<br>
<B>return:</B> nothing<br>
<B>notes:</B>
*/
const EVENT_CHR_ONBREAKMEDITATION= 27;

/*!
<B>callback prototype:</B> public mycallback(clicked, clicker)<br>
<UL>
<LI> clicked: the character who has been clicked over
<LI> clicker: the character who clicked
</UL>
<B>called when:</B> a charcater is clicked over<br>
<B>bypass:</B> avoids name showing<br>
<B>return:</B> nothing<br>
<B>notes:</B>
*/
const EVENT_CHR_ONCLICK		= 28;

/*!
<B>callback prototype:</B> public mycallback(chr, mount)<br>
<UL>
<LI> chr: the character who is mounting
<LI> mount: the mounted character
</UL>
<B>called when:</B> a character mounts another character<br>
<B>bypass:</B> avoid mounting<br>
<B>return:</B> <br>
<B>notes:</B> called after range check and befor any other check
*/
const EVENT_CHR_ONMOUNT		= 29;

/*!
<B>callback prototype:</B> public mycallback(chr)<br>
<UL>
<LI> chr: the character who has been dismounted
</UL>
<B>called when:</B> a character dismounts from his horse<br>
<B>bypass:</B> keeps the character mounted<br>
<B>return:</B> nothing<br>
<B>notes:</B>
*/
const EVENT_CHR_ONDISMOUNT	= 30;

/*!
<B>callback prototype:</B> public mycallback(killer, killed)<br>
<UL>
<LI> killer: the character who killed someone
<LI> killed: the character killed
</UL>
<B>called when:</B> a character kills another character<br>
<B>bypass:</B> NO<br>
<B>return:</B> nothing<br>
<B>notes:</B>
*/
const EVENT_CHR_ONKILL		= 31;

/*!
<B>callback prototype:</B> public mycallback(chr, talker, isghost)<br>
<UL>
<LI> chr: the character who hears a speech
<LI> talker: the character talking
<LI> isghost: true if talker is a ghost
</UL>
<B>called when:</B> a character talks and someone hears him<br>
<B>bypass:</B> NO<br>
<B>return:</B> nothing<br>
<B>notes:</B> called for each character in a range, the range is: 2 tiles for whispering, VISRANGE for normal talking, 1.5*VISRANGE for yelling
*/
const EVENT_CHR_ONHEARPLAYER	= 32;

/*!
<B>callback prototype:</B> public mycallback(attacker, defender, dist, attackweapon)<br>
<UL>
<LI> attacker: the character who attacks
<LI> defender: the character who defends
<LI> dist: distance between attaacker and defender
<LI> attackweapon: attacker's weapon
</UL>
<B>called when:</B> attacker's combat sequence starts<br>
<B>bypass:</B> avoids combat sequence<br>
<B>return:</B> nothing<br>
<B>notes:</B> bypassing this event is not recomended unless you know how sources work
*/
const EVENT_CHR_ONDOCOMBAT	= 33;

/*!
<B>callback prototype:</B> public mycallback(attacker, defender)<br>
<UL>
<LI> attacker: the character who attacks
<LI> defender: the character who defends
</UL>
<B>called when:</B> the attacker tries to hit the defender, before checking if he actually hits<br>
<B>bypass:</B> avoids the hit<br>
<B>return:</B> <br>
<B>notes:</B> bypassing this event is not recomended unless you know how sources work
*/
const EVENT_CHR_ONCOMBATHIT	= 34;

/*!
<B>callback prototype:</B> public mycallback(chr)<br>
<UL>
<LI> chr: the character who is speaking
</UL>
<B>called when:</B> a character talks<br>
<B>bypass:</B> avoids showing speech<br>
<B>return:</B> nothing<br>
<B>notes:</B> use CP_STR_SPEECH to retrieve the speech string
*/
const EVENT_CHR_ONSPEECH	= 35;

/*!
<B>callback prototype:</B> public mycallback()<br>
<UL>
<LI>
</UL>
<B>called when:</B> <br>
<B>bypass:</B> <br>
<B>return:</B> <br>
<B>notes:</B>
*/
const EVENT_CHR_ONCHECKNPCAI	= 36;

/*!
<B>callback prototype:</B> public mycallback(chr, corpse)<br>
<UL>
<LI> chr: the died character
<LI> corpse: the character's corpse
</UL>
<B>called when:</B> at the end of death sequence<br>
<B>bypass:</B> NO<br>
<B>return:</B> nothing<br>
<B>notes:</B>
*/
const EVENT_CHR_ONDIED		= 37;
/*!
synonim of EVENT_CHR_ONDIED
*/
const EVENT_CHR_ONAFTERDEATH	= 37;

/*!
<B>callback prototype:</B> public mycallback(chr)<br>
<UL>
<LI> chr: the chat opener
</UL>
<B>called when:</B> player presses chat button<br>
<B>bypass:</B> NO<br>
<B>return:</B> nothing<br>
<B>notes:</B>
*/
const EVENT_CHR_ONOPENCHAT		= 38;


/*!
<B>callback prototype:</B> public mycallback(status_requester, chr_status_requested)<br>
<UL>
<LI> status_requester: the char who requests the stat window
<LI> chr_status_requested: the char whose the stat window was requested
</UL>
<B>called when:</B> player presses status button<br>
<B>bypass:</B> NO<br>
<B>return:</B> nothing<br>
<B>notes:</B>
*/
const EVENT_CHR_ONOPENSTATUS		= 39;


/*!
<B>callback prototype:</B> public mycallback(skill_requester)<br>
<UL>
<LI> skill_requester: the chat opener
</UL>
<B>called when:</B> player presses skill button<br>
<B>bypass:</B> NO<br>
<B>return:</B> nothing<br>
<B>notes:</B>
*/
const EVENT_CHR_ONOPENSKILLS		= 40;


/*!
<B>callback prototype:</B> public mycallback(clicked, clicker)<br>
<UL>
<LI> clicked: the character who has been clicked over
<LI> clicker: the character who clicked
</UL>
<B>called when:</B> a character is clicked over<br>
<B>bypass:</B><br>
<B>return:</B> nothing<br>
<B>notes:</B>
*/

const EVENT_CHR_ONDBLCLICK		=41;
/*!
number of events
*/
const EVENT_CHR_MAX		= 42;

/* @} */