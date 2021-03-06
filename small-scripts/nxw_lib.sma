// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts (nxw_lib.inc)									  ||
// || Maintained by Xanathar											  ||
// || Last Update (01-sep-01)											  ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This file contains NoX-Wizard lightweight stock prototypes		  ||
// || These are usually helper functions to ease programming.			  ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || Designed for NXW version 0.60s									  ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#if defined _nxwlib_included
  #endinput
#endif
#define _nxwlib_included

#include "small-scripts/API/core.api"
#include "small-scripts/API/string.api"
#include "small-scripts/API/constant.sma"

/*************************************************************************
 PRECOMPILATION PROPERTIES
 *************************************************************************/
const NXWLIB_VERSION = 0x082;
#define AMX_FUNCTION_LENGTH 30

/*************************************************************************
 Boolean enums
 *************************************************************************/

enum eBoolean
{
	false = 0,
	true
};

const INVALID = -1;
const OK = 0;
const VISRANGE = 18;


const FIRST_CHAR_SERIAL = 0;
const FIRST_ITEM_SERIAL = 0x40000000;

/*************************************************************************
 STRING FUNCTIONS
 *************************************************************************/

/** \defgroup script_API_string String
 *  \ingroup script_API
 *  @{
 */

enum eStringMode
{
	UNPACKED,
	PACKED
};

/*!
\author Horian
\fn replaceStr (const string[], const oldletter, const newletter)
\param oldletter: the string to replace
\param newletter: the string to use for replacing
\return		: the replaced whole string
\brief replace certain letter inside a string
*/
stock replaceStr (string[], oldletter[], newletter[])
{
	new stringlen = strlen( string );
	for (new i = 0; i <= stringlen; ++i )
	{
		if ( eStringMode:getStringMode() == UNPACKED )
		{
			if ( string[i] == oldletter[0] )
			string[i] = newletter[0];
		}
		else
		{
			if ( string{i} == oldletter{0} )
				string{i} = newletter{0};
		}
	}
}

/*!
\author Fax modified by Sparhawk
\fn isStrContainedInStr( const string[], const container[])
\param string   : the string to find in the container
\param container: the string that may contain the contained string
\return		: true when the first string is contained somewhere in the second
\brief check if a string is contained in another
*/

stock isStrContainedInStr( const string[], const container[] )
{
	new flag;
	new stringlen    = strlen( string );
	new containerlen = strlen( container );
	new deltalen	 = containerlen - stringlen;

	if ( stringlen <= containerlen )
		for (new i = 0; i <= deltalen && !flag; ++i )
		{
			flag = 1;
			for ( new j = 0; j < stringlen; ++j )
			{
				if ( eStringMode:getStringMode() == UNPACKED )
				{
					if ( string[j] != container[i + j] )
						flag = 0;
				}
				else
				{
					if ( string{j} != container{i + j} )
						flag = 0;
				}
			}
		}

	return flag;
}

stock strcpy( dest[], const source[] )
{
	strncpy( dest, source, strlen( source ) );
}

stock strncpy( dest[], const source[], const size )
{
	new length 	= strlen( source );
	if( length > size )
		length = size;
	new index	= 0;
	switch( eStringMode:getStringMode() )
	{
		case UNPACKED 	:
			{
				while( index < length )
				{
					dest[index] = source[index];
					++index;
				}
				dest[index] = 0;
			}
		case PACKED	:
			{
				while( index < length )
				{
					dest{index} = source{index};
					++index;
				}
				dest{index} = 0;
			}
	}
}

/*!
\author Sparhawk
\fn ltrim(string[])
\brief remove leading spaces from a packed or unpacked string
*/
stock ltrim( string[] )
{
	new length = strlen( string );
	if( length )
	{
		new index  = 0;
		new index1 = 0;
		new packed = isstrpacked( string );
		if( packed )
			while( (string{index} == ' ' || string{index} == '^t') && index < length )
				++index;
		else
			while( (string[index] == ' ' || string[index] == '^t') && index < length )
				++index;
		if( index != index1 )
		{
			while( index < length )
			{
				if( packed )
					string{index1} = string{index};
				else
					string[index1] = string[index];
				++index1;
				++index;
			}
			if( packed )
				string{ index1 } = 0;
			else
				string[ index1 ] = 0;
		}
	}
}

