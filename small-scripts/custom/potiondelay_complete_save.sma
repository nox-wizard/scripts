/*
	Script		:	potiondelay.sma
	Purpose		:	to create a delay between multiple potion uses of the same type
				using this script you can controll how long a pc has to wait between for instance using 
				strength or healing potions
				in this way you can prevent warriors from gulping loads of strength potions to defeat any monster
	Creator		:	Sparhawk
	Date created	:	2002-01-04
	Version		:	1.2
	Date updated	:	2002-01-18
	Nxw version	:	070 but should be downward compatible to 054
	Notes		:	Thanks to Szerszen for posting this omission in nxw 070 in the nxw forum
				To get this script working:
				1) Add in override.scp to section [special] StartChar=itm_potionStart,AFTER
				2) Add in items.scp or scripts/items/items.xss or in items.xss in your custom directory
				   for all potions the following eventhandler @ONDBLCLICK itm_potionUse
				3) Debug processing can be stopped by commenting out 
				   #define _POTIONDELAYDEBUG_
	History		:	1.0	2002-01-04	created
				1.1	2002-01-10	altered delay checking
				1.2	2002-01-18	debug version
							tracing added to functions and global
							arrays
				1.3	2002-06-05	Added mana potion
							Changed potion ids
*/

//#define _POTIONDELAYDEBUG_

/*
	prototype	:	potiontype
	Purpose		:	define available potions
	Date created	:	2002-01-04
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

/*
	Array		:	potiontimer[][]
	Purpose		:	hold potion timers for each online user
	Date created	:	2002-01-04
*/
#define concurrent_users	1024


static potiontimer[concurrent_users][potiontype];

/*
	Array		:	potiondelay[]
	Purpose		:	holds delay value for each potion
	Date created	:	2002-01-04
	Notes		:	Values are in msec.
*/
static potiondelay[potiontype] = { 10000, 10000, 10000, 0, 10000, 10000, 10000, 10000 };

#if defined _POTIONDELAYDEBUG_

enum user
{
	user_account	,
	user_serial	,
	user_index	,
	user_timestamp
};

static users[concurrent_users][user]	;
static users_initialized = 0		;

#endif

/*
	Function	:	itm_potionStart(const chr)
	Purpose		:	initialize player specific potion timers when pc logs in
	Inputparms	:	player chr
	Outputparms	:	none
	Returnvalue	:	none
	Creator		:	Sparhawk
	Datecreated	:	2002-01-04
	Nxw version	:	070
	Version		:	1.2
	Dateupdated	:	2002-01-18
	Notes		:	In override.scp add the following to [special]
				StartChar=itm_potionStart,AFTER
	History		:	1.0	2002-01-04 sparhawk
					created
				1.1	2002-01-10 sparhawk
					replaced char indexing by chr indexing
				1.2	2002-01-18 sparhawk
					added debug
*/
public itm_potionStart(const chr)
{
#if defined _POTIONDELAYDEBUG_

	if ( !users_initialized )
	{
		printf(!"initializing^n");
		for ( new i = 0; i < concurrent_users; i++ )
		{
			users[i][user_timestamp]= -1;
			users[i][user_account]	= -1;
			users[i][user_serial]	= -1;
			users[i][user_index]	= -1;
		}
		users_initialized = 1;
	}

	new	newUser[user];

	newUser[user_index]	= chr	;
	newUser[user_account]	= chr_getProperty( newUser[user_index], CP_ACCOUNT, _ );
	newUser[user_serial]	= chr_getProperty( newUser[user_index], CP_SERIAL, _ );
	newUser[user_timestamp] = getCurrentTime()		;

	new	debugfase = 0;

	printf(
		!"itm_potionStart|%d|%d|%d|%d|%d|%d^n"	,
		debugfase				,
		newUser[user_timestamp]			,
		chr					,
		newUser[user_account]			,
		newUser[user_serial]			,
		newUser[user_index]
	      );

	/*
		Check if this user is allready registered
	*/

	debugfase = 1;

	new same_count 		= 0;
	new same_account	= 0;
	new same_serial		= 0;

	for ( new i = 0; i < concurrent_users; i++ )
	{
		if ( users[i][user_account] == newUser[user_account] )
		{
      			same_account	= 1;
		}
		if ( users[i][user_serial] == newUser[user_serial] )
		{
      			same_serial	= 1;
		}
			
		if (same_account || same_serial )
		{
			same_count++;
			printf(
				!"itm_potionStart|%d|%d|%d|%d|%d|%d|%d|%d^n",
				debugfase			,
				users[i][user_timestamp]	,
				i				,
				users[i][user_account]		,
				users[i][user_serial]		,
				users[i][user_index]		,
				same_account			,
				same_serial
			      );
			same_account	= 0;
			same_serial	= 0;
		}
	}

	/*
	safe update of users table
	*/
	if ( same_count == 0 || ( users[chr][user_account] == newUser[user_account] &&
	     users[chr][user_serial] == newUser[user_serial] ))
	{
		users[chr][user_timestamp]	= newUser[user_timestamp]	;
		users[chr][user_account]	= newUser[user_account]		;
		users[chr][user_serial]	= newUser[user_serial]		;
		users[chr][user_index]	= newUser[user_index]		;
	}

#endif
	potiontimer[chr][potion_nightsight]	= 0;
	potiontimer[chr][potion_cure]	= 0;
	potiontimer[chr][potion_agility]	= 0;
	potiontimer[chr][potion_strength]	= 0;
	potiontimer[chr][potion_poison]	= 0;
	potiontimer[chr][potion_energy]	= 0;
	potiontimer[chr][potion_heal]	= 0;
	potiontimer[chr][potion_mana]	= 0;
}

