public prop2Unsigned( string[], const defaultValue )
{
	trim( string );
	if( strlen( string ) )
	{
		str2lower( string );
		if( isStrUnsignedInt( string ) )
			return str2UnsignedInt( string );
		else
			if( isStrHex( string ) )
				return str2Hex( string );
			else
				return defaultValue;
	}
	return defaultValue;
}

public prop2Signed( string[], const defaultValue )
{
	trim( string );
	if( strlen( string ) )
	{
		str2lower( string );
		if( isStrInt( string ) )
			return str2Int( string );
		else
			if( isStrHex( string ) )
				return str2Hex( string );
			else
				return defaultValue;
	}
	return defaultValue;
}

public prop2Boolean( string[], const defaultValue )
{
	trim( string );
	if( strlen( string ) )
	{
		str2lower( string );
		if( isStrBooleanFalse( string ) )
			return 0;
		else
			if( isStrBooleanTrue( string ) )
				return 1;
			else
				return defaultValue;
	}
	return defaultValue;
}