/*!
\author Sparhawk
\fn rtrim(string[])
\brief remove trailing spaces from a packed or unpacked string
*/
stock rtrim( string[] )
{
	new length = strlen( string );
	if( length )
	{
		--length;
		new packed = isstrpacked( string );
		if( packed )
			while( (string{length} == ' ' || string{length} == '^t') && length >= 0 )
			{
				string{length} = 0;
				--length;
			}
		else
			while( (string[length] == ' ' || string[length] == '^t') && length >= 0 )
			{
				string[length] = 0;
				--length;
			}
	}
}

/*!
\author Sparhawk
\fn trim(string[])
\brief remove leading and trailing spaces from a packed or unpacked string
*/
stock trim( string[] )
{
	ltrim( string );
	rtrim( string );
}

/*!
\author Sparhawk
\fn str2upper(string[])
\brief transform all lower case characters in a packed or unpacked string to uppercase
*/
stock str2upper( string[] )
{
	new length = strlen( string );
	if( length )
	{
		new index;
		new packed = isstrpacked( string );
		for( index = 0; index < length; ++index )
		{
			if( packed )
				string{index} = toupper( string{index} );
			else
				string[index] = toupper( string[index] );
		}
	}
}

/*!
\author Sparhawk
\fn str2lower(string[])
\param string:	the string to transform
\brief transform all uppercase characters in a packed or unpacked string to lowercase
*/
stock str2lower( string[] )
{
	new length = strlen( string );
	if( length )
	{
		new index;
		new packed = isstrpacked( string );
		for( index = 0; index < length; ++index )
		{
			if( packed )
				string{index} = tolower( string{index} );
			else
				string[index] = tolower( string[index] );
		}
	}
}

/*!
\author Sparhawk
\fn strcmp(const string1[], const string2[])
\param string1	: a packed or unpacked string
\param string2	: a packed or unpacked string
\return		: 0 for equality, -1 for less, 1 for greater
\brief compare 2 (packed or unpacked or a combination of both) strings
*/
stock strcmp( const string1[], const string2[] )
{
	new looping = 1;

	new length1 = strlen( string1 );
	new length2 = strlen( string2 );

	if( length1 == 0 )
		if( length2 == 0 )
			return 0;
		else
			return -1;

	if( length2 == 0 )
		return 1;

	new packed1 = isstrpacked( string1 );
	new packed2 = isstrpacked( string2 );
	new index1  = 0;
	new index2  = 0;

	while( looping )
	{
		if( packed1 )
		{
			if( packed2 )
			{
				if( string1{index1} > string2{index2} )
					return 1;
				if( string1{index1} < string2{index2} )
					return -1;
			}
			else
			{
				if( string1{index1} > string2[index2] )
					return 1;
				if( string1{index1} < string2[index2] )
					return -1;
			}
		}
		else
		{
			if( packed2 )
			{
				if( string1[index1] > string2{index2} )
					return 1;
				if( string1[index1] < string2{index2} )
					return -1;
			}
			else
			{
				if( string1[index1] > string2[index2] )
					return 1;
				if( string1[index1] < string2[index2] )
					return -1;
			}
		}

		++index1;
		++index2;
		if( index1 == length1 || index2 == length2 )
		{
			if( length1 > length2 )
				return 1;
			if( length1 < length2 )
				return -1;
			return 0;
		}
	}
	return 0;
}

/*!
\author Sparhawk
\fn isstrpacked(string[])
\param string	: string to examine
\return		: 0 when unpacked, 1 when packed
\brief Decide wether a string is in packed or unpacked format
*/
stock isstrpacked( const string[] )
{
	if( !strlen( string ) )
		return 0;

	if( (string[0] >> 8) )
		return 1;

	return 0;
}

