/*
\fn __charLogin(const chr)
\param chr: the character who is logging in
\brief handles login stuff

Use this function to call a script at character login, do not put code in the function but call
an extern function
*/
public __charLogin(const chr)
{
	if( chr_isNpc (chr)) return;
	
	printf("^n");
	log_message(" == STARTING LOGIN SCRIPTS FOR CHARACTER %d ==",chr);
	
	//reset local vars
	globaltags(chr);
	
	//defined in small-scripts/comands.sma
	startCommandSystem(chr); 
		
	//defined in "small-scripts/skills/extendedSkillsystem.sma"
	startExtSkillsystem(chr);
		
	itm_potionStart(chr);
	
	
	//defined in "small-scripts/comands/page/pagesystem.sma"
	addOnlineStaff(chr);
	
	hungerandthirst(chr);
	
	//put here any function you want to be executed at character login
		
	log_message(" ============ END OF LOGIN SCRIPTS ============");
}




const Delay_Maptile = 300;
const Delay_HungerThirst = 180;
const NumGlobalVars = 10; //1002 hunger, 1003 thirst, 1004 + 1005 skills, 1006 Race, 1007 diverses useable, 1009 taming repeats, 1010 taming target

public npccreate(const c)
{
printf("creation start");
}

public globaltags(const c)
{
new globalVar = 1002; //first globalVar we use is 1002 for hunger
for (globalVar = 1002; globalVar < (1001+NumGlobalVars); globalVar++)
    {
    if(chr_isaLocalVar( c, globalVar, VAR_TYPE_ANY ) == 0 ) //0 means no var at globalVar
        {
        chr_addLocalIntVar( c, globalVar, 0 );
        printf("char %d got global var %d^n", c, globalVar);
        }
    if((chr_isaLocalVar( c, globalVar, VAR_TYPE_STRING ) == 1)) //there already is a string variable (shouldn't happen)
        {
        chr_delLocalVar(c, globalVar, VAR_TYPE_STRING);
        chr_addLocalIntVar( c, globalVar, 0 );
        printf("char %d got global var %d^n", c, globalVar);
        }
    }
    
    //delete temp variables - they shouldn't exist, but let's delete them for safety.
    	
    	log_message("Cleaning temp local vars");
	for(new p = CLV_TEMP1; p <= CLV_CMDTEMP; p++)
		chr_delLocalVar(c,p);
	
}

// Hungersystem starts here

public hungerandthirst(const c)
{
tempfx_activate(_, c, c, 0, Delay_HungerThirst,funcidx("hungertimer"));
}



