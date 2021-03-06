/*!
\defgroup script_commands_popup 'popup
\ingroup script_commands

@{
*/

/*!
\author Fax
\since 0.82
\fn cmd_popup(const chr)
\brief make a GM popup

<B>syntax:<B> 'popup text

<B>command params:</B>
<UL>
<LI> text: the popup text 
</UL>

This command submits a popup to the GM popup list and sends a message to online GMs and counselors
to say that a popup has been submitted
*/
public cmd_popup(const chr)
{
	new message[200];

	chr_getSpeech(chr,message);
	
	trim(message);
	
	new lasti;
	if(strlen(message) > 25)
	{
		for(new i = 0; i < strlen(message); i++)
			if(message[i] == ' ' && i - lasti > 25)
			{	
				lasti = i;
				message[i]='^n';
			}
	}
	else
	{
		for(new i = strlen(message); i < 25; i++)
			message[i] = ' ';
		message[25] = 0;
	}
	
	new title[25];
	chr_getProperty(chr,CP_STR_NAME,0,title);
	sprintf(title,msg_commandsDef[199],title);	
	broadcastPopup(title,message);	
}
/*! @}*/