//
// send to current socket (s) the list of player near him
//

public example1(const s)
{

    new c = getCharFromSocket(s);

    new set = set_open(); // creating a new set
    
    nprintf(s, "Player near you");

    new cc;
    
    // fill the set with all chars in range
    set_fillChrNearXY(set, chr_getProperty(c, CP2_X), chr_getProperty(c, CP2_Y), 10, 1);

    //set_rewind reinitialize internal set index, so now point to first element
    //!set_isEmpty check if is not at end of set
    //set_get get the current set element
    for( set_rewind(set); !set_isEmpty(set); cc=set_get(set) ) 
    {
		if(cc>0) // if is valid char
			nprintf(s, chr_getProperty(cc, CP_NAME));
    }

    set_close(set); // close the set ( very important )
}

