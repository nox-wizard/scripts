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
<LI> topic: the topic you need help on,to be choosen from topic list
</UL>

Shows a little guide on various topics, you can define topics and text in commands/help/helpTopics.txt.
The text will be shown in a gump.<br>
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

	new speech[200],topic[200],temp[20];

	chr_getProperty(chr,CP_STR_SPEECH,0,speech);
	str2Token(speech,temp,0,topic,0);

	trim(topic);

	for(new i; i < NUM_LOADED_TOPICS; i++)
		if(!strcmp(helpTopics[i][__helpTopic],topic))
		{
			cmd_help_showTopic(INVALID,chr,i + 1);
			return;
		}

	popupMenu(chr,topic,"Help is not available for that topic.^nYou can ask the staff to write it");
}

public cmd_help_showTopicList(chr)
{
	cursor_setProperty(CRP_TAB,40);
	createListMenu(30,30,20,30,NUM_LOADED_TOPICS,"Available topics","cmd_help_listTopic","cmd_help_showTopic")
	menu_show(chr);
}

public cmd_help_listTopic(page,line,col,i)
{
	menu_addLabeledButton(i + 1,helpTopics[i][__helpTopic]);
}

public cmd_help_showTopic(menu,chr,topic)
{
	if(!topic) return;
	popupMenu(chr,helpTopics[topic - 1][__helpTopic],helpTopics[topic - 1][__helpText]);
}

public loadHelpTopics()
{
	new file = file_open(helpFile,"r");

	if(file == INVALID)
	{
		log_error("Unable to open %s, help won't work",helpFile);
		return;
	}

	log_message("^t->Loading help topics for 'help command...");

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
	
	NUM_LOADED_TOPICS = i;
	log_message("^t->%d help topics loaded",NUM_LOADED_TOPICS);
	if(!file_eof(file))
		log_warning("helpTopics[][] is undersized, increas it's size in small-scripts/commands/help/constant.sma",i);
	
	file_close(file);
}