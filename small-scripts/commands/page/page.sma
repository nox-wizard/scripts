/*!
\defgroup script_commands_page
\ingroup script_commands

@{
*/

/*!
\author Fax
\since 0.82
\fn cmd_page(const chr)
\brief make a GM page

<B>syntax:<B> 'page text

<B>command params:</B>
<UL>
<LI> text: the page text 
</UL>

This command submits a page to the GM page list and sends a message to online GMs and counselors
to say that a page has been submitted
*/
public cmd_page(const chr)
{
	new speech[200],temp[20],reason[100];

	chr_getProperty(chr,CP_STR_SPEECH,0,speech);
	str2Token(speech,temp,0,speech,0);

	strcpy(reason,speech);
	#if _CMD_DEBUG_
		#if _PAGESYSTEM_DEBUG_
			log_message("character %d is submitting page: %s",chr,reason);
		#endif
	#endif
	addGmPage(chr,reason);
}
/*! @}*/