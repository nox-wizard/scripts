// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard	: Embedded Small Scripts			||
// || Maintained by	: Luxor, Sparhawk				||
// || Last Update	: 06-apr-2003					||
// || Designed for NXW 	: 0.82						||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#if defined _nxw_region_constant_
  #endinput
#endif
#define _nxw_region_constant_

/*!  \defgroup script_API_constants Region constants
*    \ingroup script_API
* @{
*/

const RG_BOUNDARY=200;
const RG2_X1=0;
const RG2_Y1=1;
const RG2_X2=2;
const RG2_Y2=3;

enum SPAWNFLAG_ENUM
{
	SPAWN_AMOUNT,
	SPAWN_RANDOM,
	SPAWN_MAX
} ;

enum SPAWNTYPE_ENUM
{
	SPAWN_ALL,
	SPAWN_DYNAMIC,
	SPAWN_STATIC
} ;


/* @} */
/* @} */