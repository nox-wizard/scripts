/*!
\defgroup script_commands_page 'page
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
	new reason[100];

	chr_getSpeech(chr,reason);
	
	if(addGmPage(chr,reason))
		chr_message(chr,_,msg_commandsDef[262]);
	else chr_message(chr,_,msg_commandsDef[263],MAX_GM_PAGES_PER_CHAR);
}
/*! @}*/