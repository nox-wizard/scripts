// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard	: Embedded Small Scripts			||
// || Maintained by	: Luxor, Sparhawk				||
// || Last Update	: 06-apr-2003					||
// || Designed for NXW 	: 0.82						||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#if defined _nxw_character_constant_
  #endinput
#endif
#define _nxw_character_constant_

const PROP_CHARACTER = 0;

/** \defgroup script_API_character_constants constants
*   \ingroup script_API_character
 *  @{
 */

/** \defgroup CP_ CP_
 *  @{
 */
const CP_CANTRAIN = 0;		//!< true if the character can train others
const CP_DEAD = 1;		//!< true if character is dead
const CP_FREE = 2;		//!< unused at the moment, no longer needed, CP_OWNSERIAL can be set too and is != 0 if npc is tamed
const CP_GUARDED = 3;		//!< ??
const CP_GUILDTRAITOR = 4;	//!< true if character is guild traitor
const CP_JAILED = 5;		//!< true if character is jailed
const CP_INCOGNITO = 6;		//!< true if under incognito effect, double with tempfx_isactive?
const CP_ONHORSE = 7;		//!< true if character is on a mount
const CP_POLYMORPH = 8;		//!< true if under polimorph effect
const CP_TAMED = 9;		//!< true if tamed, no longer needed, CP_OWNSERIAL can be set too and is != 0 if npc is tamed
const CP_UNICODE = 10;		//!< true if player uses unicode speech
const CP_SHOPKEEPER = 11;	//!< true if character is a shopkeeper
const CP_ATTACKFIRST = 12;	//!< true if charcater attacked, flase if character is defending
const CP_ISBEINGTRAINING = 13; 	//!< true if character is being trained
const CP_GUILDTOGGLE = 14;	//!< true if character has guild name toggle
const CP_OVERWEIGHTED = 15;	//!< true if overweighted
const CP_MOUNTED = 16;		//!< true if mounted - can we merge this with CP_ONHORSE? So 0 means nothing, 1 means is mounted and 2 means is ridden by someone?
const CP_FROZEN = 17;		//!< true if frozen - double with freeze priv flag?

const CP_BLOCKED = 101;		//!< ??
//const CP_CELL = 102;		//!< jail cell number, merge with CP_JAIL after region and location get merged - seems deprecated
const CP_PRIVLEVEL = 103;	//!< the command priv level: 255 admin
const CP_DIR = 104;		//!< direction, one of the DIR_* constants TODO: link to list
const CP_DIR2 = 105;		//!< ??
const CP_FIXEDLIGHT = 106;	//!< fixed light level TODO: link to light levels
const CP_FLAG = 107;		//!< reputation flag: 1=red 2=grey 4=Blue 8=green 10=Orange
const CP_FLY_STEPS = 108;	//!< number of step the creature flies if it can fly
const CP_GMRESTRICT = 109;	//!< 0: no GM restriction, else contains the region the GM is restricted in
const CP_HIDDEN = 110;		//!< 0: not hidden 1:hidden 2:hidden by spell
const CP_LOCKSKILL = 112;	//!< array property - use a SK_* constant as subproperty to read it. values: 0:not locked 1:?? 2:?? TODO: link to SK_*
const CP_NPC = 114;		//!< 1 if character is npc
const CP_NPCTYPE = 115;		//!< currently only used for stabling, (type==1 -> stablemaster), CP_NPCAI includes stable master too, so not needed anymore?
const CP_NPCWANDER = 116;	//!< wander mode: controls how the npc moves around. contains one of the WANDER_* constants
const CP_OLDNPCWANDER = 117;	//!< used for fleeing npcs, is wander mode before the flee
//const CP_ORGSKIN = 118;		//!< unused ?? - seems to be deprecated
const CP_PRIV2 = 121;		//!< the priv2 flag TODO:link to priv2 list
const CP_REACTIVEARMORED = 122;	//!< reactive armor spell
const CP_REGION = 123;		//!< the region the character is in
const CP_SHOP = 125; 		//!< Sparhawk DEPRECIATED use CP_SHOPKEEPER
const CP_SPEECH = 127;		//!< For NPCs: Number of the assigned speech block
const CP_WAR = 128;		//!< war mode
const CP_NXWFLAGS = 131;	//!< array[4] property - for special nxw features - still needed?
const CP_RESISTS = 132;		//!< array property - index with one of the DAMAGE_* canstants - contains RESISTANCE to damage types (0:no RESISTANCE 100: full RESISTANCE) TODO: link to DAMAGE_*
const CP_TRAININGPLAYERIN = 133;//!< the skill the char is training a player in
const CP_PRIV = 134;		//!< priv flags TODO:link to PRIV list
const CP_DAMAGETYPE = 135;	//!< only npc, the damage type, one of the DAMAGE_* constants TODO:link to DAMAGE_*

