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

enum {
	DAMAGE_PURE = 0, DAMAGE_SLASH, DAMAGE_PIERCE, DAMAGE_BLUDGEON, DAMAGE_BACKSTAB,
	DAMAGE_FIRE, DAMAGE_ELECTRICITY, DAMAGE_MENTAL, DAMAGE_POISON, DAMAGE_COLD,
	DAMAGE_FORCE, DAMAGE_HOLY, DAMAGE_MAGIC, MAX_RESISTANCE_INDEX
};

/*************************************************************************
 LAYER TYPES CONSTANTS
 *************************************************************************/

enum
{
	LAYER_1HANDWEAPON	= 1,
	LAYER_2HANDWEAPON,
	LAYER_SHOES,
	LAYER_PANTS,
	LAYER_SHIRT,
	LAYER_HELM,
	LAYER_GLOVES,
	LAYER_RING,
	LAYER_UNUSED,
	LAYER_NECK,
	LAYER_HAIR,
	LAYER_WAIST,
	LAYER_INNER_TORSO,
	LAYER_BRACELET,
	LAYER_UNUSED_BP,
	LAYER_BEARD,
	LAYER_MID_TORSO,
	LAYER_EARRINGS,
	LAYER_ARMS,
	LAYER_CLOAK,
	LAYER_BACKPACK,
	LAYER_OUTER_TORSO,
	LAYER_OUTER_LEGS,
	LAYER_INNER_LEGS,
	LAYER_MOUNT,
	LAYER_TRADE_RESTOCK,
	LAYER_TRADE_NORESTOCK,
	LAYER_TRADE_BOUGHT,
	LAYER_BANKBOX,
	LAYER_COUNT		= 29
};
