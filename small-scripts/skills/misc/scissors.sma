
public _scissorsDbClick( const scissor, const chr ) 
{  
	chr_message( chr, _,  msg_sk_miscDef[0]);
	target_create( chr, _, _, _, "_scissorsTarget" );
	bypass();
} 
 
public _scissorsTarget( const target, const chr, const itm )
{

	if( !isItem( itm ) )
		return;

    if( itm_getProperty( itm, IP_MAGIC )==4 )
    	return;
    	
	new id = itm_getProperty( itm, IP_ID );

	
	if( isCloth( id ) || isCutCloth( id ) ) 
	{

		if( itm_getProperty( itm, IP_AMOUNT )<0 ) 
		{
			itm_remove(itm);
			return;
		}

		chr_sound( chr, 0x0248 );
		chr_message( chr, _,  msg_sk_miscDef[1]);
		/*new benda =*/ itm_createInBpDef( "$item_clean_bandages", chr, 3 );
		itm_reduceAmount(itm, 1);
		
	}

	else if( isBoltOfCloth( id ) ) 
		_doCloth( chr, itm );		
	else if( isHide( id ) ) 
		_doLeatherPiece( chr, itm );
	else
    	chr_message( chr, _, msg_sk_miscDef[2] );

}