/*
	Function	:	itm_potionUse(const item, const chr)
	Purpose		:	set and check potion timers.
	Inputparms	:	item, player chr
	Outputparms	:	none
	Returnvalue	:	none
	Creator		:	Sparhawk
	Datecreated	:	2002-01-04
	Nxw version	:	070
	Version		:	1.2
	Dateupdated	:	2001-01-18
	Notes		:	Add in items.scp or scripts/items/items.xss or in items.xss in 
				your custom directory for all potions the following eventhandler 
				@ONDBLCLICK itm_potionUse
	History		:	1.0	2002-01-04 sparhawk
					created
				1.1	2002-01-10 sparhawk
					altered delay checking to circumvent unknown bug  where 
					pc's had to wait much longer than specified delay
				1.2	2002-01-18 sparhawk
					added debug
*/
public itm_potionUse(const item, const chr)
{
#if defined _POTIONDELAYDEBUG_

	new thisUser[user];

	thisUser[user_index]	= chr	;
	thisUser[user_account]	= chr_getProperty( thisUser[user_index], CP_ACCOUNT, _ );
	thisUser[user_serial]	= chr_getProperty( thisUser[user_index], CP_SERIAL, _ );
	thisUser[user_timestamp]= getCurrentTime()		;

	new	debugfase = 0;

	printf(
		!"itm_potionUse|%d|%d|%d|%d|%d|%d|%d|%d|%d^n"	,
		debugfase				,
		thisUser[user_timestamp]		,
		chr					,
		thisUser[user_account]			,
		thisUser[user_serial]			,
		thisUser[user_index]			,
		users[chr][user_account]		,
		users[chr][user_serial]		,
		users[chr][user_index]
	      );

#endif
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

	if (thispotion == -1)
	{
#if defined _POTIONDELAYDEBUG_

		debugfase = 1;

		printf(
			!"itm_potionUse|%d|%d|%d|%d|%d|%d|%d^n"	,
			debugfase				,
			thisUser[user_timestamp]		,
			chr					,
			thisUser[user_account]			,
			thisUser[user_serial]			,
			thisUser[user_index]			,
			thispotion
		      );
#endif
		return;
	}

	new now   = getCurrentTime();
	new delay = potiontimer[chr][potiontype:thispotion] - now;
	
	if ( delay > 0 && delay <= potiondelay[potiontype:thispotion] )
	{
#if defined _POTIONDELAYDEBUG_

		debugfase = 2;

		printf(
			!"itm_potionUse|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d^n"	,
			debugfase						,
			thisUser[user_timestamp]				,
			chr							,
			thisUser[user_account]					,
			thisUser[user_serial]					,
			thisUser[user_index]					,
			thispotion						,
			now							,
			potiontimer[chr][potiontype:thispotion]				,
			delay							,
			potiondelay[potiontype:thispotion]
		      );

#endif
		chr_message( chr, _, !"You don't feel up to this yet!^n" );
		bypass();
	}
	else
	{
		potiontimer[chr][potiontype:thispotion] = now + potiondelay[potiontype:thispotion];
#if defined _POTIONDELAYDEBUG_

		debugfase = 3;

		printf(
			!"itm_potionUse|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d^n"	,
			debugfase						,
			thisUser[user_timestamp]				,
			chr							,
			thisUser[user_account]					,
			thisUser[user_serial]					,
			thisUser[user_index]					,
			thispotion						,
			now							,
			potiontimer[chr][potiontype:thispotion]				,
			delay							,
			potiondelay[potiontype:thispotion]
		      );

#endif
	}

}
