// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard	: Embedded Small Scripts			||
// || Maintained by	: Luxor, Sparhawk				||
// || Last Update	: 06-apr-2003					||
// || Designed for NXW 	: 0.82						||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#if defined _nxw_guild_constant_
  #endinput
#endif
#define _nxw_guild_constant_


const PROP_GUILD = 3;

/** \defgroup script_const_guild Guild constants
 *  \ingroup script_API_guild
 *  @{
 */

	const GP_TYPE = 100;
	const GP_STR_NAME = 450;
	const GP_STR_WEBPAGE = 451;
	const GP_STR_ABBREVIATION = 452;
	const GP_UNI_CHARTER = 500;

	enum GUILD_TYPE {
		GUILD_TYPE_NORMAL = 0,
		GUILD_TYPE_CHAOS,
		GUILD_TYPE_ORDER,
		GUILD_TYPE_CITY
	}
	
	const GMP_RANK = 100;
	const GMP_TITLETOGGLE = 101;
	const GMP_STR_TITLE = 450;

	const GRP_I_RECRUITER = 200;
	

 
/** @} */ // end of script_const_guild