public hungertimer(const source, const dest, const power, const mode)
{
if(mode != TFXM_END) return;
new c = source;

    new hunger = chr_getLocalIntVar(c, 1002);//Hungerwert
    new newhunger = hunger - 3;
    if(newhunger < 0)
    {newhunger = 0;}
    chr_setLocalIntVar(c, 1002, newhunger); //neuer Hungerwert
    switch(newhunger)
        {
        case 0..1: chr_message( c, _, "You must eat something immediatelly or you will die in 1 minute!");
        case 2..11: chr_message( c, _, "You must eat something very very fast or you will die from hunger!");
        case 12..21: chr_message( c, _, "You are extremly hungry!");
        case 22..31: chr_message( c, _, "You are very hungry and start feeling dizzy!");
        case 32..41: chr_message( c, _, "You are really hungry and your stomache growls loudly!");
        case 42..51: chr_message( c, _, "You stomach starts growling by hunger!");
        case 52..61: chr_message( c, _, "You are bit hungry.");
        case 62..71: chr_message( c, _, "You could have something to eat.");
        case 72..81: chr_message( c, _, "You feel satisfied.");
        case 82..91: chr_message( c, _, "You are well fed.");
        case 92..100: chr_message( c, _, "You are absolutly stuffed.");
        default: 
               {
               chr_message( c, _, "You die from starving too long!");
               }
        }
        
    new thirst = chr_getLocalIntVar(c, 1003);//thirst value
    new newthirst = thirst - 3;
    if(newthirst < 0)
    {newthirst = 0;}
    chr_setLocalIntVar(c, 1003, newthirst); //new thirst value
    
    switch(newthirst)
      {
      case 0..1: chr_message( c, _, "And you must drink something immediatelly or you will die in 1 minute!^n");
      case 2..11: chr_message( c, _, "And you must drink something very very fast or you will die from thirst!^n");
      case 12..21: chr_message( c, _, "And you are extremly thirsty!^n");
      case 22..31: chr_message( c, _, "And you are very thirsty and start feeling dizzy!^n");
      case 32..41: chr_message( c, _, "And you are really hungry and your tongue sticks in your mouth!^n");
      case 42..51: chr_message( c, _, "And your tongue starts becoming sticky by thirst!^n");
      case 52..61: chr_message( c, _, "And you are bit thirsty.^n");
      case 62..71: chr_message( c, _, "And you could have something to drink.^n");
      case 72..81: chr_message( c, _, "And you don't need to drink anything.^n");
      case 82..91: chr_message( c, _, "And you feel absolutely no thirst.^n");
      case 92..100: chr_message( c, _, "And your belly is filled with liquid.^n");
      default: 
             {
             chr_message( c, _, "And you die from being thirsty too long!^n");
             }
      }
tempfx_activate(_, c, c, 0, Delay_HungerThirst,funcidx("hungertimer"));
}

/*
	Script		:	potiondelay.sma
	Purpose		:	to create a delay between multiple potion uses of the same type
				using this script you can controll how long a pc has to wait between for instance using 
				strength or healing potions
				in this way you can prevent warriors from gulping loads of strength potions to defeat any monster
	Creator		:	Sparhawk, 2002-01-04
	Nxw version	:	070 but should be downward compatible to 054
	Notes		:	Thanks to Szerszen for posting this omission in nxw 070 in the nxw forum
*/

enum potiontype
{
	potion_nightsight,
	potion_cure,
	potion_agility,
	potion_strength,
	potion_poison,
	potion_energy,
	potion_heal,
	potion_mana
}

#define concurrent_users	1024

static potiontimer[concurrent_users][potiontype]; //holds delay value for each potion, values are in msec.
static potiondelay[potiontype] = { 10000, 10000, 10000, 0, 10000, 10000, 10000, 10000 };

public itm_potionStart(const chr) //initialize player specific potion timers when pc logs in
{
	potiontimer[chr][potion_nightsight]	= 0;
	potiontimer[chr][potion_cure]	= 0;
	potiontimer[chr][potion_agility]	= 0;
	potiontimer[chr][potion_strength]	= 0;
	potiontimer[chr][potion_poison]	= 0;
	potiontimer[chr][potion_energy]	= 0;
	potiontimer[chr][potion_heal]	= 0;
	potiontimer[chr][potion_mana]	= 0;
}

public itm_potionUse(const item, const chr) //set and check potion timers.
{
	new thispotion = -1;

	switch(itm_getProperty(item, IP_ID))
	{
		case 0x0F06	: 	thispotion = 1;
		case 0x0F07	: 	thispotion = 2;
		case 0x0F08	: 	thispotion = 3;
		case 0x0F09	: 	thispotion = 4;
		case 0x0F0A	: 	thispotion = 5;
		case 0x0F0B	:	thispotion = 6;
		case 0x0F0C	:	thispotion = 7;
		case 0x0F0E	:	thispotion = 8;
	}

	if (thispotion == -1)		return;

	new now   = getCurrentTime();
	new delay = potiontimer[chr][potiontype:thispotion] - now;
	
	if ( delay > 0 && delay <= potiondelay[potiontype:thispotion] )
	{
		chr_message( chr, _, !"You don't feel up to this yet!^n" );
		bypass();
	}
	else
	{
		potiontimer[chr][potiontype:thispotion] = now + potiondelay[potiontype:thispotion];
	}

}
