
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
	if( chr==INVALID )
		return;
	
	if( itm==INVALID )
		return;

    if( itm_getProperty( itm, IP_MAGIC )==4 )
    	return;
    	
	new id = itm_getProperty( itm, IP_ID );
	
	if( IsCloth( id ) || IsCutCloth( id ) ) {

		new amt=pi->amount;
		new color = itm_getProperty( itm, IP_COLOR );
		
		chr_sound( chr, 0x0248 );
		pc->sysmsg(TRANSLATE("You cut some cloth into bandages, and put it in your backpack"));

		P_ITEM pcc=item::CreateFromScript( "$item_clean_bandages", pc->getBackpack() );
		VALIDATEPI(pcc);
		pcc->setColor( color );
		// need to set amount and weight and pileable, note: cannot set pilable while spawning item -Fraz-
		pcc->weight=10;
		pcc->pileable=1;
		pcc->att=9;
		pcc->amount=amt;
		pcc->Refresh();
		pi->deleteItem();
		weights::NewCalc(pc);
		statwindow(pc,pc);
		return;
	}

	else if( IsBoltOfCloth( id ) ) {
		_doCloth( s, itm );
	}
	
	else if( IsHide( id ) ) {
		_doLeatherPiece( s, itm );
	}
    
    else ntprintf( s, "You cannot cut anything from that item." );

}
