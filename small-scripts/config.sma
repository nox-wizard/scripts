//Attention: don't change this file while running server and than reload it with ingame small-reload-command, it may crash the server!
//always make a reboot when changing this file!

//Meditation Skill regeneration rate (seconds untill mana = int) 
#define REGEN_RATE 4; 

//Extended Skillsystem
#define _SKILLS_DEBUG_ 1 //<! set to 1 if you want debug messages to be printed
#define ACTIVATE_EXTENDED_SKILLSYSTEM 0	//!< set to 1 to activate the extended skillsystem
#define EXT_SKILLSYSTEM_TEST 0	//!< set to 1 if you want a skillsystem test performed on char login (VERY MUCH LAG at char login) then look in skilltest.txt the results
#define MAX_SKILL_SUM 7000	//!< maximum value the skillsumcan reach
#define MAX_SKILL_VALUE 1000 	//!< maximum value a skill can reach, not considering modifiers
#define SK_ADDITIONAL_MAX 10	//!< max number of additional skills in skills2.xss, change it if you need more skills
//these local vars are reserved, DON'T change!!!
#define CLV_ADDITIONALSKILLS 9998	//<! local variable to store additional skill values
#define CLV_ADDITIONALSKILLSBASE 9997	//<! local variable to store addition base skill values

//inscription skill
#define BLANK_SCROLL_ID 3636

//house menu
#define _AUTOBOUNCE_AVAIL 0 // this activates auto-bounce option in gumps to prevent house looting by exploiter (getting into a house without using the door), 1 means ON (only friends and co-owner can enter the house no matter if the door is open or locked)
#define _AUTOBOUNCE_KEY 1 // this decides if the autoban should be only active if a non-friend/non-coowner enters the house and the door us looked, so _AUTOBOUNCE_KEY 1 means that player still need to take care for locked doors even if auto-bounce is active
#define HOUSE_COOWNER 5 //how many are allowed
#define HOUSE_FRIENDS 15
#define HOUSE_BANNED 50

//commands system
#define MAX_AREAS 32;	//!< max number of areas for commands system, should be >= to the number of players that can access the 'area command
#define _CMD_DEBUG_  1		//!< command system debug switch set to 1 to have debug messages shown, 0 else.
#define _CMD_SHOWLIST_ 1	//!< set to 1 if you want to see a list of available commands at startup
#define _CMD_SHOW_MSG 1		//!< set to 1 if you want users to be warned when they try to use commands they are not authorized to use or that not exist
//these vars are deleted at character's login (globaltags(c) function in charLogin.sma), DON'T change!
#define CLV_CMDTEMP 9996		//!< commands temp variable - created on the fly,delete after use
#define CLV_CMDTEMPVEC 9995
#define CLV_CONTINUOUS_ADDING_MODE 9994	//!< toggles continuous adding mode
#define CLV_TEMP1 9991			//!< generic temp var 1 - now used for getRectangle() - created on the fly, delete after use.

//stats menu
#define TXT_COLOR 33

//GM-Paging System
#define _PAGESYSTEM_DEBUG_ 1 	//!< set to 1 toenable pagesystemdebug messages

// unknown char system (you need to tell the other chars your name before they can see it)
#define ACTIVATE_UKNOWN_CHARSYS 0	//!< set to 1 to activate the unknown char system
#define UNKNOWN_CHAR_VAR 9500           //this localVar stores the hash map which is assigned to the char and stores which chars he already knows
#define UNKNOWN_CHAR_NAME 9501          //this localVar stores the real char name
