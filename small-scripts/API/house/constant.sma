// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard	: Embedded Small Scripts			||
// || Maintained by	: Wintermute				||
// || Last Update	: 06-apr-2003					||
// || Designed for NXW 	: 0.82						||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#if defined _house_constant_
  #endinput
#endif
#define _house_constant_

/*!  \defgroup script_API_constants Constants from the house system
*    \ingroup script_API
* @{
*/
//	if (property < 100) return T_BOOL;
//	if (property < 200) return T_CHAR;
//	if (property < 400) return T_INT;
//	if (property < 450) return T_SHORT;
//	if (property < 500) return T_STRING;

// Boolean properties
const HP_PUBLICHOUSE = 1;
const HP_NOREALMULTI = 2;

// Byte properties

const HP_DIMENSION = 100; // 4 subproperties

// Integer properties
const HP_SERIAL = 200;
const HP_OWNER = 201;
const HP_KEYCODE = 202;
const HP_HOUSEDEED=203;
const HP_CHARPOSITION=204; // x,y,z as supproperties
const HP_LOCKEDITEMS=205;
const HP_MAXLOCKEDITEMS=206;
const HP_SECUREDITEMS=207;
const HP_MAXSECUREDITEMS=208;

// Short properties

// String properties

const HP_STR_HOUSENAME=450;


/* @} */
/* @} */