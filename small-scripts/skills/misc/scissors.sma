
public _scissorsDbClick( const scissor, const s ) 
{  
	if (s < 0) return;  
   	ntprintf( s, "What cloth should I use these scissors on?" );
	getTarget(s, funcidx("_scissorsTarget"), ""); 
	bypass();
} 
 
public _scissorsTarget( const s, const target, const itm ) 
{
	if( s<0 ) 
		return;
		
	new chr = getCharFromSocket(s);
	if( chr < 0 )
		return;
	
	if( itm < 0 )
		return;

    if( itm_getProperty( itm, IP_MAGIC )==4 )
    	return;
    	
	new id = itm_getProperty( itm, IP_ID );

	
	if( isCloth( id ) || isCutCloth( id ) ) {

		if( itm_getProperty( itm, IP_AMOUNT )<0 ) {
			itm_remove(itm);
			return;
		}

		chr_sound( chr, 0x0248 );
		ntprintf(s,"You cut some cloth into bandages, and put it in your backpack");
		new benda = itm_createInBpDef( "$item_clean_bandages", chr, 3 );
		itm_reduceAmount(itm, 1);
		
	}

	else if( isBoltOfCloth( id ) ) {
		_doCloth( s, itm );
		
	}
	
	else if( isHide( id ) ) {
		_doLeatherPiece( s, itm );
	}
    
    else
    	ntprintf( s, "You cannot cut anything from that item." );

}
