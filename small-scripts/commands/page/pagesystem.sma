#include "small-scripts/commands/page/constants.sma"

/*!
\defgroup script_commands_pagesystem
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn initPageSystem()
\since 0.82
\brief initializes GMpage system

Creates the __onlineStaff set, wich contain all online pageable GM and counselors
\return nothing
*/
public initPageSystem()
{
	log_message("Initializing GM page system");
	__onlineStaff = set_create();
}

/*!
\author Fax
\fn addOnlineStaff(const chr)
\param chr: the character
\since 0.82
\brief adds a pageable character to the pageable characters set

Checks if the character is a pageable GM or a counselor and adds his serial to the list of online pageable
staff
\return nothing
*/
public addOnlineStaff(const chr)
{
	if(chr_isGM(chr) || chr_isCounselor(chr))
	{
		set_add(__onlineStaff,chr);
	#if _PAGESYSTEM_DEBUG_
		new name[30];
		chr_getProperty(chr,CP_STR_NAME,0,name);
		log_message("Adding %s to online staff list",name);
		log_message("Online staff is:");
		new chr2;
		set_rewind(__onlineStaff);
		while(!set_end(__onlineStaff))
		{
			chr2 = set_getChar(__onlineStaff);
			chr_getProperty(chr2,CP_STR_NAME,0,name);
			if(chr_isGMPageable(chr))
				log_message("^t%s - pageable",name);
			else log_message("^t%s",name);
		}
		printf("^n");
	#endif
	}
}

/*!
\author Fax
\fn removeOnlineStaff(const chr)
\param chr: the character
\since 0.82
\brief removes a character from the pageable staff list

removes a character from the pageable staff list
\return nothing
*/
public removeOnlineStaff(const chr)
{
	new chr2 = INVALID;
	set_rewind(__onlineStaff);
	while(!set_end(__onlineStaff) && chr2 != chr)
		chr2 = set_getChar(__onlineStaff);

	if(set_end(__onlineStaff) && chr2 != chr) return;

#if _PAGESYSTEM_DEBUG_
	new name[30];
	chr_getProperty(chr,CP_STR_NAME,0,name);
	log_message("Removing %s from online staff list",name);
	printf("^n");
#endif
	set_remove(__onlineStaff,chr);
}

/*!
\author Fax
\fn sendPageHandlingMessage(solver,pager,page,status)
\param solver: the character who is solving the page
\param pager:the character who did the page
\param page: page index, to specify wich of the character's page we are referring to.
\param status: page status (PAGE_STATUS_SOLVING, PAGE_STATUS_SOLVED)
\since 0.82
\brief sends a message to all onlie pageable staff to inform them that someone is solving a page

Sends a message to all onlie pageable staff to inform them that someone is solving a page.<br>
The message says if the page is being solved or if it's already solved.

\return nothing
*/
public sendPageHandlingMessage(solver,pager,page,status)
{
	new solverName[30],pagerName[30],message[100];

	chr_getProperty(solver,CP_STR_NAME,0,solverName);
	chr_getProperty(pager,CP_STR_NAME,0,pagerName);

	switch(status)
	{
		case PAGE_STATUS_SOLVING: sprintf(message,"%s is solving %s's page",solverName,pagerName,page);
		case PAGE_STATUS_SOLVED: sprintf(message,"%s is solved %s's page number %d",solverName,pagerName,page);
	}

	new chr2 = INVALID;

	//send page handling massage only to those who are pageable
	for(set_rewind(__onlineStaff);!set_end(__onlineStaff);)
	{
		chr2 = set_getChar(__onlineStaff);
		if(chr_isGMPageable(chr2) || chr_isCounselor(chr2))
			chr_message(chr2,_,message);
	}
}

/*! @}*/