//Detect Hidden Skill-Bypass in SMALL by Horian

public __nxw_sk_dtchidden(const chr)
{
bypass();
	chr_message( chr, _ , "Where do you want to search for someone?");
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
	set_addNpcsNearXY( set, char_x, char_y,(detectskill)/10); //?!?

    //set_rewind reinitialize internal set index, so now point to first element
    //!set_isEmpty check if is not at end of set
    
    printf("test1");
    for( set_rewind(set); !set_end(set);  ) 
        {
        printf("test2");
        new cc=set_getChar(set); // get the current set character and move internal index to next
        new priv2 = chr_getProperty(cc,CP_PRIV2);
        new hidden = chr_getProperty(cc,CP_HIDDEN);
        if(cc!=INVALID && cc!=c && !(priv2&0x08) && (hidden!=0)) 
/* if is valid char and not our char and is not permahidden and is hidden itself */
		{
		//printf("test3, hidden: %d", hidden);
		new trg_x = chr_getProperty(c, CP_POSITION, CP2_X);
		new trg_y = chr_getProperty(c, CP_POSITION, CP2_Y);
		new cd_x = char_x - trg_x;
		new cd_y = char_y - trg_y;
		new hidingskill = chr_getProperty(cc,CP_SKILL,21);
		new dist = (cd_x + cd_y)/2;
		new skillmin = (dist*20)+(hidingskill/2);
		if ( skillmin < 0 )
		skillmin = 0;
		else if ( skillmin > 999 )
		skillmin = 999;
		if(chr_checkSkill(c, 14, skillmin, 1000, 1))
		      {
		      chr_message(cc, _, "You have been revealed");
		      chr_setProperty( cc,CP_HIDDEN,_,0); //becomes visible
		      chr_setProperty( cc,CP_PRIV2,_, chr_getProperty( target,CP_PRIV2,_) &~0x08 ); //not permahidden
		      new chrname[30]; //neuer leerer String fuer das auslesen des Charnamens
		      chr_getProperty(cc, CP_STR_NAME, 0, chrname); //auslesen des Charnamen
		      chr_message(c, _,"You revealed %s.", chrname);
		      return;
		      }
		} //if closed
	} //for searches whole range, if not stopped before than goes on
	chr_message(c, _, "You fail to find anyone.");
	return;
} //else closed
} //function closed