const CP_ACCOUNT = 200;		//!< account number
const CP_ADVOBJ = 201;		//!< if character used advancement gate, this is the serial of the gate
const CP_ATT = 202;		//!< attack power
const CP_ATTACKER = 203;	//!< if the character is attacked, this is the attacker's serial
const CP_BEARDSERIAL = 205;	//!< serial of the beard item
//const CP_CALLNUM = 207;		//!< used for GM paging - seems to be deprecated
const CP_CARVE = 208;		//!< internal, used for carving system
const CP_CASTING = 209;		//!< true if the char is casting
const CP_CLIENTIDLETIME = 210;	//!<
const CP_COMBATHITMESSAGE = 211;//!<
const CP_CREATIONDAY = 212;	//!<
const CP_CRIMINALFLAG = 213;	//!< time the char will remain criminal
const CP_DEATHS = 214;		//!< number of deaths
const CP_DEF = 215;		//!< defense value
const CP_DEXTERITY = 216;	//!< dexterity, use stat subproperties to get appropriate values
const CP_DISABLED = 217;	//!< true if the char is disabled
const CP_FAME = 218;		//!< fame
const CP_FLEEAT = 219;		//!< HP at wich the char starts fleeing
const CP_FOODPOSITION = 220;	//!<location where npc goes to eat, CP_NPCWANDER must be WANDER_FREELY, use CP2_X CP2_Y CP2_Z as subproperties
const CP_FPOS1_NPCWANDER = 221;	//!< first box corner when wnader mode is WANDER_FREELY_BOX, use CP2_X, CP2_Y, CP2_Z as subproperties
const CP_FPOS2_NPCWANDER = 222;	//!< second box corner when wnader mode is WANDER_FREELY_BOX, use CP2_X, CP2_Y as subproperties
const CP_FTARG = 223;		//!< npc follow target, the serial of the character the npc should follow
const CP_GMMOVEEFF = 224;	//!< move effect for GMs
const CP_GUILDFEALTY = 225;	//!< serial of the loyalty declaration in the guildstone
const CP_GUILDNUMBER = 226;	//!< guild the player is in
const CP_HAIRSERIAL = 229;	//!< serial of the hair item
const CP_HAIRSTYLE = 230;	//!< hair style TODO: link to hair styles
const CP_HIDAMAGE = 231;	//!< npc only - maximum damage an NPC can do in combat
const CP_HOLDGOLD = 232;	//!< gold kept by player vendors
const CP_HOMELOCPOS = 233;	//!< location where npc goes to sleep, CP_NPCWANDER must be WANDER_FREELY, use CP2_X CP2_Y CP2_Z as subproperties
const CP_HUNGER = 234;		//!< level of hungerness 6= full  0=empty - no longer needed since stored in AMX-local var 1002 and 1003 (thirst)
const CP_HUNGERTIME = 235;	//!< timer used for hungerness - no longer needed because of tempfx set time for all chars
const CP_INTELLIGENCE = 236;	//!< intelligence
const CP_KARMA = 237;		//!< karma
const CP_KEYNUMBER = 238;	//!< for renaming keys - no longer needed?
const CP_KILLS = 239;		//!< number of kills
const CP_LODAMAGE = 240;	//!< npc only - minimum damage an npc can do in combat
const CP_LOGOUT = 241;		//!< time till logout for this char, -1 means in the world
const CP_MAKING = 242;		//!< skill used to make the item the char is making
const CP_MEDITATING = 243;	//!< true if character is meditating
const CP_MULTISERIAL = 245;	//!<
const CP_MURDERERSER = 246;	//!< serial of the murderer
const CP_MURDERRATE = 247;	//!< time to murdercount decay
const CP_MUTETIME = 248;	//!< time to end of squelch
const CP_NAMEDEED = 249;	//!< name deed serial - really needed? for what do we need the name deed serial? why not if temporary the incognito function?
const CP_NEXTACT = 250;		//!< time to next spell action
const CP_NPCAI = 251;		//!< npc AI type
const CP_NPCMOVETIME = 252;	//!<
const CP_OBJECTDELAY = 253;	//!< time till a new object can be used
const CP_OLDPOS = 254;		//!< old position, usually used for gates
const CP_OWNSERIAL = 255;	//!< npc only - owner's serial, for tamed animals
const CP_PACKITEM = 256;	//!< the backpack serial
const CP_POISON = 257;		//!< type of poison attack
const CP_POISONED = 258;	//!< type of poison if the char is poisoned
const CP_POISONTIME = 259;	//!< poison damage timer
const CP_POISONTXT = 260;	//!< poison text timer
const CP_POISONWEAROFFTIME = 261;//!< poison expire time
const CP_POSITION = 262;	//!< position, use CP2_X CP2_Y CP2_Z as subproperties
const CP_POSTTYPE = 263;	//!<
const CP_PREVPOS = 264;		//!< previous position
const CP_PRIV3 = 265;		//!< gm commands privileges
const CP_QUESTBOUNTYPOSTSERIAL = 266;//!<
const CP_QUESTBOUNTYREWARD = 267;//!<
const CP_QUESTDESTREGION = 268;	//!<
const CP_QUESTORIGREGION = 269;	//!<
const CP_REATTACKAT = 270;	//!< when the character begins to reattack
const CP_REGENRATE = 271;	//!< seconds between 2 1 point regenerations, use CP2_REGEN_ constants as subproperties
const CP_SCRIPTID = 272;	//!< npc only - the XSS script id of the npc definition
const CP_GUILD = 273;		//!< the guild a character belongs to
const CP_ROBE = 274;		//!< death robe serial -> no longer needed (getItemfromLayer)
const CP_RUNNING = 275;		//!< true if the character is running
const CP_SERIAL = 276;		//!< useless, is the same as the character number (the chr value) -> no longer needed because socket is not used anymore
const CP_SKILLDELAY = 277;	//!< time to next skill use -> still needed? we have CP_DISABLED
const CP_SMELTITEM = 278;	//!< item the char is smelting -> needed for anything???
const CP_SMOKEDISPLAYTIME = 279;//!< time till smoke display
const CP_SMOKE = 280;		//!<
const CP_SPADELAY = 281;	//!< delay between spell attacks
const CP_SPATIMER = 282;	//!< spell attack timer
const CP_SPATTACK = 283;	//!< type of spell attack
const CP_SPAWNREGION = 284;	//!< region from wich the char spawned
const CP_SPAWNSERIAL = 285;	//!< serial of the spawner
const CP_SPELL = 286;		//!< the spell the character is casting
const CP_SPELLACTION = 287;	//!<
const CP_SPELLTIME = 288;	//!<
const CP_SPLIT = 290;		//!< split pieces
const CP_SPLITCHNC = 291;	//!< chance of splitting
const CP_SQUELCHED = 292;	//!< true if the char is squelched -> merge with CP_MUTETIME ? 0 means it is not squelched, otherwise how long still muted, -1 means muted eternal
const CP_STABLEMASTER_SERIAL = 293;//!< serial of the stable master
const CP_STEALTH = 294;		//!< true if the char is stealthing -> still needed? what is the difference to CP_HIDDEN?
const CP_STRENGTH = 295;	//!< strength
const CP_SUMMONTIMER = 296;	//!< timer befor unsummoning
const CP_SWINGTARG = 297;	//!< target that will be hit by the weapon swing, used internally for combat
//const CP_TAILITEM = 298;	//!< seems to be deprecated
const CP_TAMING = 299;		//!< taming needed to tame the npc
const CP_TARG = 300;		//!< character's attacked target, used internally for combat
const CP_TARGTRIG = 301;	//!< trigger to be launched on target choice -> still needed? we have events for hitting and we have target, what is special here? is it string?
const CP_TEMPFLAGTIME = 302;	//!<
const CP_TIME_UNUSED = 303;	//!<
const CP_TIMEOUT = 304;		//!<
const CP_TIMEUSED_LAST = 305;	//!<
const CP_TRAINER = 309;		//!< if npc can train players
const CP_FLEETIMER = 310;	//!<
const CP_TRIGGER = 311;		//!< trigger for NPCs
const CP_WEIGHT = 312;		//!< weight
const CP_WORKLOCPOS = 313;	//!< location where the npc goes to work at day, CP_NPCWANDER must be WANDER_FREELY. UseCP2_x CP2_Y CP2_Z as subproperties
const CP_AMXFLAGS = 314;	//!< use local vars instead
const CP_NPCRACE = 315;		//!<
const CP_LASTMOVETIME = 319;	//!<
const CP_PARTY = 320;		//!<

