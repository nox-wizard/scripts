// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard	: Embedded Small Scripts			||
// || Maintained by	: Luxor, Sparhawk				||
// || Last Update	: 06-apr-2003					||
// || Designed for NXW 	: 0.82						||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#if defined _nxw_misc_constant_
  #endinput
#endif
#define _nxw_misc_constant_

/*!  \defgroup script_API_constants General constants
*    \ingroup script_API
* @{
*/
const NXWINC_VERSION = 0x060;

const VERTYPE_SUPPORTED = 0x1;
const VERTYPE_PRIVATE = 0x2;
const VERTYPE_BETA = 0x4;
const VERTYPE_SPECIAL = 0x8;
const VERTYPE_EZ = 0x80;

const PLATFORM_UNKNOWN = 0;
const PLATFORM_WINCONSOLE = 1;
const PLATFORM_WINGUI = 2;
const PLATFORM_WINGUIEZ = 130;      //0x80 || WINGUI
const PLATFORM_WINSERVICE = 3;
const PLATFORM_LINUX = 4;
const PLATFORM_BEOS = 5;

/*************************************************************************
 WEATHER RELATED CONSTANTS
 *************************************************************************/
enum
{
	WEATHER_SUN = 0,
	WEATHER_RAIN = 1,
	WEATHER_SNOW = 2
};

enum
{
	SEASON_SPRING = 0,
	SEASON_SUMMER = 1,
	SEASON_AUTUMN = 2,
	SEASON_FALL   = 2,
	SEASON_WINTER = 3,
	SEASON_DEAD   = 4
};

/*************************************************************************
 DIRECTION RELATED CONSTANTS
 *************************************************************************/

enum
{
	DIR_NORTH = 0,
	DIR_NORTHEAST = 1,
	DIR_EAST  = 2,
	DIR_SOUTHEAST = 3,
	DIR_SOUTH = 4,
	DIR_SOUTHWEST = 5,
	DIR_WEST  = 6,
	DIR_NORTHWEST = 7
};
/*************************************************************************
 LINE OF SIGHT RELATED CONSTANTS
 *************************************************************************/

const TREES_BUSHES = 1;
const WALLS_CHIMNEYS = 2;
const DOORS = 4;
const ROOFING_SLANTED = 8;
const FLOORS_FLAT_ROOFING = 16;
const LAVA_WATER = 32;

/*************************************************************************
 DAMAGE TYPES CONSTANTS
 *************************************************************************/
/*! \defgroup DAMAGE_ DAMAGE_
* @{
*/
enum {
	DAMAGE_PURE = 0, DAMAGE_SLASH, DAMAGE_PIERCE, DAMAGE_BLUDGEON, DAMAGE_BACKSTAB,
	DAMAGE_FIRE, DAMAGE_ELECTRICITY, DAMAGE_MENTAL, DAMAGE_POISON, DAMAGE_COLD,
	DAMAGE_FORCE, DAMAGE_HOLY, DAMAGE_MAGIC, MAX_RESISTANCE_INDEX
};
/* @} */

/*************************************************************************
 LOCAL VARS CONSTANTS
 *************************************************************************/

const VAR_TYPE_ANY	= 0;
const VAR_TYPE_INTEGER	= 1;
const VAR_TYPE_STRING	= 3;

enum
{
	VAR_ERROR_NONE = 0,
	VAR_ERROR_UNKNOWN_VAR = 1,
	VAR_ERROR_DUPLICATE_VAR = 2,
	VAR_ERROR_WRONG_TYPE = 3,
	VAR_ERROR_ACCESS_DENIED = 4
};
/*************************************************************************
 LAYER TYPES CONSTANTS
 *************************************************************************/

/*! \defgroup LAYER_ LAYER_
* @{
*/
enum
{
	LAYER_1HANDWEAPON	= 1,
	LAYER_2HANDWEAPON	= 2,
	LAYER_SHOES		= 3,
	LAYER_PANTS		= 4,
	LAYER_SHIRT		= 5,
	LAYER_HELM		= 6,
	LAYER_GLOVES		= 7,
	LAYER_RING		= 8,
	LAYER_UNUSED		= 9,
	LAYER_NECK		= 10,
	LAYER_HAIR		= 11,
	LAYER_WAIST		= 12,
	LAYER_INNER_TORSO	= 13,
	LAYER_BRACELET		= 14,
	LAYER_UNUSED_BP		= 15,
	LAYER_BEARD		= 16,
	LAYER_MID_TORSO		= 17,
	LAYER_EARRINGS		= 18,
	LAYER_ARMS		= 19,
	LAYER_CLOAK		= 20,
	LAYER_BACKPACK		= 21,
	LAYER_OUTER_TORSO	= 22,
	LAYER_OUTER_LEGS	= 23,
	LAYER_INNER_LEGS	= 24,
	LAYER_MOUNT		= 25,
	LAYER_TRADE_RESTOCK	= 26,
	LAYER_TRADE_NORESTOCK	= 27,
	LAYER_TRADE_BOUGHT	= 28,
	LAYER_BANKBOX		= 29,
	LAYER_COUNT		= 29
};

//===================================================================================//
//                                   ACTIONS CONSTANTS                               //
//===================================================================================//

enum
{
	ACTION_WALK_UNARMED = 0,
	ACTION_WALK_ARMED = 1,
	ACTION_RUN_UNARMED = 2,
	ACTION_RUN_ARMED = 3,
	ACTION_STAND = 4,
	ACTION_LOOKAROUND = 5,
	ACTION_LOOKDOWN = 6,
	ACTION_STAND_1H_ATTACK = 7,
	ACTION_STAND_2H_ATTACK = 8,
	ACTION_ATTACK_1H = 9,
	ACTION_ATTACK_UNARMED_JAB = 10,
	ACTION_ATTACK_UNARMED_FIST = 11,
	ACTION_ATTACK_2H_DOWN = 12,
	ACTION_ATTACK_2H_WIDE = 13,
	ACTION_ATTACK_2H_JAB = 14,
	ACTION_WALK_ATTACKPOS = 15,
	ACTION_CAST_DIRECT = 16,
	ACTION_CAST_AREA = 17,
	ACTION_ATTACK_BOW = 18,
	ACTION_ATTACK_CROSSBOW = 19,
	ACTION_TAKE_HIT = 20,
	ACTION_DIE_BACKWARD = 21,
	ACTION_DIE_FORWARD = 22,
	ACTION_WALK_HORSE = 23,
	ACTION_RUN_HORSE = 24,
	ACTION_ATTACK_HORSE = 25,
	ACTION_ATTACK_BOW_HORSE = 26,
	ACTION_ATTACK_CROSSBOWHORSE = 27,
	ACTION_SLAP_HORSE = 28,
	ACTION_TURN = 29,
	ACTION_ATTACK_UNARMED_AND_WALK = 30,
	ACTION_BOW = 31,
	ACTION_SALUTE = 32,
	ACTION_DRINK = 33,
}

/* @} */
/* @} */