/*!
\defgroup script_command_add_constants constants
\ingroup script_commands_add

@{
*/

enum
{	
	P_MAGIC_MENU = 1,
	P_REAGENTS,
	P_REAGENTS2,
	P_BOTTLES,
	P_POTIONS,
	P_WANDS,
	P_GATES,
	P_SCROLLS1,
	P_SCROLLS2,
	P_SCROLLS3,
	P_SCROLLS4,
	P_SCROLLS5,
	P_SCROLLS6,
	P_SCROLLS7,
	P_SCROLLS8,
	
	P_COMBAT_MENU,
	P_PLATEMAIL,
	P_CHAINMAIL,
	P_RINGMAIL,
	P_STUDDED,
	P_LEATHER,
	P_BONE,
	P_HELMS,
	P_SHIELDS,
	P_AXES,
	P_SWORDS,
	P_BLADES,
	P_FORKS,
	
	P_BUILDING_MENU,
	
	P_NPC_MENU,
	P_ANIMALS,
	P_T2A_MONSTERS,
	P_DEAMONS,
	P_ELEMENTALS,
	P_ORCS,
	P_MONSTERS,
	P_UNDEADS,
	P_UNIQUE,
	P_FROST_STONE,
	P_DRAGONS,
	P_PEOPLE_M,
	P_PEOPLE_F,
	P_MERCHANTS_M,
	P_MERCHANTS_F,
	
	P_SPAWNER_MENU,
	
	P_SUPPLY_MENU,
	P_BEVERAGES,
	P_BAKED,
	P_BOWLSMEATFRUIT,
	
	P_SKILLS_MENU,
	P_SPECIAL_MENU,
	P_SHARD_MENU,
	P_TREASURE_MENU,
};

#define MAGIC_MENU_ENTRIES 6
new magicMenuTxt[MAGIC_MENU_ENTRIES][20] =
{
	"reagents",
	"reagents 2",
	"bottles",
	"potions",
	"wands",
	"gates"	
}

#define COMBAT_MENU_ARMOR_ENTRIES 8
#define COMBAT_MENU_WEAPON_ENTRIES 4
#define COMBAT_MENU_ENTRIES COMBAT_MENU_ARMOR_ENTRIES + COMBAT_MENU_WEAPON_ENTRIES
new combatMenuTxt[COMBAT_MENU_ENTRIES][20] =
{
	"Platemail",
	"Chainmail",
	"Ringmail",
	"Studded",
	"Leather",
	"Bone",
	"Helms",
	"Shields",
	
	"Axes",
	"Blades",
	"Maces",
	"Forks"	
}

#define NPC_MENU_MONSTERS_ENTRIES 10
#define NPC_MENU_PEOPLE_ENTRIES 4
#define NPC_MENU_ENTRIES NPC_MENU_MONSTERS_ENTRIES + NPC_MENU_PEOPLE_ENTRIES
new npcMenuTxt[NPC_MENU_ENTRIES][20] =
{
	"Animals",
	"T2A",
	"Deamons",
	"Elementals",
	"Orcs",
	"Monsters",
	"Undeads",
	"Unique",
	"Frost-stone",
	"Dragons",
	
	"males",
	"females",
	"merchants",
	"merchants-f"	
}

#define SUPPLY_MENU_FOOD_ENTRIES 3
#define SUPPLY_MENU_ENTRIES SUPPLY_MENU_FOOD_ENTRIES
new supplyMenuTxt[SUPPLY_MENU_ENTRIES][20] =
{
	"Beverages",
	"Backed",
	"Bowls, Meat and Fruit"
}

enum {AR_HELM,AR_GORGET,AR_CHEST,AR_ARMS,AR_GLOVES,AR_LEGS,AR_FEMALE}

/*! }@ */
