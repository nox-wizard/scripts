//
// send to current socket (s) the list of player near him
//

public example1(const c)
{

    new set = set_create(); // creating a new set
    
    chr_message( c, _, "Player near you");

    // fill the set with all player in range
	set_addOnPlNearObj( set, c );

    // set_rewind reinitialize internal set index, so now point to first element
    // !set_end check if is not at end of set
    
    for( set_rewind(set); !set_end(set);  ) 
    {
		new cc=set_getChar(set); // get the current set character and move internal index to next
		if(cc!=INVALID) // if is valid char
			chr_message( c, _, chr_getProperty(cc, CP_NAME));
    }

    set_delete(set); // delete the set ( very important )
}

