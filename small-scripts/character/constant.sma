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

//second cp for positions
const CP2_X = 0;
const CP2_Y = 1;
const CP2_Z = 2;
const CP2_DZ = 3;
const CP2_DISPZ = 3;

//second cp for generic stat
const CP2_EFF   = 0;
const CP2_DEC  = 1;
const CP2_REAL = 2;
const CP2_ACT  = 3;

//second cp for strenght (more readable :))
const CP2_STR   = 0;
const CP2_STRDEC  = 1;
const CP2_STRREAL = 2;
const CP2_HITPOINTS  = 3;
const CP2_HP  = 3;

//second cp for dexterity (more readable :))
const CP2_DEX  = 0;
const CP2_DEXDEC  = 1;
const CP2_DEXREAL = 2;
const CP2_STAMINA  = 3;

//second cp for intelligence (more readable :))
const CP2_INT   = 0;
const CP2_INTDEC  = 1;
const CP2_INTREAL = 2;
const CP2_MANA  = 3;

//second cp for regenerate
const CP2_REGEN_HP = 0;
const CP2_REGEN_MANA = 1;
const CP2_REGEN_STAMINA = 2;


//property list
const CP_CANTRAIN = 0;
const CP_DEAD = 1;
const CP_FREE = 2;
const CP_GUARDED = 3;
const CP_GUILDTRAITOR = 4;
const CP_INCOGNITO = 6;
const CP_ONHORSE = 7;
const CP_POLYMORPH = 8;
const CP_TAMED = 9;
const CP_UNICODE = 10;
const CP_SHOPKEEPER = 11;
const CP_ATTACKFIRST = 12;
const CP_ISBEINGTRAINING = 13;
const CP_GUILDTOGGLE = 14;
const CP_OVERWEIGHTED = 15;

const CP_BLOCKED = 101;
const CP_CELL = 102;
const CP_COMMANDLEVEL = 103;
const CP_DIR = 104;
const CP_DIR2 = 105;
const CP_FIXEDLIGHT = 106;
const CP_FLAG = 107;
const CP_FLY_STEPS = 108;
const CP_GMRESTRICT = 109;
const CP_HIDDEN = 110;
const CP_ID = 111;
const CP_LOCKSKILL = 112;
const CP_MULTISERIAL2 = 113;
const CP_NPC = 114;
const CP_NPCTYPE = 115;
const CP_NPCWANDER = 116;
const CP_OLDNPCWANDER = 117;
const CP_ORGSKIN = 118;
const CP_OWNSERIAL2 = 119;
const CP_PRIV2 = 121;
const CP_REACTIVEARMORED = 122;
const CP_REGION = 123;
const CP_SERIAL2 = 124;
const CP_SHOP = 125; //Sparhawk DEPRECIATED use CP_SHOPKEEPER
const CP_SKIN = 126;
const CP_SPEECH = 127;
const CP_WAR = 128;
const CP_XID = 129;
const CP_XSKIN = 130;
const CP_NXWFLAGS = 131;
const CP_RESISTS = 132;
const CP_TRAININGPLAYERIN = 133;
const CP_PRIV = 134;
const CP_DAMAGETYPE = 135;