/*!
\author Sparhawk
\fn str2Token(const string[], token[], const packedToken, remainder[], const packedRemainder)
\param string		: The string from which to extract a token. Maybe in packed or unpacked format
\param token		: The token extracted from the string
\param packedToken	: Flag which denotes whether the token should be returned in packed or unpacked format
\param remainder	: String minus the extracted token
\param packedRemainder	: Flag which denotes whether the remainder should be returned in packed or unpacked format
\return			: token and remainder
\brief Return token from a string. A token is a substring delimited by a space
*/
stock str2Token( const string[], token[], const packedToken, remainder[], const packedRemainder )
{
	new packedString   = isstrpacked( string );
	new stringLength   = strlen( string );
	new stringIndex	   = 0;
	new tokenIndex     = 0;
	new remainderIndex = 0;
	if( stringLength )
	{
		while( stringIndex < stringLength && ( (packedString ? string{stringIndex} : string[stringIndex]) == ' ' || (packedString ? string{stringIndex} : string[stringIndex]) == '^t' || (packedString ? string{stringIndex} : string[stringIndex]) == '^n') )
			++stringIndex;
		while( stringIndex < stringLength && (packedString ? string{stringIndex} : string[stringIndex]) != ' ' && (packedString ? string{stringIndex} : string[stringIndex]) != '^t' && (packedString ? string{stringIndex} : string[stringIndex]) != '^n')
			if( packedToken )
				token{tokenIndex++} = (packedString ? string{stringIndex++} : string[stringIndex++]);
			else
				token[tokenIndex++] = (packedString ? string{stringIndex++} : string[stringIndex++]);
		while( stringIndex < stringLength )
			if( packedRemainder )
				remainder{remainderIndex++} = (packedString ? string{stringIndex++} : string[stringIndex++]);
			else
				remainder[remainderIndex++] = (packedString ? string{stringIndex++} : string[stringIndex++]);
	}
	if( packedToken )
		token{tokenIndex} = 0;
	else
		token[tokenIndex] = 0;
	if( packedRemainder )
		remainder{remainderIndex} = 0;
	else
		remainder[remainderIndex] = 0;
}

/*!
\author Sparhawk
\fn substring(const string1[], const from, const to, string2[], const packed2)
\param string1	: String from which to extract the substring
\param from	: Offset in string where the substring starts
\param to	: Offset in string where the substring ends
\param string2	: Returned substring
\param packed2	: Flag which signals wether substring should be returned in packed or unpacked format
\return		: string2
\brief Extract a substring from a string
*/
stock substring( const string1[], const from, const to, string2[], const packed2 )
{
	new length = strlen( string1 );
	new index2 = 0;
	if( length && from < length )
	{
		new packed1 = isstrpacked( string1 );
		new from1   = from;
		new to1	    = to < length ? to : length - 1;
		while( from1 <= to1 )
		{
			if( packed1 )
				if( packed2 )
					string2{index2} = string1{from1};
				else
					string2[index2] = string1{from1};
			else
				if( packed2 )
					string2{index2} = string1[from1];
				else
					string2[index2] = string1[from1];
			++from1;
			++index2;
		}
	}
	if( packed2 )
		string2{index2} = 0;
	else
		string2[index2] = 0;
}

/*!
\author Sparhawk
\fn isDigit(const digit)
\param digit	: character to examine
\return		: true when character is a decimal digit else false
\brief Decides wether a character is a decimal digit
*/
stock isDigit( const digit )
{
	if( digit >= '0' && digit <= '9' )
		return 1;
	return 0;
}

/*!
\author Sparhawk
\fn isHexDigit(const digit)
\param digit	: character to examine
\return		: true when character is a hexadecimal digit else false
\brief Decides wether a character is a hexadecimal digit
*/
stock isHexDigit( const digit )
{
	new digit1 = tolower( digit );
	if( isDigit( digit1 ) || digit1 >= 'a' && digit <= 'f' )
		return 1;
	return 0;
}