const CP_BASESKILL = 400;	//!<
const CP_SKILL = 401;		//!<
const CP_GUILDTYPE = 402;	//!<
const CP_ID = 403;		//!<
const CP_SKIN = 404;		//!<
const CP_XID = 405;		//!<
const CP_XSKIN = 406;		//!<
const CP_ICON = 407;		//!<
const CP_SOUND = 408;		//!<
const CP_RACE = 409;		//!<
const CP_TOTALSKILL = 410;	//!< sum of the skills values

const CP_STR_DISABLEDMSG = 450;	//!<
const CP_STR_GUILDTITLE = 451;	//!<
const CP_STR_NAME = 453;	//!< name of the character
const CP_STR_ORGNAME = 454;	//!<
const CP_STR_TITLE = 455;	//!< title of the character
const CP_STR_TRIGWORD = 456;	//!<
const CP_STR_SPEECHWORD = 457;	//!< word/phrase in speech that triggered speech override
const CP_STR_SPEECH = 458; 	//!< entire speech that contains word/phrase that triggered speech override
const CP_STR_ACCOUNT = 459; 	//!< Account name of current player
const CP_STR_PASSWORD = 460; 	//!< password of current player
const CP_STR_PARAM = 461; 	//!< Params given by the character with the last command called

const CP_UNI_SPEECH_CURRENT = 500;//!<
const CP_UNI_PROFILE = 501;	//!<
/** @} */
/** \defgroup CP2_ CP2_
 *  @{
 */
