// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard	: Embedded Small Scripts			||
// || Maintained by	: Luxor, Sparhawk				||
// || Last Update	: 06-apr-2003					||
// || Designed for NXW 	: 0.82						||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#if defined _nxw_variable_constant_
  #endinput
#endif
#define _nxw_variable_constant_

const VAR_TYPE_ANY	= 0;
const VAR_TYPE_INTEGER	= 1;
const VAR_TYPE_STRING	= 3;

enum
{
	VAR_ERROR_NONE = 0,
	VAR_ERROR_UNKNOWN_VAR = 1,
	VAR_ERROR_DUPLICATE_VAR = 2,
	VAR_ERROR_WRONG_TYPE = 3,
	VAR_ERROR_ACCESS_DENIED = 4
};
