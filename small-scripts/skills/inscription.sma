static const START_SCROLL = 810;
static book_array[64];

public __nxw_sk_inscript( const socket )
{
    getTarget( socket ,funcidx("__inscription_copy"), "Select scroll...");
}

public __inscription_copy(const socket, const target, const item)
{

	if ( socket < 0 || item < 0 )
	    exit;

	new id = itm_getDualByteProperty(item,IP_ID);

	if ( id == 3643 || id == 3834 )
	{
		__inscription_book(socket, item);
		exit;
	}

	if ((id < 7981) || (id > 8044))
	{
		nprintf(socket,"That's not a scroll %d",id);
		exit;
	}

	new chr = getCharFromSocket(socket);
	new backpack = itm_getCharBackPack( chr );
	new backpack_ser = itm_getProperty(backpack,IP_SERIAL);
	new cont_ser = itm_getProperty(item,IP_CONTAINERSERIAL);

	if ( itm_contCountItems(backpack, 3636,0) < 1 )
	{
		nprintf(socket,"You dont have blank scroll in your backpack");
		exit;
	}

	if ( backpack_ser != cont_ser && target ==-1 )
	{
		nprintf(socket,"It must be in your backpack");
		exit;
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
		exit;
	}

	if ( chr_checkSkill( chr, 23, skill_low, skill_hi, 1) )
	{
		// very _very_ dirty solution
		// printf("%d",START_SCROLL+id-7981);
		itm_contDelAmount(backpack, 1, 3636 );
		itm_spawnBackpack(socket, START_SCROLL+id-7981);
		nprintf(socket,"You success to copy that spell");
	}
	else
	{
		new luck = random(100);
		itm_contDelAmount(backpack, 1, 3636 );
		if (luck < 80 )
		{
			nprintf(socket,"You failed to copy that spell");
		}
		else if (luck < 90)
		{
			nprintf(socket,"You destroyed the orginal scroll !");
			itm_reduceAmount(item,1);
		}
		else if (luck < 100)
		{
			nprintf(socket,"You suffered serious magic damage !");
			chr_damage( chr, random(8)*skill_hi/10 );
			magic_castExplosion( chr, chr, 0);
		}
	}
}

static __inscription_book(const socket, const book)
{
	new book_ser = itm_getProperty(book,IP_SERIAL);
	new book_set = set_open();
	set_fillItemsInCont( book_set, book_ser, 0 );
	new book_size = set_size( book_set );
	new i,j;
	//printf("Size %d^n", book_size);
	for (i = 0; i < book_size; i++)
	{
		new item = set_pop( book_set );
		//    printf("Item %d ^n",item);
		new id = itm_getDualByteProperty(item,IP_ID);
		book_array[id-7981]=item;
	}
	set_close( book_set );

	mnu_prepare(socket,8,8);
	mnu_setStyle(socket,MENUSTYLE_SCROLL, 0x481);
	mnu_setTitle(socket,"Select spell");

	for( i = 0; i < 8; i++)
		for (j = 0 ; j < 8; j++)
		{
			if (book_array[i*8+j]!=0)
			{
				//          printf("add %d %d %d^n",book_array[i*8+j],i,j);
				new spell_name[50];
				itm_getProperty(book_array[i*8+j],IP_STR_NAME,_,spell_name);
				mnu_addItem(socket,i,j,spell_name);
			}
			else
				mnu_addItem(socket,i,j,"Empty");
		}

	mnu_setCallback(socket, funcidx("__inscription_cbck"));
	mnu_show(socket);
}

public __inscription_cbck(const socket,const pg,const idx)
{
	if ( book_array[pg*8+idx] !=0 )
		__inscription_copy(socket,-2,book_array[pg*8+idx])
}
