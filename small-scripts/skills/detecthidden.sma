//Detect Hidden Skill-Bypass in SMALL by Horian

public __nxw_sk_dtchidden(const chr)
{
bypass();
	chr_message( chr, _ , msg_sk_dhiddenDef[0]);
	target_create( chr, _ , _, _, "detecthidtwo" );
}

public detecthidtwo( const t, const c, const target, const trgx, const trgy, const trgz, const model, const param1 )
{
	new char_x = chr_getProperty(c, CP_POSITION, CP2_X);  
	new char_y = chr_getProperty(c, CP_POSITION, CP2_Y); 
	new char_z = chr_getProperty(c, CP_POSITION, CP2_Z); 
	new detectskill = chr_getProperty(c,CP_SKILL,14); //range for detect is as smaller as lower skill is and chance for detect is lower when other char has higher hiding skill
	
	new dx = char_x - trgx;
	new dy = char_y - trgy;
	
	if ((dx > 10) || (dx < -10) || (dy > 10) || (dy < -10)) // Abfrage ueber Visrange
	{
		chr_message(c, _, "Thats too far away to search there, if you want to search there go closer.");
		return;
	}
	else
	{
		new set = set_create(); // creating a new set
		// fill the set with all chars in range
		new range = detectskill/10;
		set_addNpcsNearXY( set, char_x,char_y,range);
		//set_rewind reinitialize internal set index, so now point to first element
		//!set_isEmpty check if is not at end of set
		new trg_x;
		new trg_y;
		new cd_x;
		new cd_y;
		new hidingskill;
		new dist;
		new skillmin;
		new hidden;
		
		for( set_rewind(set); !set_end(set);  )
		{
			new cc=set_getChar(set); // get the current set character and move internal index to next
			new priv2 = chr_getProperty(cc,CP_PRIV2);
			hidden = chr_getProperty(cc,CP_HIDDEN);
			if(cc!=INVALID && cc!=c && !(priv2&0x08) && (hidden!=0)) 
			/* if is valid char and not our char and is not permahidden and is hidden itself */
			{
				//printf("test3, hidden: %d", hidden);
				trg_x = chr_getProperty(c, CP_POSITION, CP2_X);
				trg_y = chr_getProperty(c, CP_POSITION, CP2_Y);
				cd_x = char_x - trg_x;
				cd_y = char_y - trg_y;
				
				hidingskill = chr_getProperty(cc,CP_SKILL,21);
				dist = (cd_x + cd_y)/2;
				skillmin = (dist*20)+(hidingskill/2);
				//printf("skillmin: %d", skillmin);
				
				if ( skillmin < 0 )skillmin = 0;
				else if ( skillmin > 999 ) skillmin = 999;
				
				if(chr_checkSkill(c, 14, skillmin, 1000, 1))
				{
					chr_message(cc, _, msg_sk_dhiddenDef[2]);
					chr_setProperty( cc,CP_HIDDEN,_,0); //becomes visible
					chr_setProperty( cc,CP_PRIV2,_, chr_getProperty( target,CP_PRIV2,_) &~0x08 ); //not permahidden
					chr_update(cc);
					new chrname[30]; //neuer leerer String fuer das auslesen des Charnamens
					chr_getProperty(cc, CP_STR_NAME, 0, chrname); //auslesen des Charnamen
					chr_message(c, _,msg_sk_dhiddenDef[3], chrname);
					return;
				}
			} //if closed
		} //for searches whole range, if not stopped before than goes on
		set_delete( set );
		//item detect
		set = set_create(); // creating a new set
		set_addItemsNearXY( set, char_x, char_y, range, false );
		//set_rewind reinitialize internal set index, so now point to first element
		//!set_isEmpty check if is not at end of set
		
		for( set_rewind(set); !set_end(set);  )
		{
			new itm=set_getItem(set); // get the current set item and move internal index to next
			//printf("item found: %d^n", itm);
			hidden = itm_getProperty(itm,IP_VISIBLE);
			new owner = itm_getProperty(itm,IP_OWNERSERIAL);
			//printf("itm: %d, owner: %d, char: %d, hidden: %d", itm, owner, c, hidden);
			if(itm!=INVALID && owner!=c && (hidden==1)) 
			/* if is valid itm and owner is not our char and its hidden level 1 (owner and GM can see it = detectable) */
			{
				//printf("test3, hidden: %d", hidden);
				trg_x = itm_getProperty(itm, IP_POSITION, IP2_X);
				trg_y = itm_getProperty(itm, IP_POSITION, IP2_Y);
				cd_x = char_x - trg_x;
				cd_y = char_y - trg_y;
				
				printf("hidingskill call");
				hidingskill = chr_getProperty(c,CP_SKILL,SK_HIDING);
				printf("hidingskill left");
				dist = (cd_x + cd_y)/2;
				skillmin = (dist*20)+(hidingskill/2);
				//printf("skillmin: %d", skillmin);
				
				if ( skillmin < 0 )skillmin = 0;
				else if ( skillmin > 999 ) skillmin = 999;
				
				if(chr_checkSkill(c, 14, skillmin, 1000, 1))
				{
					chr_message(c, _, msg_sk_dhiddenDef[2]);
					itm_setProperty( itm,IP_VISIBLE,_,0); //becomes visible
					itm_refresh(itm);
					new itmname[30]; //neuer leerer String fuer das auslesen des Itemnamens
					itm_getProperty(itm, IP_STR_NAME, 0, itmname); //auslesen des Itemnamen
					chr_message(c, _,msg_sk_dhiddenDef[3], itmname);
					return;
				}
			} //if closed
		} //for searches whole range, if not stopped before than goes on
		set_delete( set );
		
		chr_message(c, _, msg_sk_dhiddenDef[4]);
		return;
	} //else closed
} //function closed
