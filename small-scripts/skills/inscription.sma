static const START_SCROLL = 810;
static book_array[64];

public __nxw_sk_inscript( const chr )
{
	chr_message( chr, _, "Select scroll...");
	target_create( chr, _, _, _, "__inscription_copy" );
}

public __inscription_copy( const t, const chr, const item, const x, const y, const z, const model, const param1 )
{

	if ( chr < 0 || item < 0 )
	    return;

	new id = itm_getProperty(item,IP_ID);

	if ( id == 3643 || id == 3834 )
	{
		__inscription_book(chr, item);
		return;
	}

	if ((id < 7981) || (id > 8044))
	{
		chr_message( chr, _,"That's not a scroll %d",id);
		return;
	}

	new backpack = chr_getBackpack( chr );
	new cont_ser = itm_getProperty(item,IP_CONTAINERSERIAL);

	if ( itm_contCountItems(backpack, 3636,0) < 1 )
	{
		chr_message( chr, _,"You dont have blank scroll in your backpack");
		return;
	}

	if ( backpack != cont_ser )
	{
		chr_message( chr, _,"It must be in your backpack");
		return;
	}

	new skill_low;
	new skill_hi;

	if ((id <= 7988))
	{
		//1 Circle
		skill_low = 10;
		skill_hi = 30;
	}
	else if ((id <= 7996))
	{
		//2 Circle
		skill_low = 30;
		skill_hi = 40;
	}
	else if (id <= 8004)
	{
		//3 Circle
		skill_low = 40;
		skill_hi = 50;
	}
	else if ((id <= 8012))
	{
		//4 Circle
		skill_low = 50;
		skill_hi = 60;
	}
	else if ((id <= 8020))
	{
		//5 Circle
		skill_low = 60;
		skill_hi = 70;
	}
	else if ((id <= 8028))
	{
		//6 Circle
		skill_low = 70;
		skill_hi = 80;
	}
	else if ((id <= 8036))
	{
		//7 Circle
		skill_low = 80;
		skill_hi = 90;
	}
	else if ((id <= 8044))
	{
		//8 Circle
		skill_low = 90;
		skill_hi = 100;
	}
	else
	{
		//shouldnt happen
		printf("Player %d tried to use rewrite on item %d", chr, item);
		return;
	}

	if ( chr_checkSkill( chr, 23, skill_low, skill_hi, 1) )
	{
		// very _very_ dirty solution
		// printf("%d",START_SCROLL+id-7981);
		itm_contDelAmount(backpack, 1, 3636 );
		itm_createInBp( START_SCROLL+id-7981, chr );
		chr_message( chr, _,"You success to copy that spell");
	}
	else
	{
		new luck = random(100);
		itm_contDelAmount(backpack, 1, 3636 );
		if (luck < 80 )
		{
			chr_message( chr, _,"You failed to copy that spell");
		}
		else if (luck < 90)
		{
			chr_message( chr, _,"You destroyed the orginal scroll !");
			itm_reduceAmount(item,1);
		}
		else if (luck < 100)
		{
			chr_message( chr, _,"You suffered serious magic damage !");
			chr_damage( chr, random(8)*skill_hi/10 );
			magic_castExplosion( chr, chr, 0);
		}
	}
}

static __inscription_book(const chr, const book)
{
	new book_ser = itm_getProperty(book,IP_SERIAL);
	new book_set = set_create();
	set_addItemsInCont( book_set, book_ser, false, _ );
	//new book_size = set_size( book_set );
	new i,j;
	//printf("Size %d^n", book_size);
	for( set_rewind( book_set); !set_end( book_set ); )
	{
		new item = set_getItem( book_set );
		//    printf("Item %d ^n",item);
		if( item!=INVALID ) {
			new id = itm_getProperty(item,IP_ID);
			book_array[id-7981]=item;
		}
	}
	set_delete( book_set );

	mnu_prepare(chr,8,8);
	mnu_setStyle(chr,MENUSTYLE_SCROLL, 0x481);
	mnu_setTitle(chr,"Select spell");

	for( i = 0; i < 8; i++)
		for (j = 0 ; j < 8; j++)
		{
			if (book_array[i*8+j]!=0)
			{
				//          printf("add %d %d %d^n",book_array[i*8+j],i,j);
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
	if ( book_array[pg*8+idx] !=0 )
		__inscription_copy( -1, chr, book_array[pg*8+idx],0,0,0,0,0 )
}
