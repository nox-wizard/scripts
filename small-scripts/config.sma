//Meditation Skill regeneration rate (seconds untill mana = int) 
#define REGEN_RATE 4; 

//Extended Skillsystem
#define _SKILLS_DEBUG_ 1 //<! set to 1 if you want debug messages to be printed
#define ACTIVATE_EXTENDED_SKILLSYSTEM 0	//!< set to 1 to activate the extended skillsystem
#define EXT_SKILLSYSTEM_TEST 0	//!< set to 1 if you want a skillsystem test performed on char login (VERY MUCH LAG at char login) then look in skilltest.txt the results
#define MAX_SKILL_SUM 7000	//!< maximum value the skillsumcan reach
#define MAX_SKILL_VALUE 1000 	//!< maximum value a skill can reach, not considering modifiers
#define SK_ADDITIONAL_MAX 10	//!< max number of additional skills in skills2.xss, change it if you need more skills

//inscription skill
#define BLANK_SCROLL_ID 3636

//house menu
#define _AUTOBOUNCE_AVAIL 0 // this activates auto-bounce option in gumps to prevent house looting by exploiter (getting into a house without using the door), 1 means ON (only friends and co-owner can enter the house no matter if the door is open or locked)
#define _AUTOBOUNCE_KEY 1 // this decides if the autoban should be only active if a non-friend/non-coowner enters the house and the door us looked, so _AUTOBOUNCE_KEY 1 means that player still need to take care for locked doors even if auto-bounce is active
#define HOUSE_COOWNER 5 //how many are allowed
#define HOUSE_FRIENDS 15
#define HOUSE_BANNED 50

//area param in commands system
#define MAX_AREAS 32;	//!< max number of areas, should be >= to the number of players that can access the 'area command

//commands system general
#define _CMD_DEBUG_  1		//!< command system debug switch set to 1 to have debug messages shown, 0 else.
#define _CMD_SHOWLIST_ 1	//!< set to 1 if you want to see a list of available commands at startup
#define _CMD_SHOW_MSG 1		//!< set to 1 if you want users to be warned when they try to use commands they are not authorized to use or that not exist

//stats menu
#define TXT_COLOR 33

//GM-Paging System
#define _PAGESYSTEM_DEBUG_ 1 	//!< set to 1 toenable pagesystemdebug messages