/*!
\syntax gui_guildRecruitR(const socket, const recruit )
\author Sparhawk
\since 0.82
\param socket	: socket of the recruiting pc
\param recruit	: serial of the (targetted) recruit
\brief Add a new recruit to a guild
*/
public gui_guildRecruitR(const socket, const recruit )
{
	if( socket >= 0 )
	{
		//
		// Retrieve guild information from recruiter
		//
		new recruiter	   = getCharFromSocket( socket )
		new recruiterGuild = chr_getGuild( recruiter );
		new guildName[31];
		guild_getProperty( recruiterGuild, GP_NAME, _, guildName );
		if( recruit >= 0 )
		{
			//
			// Check wether candidate can be recruited
			//
			new recruitName[31];
			chr_getProperty( recruit, CP_STR_NAME, _, recruitName );
			new recruitGuild = chr_getGuild( recruit );
			if( !guild_exists( recruitGuild ) )
			{
				//
				// Add target as candidate
				//
				if( !guild_addRecruit( recruiterGuild, recruit ) )
					nprintf( socket, !"%s is already a candidate in your guild", recruitName );
				else
				{
					nprintf( socket, !"%s has been accepted as a candidate in your guild", recruitName );
					new recruitSocket = getSocketFromChar( recruit );
					if( recruitSocket >= 0 )
						nprintf( recruitSocket, !"You have been accepted as a candidate in guild %s", guildName );
				}
			}
			else
			{
				//
				// Allready a guild member
				//
				if( recruitGuild == recruiterGuild )
					nprintf( socket, !"%s is already a member of your guild", recruitName );
				else
					nprintf( socket, !"%s is already a member of another guild %d", recruitName, recruitGuild );
			}
		}
		else
		{
			//
			// Not a valid character
			//
			nprintf( socket, !"That's not a valid character" );
		}
		//
		// Redisplay guildstone gump
		//
		gui_guildStone( recruiterGuild, recruiter );
	}
	else
		log_warning(!"invalid socket in gui_guildRecruitR");
}

/*!
\syntax gui_guildRecruit( const recruiter )
\author Sparhawk
\since 0.82
\param recruiter: serial of the pc who's going to recruit a guild member
\brief Display a targetting cursor to select a guild recruit
*/
public gui_guildRecruit( const recruiter )
{
	//
	// Display targeting cursor
	//
	getTarget(getSocketFromChar( recruiter ), funcidx("gui_guildRecruitR"), "Select recruit" )
}
