//
// send to current socket (s) the list of player near him
//

public example1(const s)
{

    new c = getCharFromSocket(s);

    new set = set_open(); // creating a new set
    
    nprintf(s, "Player near you");

    // fill the set with all chars in range
	set_addCharsNearXYZ( set, chr_getProperty(c, CP2_X), chr_getProperty(c, CP2_Y), _, true, false );

    //set_rewind reinitialize internal set index, so now point to first element
    //!set_isEmpty check if is not at end of set
    
    for( set_rewind(set); !set_end(set);  ) 
    {
		new cc=set_getChar(set); // get the current set character and move internal index to next
		if(cc!=INVALID) // if is valid char
			nprintf(s, chr_getProperty(cc, CP_NAME));
    }

    set_close(set); // close the set ( very important )
}

