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
/* @} */
/* @} */