//second cp for positions
const CP2_X = 0;		//!< X subproperty of CP_POSITION
const CP2_Y = 1;		//!< Y subproperty of CP_POSITION
const CP2_Z = 2;		//!< Z subproperty of CP_POSITION
const CP2_DZ = 3;		//!< DZ subproperty of CP_POSITION (same as Z)
const CP2_DISPZ = 3;		//!< DISPZ subproperty of CP_POSITION (same as Z)

//second cp for generic stat
const CP2_EFF   = 0;		//!< effective value of a stat
				/*!< This value is the effective stat value, including bonuses and maluses */
const CP2_DEC  = 1;		//!< decimal value of a stat
				/*!< when this number reaches 1000 the stat is increased by 1 */
const CP2_REAL = 2;		//!< real value of a stat
				/*!< this is the real unmodified value, not including any bonuses/maluses */
const CP2_ACT  = 3;		//!< actual value of a stat
				/*!< this value maps into hp for str, mana for int, stamina for dex */

//second cp for strenght (more readable :))
const CP2_STR   = 0;		//!< strenght effective value
const CP2_STRDEC  = 1;		//!< strenght decimal value
const CP2_STRREAL = 2;		//!< strenght real value
const CP2_HITPOINTS  = 3;	//!< strenght actual value (HP)
const CP2_HP  = 3;		//!< hit point (same as HITPOINTS)

