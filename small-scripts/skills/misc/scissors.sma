
public _scissorsDbClick( const s ) 
{  
	if (s < 0) return;  
	getTarget(s, funcidx("_scissorsTarget"), "What cloth should I use these scissors on?"); 
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
	
	if( IsCloth( id ) || IsCutCloth( id ) ) {

		new amt = itm_getProperty( itm, IP_AMOUNT );
		chr_sound( chr, 0x0248 );
		nprintf(s,"You cut some cloth into bandages, and put it in your backpack");
		new bp = itm_getCharBackPack( target );
		new benda = itm_createByDef( "$item_clean_bandages" );
		itm_setProperty( benda, IP_AMOUNT, _, 3 );
		itm_contPileItem( bp, benda );
		itm_setProperty( itm, IP_AMOUNT, _, ( (itm_getProperty( itm, IP_AMOUNT )) -1) );
		if ((itm_getProperty( itm, IP_AMOUNT )) == 0) {
			itm_remove(itm);
			return;
		}			
		
	}

	else if( IsBoltOfCloth( id ) ) {
		_doCloth( s, itm );
	}
	
	else if( IsHide( id ) ) {
		_doLeatherPiece( s, itm );
	}
    
    else ntprintf( s, "You cannot cut anything from that item." );

}
