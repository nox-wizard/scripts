#define BLANK_SCROLL_ID 3636

#define NUM_SCROLLS 64
static book_array[NUM_SCROLLS];  //scrolls in a spellbook
/*!
\author unknown, modified by Fax
\ingroup script_skills
\fn __nxw_sk_inscript( const chr )
\param chr the character who is using inscription
\brief called by __nxw_sk_main, gets a target to select the scroll
*/
public __nxw_sk_inscript( const chr )
{
	chr_message( chr, _, "Select scroll...");
	target_create( chr, _, _, _, "__inscriptTarget" );
}

/*!
\author unknown, modified by Fax
\ingroup script_skills
\fn __inscriptTarget( const t, const chr, const item, const x, const y, const z, const model, const param1 )
\param all standard target callback params
\brief target callback for inscription
*/
public __inscriptTarget( const t, const chr, const item, const x, const y, const z, const model, const param1 )
{	    
	if (!isItem(item))
	{
		chr_message(chr,_,"What are you trying to do?");
	    	return;
	}
	
	//if the item is a book, call __inscription_book
	new id = itm_getProperty(item,IP_ID);
	if ( id == 3643 || id == 3834 )
	{
		__inscription_book(chr, item);
		return;
	}

	//if item is a scroll call __inscription_scroll
	if(7981 <= id <= 8044)
	{
		__inscription_scroll(chr, item);
		return;
	}

	chr_message( chr, _,"That's not a scroll %d",id);
}

static __inscription_scroll(const chr, const scroll)
{
	new id = itm_getProperty(scroll,IP_ID);
	
	//check if scroll is in backpack
	new backpack = chr_getBackpack( chr );
	new cont_ser = itm_getProperty(scroll,IP_CONTAINERSERIAL);
	if ( backpack != cont_ser )
	{
		chr_message( chr, _,"It must be in your backpack");
		return;
	}

	//count blank scrolls in backpack
	if ( itm_contCountItems(backpack, 3636,0) < 1 )
	{
		chr_message( chr, _,"You dont have blank scroll in your backpack");
		return;
	}
	
	//set skill requirements depending on circle
	new skill_low;
	new skill_hi;
	switch(id)
	{
		case 7981..7988: {skill_low = 100;  skill_hi = 300;} //1st circle
		case 7989..7996: {skill_low = 300;  skill_hi = 400;} //2nd circle
		case 7997..8004: {skill_low = 400;  skill_hi = 500;} //3rd circle
		case 8005..8012: {skill_low = 500;  skill_hi = 600;} //4th circle
		case 8013..8020: {skill_low = 600;  skill_hi = 700;} //5th circle
		case 8021..8028: {skill_low = 700;  skill_hi = 800;} //6th circle
		case 8029..8036: {skill_low = 800;  skill_hi = 900;} //7th circle
		case 8037..8044: {skill_low = 900;  skill_hi = 1000;} //8th circle
	}

	//if success copy scroll
	if ( chr_checkSkill( chr, SK_INSCRIPTION, skill_low, skill_hi, true) )
	{
		itm_contDelAmount(backpack, 1, BLANK_SCROLL_ID );
		itm_createInBp(id, chr );
		chr_message( chr, _,"You success to copy that spell");
	}
	
	//else see if character only fails or destroys the scroll too
	else
	{
		new luck = random(100);
		itm_contDelAmount(backpack, 1, BLANK_SCROLL_ID );
		switch(luck)
		{
		case 0..80: chr_message( chr, _,"You failed to copy that spell");
		case 81..90:
			{
				chr_message( chr, _,"You destroyed the orginal scroll !");
				itm_reduceAmount(scroll,1);
			}
		case 91..100:
			{
				chr_message( chr, _,"You suffered serious magic damage !");
				chr_damage( chr, random(8)*skill_hi/10 );
				magic_castExplosion( chr, chr, 0);
			}
		}
	}
}


static __inscription_book(const chr, const book)
{
	new book_ser = itm_getProperty(book,IP_SERIAL);
	new book_set = set_create();
	
	//fill a set with the scrolls in the book
	set_addItemsInCont( book_set, book_ser, false, _ );
	
	
	//transfer scroll IDs to book_array
	for( set_rewind( book_set); !set_end( book_set ); )
	{
		new item = set_getItem( book_set );
		if( item!=INVALID ) {
			new id = itm_getProperty(item,IP_ID);
			book_array[id-7981]=item;
		}
	}
	set_delete( book_set );

	//build a menu to select scrolls in the book
	mnu_prepare(chr,8,8);
	mnu_setStyle(chr,MENUSTYLE_SCROLL, 0x481);
	mnu_setTitle(chr,"Select spell");

	new i,j;
	for( i = 0; i < 8; i++)
		for (j = 0 ; j < 8; j++)
		{
			if (book_array[i*8+j]!=0)
			{
				new spell_name[50];
				itm_getProperty(book_array[i*8+j],IP_STR_NAME,_,spell_name);
				mnu_addItem(chr,i,j,spell_name);
			}
			else
				mnu_addItem(chr,i,j,"Empty");
		}
	mnu_setCallback(chr, funcidx("__inscription_cbck"));
	mnu_show(chr);
}

public __inscription_cbck( const chr, const pg, const idx )
{
	//copy scroll by calling __inscription_scroll for the selected scroll
	if ( book_array[pg*8+idx] != 0 )
		__inscription_scroll(chr, book_array[pg*8+idx]);
}