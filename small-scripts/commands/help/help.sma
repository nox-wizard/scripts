#include "small-scripts/commands/help/constants.sma"
/*!
\defgroup script_command_tile 'tile
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_help(const chr)
\brief tiles an item

<B>syntax:<B> 'help [topic]
<B>command params:</B>
<UL>
<LI> topic: the topic you need helpon,to be choosen from topic list
</UL>

Shows a little guide on various topics, you can define topics and text in commands/help/helpTopics.txt.
The textwill be shown in a gump.<br>
If you don't specify any parameters a topic list will be shown.
*/
public cmd_help(const chr)
{
	readCommandParams(chr);
	
	if(!strlen(__cmdParams[0]))
	{
		cmd_help_showTopicList(chr);
		return;	
	}
	
	for(new p = 1; p < __MAX_PARAMS;p++)
		sprintf(__cmdParams[0],"%s %s",__cmdParams[0],__cmdParams[p]);
	
	rtrim(__cmdParams[0]);
	
	for(new i; i < NUM_HELP_TOPICS && strlen(helpTopics[i][__helpTopic]);i++)
	{
		printf("i:%d^n",i);
		if(!strcmp(helpTopics[i][__helpTopic],__cmdParams[0]))
		{
			printf("sending message^n");
			chr_message(chr,_,"%s",helpTopics[i][__helpText]);
			return;
		}
	}
	
	chr_message(chr,_,"Help is not available for that topic, you can ask the staff to write it");
	
}	

public cmd_help_showTopicList(chr)
{
	chr_message(chr,_,"Available help topics:");
	for(new i; i < NUM_HELP_TOPICS && strlen(helpTopics[i][__helpTopic]);i++)
		chr_message(chr,_,"%s",helpTopics[i][__helpTopic]);
	
}

public loadHelpTopics()
{
	new file = file_open(helpFile,"r");
	
	if(file == INVALID)
	{
		log_error("Unable to open %s, help won't work",helpFile);
		return;	
	}
	
	log_message("Loading help topics for 'help command...");
	
	new buffer[200],cmd[50],i;
	for(i = 0; i < NUM_HELP_TOPICS; i++)
	{
		//seek TOPIC command
		while(strcmp(cmd,"TOPIC") && !file_eof(file))
		{
			file_read(file,buffer);
			str2Token(buffer,cmd,0,buffer,0);
		}
		
		if(file_eof(file)) break;
		
		trim(buffer);
		strcpy(helpTopics[i][__helpTopic],buffer);
		
		//seek TEXT command
		while(strcmp(cmd,"TEXT"))
		{
			file_read(file,buffer);
			str2Token(buffer,cmd,0,buffer,0);
		}
		
		
		file_read(file,buffer);
		sprintf(helpTopics[i][__helpText],"%s",buffer);
		file_read(file,buffer);
		while(strcmp(buffer,""))
		{
			sprintf(helpTopics[i][__helpText],"%s^n%s",helpTopics[i][__helpText],buffer);
			file_read(file,buffer);
		}		
	}
	
	log_message("%d help topics loaded",i);
	printf("^n");
}