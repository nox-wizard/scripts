
public target_stats( const socket, const target, const item )
{
	if(socket < 0) 
		return;
		
	if( isChar(target) ) {
		stats_char( socket, target );
	}
	else if( isItem( item ) ) {
		stats_item( socket, item );
	}
	else nprintf( socket, "stats work only on object" );

}

stats_char( const socket, const chr )
{
	nprintf( socket, "stats on character" );
}


stats_item( const socket, const item )
{
	nprintf( socket, "stats on item" );
}

