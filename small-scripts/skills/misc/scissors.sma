
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
    	
	new id = itm_getDualByteProperty( itm, IP_ID );

	
	if( isCloth( id ) || isCutCloth( id ) ) {

		if( itm_getProperty( itm, IP_AMOUNT )<0 ) {
			itm_remove(itm);
			return;
		}

		chr_sound( chr, 0x0248 );
		ntprintf(s,"You cut some cloth into bandages, and put it in your backpack");
		new bp = itm_getCharBackPack( chr );
		new benda = itm_createByDef( "$item_clean_bandages" );
		itm_setProperty( benda, IP_AMOUNT, _, 3 );
		itm_contPileItem( bp, benda );
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
