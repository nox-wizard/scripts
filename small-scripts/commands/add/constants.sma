/*!
\defgroup script_command_add_constants constants
\ingroup script_commands_add

@{
*/

enum
{		
	P_REAGENTS = 1,
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
	
	P_PLATEMAIL = 1,
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
	P_OTHER,
		
	P_ANIMALS = 1,
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
	
	P_BEVERAGES = 1,
	P_BAKED,
	P_BOWLSMEATFRUIT,
	P_PLANTS,
	P_LIGHTS,
	P_CONTAINERS,
	P_STATUES_TROPHIES,
	P_HAIR_BEARD,
	P_RUGS,
	P_CLOTHING,
	P_JEWELS,
	
	P_CARPENTER = 1,
	P_BLACKSMITH,
	P_MUSICIAN,
	P_TAILOR,
	P_THIEF,
	P_BOWYER,
	P_TINKER,
	P_FISHER
};

#define ADD_MENU_ENTRIES 13	//! number of items in the ad menu
#define ADD_MENU_ENTRIES_L 13	//! string length of add menu items
#define ADD_MENU_ROWS 3		//! number of rows the items will be displayed in
enum __addMenuStruct
{
	__addGuiText: ADD_MENU_ENTRIES_L,
	__addGuiFunc: 20,
}
new addMenuItems[ADD_MENU_ENTRIES][__addMenuStruct] =
{
	{"Magic       ","addgui_magic"},
	{"Combat      ","addgui_combat"},
	{"Deeds       ","addgui_deeds"},
	{"NPCs        ","addgui_NPCs"},
	{"Spawner     ","addgui_spawner"},
	{"Supply      ","addgui_supply"},
	{"Signs       ","addgui_signs"},
	{"Tools       ","addgui_tools"},
	{"Architecture","addgui_architecture"},
	{"Furniture   ","addgui_furniture"},
	{"Special     ","addgui_special"},
	{"Shard       ","addgui_shard"},
	{"Treasure    ","addgui_treasure"}
}

#define MAGIC_MENU_ITEM_ENTRIES 6
#define MAGIC_MENU_SCROLL_ENTRIES 8
#define MAGIC_MENU_ENTRIES MAGIC_MENU_ITEM_ENTRIES + MAGIC_MENU_SCROLL_ENTRIES
#define MAGIC_MENU_ENTRIES_L 12
#define MAGIC_MENU_ROWS 3
new magicMenuTxt[MAGIC_MENU_ENTRIES][MAGIC_MENU_ENTRIES_L] =
{
	"reagents",
	"reagents 2",
	"bottles",
	"potions",
	"wands",
	"gates",
	
	"circle 1",
	"circle 2",
	"circle 3",
	"circle 4",
	"circle 5",
	"circle 6",
	"circle 7",
	"circle 8"	
}

#define COMBAT_MENU_ARMOR_ENTRIES 8
#define COMBAT_MENU_WEAPON_ENTRIES 4
#define COMBAT_MENU_ENTRIES COMBAT_MENU_ARMOR_ENTRIES + COMBAT_MENU_WEAPON_ENTRIES
#define COMBAT_MENU_ENTRIES_L 10
#define COMBAT_MENU_ROWS 3
new combatMenuTxt[COMBAT_MENU_ENTRIES][COMBAT_MENU_ENTRIES_L] =
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
	"Other"	
}

#define NPC_MENU_MONSTERS_ENTRIES 10
#define NPC_MENU_PEOPLE_ENTRIES 4
#define NPC_MENU_ENTRIES NPC_MENU_MONSTERS_ENTRIES + NPC_MENU_PEOPLE_ENTRIES
#define NPC_MENU_ENTRIES_L 12
#define NPC_MENU_ROWS 3
new npcMenuTxt[NPC_MENU_ENTRIES][NPC_MENU_ENTRIES_L] =
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
#define SUPPLY_MENU_ENTRIES SUPPLY_MENU_FOOD_ENTRIES + 8
#define SUPPLY_MENU_ENTRIES_L 17
#define SUPPLY_MENU_ROWS 3
new supplyMenuTxt[SUPPLY_MENU_ENTRIES][SUPPLY_MENU_ENTRIES_L] =
{
	"Beverages",
	"Backed & meat",
	"Fruit & veggys",
	"Plants",
	"Lights",
	"Containers",
	"Statues/Trophies",
	"Hair/beard",
	"Rugs",
	"Clothing",
	"Jewels"
}

#define TOOLS_MENU_ENTRIES 8
#define TOOLS_MENU_ENTRIES_L 11
#define TOOLS_MENU_ROWS 2
new toolsMenuTxt[TOOLS_MENU_ENTRIES][TOOLS_MENU_ENTRIES_L] =
{
	"Carpenter",
	"Blacksmith",
	"Musician",
	"Tailor",
	"Thief",
	"Bowyer",
	"Tinker",
	"Fisher"
}

enum {AR_HELM,AR_GORGET,AR_CHEST,AR_ARMS,AR_GLOVES,AR_LEGS,AR_FEMALE}

/*! }@ */
