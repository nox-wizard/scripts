/*!
\defgroup script_command_racelang 'racelang
\ingroup script_commands

@{
*/

/*!
\author Horian(const chr)
\fn cmd_racelang
\brief sets the char to speak in racelanguage (only people that are of same race understand what is said, inkludes range check)

<B>syntax:<B> 'racelang
*/
public cmd_racelang(const c)
{
	new race = chr_getProperty(c, CP_NPCRACE ); 
	new name[50] ;  
	chr_getProperty(c, CP_STR_NAME, _ ,name);
	new str[200] ;  
	chr_getProperty(c, CP_STR_SPEECH, _ ,str);
	
	//position of player  
 
	new ch_x = chr_getProperty(c, CP_POSITION, CP2_X);  
	new ch_y = chr_getProperty(c, CP_POSITION, CP2_Y);  
 
	//get the chars in range.  
 
	new in_range = set_create(); 
	set_addOnPlNearXY( in_range,ch_x,ch_y,10 );    
 
	while(set_size(in_range)>0)  
	{  
		new near_cc = set_getChar(in_range); 
		if (near_cc)  
		{			
			if ((chr_getProperty(c, CP_NPCRACE ) == race) || ( random(80) < chr_getInt(near_cc)))  
			{  
			//str[5] cuts ".lang" from the begining
				chr_message( c, _,"You understand how %s says: %s",name,str[5]);  
			}
			else 
			{
				chr_speech(NPC_TALK_RUNIC ,-1,c, "bla");
				chr_message( c, _," %s says something in an unknown language.",name);
			}
		}
	}
	set_delete(in_range); 
}

/*! }@ */