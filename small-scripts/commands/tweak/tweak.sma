
public target_tweak( const socket, const target, const item )
{
	if(socket < 0) 
		return;
		
	if( isChar(target) ) {
		tweak_char( socket, target );
	}
	else if( isItem( item ) ) {
		tweak_item( socket, item );
	}
	else nprintf( socket, "Tweak work only on object" );

}

tweak_char( const socket, const chr )
{
	nprintf( socket, "Tweak on character" );
}


tweak_item( const socket, const item )
{
	nprintf( socket, "Tweak on item" );
}
