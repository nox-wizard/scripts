//Hide skill Bypass in SMALL by Horian

public __nxw_sk_hiding(const c)
{
bypass();
if(chr_getProperty( c,CP_HIDDEN,_) == 1)
{
	chr_setProperty( c,CP_HIDDEN,_,0);
	chr_setProperty( c,CP_PRIV2,_, chr_getProperty( c,CP_PRIV2,_) &~0x08 ); //not hidden by skill and not permahidden
	chr_update(c);
	return;
}
new char_x = chr_getProperty(c, CP_POSITION, CP2_X);  
new char_y = chr_getProperty(c, CP_POSITION, CP2_Y); 
new char_z = chr_getProperty(c, CP_POSITION, CP2_Z); 
new hidingskill = chr_getProperty(c,CP_SKILL,21);

new set = set_create(); // creating a new set
    // fill the set with all chars in range
    new range = ((2000-(2*hidingskill))/150);
    if(range <= 4) range = 4; //you can't hide standing right next to someone, TODO: LOS 
	set_addNpcsNearXY( set, char_x,char_y,range);

    //set_rewind reinitialize internal set index, so now point to first element
    //!set_isEmpty check if is not at end of set
    
    for( set_rewind(set); !set_end(set);  ) 
        {
        new cc=set_getChar(set); // get the current set character and move internal index to next
        new priv2 = chr_getProperty(cc,CP_PRIV2); 
        if(cc!=INVALID && cc!=c && (chr_getInt(cc)>= 36) && !(priv2&0x08) && (chr_getProperty(cc,CP_HIDDEN)==0)) 
/* if is valid char and not our char and not intelligent enough to realize we hide us or something and
there is nobody permahidden or hidden itself (exploit prevention: use hide for detect hidden player)- prevent hiding*/
		{
		chr_message(c, _,msg_sk_dhiddenDef[5]);
		set_delete(set);
		return;
		}
	} //for searches whole range, if not stopped before than goes on
	new checkskill = random(1000)
	printf("checkskill: %d, hidingskill: %d", checkskill, hidingskill);
	if( (hidingskill > checkskill) && (chr_checkSkill(c, 21, 0, 1000, 1)))
	{
	chr_message(c, _, msg_sk_dhiddenDef[6]);
	chr_setProperty( c,CP_HIDDEN,_,1);
	chr_setProperty( c,CP_PRIV2,_, chr_getProperty( c,CP_PRIV2,_) &~0x08 ); //hidden by skill and not permahidden
	chr_update(c);
	}
	else chr_message(c, _, msg_sk_dhiddenDef[7]);
	
	set_delete(set);
}
