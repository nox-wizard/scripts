//Hide skill Bypass in SMALL by Horian

public __nxw_sk_hiding(const c)
{
bypass();
new char_x = chr_getProperty(c, CP_POSITION, CP2_X);  
new char_y = chr_getProperty(c, CP_POSITION, CP2_Y); 
new char_z = chr_getProperty(c, CP_POSITION, CP2_Z); 
new hidingskill = chr_getProperty(c,CP_SKILL,21);

new set = set_create(); // creating a new set
    // fill the set with all chars in range
	set_addNpcsNearXY( set, char_x,char_y,((2000-(2*hidingskill))/2));

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
		chr_message(c, _,"There is someone nearby who prevents you to hide.");
		return;
		}
	} //for searches whole range, if not stopped before than goes on
	new checkskill = random(1000)
	if( hidingskill >= checkskill && chr_checkSkill(c, SK_HIDING, 0, 1000, 1))
	{
	chr_setProperty( c,CP_HIDDEN,_,1);
	chr_setProperty( c,CP_PRIV2,_, chr_getProperty( c,CP_PRIV2,_) &~0x08 ); //hidden by skill and not permahidden
	}
	else chr_message(c, _, "Your attempt to hide is not succesfull.");
}
