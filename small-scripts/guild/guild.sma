
enum {
	PRIV_NONE = 0x00,
	PRIV_ADD_MEMBER = 0x01,
	PRIV_DEL_MEMBER = 0x02,
	PRIV_ADD_RECRUIT = 0x04,
	PRIV_DEL_RECRUIT = 0x08,
	PRIV_ALL = 0xFF
}
	
enum {
	RANK_GUILDMASTER = 0,
	RANK_MEMBER	
}

const ALL_RANKS = 2;

static ranks[ALL_RANKS][] = { //rank name
	"GuildMaster",
	"Member"
};

static rank_priv[ALL_RANKS] = {	//rank privileges
	PRIV_ALL,
	PRIV_NONE
};

static rank_male_name[ALL_RANKS][] = {	//rank male name
	"GuildMaster",
	"Novice"
};

static rank_female_name[ALL_RANKS][] = {	//rank female name
	"GuildMistress",
	"Novice"
};



public _guild_createStandardGuild( const stone, const master )
{
	new guild = guild_create( stone );
	
	if( chr_getProperty( master, CP_ID )==BODY_MALE )
		guild_addMember( guild, master, RANK_GUILDMASTER, 0, rank_male_name[ RANK_GUILDMASTER ][RANK_GUILDMASTER] );
	else
		guild_addMember( guild, master, RANK_GUILDMASTER, 0, rank_female_name[ RANK_GUILDMASTER ][RANK_GUILDMASTER] );
	
	return guild;
}