const CP_ACCOUNT = 200;
const CP_ADVOBJ = 201;
const CP_ATT = 202;
const CP_ATTACKER = 203;
const CP_BEARDCOLOR = 204;
const CP_BEARDSERIAL = 205;
const CP_BEARDSTYLE = 206;
const CP_CALLNUM = 207;
const CP_CARVE = 208;
const CP_CASTING = 209;
const CP_CLIENTIDLETIME = 210;
const CP_COMBATHITMESSAGE = 211;
const CP_CREATIONDAY = 212;
const CP_CRIMINALFLAG = 213;
const CP_DEATHS = 214;
const CP_DEF = 215;
const CP_DEXTERITY = 216;
const CP_DISABLED = 217;
const CP_FAME = 218;
const CP_FLEEAT = 219;
const CP_FOODPOSITION = 220;
const CP_FPOS1_NPCWANDER = 221;
const CP_FPOS2_NPCWANDER = 222;
const CP_FTARG = 223;
const CP_GMMOVEEFF = 224;
const CP_GUILDFEALTY = 225;
const CP_GUILDNUMBER = 226;
const CP_HAIRCOLOR = 228;
const CP_HAIRSERIAL = 229;
const CP_HAIRSTYLE = 230;
const CP_HIDAMAGE = 231;
const CP_HOLDGOLD = 232;
const CP_HOMELOCPOS = 233;
const CP_HUNGER = 234;
const CP_HUNGERTIME = 235;
const CP_INTELLIGENCE = 236;
const CP_KARMA = 237;
const CP_KEYNUMBER = 238;
const CP_KILLS = 239;
const CP_LODAMAGE = 240;
const CP_LOGOUT = 241;
const CP_MAKING = 242;
const CP_MEDITATING = 243;
const CP_MENUPRIV = 244;
const CP_MULTISERIAL = 245;
const CP_MURDERERSER = 246;
const CP_MURDERRATE = 247;
const CP_MUTETIME = 248;
const CP_NAMEDEED = 249;
const CP_NEXTACT = 250;
const CP_NPCAI = 251;
const CP_NPCMOVETIME = 252;
const CP_OBJECTDELAY = 253;
const CP_OLDPOS = 254;
const CP_OWNSERIAL = 255;
const CP_PACKITEM = 256;
const CP_POISON = 257;
const CP_POISONED = 258;
const CP_POISONTIME = 259;
const CP_POISONTXT = 260;
const CP_POISONWEAROFFTIME = 261;
const CP_POSITION = 262;
const CP_POSTTYPE = 263;
const CP_PREVPOS = 264;
const CP_PRIV3 = 265;
const CP_QUESTBOUNTYPOSTSERIAL = 266;
const CP_QUESTBOUNTYREWARD = 267;
const CP_QUESTDESTREGION = 268;
const CP_QUESTORIGREGION = 269;
const CP_REATTACKAT = 270;
const CP_REGENRATE = 271;
const CP_ROBE = 274;
const CP_RUNNING = 275;
const CP_SERIAL = 276;
const CP_SKILLDELAY = 277;
const CP_SMELTITEM = 278;
const CP_SMOKEDISPLAYTIME = 279;
const CP_SMOKE = 280;
const CP_SPADELAY = 281;
const CP_SPATIMER = 282;
const CP_SPATTACK = 283;
const CP_SPAWNREGION = 284;
const CP_SPAWNSERIAL = 285;
const CP_SPELL = 286;
const CP_SPELLACTION = 287;
const CP_SPELLTIME = 288;
const CP_SPLIT = 290;
const CP_SPLITCHNC = 291;
const CP_SQUELCHED = 292;
const CP_STABLEMASTER_SERIAL = 293;
const CP_STEALTH = 294;
const CP_STRENGHT = 295;
const CP_SUMMONTIMER = 296;
const CP_SWINGTARG = 297;
const CP_TAILITEM = 298;
const CP_TAMING = 299;
const CP_TARG = 300;
const CP_TARGTRIG = 301;
const CP_TEMPFLAGTIME = 302;
const CP_TIME_UNUSED = 303;
const CP_TIMEOUT = 304;
const CP_TIMEUSED_LAST = 305;
const CP_TRACKINGDISPLAYTIMER = 306;
const CP_TRACKINGTARGET = 307;
const CP_TRACKINGTIMER = 308;
const CP_TRAINER = 309;
const CP_TRIGGER = 311;
const CP_WEIGHT = 312;
const CP_WORKLOCPOS = 313;
const CP_AMXFLAGS = 314;
const CP_NPCRACE = 315;
const CP_LASTMOVETIME = 319;

const CP_BASESKILL = 400;
const CP_SKILL = 401;
const CP_GUILDTYPE = 402;

const CP_STR_DISABLEDMSG = 450;
const CP_STR_GUILDTITLE = 451;
const CP_STR_NAME = 453;
const CP_STR_ORGNAME = 454;
const CP_STR_TITLE = 455;
const CP_STR_TRIGWORD = 456;
const CP_STR_SPEECHWORD = 457;	// word/phrase in speech that triggered speech override
const CP_STR_SPEECH = 458; // entire speech that contains word/phrase that triggered speech override

const CP_UNI_SPEECH_CURRENT = 500;
const CP_UNI_PROFILE = 501;

const NPC_TALK = 1;
const NPC_TALK_ALL = 2;
const NPC_TALK_RUNIC = 3;
const NPC_TALK_ALL_RUNIC = 4;
const NPC_EMOTE = 5;
const NPC_EMOTE_ALL = 6;

const NXWF0_GREY = 1;
const NXWF0_PERMAGREY = 2;
