// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard	: Embedded Small Scripts			||
// || Maintained by	: Luxor, Sparhawk				||
// || Last Update	: 06-apr-2003					||
// || Designed for NXW 	: 0.82						||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#if defined _nxw_item_constant_
  #endinput
#endif
#define _nxw_item_constant_

const PROP_ITEM = 1;

/** \defgroup script_API_item_constants constants
 *  \ingroup script_API_item
 *  @{
 */

/** \defgroup IP2_ IP2_
 *  @{
 */
const IP2_X = 0;
const IP2_Y = 1;
const IP2_Z = 2;
const IP2_DZ = 3;
const IP2_DISPZ = 3;
/** @} */

/** \defgroup IP_ IP_
 *  @{
 */
const IP_INCOGNITO = 0;                //!< for items under incognito effect
const IP_CORPSE = 102;                 //!< true if the item is a corpse
const IP_DOORDIR = 103;                //!< door direction
const IP_DOOROPEN = 104;               //!< true if the dorr is open
const IP_DYE = 105;                    //!< true if can be dyed with dye kit
const IP_FREE = 106;                   //!< true if item is removed
const IP_LAYER = 110;                  //!< the layer the item is on (see \ref LAYER_ constants)
const IP_MAGIC = 111;                  //!< 0: default as stored in client 1:always movable 2:never movable 3:owner movable
const IP_MORE = 112;                   //!< more
const IP_MOREB = 113;                  //!< moreb
const IP_OFFSPELL = 114;               //!< 
const IP_OLDLAYER = 115;               //!<
const IP_PILEABLE = 117;               //!< true if the item can be piled
const IP_PRIV = 118;                   //!< bit 0: decay off/on bit 1:newbie off/on bit 2:dispellable
const IP_VISIBLE = 120;                //!< 0:normally visible 1:owner & GM visible 2:GM visible
const IP_DAMAGETYPE = 121;             //!< the damage type (see \ref DAMAGE_ constants)
const IP_AUXDAMAGETYPE = 122;          //!< the additional damagetype for magic weapons (see \ref DAMAGE_ constants)
const IP_ATT = 200;                    //!< attack power of the item
const IP_CARVE = 201;                  //!< internal for carving system
const IP_CONTAINERSERIAL = 202;        //!< the serial of the container the item is in
const IP_DECAYTIME = 203;              //!< the time the item will decay
const IP_DEF = 204;                    //!< AR the item adds to a player
const IP_DEXBONUS = 205;               //!< dexterity bonus
const IP_DEXREQUIRED = 206;            //!< dexterity required to use the item
const IP_DISABLED = 207;               //!< true if disabled
const IP_GATENUMBER = 208;             //!< 
const IP_GATETIME = 209;               //!<
const IP_GOOD = 211;                   //!<
const IP_HIDAMAGE = 212;               //!< maximum damage done by the item
const IP_HP = 213;                     //!< item hit points
const IP_INTBONUS = 214;               //!< intelligence bonus
const IP_INTREQUIRED = 215;            //!< intelligence required to use the item
const IP_ITEMHAND = 216;               //!< the hand that holds the item when it's weared
const IP_LODAMAGE = 217;               //!< minimum damage done by the item
const IP_MADEWITH = 218;               //!< 
const IP_MAXHP = 219;                  //!< maximum item hit points
const IP_MOREPOSITION = 220;           //!< morex, morey, morez
const IP_MULTISERIAL = 221;            //!<
const IP_MURDERTIME = 222;             //!<
const IP_OLDCONTAINERSERIAL = 223;     //!<
const IP_OLDPOSITION = 224;            //!<
const IP_OWNERSERIAL = 225;            //!< the serial of the owner
const IP_POISONED = 226;               //!< poison type
const IP_POSITION = 227;               //!< position, use CP2_X CP2_Y CP2_Z as subproperties
const IP_RANK = 228;                   //!< rank
const IP_REQSKILL = 229;               //!< 
const IP_RESTOCK = 230;                //!<
const IP_RNDVALUERATE = 231;           //!<
const IP_SECUREIT = 232;               //!<
const IP_SERIAL = 233;                 //!< useless, the item serial
const IP_SMELT = 234;                  //!< 
const IP_SPAWNREGION = 235;            //!< the region from wich the item spawned
const IP_SPAWNSERIAL = 236;            //!< serial of the spawner
const IP_SPEED = 237;                  //!< weapon speed
const IP_STRBONUS = 238;               //!< strength bonus
const IP_STRREQUIRED = 239;            //!< strength required to use the item
const IP_TIME_UNUSED = 240;            //!< 
const IP_TIME_UNUSEDLAST = 241;        //!<
const IP_TRIGGER = 242;                //!< trigger of the item
const IP_TRIGGERUSES = 243;            //!< number of trigger uses
const IP_TRIGTYPE = 244;               //!< trigger type
const IP_TYPE = 245;                   //!< item type
const IP_TYPE2 = 246;                  //!< 
const IP_VALUE = 247;                  //!< price of the item when it's sold
const IP_WEIGHT = 248;                 //!< weight
const IP_WIPE = 249;                   //!<
const IP_AMXFLAGS = 250;               //!< use local vars instead
const IP_SCRIPTID = 251;               //!< XSS script id of the item
const IP_ANIMID = 252;                 //!< animation ID
const IP_RESISTS = 253;                //!< 
const IP_AUXDAMAGE = 254;              //!< additional damage for magic weapons
const IP_AMMO = 255;                   //!< scriptID of the ammo
const IP_AMMOFX = 256;                 //!< effect to be played when a bullet is fired
                                       
const IP_AMOUNT = 400;                 //!< amount
const IP_AMOUNT2 = 401;                //!<
const IP_DIR = 402;                    //!< direction
const IP_COLOR = 403;                  //!< color
const IP_ID = 404;                     //!< item ID
                                       
const IP_STR_CREATOR = 450;            //!< name of the character who created the item
const IP_STR_DESCRIPTION = 451;        //!< description of the item
const IP_STR_DISABLEDMSG = 452;        //!< message shown when disabled
const IP_STR_MURDERER = 453;           //!< murderer name for corpses
const IP_STR_NAME = 454;               //!< name of the item
const IP_STR_NAME2 = 455;              //!< item-id name of the item
/** @} */
/** @} */

enum {
	TYPE_KNIFE,	
	TYPE_SWORD,
	TYPE_AXE_1H,
	TYPE_FORK_1H,
	TYPE_CROSSBOW,
	TYPE_BOW,
	TYPE_SPEAR_1H,
	
	TYPE_STAFF,	
	TYPE_MACE_1H,
	TYPE_MACE_2H,
	TYPE_AXE_2H,
	TYPE_LONGWEAPON,
	TYPE_FORK_2H,
	TYPE_SPEAR_2H,
	TYPE_JAVELIN,
	
	TYPE_BOLT,
	TYPE_ARROW,

	TYPE_CHAINMAIL,
	TYPE_LEATHER,
	TYPE_STUDDED,
	TYPE_RINGMAIL,
	TYPE_HELM,
	TYPE_PLATEMAIL,
	TYPE_BONEARMOR,
	TYPE_UNDEFINED
}
