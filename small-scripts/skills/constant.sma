// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard	: Embedded Small Scripts			||
// || Maintained by	: Luxor, Sparhawk				||
// || Last Update	: 06-apr-2003					||
// || Designed for NXW 	: 0.82						||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#if defined _nxw_skill_constant_
  #endinput
#endif
#define _nxw_skill_constant_

/*! \defgroup skillconstants constants
\ingroup script_skills
@{
*/

/*!
\brief skill constants used to identify a skill with a number always use this constants to refer to a skill
*/
enum
{
	SK_ALCHEMY = 0,
	SK_ANATOMY = 1,
	SK_ANIMALLORE = 2,
	SK_ITEMID = 3,
	SK_ARMSLORE = 4,
	SK_PARRYING = 5,
	SK_BEGGING = 6,
	SK_BLACKSMITHING = 7,
	SK_BOWCRAFT = 8,
	SK_PEACEMAKING = 9,
	SK_CAMPING = 10,
	SK_CARPENTRY = 11,
	SK_CARTOGRAPHY = 12,
	SK_COOKING = 13,
	SK_DETECTINGHIDDEN = 14,
	SK_ENTICEMENT = 15,
	SK_EVALUATINGINTEL = 16,
	SK_HEALING = 17,
	SK_FISHING = 18,
	SK_FORENSICS = 19,
	SK_HERDING = 20,
	SK_HIDING = 21,
	SK_PROVOCATION = 22,
	SK_INSCRIPTION = 23,
	SK_LOCKPICKING = 24,
	SK_MAGERY = 25,
	SK_MAGICRESISTANCE = 26,
	SK_TACTICS = 27,
	SK_SNOOPING = 28,
	SK_MUSICIANSHIP = 29,
	SK_POISONING = 30,
	SK_ARCHERY = 31,
	SK_SPIRITSPEAK = 32,
	SK_STEALING = 33,
	SK_TAILORING = 34,
	SK_TAMING = 35,
	SK_TASTEID = 36,
	SK_TINKERING = 37,
	SK_TRACKING = 38,
	SK_VETERINARY = 39,
	SK_SWORDSMANSHIP = 40,
	SK_MACEFIGHTING = 41,
	SK_FENCING = 42,
	SK_WRESTLING = 43,
	SK_LUMBERJACKING = 44,
	SK_MINING = 45,
	SK_MEDITATION = 46,
	SK_STEALTH = 47,
	SK_REMOVETRAPS = 48,
	SK_COUNT
};


public skillName[SK_COUNT][] = {
"Alchemy",
"Anatomy",
"Animal Lore",
"Item Id",
"Arms Lore",
"Parrying",
"Begging",
"Blacksmithing",
"Bowcraft",
"Peacemaking",
"Camping",
"Carpentery",
"Cartography",
"Cooking",
"Detecting hidden",
"Enticement",
"Evaluating intelligence",
"Healing",
"Fishing",
"Forensic",
"Herding",
"Hiding",
"Provocation",
"Inscription",
"Lockpicking",
"Magery",
"Magic Resistance",
"Tactics",
"Snooping",
"Musicianship",
"Poisoning",
"Archery",
"Spirit Speak",
"Stealing",
"Tailoring",
"Taming",
"Taste Id",
"Tinkering",
"Tracking",
"Veterinary",
"Swordsmanship",
"Macefighting",
"Fencing",
"Wrestling",
"Lumberjacking",
"Mining",
"Meditation",
"Stealth",
"Remove Traps"
}; //!< skill names array, to be indexed with SK_ constants



public skillByName[SK_COUNT] = {
SK_ALCHEMY,
SK_ANATOMY,
SK_ANIMALLORE,
SK_ARMSLORE,
SK_ARCHERY,
SK_BEGGING,
SK_BLACKSMITHING,
SK_BOWCRAFT,
SK_CAMPING,
SK_CARPENTRY,
SK_CARTOGRAPHY,
SK_COOKING,
SK_DETECTINGHIDDEN,
SK_ENTICEMENT,
SK_EVALUATINGINTEL,
SK_FENCING,
SK_FISHING,
SK_FORENSICS,
SK_HEALING,
SK_HERDING,
SK_HIDING,
SK_ITEMID,
SK_INSCRIPTION,
SK_LOCKPICKING,
SK_LUMBERJACKING,
SK_MAGERY,
SK_MAGICRESISTANCE,
SK_MUSICIANSHIP,
SK_MINING,
SK_MEDITATION,
SK_MACEFIGHTING,
SK_PARRYING,
SK_PEACEMAKING,
SK_PROVOCATION,
SK_POISONING,
SK_REMOVETRAPS, 
SK_SPIRITSPEAK,
SK_SNOOPING,
SK_STEALING,
SK_SWORDSMANSHIP,
SK_STEALTH,
SK_TACTICS,
SK_TAILORING,
SK_TAMING,
SK_TASTEID,
SK_TINKERING,
SK_TRACKING,
SK_VETERINARY,
SK_WRESTLING
}; //!< brief alphabetically ordered skill constants


/*!
\brief skill functions names array.

This array contains the names of the functions called to execute
a skill.
Changing values in the array will cause a different function to be called to execute a skill
*/
public skillFunctions[SK_COUNT][] = {
	"__nxw_sk_alchemy",
	"__nxw_sk_anatomy",
	"__nxw_sk_animalLore",
	"__nxw_sk_itemId",
	"__nxw_sk_armsLore",
	"__nxw_sk_parrying",
	"__nxw_sk_begging",
	"__nxw_sk_blacksmith",
	"__nxw_sk_bowcraft",
	"__nxw_sk_peace",
	"__nxw_sk_camping",
	"__nxw_sk_carpentery",
	"__nxw_sk_cartography",
	"__nxw_sk_cooking",
	"__nxw_sk_detectHid",
	"__nxw_sk_enticement",
	"__nxw_sk_evint",
	"__nxw_sk_healing",
	"__nxw_sk_fishing",
	"__nxw_sk_forensic",
	"__nxw_sk_herding",
	"__nxw_sk_hiding",
	"__nxw_sk_provocat",
	"__nxw_sk_inscript",
	"__nxw_sk_lockpick",
	"__nxw_sk_magery",
	"__nxw_sk_magicRes",
	"__nxw_sk_tactics",
	"__nxw_sk_snooping",
	"__nxw_sk_musician",
	"__nxw_sk_poisoning",
	"__nxw_sk_archery",
	"__nxw_sk_spiritSp",
	"__nxw_sk_stealing",
	"__nxw_sk_tailoring",
	"__nxw_sk_taming",
	"__nxw_sk_tasteId",
	"__nxw_sk_tinkering",
	"__nxw_sk_tracking",
	"__nxw_sk_veterinary",
	"__nxw_sk_sword",
	"__nxw_sk_mace",
	"__nxw_sk_fencing",
	"__nxw_sk_wrestling",
	"__nxw_sk_lumberjack",
	"__nxw_sk_mining",
	"__nxw_sk_meditation",
	"__nxw_sk_stealth",
	"__nxw_sk_removeTrap"
	};

/* @}*/