/*!
\author Sparhawk
\fn hexChar2Number(const character)
\param character: hexadecimal character
\return		: decimal value or -1 on failure
\brief Transform hexadecimal character to a decimal value
*/
stock hexChar2Number( const character )
{
	if( isDigit( character ) )
		return (character - '0');
	else
		if( isHexDigit( character ) )
			return (tolower( character ) - 'a' + 10);

	return -1;
}

/*!
\author Sparhawk
\fn isStrUnsignedInt(const string[])
\param string	: string to check
\return		: true when string is a unsigned integer or false on failure
\brief Check if a string is an unsigned integer value
*/
stock isStrUnsignedInt( const string[] )
{
	new length = strlen( string );
	if( length )
	{
		new packed = isstrpacked( string );
		new index  = 0;
		if( packed )
			while( (index < length) && isDigit( string{index} ) )
				++index;
		else
			while( (index < length) && isDigit( string[index] ) )
				++index;
		if( index == length )
			return 1;
	}
	return 0;
}

/*!
\author Sparhawk
\fn str2UnsignedInt(const string[])
\param string	: stringvalue to transform
\return		: unsigned integer value
\brief Transform a string into an unsigned integer value. Check for validity with isStrUnsignedInt() first!
*/
stock str2UnsignedInt( const string[] )
{
	new length = strlen( string );
	new value  = 0;
	if( length )
	{
		new packed = isstrpacked( string );
		new index  = length - 1;
		new factor = 1;
		while( (index >= 0) && isDigit( (packed ? string{index} : string[index] ) ) )
		{
			value += factor * ( packed ? string{index} - '0' : string[index] - '0' );
			factor*= 10;
			--index;
		}
	}
	return value;
}

/*!
\author Sparhawk
\fn isStrInt(const string[])
\param string	: string to check
\return		: true if string is an integer else false
\brief Check if a string can be transformed into a signed integer value
*/
stock isStrInt( const string[] )
{
	new length = strlen( string );
	if( length )
	{
		new packed = isstrpacked( string );
		new index  = 0;
		new signed = 0;
		if( packed )
		{
			if( string{index} == '-' || string{index} == '+')
			{
				signed = 1;
				++index;
			}
			while( (index < length) && isDigit( string{index} ) )
				++index;
		}
		else
		{
			if( string[index] == '-' || string[index] == '+' )
			{
				signed = 1;
				++index;
			}
			while( (index < length) && isDigit( string[index] ) )
				++index;
		}
		if( index == length && ( !signed || (signed && length > 1) ) )
			return 1;
	}
	return 0;
}

/*!
\author Sparhawk
\fn str2Int(const string[])
\param string	: string to transform
\return		: signed integer value
\brief Transform a string into a signed integer value. Check validity with isStrInt() first;
*/
stock str2Int( const string[] )
{
	new length = strlen( string );
	new value  = 0;
	if( length )
	{
		new packed = isstrpacked( string );
		new sign = 1,signed;
		
		switch(packed ? string{0} : string[0])
		{
			case '-': {signed = 1; sign = -1; }
			case '+': {signed = 1; sign = 1; }
		}
		
		new index  = length - 1;
		new factor = 1;
		while( (index >= signed) && isDigit( (packed ? string{index} : string[index] ) ) )
		{
			value += factor * ( packed ? string{index} - '0' : string[index] - '0' );
			factor*= 10;
			--index;
		}
		
		value *= sign;
	}
	return value;
}

/*!
\author Sparhawk
\fn isStrHex(const string[])
\param string	: string to check
\return		: true if string is a hexadecimal value else false
\brief Check if a string is a hexadecimal value
*/
stock isStrHex( const string[] )
{
	new length = strlen( string );
	if( length > 2 )
	{
		new packed = isstrpacked( string );
		new index  = 0;
		new prefix[1];
		substring( string, 0, 1, prefix, 1 );
		str2lower( prefix );
		if( !strcmp( prefix, !"0x" ) )
		{
			index += 2;
			while( (index < length) && isHexDigit( (packed ? string{index} : string[index] ) ) )
				++index;
		}
		if( index == length )
			return 1;
	}
	return 0;
}

