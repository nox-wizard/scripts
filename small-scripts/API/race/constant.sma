//global props
const RP_TELEPORT_ON_ENLIST = 0;
const RP_WITH_WEB_INTERFACE = 1;
const RP_MODE = 3;
const RP_STARTLOCATION = 200;
const RP_STR_WEBLINK = 452;
const RP_STR_WEBROOT = 453;

//global subprops
const RP2_X = 0;
const RP2_Y = 1;
const RP2_Z = 2;

//race properties
const RP_SKINCOLOR = 400;   //tells one number from SECTION SKINCOLOR
const RP_GENDER = 201;      //tells which gender is allowed (GENDER in XSS) to choose that race, 0: female only, 1: male only, 2: both gender are allowed, voluntarly subproperty RP2_MALE and RP2_FEMALE can be used to call Bodies-Section in XSS

//race subproperties
const RP2_MALE = 202;        //used as subproperty to RP_GENDER, returns a body ID (decimal) from SECTION MALEBODIES or -1 if not allowed as gender
const RP2_FEMALE = 203;      //used as subproperty to RP_GENDER, returns a body ID (decimal) from SECTION FEMALEBODIES or -1 if not allowed as gender

//unsorted/untested
const RP2_DESCRIPTION_COUNT = 1;
const RP_TYPE = 100;
const RP_LAYER_PERMITTED = 101;

const RP_STR_NAME = 450;
const RP_STR_DESCRIPTION = 451;



const RT_OPTIONAL = 0;
const RT_PROHIBITED = 1;
const RT_MANDATORY = 2;


const RACETYPE_PC = 1;
const RACETYPE_NPC = 2;
const RACETYPE_PCNPC = 3;


const RS_BACKPACK_ITEM = 1;
const RS_BANK_ITEM = 2;
const RS_EQUIP_ITEM = 3;


