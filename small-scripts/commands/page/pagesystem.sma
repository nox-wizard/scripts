#include "small-scripts/commands/page/constants.sma"
#define MAX_GM_PAGES 100
#define MAX_GM_PAGE_LENGTH 128
static GMpages[MAX_GM_PAGES][MAX_GM_PAGE_LENGTH];

/*!
\defgroup script_commands_pagesystem page system functions
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
	log_message("Initializing GM page system^n");
	__onlineStaff = set_create();
	pageResourceMap = createResourceMap();
	//pageSystemTest();
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

Sends a message to all online pageable staff to inform them that someone is solving a page.<br>
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
		case PAGE_STATUS_SOLVING: sprintf(message,msg_commandsDef[25],solverName,pagerName,page);
		case PAGE_STATUS_SOLVED: sprintf(message,msg_commandsDef[26],solverName,pagerName,page);
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

//TEMPORARY SMALL BASED APIs

public getGmPageList(&set)
{	
	set = set_create();
	new s = set_create();
	set_addAllOnlinePl(s);
	
	//seek paging players in the online players list
	new chr;
	for(set_rewind(s); !set_end(s);)
	{
		//store characters that have at least one page submitted
		chr = set_getChar(s);
		if(getResourceLocationValue(pageResourceMap,chr,0,0) != -1)
			set_add(set,chr);
	}
	
	return 1;
}

public addGmPage(chr,reason[])
{
	//seek first empty place in the array
	new p;
	for(p = 0; p < MAX_GM_PAGES; p++)
		if(GMpages[p][0] == 0)
			break;
	
	
	strcpy(GMpages[p],reason);
	
	//seek first empty place in the resource map for this player
	new i;
	while(getResourceLocationValue(pageResourceMap,chr,i,0) >= 0)
		i++;
	
	if(i == MAX_GM_PAGES_PER_CHAR)
		return false;
	
	
	//store the page index in the resource map as:
	//x: player
	//y: page
	//z: unused
	setResourceLocationValue(pageResourceMap,p,chr,i,0);
		
	#if _CMD_DEBUG_
		#if _PAGESYSTEM_DEBUG_
			log_message("loading page '%s' from character %d at position %d",reason,chr,p);
		#endif
	#endif
	
	return true;
}

public chr_getGmPage(const chr, const page,reason[],time[])
{
	new pageIdx = getResourceLocationValue(pageResourceMap,chr,page - 1,0);
	if(pageIdx < 0)
		return false;
		
	strcpy(reason,GMpages[pageIdx]);
	strcpy(time,"--:--");
	
	return true;
}

public chr_solveGmPage (const chr ,const page)
{
	new p = page - 1;
	new pageIdx = getResourceLocationValue(pageResourceMap,chr,p,0);
	if(pageIdx < 0)
		return false;
	
	#if _CMD_DEBUG_
		#if _PAGESYSTEM_DEBUG_
			log_message("deleting page %d (index %d) from character %d",page,pageIdx,chr);
		#endif
	#endif
	
	GMpages[pageIdx][0] = 0;
	setResourceLocationValue(pageResourceMap,-1,chr,p,0);
	
	//move next pages back to fill the blank
	for(p++; pageIdx != -1 ;p++)
	{
		pageIdx = getResourceLocationValue(pageResourceMap,chr,p,0);
		setResourceLocationValue(pageResourceMap,pageIdx,chr,p - 1,0);	
	}
	
	return true;
}

/*! @}*/