//second cp for dexterity (more readable :))
const CP2_DEX  = 0;		//!< dexterity effective value
const CP2_DEXDEC  = 1;		//!< dexterity decimal value
const CP2_DEXREAL = 2;		//!< dexterity real value
const CP2_STAMINA  = 3;		//!< dexterity actual value (stamina)

//second cp for intelligence (more readable :))
const CP2_INT   = 0;		//!< intelligence effective value
const CP2_INTDEC  = 1;		//!< intelligence decimal value
const CP2_INTREAL = 2;		//!< intelligence real value
const CP2_MANA  = 3;		//!< intelligence actual value (mana)

//constants to be used with chr_applyDamage as stat parameter
const STAT_HP = 0;
const STAT_MANA = 1;
const STAT_STAMINA = 2;


//property for regenerate
const CP2_REGEN_HP = 0;		//!< HP regen rate
const CP2_REGEN_MANA = 1;	//!< MANA regen rate
const CP2_REGEN_STAMINA = 2;	//!< STAMINA regen rate

//property for applyDamage
const CP2_DAMAGE_HP = 0;	//!< subproperty for applyDamage, damages HP
const CP2_DAMAGE_MANA = 1;	//!< subproperty for applyDamage, damages MANA
const CP2_DAMAGE_STAMINA = 2;	//!< subproperty for applyDamage, damages STAMINA

const CP2_STARTATTACK = 0;	//!< ??
const CP2_IDLE = 1;		//!< ??
const CP2_ATTACK = 2;		//!< ??
const CP2_DEFEND = 3;		//!< ??
const CP2_DIE = 4;		//!< ??
/** @} */

enum {
	GENDER_MALE,		//!< ??
	GENDER_FEMALE,		//!< ??
	GENDER_UNDEFINED	//!< ??
	}

const SPEECH_NORMAL = 1;		//!<
const SPEECH_RUNIC = 2;		//!<
const SPEECH_EMOTE = 3;		//!<

const NXWF0_GREY = 1;		//!<
const NXWF0_PERMAGREY = 2;	//!<

const WANDER_NOMOVE = 0;	//!<
const WANDER_FOLLOW = 1;	//!< npc will follow the character specified in CP_FTARG
const WANDER_FREELY_CIRCLE = 2;	//!<
const WANDER_FREELY_BOX = 3;	//!< npc will wander in box with corners in CP_FPOS1_NPCWANDER, CP_FPOS2_NPCWANDER
const WANDER_FREELY = 4;	//!<
const WANDER_FLEE = 5;		//!<
const WANDER_AMX = 6;		//!< ???

const BODY_MALE = 0x190;	//!<
const BODY_FEMALE = 0x191;	//!<
const BODY_DEADMALE = 0x192;	//!<
const BODY_DEADFEMALE = 0x193;	//!<
const BODY_GMSTAFF = 0x03DB;	//!<

//bitfields for priv flag
const PRIV_ISGM = 0x01;		//!<
const PRIV_CANBROADCAST = 0x02;	//!<
const PRIV_INVULNERABLE = 0x04;	//!<
const PRIV_CANSEESERIALS = 0x08;//!<
const PRIV_NOSKILLTITLES = 0x10;//!<
const PRIV_GMPAGEABLE = 0x20;	//!<
const PRIV_CANSNOOP = 0x40;	//!<
const PRIV_ISCOUNSELOR = 0x80;	//!<

//bitfields for priv2 flag
const PRIV2_ALLMOVE = 0x01;	//!<
const PRIV2_FROZEN = 0x02;	//!<
const PRIV2_VIEWHOUSESASICON = 0x04;//!<
const PRIV2_PERMAHIDDEN = 0x08;	//!<
const PRIV2_NONEEDMANA = 0x10;	//!<
const PRIV2_DISPELLABLE = 0x20;	//!<
const PRIV2_PERMAMAGICREFLECT = 0x40;//!<
const PRIV2_NONEEDREAGS = 0x80;	//!<

/** @} */