/*!
\author Sparhawk
\fn str2Hex(const string[])
\param string	: string to transform
\return		: unsigned integer value
\brief Transform hexadecimal string value into unsigned integer value. Check for validity with isStrHex first!
*/
stock str2Hex( const string[] )
{
	new length = strlen( string );
	new value  = 0;
	if( isStrHex( string ) )
	{
		new packed = isstrpacked( string );
		new index = length - 1;
		new factor = 1;
		while( index > 1 )
		{
			value = value + hexChar2Number( (packed ? string{index--} : string[index--] ) ) * factor;
			factor *= 16;
		}
	}
	return value;
}

/*!
\author Sparhawk
\fn str2Dirconst string[])
\param string	: string to transform
\return		: one of the DIR_* constants or INVALID
\brief Transform strin into DIR_* constant

allowed direction strings are: n ne e se s sw w nw
*/
stock str2Dir(const string[])
{		
	switch(string[0])
	{
		case 'n':
			switch(string[1])
			{
				case 'e': return DIR_NORTHEAST;
				case 'w': return DIR_NORTHWEST;
				default:  return DIR_NORTH;
			}
		case 's':
			switch(string[1])
			{
				case 'e': return DIR_SOUTHEAST;
				case 'w': return DIR_SOUTHWEST;
				default:  return DIR_SOUTH;
			}
		case 'e': return DIR_EAST;
		case 'w': return DIR_WEST;
		default: return INVALID;
	}

	return INVALID;
}
/*!
\author Sparhawk
\fn isStrBooleanFalse(const string[])
\param	string	: string to examine
\return		: true if string contains boolean false value else false
\brief Check if string contains boolean false value. Valid values are "false", "no", decimal or hexadecimal 0.
*/
stock isStrBooleanFalse( const string[] )
{
	if( !strcmp( string, !"false" ) || !strcmp( string, !"no" ) || ( isStrUnsignedInt( string ) && str2UnsignedInt( string ) == 0 ) ||
	    ( isStrHex( string ) && str2Hex( string ) == 0 ) )
		return 1;
	return 0;
}

/*!
\author Sparhawk
\fn isStrBooleanTrue(const string[])
\param	string	: string to examine
\return		: true if string contains boolean true value else false
\brief Check if string contains boolean true value. Valid values are "true", "no", decimal or hexadecimal 1
*/
stock isStrBooleanTrue( const string[] )
{
	if( !strcmp( string, !"true" ) || !strcmp( string, !"yes" ) || ( isStrUnsignedInt( string) && str2UnsignedInt( string ) == 1 ) ||
	    ( isStrHex( string ) && str2Hex( string ) == 1 ) )
		return 1;
	return 0;
}

/** @} */ // end of script_API_string


/*************************************************************************
 TEMP-FX FUNCTIONS
 *************************************************************************/

/** \addtogroup script_API_tempfx
 *  @{
 */


/*!
\author ???
\fn tempfx_getMore1(const more)
\brief
*/
stock tempfx_getMore1(const more)
{
	return more & 0xFF;
}

/*!
\author ???
\fn tempfx_getMore2(const more)
\brief
*/
stock tempfx_getMore2(const more)
{
	return (more>>8) & 0xFF;
}

/*!
\author ???
\fn tempfx_getMore3(const more)
\brief
*/
stock tempfx_getMore3(const more)
{
	return (more>>16) & 0xFF;
}

/*!
\author ???
\fn tempfx_setMore(const more1, const more2, const more3)
\brief
*/
stock tempfx_setMore(const more1, const more2, const more3)
{
	return more1 + (more2<<8) + (more3<<16);
}

/** @} */ // end of script_API_tempfx


/*************************************************************************
 GUILD FUNCTIONS
 *************************************************************************/
/** \addtogroup script_API_guild
 *  @{
 */

/*!
\author Rage
\fn guild_getGuildFromStone(const stone)
\brief
*/
stock guild_getGuildFromStone(const stone)
{
	return itm_getMultiByteProperty(stone, IP_MORE);
}

/** @} */ // end of script_API_guild

