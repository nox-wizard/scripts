#if defined _gmpages_included_
	#endinput
#endif
#define _gmpages_included_

/*!
\defgroup script_commands_pagesystem_constants constants
\ingroup script_commands_pagesystem

@{
*/

#define MAX_GM_PAGES_PER_CHAR 3 //!< maximum number of pages per character, you can't modify this valueas it is defined in sources too.

new __onlineStaff; //!< set that is filled with all pageable online staff
new pageResourceMap;

enum
{
	PAGE_STATUS_SOLVING, //!< the page is being solved
	PAGE_STATUS_SOLVED //!< the page has been solved
} //!< codes to be used to call sendPageHandlingMessage(solver,pager,page,status) as "status" parameter

/*! @}*/