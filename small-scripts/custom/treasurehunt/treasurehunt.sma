/*!
\defgroup script_treasurehunt
\ingroup script_misc

@{
*/

/*!
\author Horian
\brief regulates treasure chest creation, treasure map creation and map deciphering

See config.sma for setting it up, don't change values here if you don't have to.
<br>
*/

const maporigin = 1001;
const mapintelligence = 1002;
const mapcharname = 1003;
const mapmlx = 1004;
const mapmty = 1005;
const mapmrx = 1006;
const mapmby = 1007;
const maptx = 1008;
const mapty = 1009;
const Treasure_MAP_DROP = 1010

const xone =3; //X1
const yone =4; //Y1
const xtwo =5; //X2
const ytwo =6; //Y2
static map_drop_chance; //get from dying char to calculate map-loot-chance

//version1: list of regions that are allowed to spawn treasure
static filename_rec[] = "small-scripts/custom/treasurehunt/treasure_region.cfg";
public regionRecAmount; //numbers of region rectangles for treasure hunt
const rec_exists = 1; //param to store if rectangle exists

public callmapdrop ( const died)
{
	if(chr_isaLocalVar(died, Treasure_MAP_DROP, VAR_TYPE_INTEGER))
	{
		map_drop_chance = chr_getLocalIntVar(died, Treasure_MAP_DROP);
	}
}

public deathsavevalue( const c, const serialcorps) //called by ONAFTERDEATH monster/animal
{
	new mapchance = random(100);
	//printf("treasure map drop chance");
	printf("mapdrop-chance is %d, mapchance is %d^n", map_drop_chance, mapchance);
	//if(mapchance <= 100) //ok, map should be created
	if(mapchance <= map_drop_chance) //ok, map should be created
	{
		//first analyze the monster the map is from
		new mobname[50];
		chr_getProperty(c, CP_STR_NAME, 0, mobname); //Monstername
		
		new mobscript = chr_getProperty(c, CP_SCRIPTID); //monster ScriptID
		
		new mobint = chr_getInt(c); //monster Intelligence
		new mobhp = chr_getHitPoints(c) //monster hitpoints
		new decipherlevel = (mobint + mobhp)/2;
		
		//printf("map creation");
		new map = itm_create(getIntFromDefine( "$item_treasure_map" ), serialcorps, 1);
		itm_setProperty(map, IP_STR_NAME, 0, "treasure map from a %s", mobname);
		
		itm_addLocalStrVar(map, mapcharname, mobname);
		itm_addLocalIntVar(map, maporigin, mobscript);
		itm_addLocalIntVar(map, mapintelligence, decipherlevel );
		
		//add double click event for deciphering function
		#if treas_sys_type //old, osi-like system (treasure is only spawned when digging at treasure location)
		{
			itm_setEventHandler(map, EVENT_ITM_ONDBLCLICK, EVENTTYPE_STATIC, "deciphermapold");
			return;
		}
		#endif
		
		#if !treas_sys_type //new system, treasure is spawned immediatelly = world gets a treasure that can be found no matter if someone searches for it
		{
			itm_setEventHandler(map, EVENT_ITM_ONDBLCLICK, EVENTTYPE_STATIC, "deciphermapnew");
			new mlx, mty, mrx, mby, tx, ty;
			
			switch(REGIONBASING)
			{
				case 0: treasureposition_zero(mlx, mty, mrx, mby, tx, ty);
				case 1: treasureposition_one(mlx, mty, mrx, mby, tx, ty);
			}
			
			//store map values in local Vars untill no deciphering is done
			//printf("set map values for positions: mlx %d, mty %d, mrx %d, mby %d^n", mlx, mty, mrx, mby);
			itm_addLocalIntVar(map, mapmlx, mlx );
			itm_addLocalIntVar(map, mapmty, mty );
			itm_addLocalIntVar(map, mapmrx, mrx );
			itm_addLocalIntVar(map, mapmby, mby );
			itm_addLocalIntVar(map, maptx, tx );
			itm_addLocalIntVar(map, mapty, ty );
			
			new treasure;
			//printf("decipherlevel is %d^n", decipherlevel);
			switch(decipherlevel)
			{
				case 0..20: treasure = itm_createByDef( "$item_treasure_chest_lvl1" );
				case 21..40: treasure = itm_createByDef( "$item_treasure_chest_lvl2" );
				case 41..60: treasure = itm_createByDef( "$item_treasure_chest_lvl3" );
				case 61..80: treasure = itm_createByDef( "$item_treasure_chest_lvl4" );
				case 81..100: treasure = itm_createByDef( "$item_treasure_chest_lvl5" );
			}			 
			itm_setProperty(treasure, IP_POSITION, IP2_X, tx);
			itm_setProperty(treasure, IP_POSITION, IP2_Y, ty);
			itm_setProperty(treasure, IP_POSITION, IP2_Z, map_getZ(tx, ty));
			itm_setProperty(treasure, 111, _, 2); //moveable by nobody
			itm_setProperty(treasure, 120, _, 1); //visible to GM's and owner
			itm_refresh(treasure);
			//printf("treasure chest spawned at %d, %d, %d^n", tx, ty, map_getZ(tx, ty))
		}
		#endif
	}
}

public deciphermapold (const map, const c)
{
	bypass();
	if (chr_getProperty(c, CP_SKILLDELAY) <= getCurrentTime() || chr_isGM(c)) // no more skilldelay or char is GM
	{
		new decipherlevel = itm_getLocalIntVar(map, mapintelligence);
		new chrstr[50];
		itm_getLocalStrVar(map, mapcharname, chrstr);
		//new chrscript = itm_getLocalIntVar(map, maporigin); //wofür eigentlich?
		new skillcarto = (decipherlevel/4);
		
		if(!chr_checkSkill (c, SK_CARTOGRAPHY, skillcarto, 1000, 1)) //cartography skill is lower than mean of mob int and mob hitpoints devided by 4
		{
			chr_message( c, _, "You fail to decipher the map");  // Nope :P
			new delay = decipherdelay;
			chr_setProperty( c, CP_SKILLDELAY, _, getCurrentTime() + delay ); // Set the skill delay, no matter if it was a success or not
			chr_sound (c, 91); //inscription sound, soundeffect(s, 0x02, 0x49); // Do some inscription sound regardless of success or failure
			return;
		}
		
		new mapname[50];
		sprintf(mapname, "a deciphered treasure map from %s", chrstr);
		itm_setProperty(map, IP_STR_NAME, _, "%s", mapname);
		chr_getProperty(c, CP_STR_NAME, 0, chrstr); //auslesen des entziffernden Chars
		itm_setProperty(map, IP_STR_CREATOR, _, chrstr); // Store the decipherer
		
		new mlx, mty, mrx, mby, tx, ty;
		switch(REGIONBASING)
		{
			case 0: treasureposition_zero(mlx, mty, mrx, mby, tx, ty);
			case 1: treasureposition_one(mlx, mty, mrx, mby, tx, ty);
		}
		
		//store the treasure map borders at the deciphered treasure map
		itm_setProperty( map, IP_MORE, 1, ((mlx >> 8)&0xFF)); //map border left x
		itm_setProperty( map, IP_MORE, 2, (mlx&0xFF));
		itm_setProperty( map, IP_MORE, 3, ((mty >> 8)&0xFF)); //map border top y
		itm_setProperty( map, IP_MORE, 4, (mty&0xFF));
		itm_setProperty( map, IP_MOREB, 1, ((mrx >> 8)&0xFF)); //map border right x
		itm_setProperty( map, IP_MOREB, 2, (mrx&0xFF));
		itm_setProperty( map, IP_MOREB, 3, ((mby >> 8)&0xFF)); //map border bottom y
		itm_setProperty( map, IP_MOREB, 4, (mby&0xFF));
		
		// Store the treasure's location
		itm_setProperty( map, IP_MOREPOSITION, IP2_X, tx);
		itm_setProperty( map, IP_MOREPOSITION, IP2_Y, ty);
		itm_refresh(map);
		chr_setProperty( c, CP_SKILLDELAY, _, getCurrentTime() + decipherdelay ); // Set the skill delay, no matter if it was a success or not
		chr_sound (c, 91); //inscription sound, soundeffect(s, 0x02, 0x49); // Do some inscription sound regardless of success or failure
		chr_message( c, _, "You put the deciphered map in your pack");
		return;
	}
	else
	{
		chr_message( c, _, "You must wait a few moments before trying to decipher the map.");
		return;
	}
}

public deciphermapnew (const map, const c)
{	
	bypass();
	if ( chr_getProperty(c, CP_SKILLDELAY) <= getCurrentTime() || chr_isGM(c) ) // kein Skilldelay mehr oder GM
	{
		new decipherlevel = itm_getLocalIntVar(map, mapintelligence);
		new chrstr[50];
		itm_getLocalStrVar(map, mapcharname, chrstr);
		//new chrscript = itm_getLocalIntVar(map, maporigin); //for what do we need this? can't remember ... :(
		new skillcarto = (decipherlevel/4);
		
		if(!chr_checkSkill (c, SK_CARTOGRAPHY, skillcarto, 1000, 1)) //Kartographieskill ist niedriger als Durchschnitt Monsterint und Monsterhitpoints durch 4
		{
			chr_message( c, _, "You fail to decipher the map");  // Nope :P
			chr_setProperty( c, CP_SKILLDELAY, _, getCurrentTime() + decipherdelay ); // Set the skill delay, no matter if it was a success or not
			chr_sound (c, 91); //inscription sound, soundeffect(s, 0x02, 0x49); // Do some inscription sound regardless of success or failure
			return;
		}
		
		//schatz nicht mehr per detect hidden auffindbar
		new mapname[50];
		sprintf(mapname, "a deciphered treasure map from %s", chrstr);
		itm_setProperty(map, IP_STR_NAME, _, "%s", mapname);

		chr_getProperty(c, CP_STR_NAME, 0, chrstr); //auslesen des Charnamen
		itm_setProperty(map, IP_STR_CREATOR, _, chrstr); // Store the decipherer
		
		//printf("call map values for positions: mlx %d, mty %d, mrx %d, mby %d^n", mlx, mty, mrx, mby);
		new mlx = itm_getLocalIntVar(map, mapmlx);
		new mty = itm_getLocalIntVar(map, mapmty);
		new mrx = itm_getLocalIntVar(map, mapmrx);
		new mby = itm_getLocalIntVar(map, mapmby);
		new tx = itm_getLocalIntVar(map, maptx);
		new ty = itm_getLocalIntVar(map, mapty);
		
		//store the treasure map borders at the deciphered treasure map
		itm_setProperty( map, IP_MORE, 1, mlx%256); //map border left x
		itm_setProperty( map, IP_MORE, 2, mlx/256);
		itm_setProperty( map, IP_MORE, 3, mty%256); //map border top y
		itm_setProperty( map, IP_MORE, 4, mty/256);
		itm_setProperty( map, IP_MOREB, 1, mrx%256); //map border right x
		itm_setProperty( map, IP_MOREB, 2, mrx/256);
		itm_setProperty( map, IP_MOREB, 3, mby%256); //map border bottom y
		itm_setProperty( map, IP_MOREB, 4, mby/256);
		
		// Store the treasure's location
		itm_setProperty( map, IP_MOREPOSITION, IP2_X, tx);
		itm_setProperty( map, IP_MOREPOSITION, IP2_Y, ty);
		itm_refresh(map);
		chr_setProperty( c, CP_SKILLDELAY, _, (getCurrentTime() + decipherdelay) ); // Set the skill delay, no matter if it was a success or not
		chr_sound (c, 91); //inscription sound, soundeffect(s, 0x02, 0x49); // Do some inscription sound regardless of success or failure
		chr_message( c, _, "You put the deciphered map in your pack");
		itm_delEventHandler(map, EVENT_ITM_ONDBLCLICK);
		itm_setProperty(map, IP_TYPE, _, 302);
		
		itm_delLocalVar(map, mapintelligence);
		itm_delLocalVar(map, mapcharname);
		itm_delLocalVar(map, maporigin);
		itm_delLocalVar(map, mapmlx);
		itm_delLocalVar(map, mapmty);
		itm_delLocalVar(map, mapmrx);
		itm_delLocalVar(map, mapmby);
		itm_delLocalVar(map, maptx);
		itm_delLocalVar(map, mapty);
		return;
	}
	else
	{
		chr_message( c, _, "You must wait a few moments before trying to decipher the map.");
		return;
	}
}

//helper to calculate the treasure position and map border
public treasureposition_zero( &mlx, &mty, &mrx, &mby, &tx, &ty) //& before the value instead of const means, the value is changed in the calling function too - no need for return
{
	random(bmrx);
	random(bmby);
	
	// Generate treasure map borders, 500 steps is the map area wide and long
	mlx = bmrx - 250;	 
	mty = bmby - 250;
	mrx = bmrx + 250;
	mby = bmby + 250;
	
	// Check if the treasure map borders are over map0.mul borders, correct errors
	if (mlx < 0)    // Too far left?
	{
		mrx -= mlx; // Add the stuff too far left to the right border (tlx is neg. so - and - gets + ;)
		mlx = 0;    // Set mlx to correct value
	}
	else if (mrx > bmrx) // Too far right?
	{
		mlx -= mrx - bmrx;    // Subtract what is to much from the left border
		mrx = bmrx;   // Set lrx to correct value
	}
	if (mty < 0)    // Too far top?
	{
		mby -= mty; // Add the stuff too far top to the bottom border (mly is neg. so - and - gets + ;)
		mty = 0;    // Set tly to correct value
	}
	else if (mby > bmby) // Too far bottom?
	{
		mty -= mby - bmby;    // Subtract what is to much from the top border
		mby = bmby;   // Set lry to correct value
	}
}

public treasureposition_one( &mlx, &mty, &mrx, &mby, &tx, &ty) //& before the value instead of const means, the value is changed in the calling function too - no need for return
{
	//printf("enter treasure position two^n");
	//inside which region rectangle we put the treasure?
	new selected = random(regionRecAmount); //starts with zero so we must make sure we get zero too
	//printf("we have %d possible Positions and %d is we want^n", regionRecAmount, selected);
	new Treasure_loc = createResourceMap( RESOURCEMAP_LOCATION, 1, "Treasure_loc");
	new existingcounter = -1;
	new btlx;
	new btty;
	new btrx;
	new btby;
	
	//now lets go to the chosen region rectangle number and get the region borders
	for(new regioncycle = 0; regioncycle <= max_Regionnumber; regioncycle++) //we need to search through all possible position and see which ones are defined, then see if the next defined one is the one we place the treasure in from random
	{
		new exist = getResourceLocationValue(Treasure_loc, regioncycle, rec_exists, 0 );
		if(exist == 1)
		{
			existingcounter++;
			//printf("enter %d of possible %d, which is Position section %d^n", existingcounter, regionRecAmount, regioncycle);
			if(existingcounter == selected)
			{
				btlx = getResourceLocationValue(Treasure_loc, regioncycle, xone, 0 );
				btty = getResourceLocationValue(Treasure_loc, regioncycle, yone, 0 );
				btrx = getResourceLocationValue(Treasure_loc, regioncycle, xtwo, 0 );
				btby = getResourceLocationValue(Treasure_loc, regioncycle, ytwo, 0 );
			}
		}
	}
	tx = btrx-btlx;
	if(tx != 0)
		tx = random(tx);
	tx = btlx + tx;
	
	ty = btby-btty;
	if(ty != 0)
		ty = random(ty);
	ty = btty + ty;
	
	// Generate treasure map borders, 500 steps is the map area wide and long
	mlx = tx - 250;	 
	mty = ty - 250;
	mrx = tx + 250;
	mby = ty + 250;
	
	printf("treasurepositions claculating: X1 %d, Y1 %d, X2 %d, Y2 %d^n", mlx, mby, mrx, mty);
	
	// Check if the treasure map borders are over map0.mul borders, correct errors
	if (mlx < 0)    // Too far left?
	{
		mrx -= mlx; // Add the stuff too far left to the right border (tlx is neg. so - and - gets + ;)
		mlx = 0;    // Set mlx to correct value
	}
	else if (mrx > bmrx) // Too far right?
	{
		mlx -= mrx - bmrx;    // Subtract what is to much from the left border
		mrx = bmrx;   // Set lrx to correct value
	}
	if (mty < 0)    // Too far top?
	{
		mby -= mty; // Add the stuff too far top to the bottom border (mly is neg. so - and - gets + ;)
		mty = 0;    // Set tly to correct value
	}
	else if (mby > bmby) // Too far bottom?
	{
		mty -= mby - bmby;    // Subtract what is to much from the top border
		mby = bmby;   // Set lry to correct value
	}
}

public initTreasure()
{
	#if REGIONBASING //treasure rect
	{		
		log_message("Loading region rectangles borders for treasure hunt ...");
		regionRecAmount = xss_scanFile(filename_rec,"scan_regions_rect");
		if( regionRecAmount ==INVALID)
		{
			log_error("Unable to read from %s",filename_rec);
			return;
		}
		log_message("Region rectangles borders for treasure hunt loaded^n");
	}
	#endif
}

public scan_regions_rect(file,line)
{
	new Treasure_loc = createResourceMap( RESOURCEMAP_LOCATION, 1, "Treasure_loc");
	if(strcmp(currentXssSectionType,"REGREC"))
	{
		skipXssSection = true;
		return;
	}
	
	//number of rectangle we have at the moment
	new regionRecNumber = currentXssSection;
	
	//how many region rectangles have we defined?
	if(!strcmp(currentXssSectionType,"REGREC"))
	{		
		setResourceLocationValue(Treasure_loc, 1, regionRecNumber, rec_exists, 0 ); //treasure position exists
	}
	
	//do we exceed region rectangle max (512)
	if(currentXssSection >= max_Regionnumber)
	{
		log_warning("%s(%d): there are only %d available regions",filename_rec,line,max_Regionnumber);
		skipXssSection = true;
		return;
	}
	
	if(!strcmp(currentXssCommand,"X1"))
	{
		if(!isStrInt(currentXssValue))
		{
			log_error("%s(%d): must be an integer",filename_rec,line);
			skipXssSection = true;
			return;
		}
		setResourceLocationValue(Treasure_loc, str2Int(currentXssValue) , regionRecNumber, xone, 0 ); //save rectangles number "regionRecNumber" X1
		return;
	}
	
	if(!strcmp(currentXssCommand,"Y1"))
	{
		if(!isStrInt(currentXssValue))
		{
			log_error("%s(%d): must be an integer",filename_rec,line);
			skipXssSection = true;
			return;
		}
		setResourceLocationValue(Treasure_loc, str2Int(currentXssValue) , regionRecNumber, yone, 0 ); //save rectangles number "regionRecNumber" Y1
		return;
	}
	
	if(!strcmp(currentXssCommand,"X2"))
	{
		if(!isStrInt(currentXssValue))
		{
			log_error("%s(%d): must be an integer",filename_rec,line);
			skipXssSection = true;
			return;
		}
		setResourceLocationValue(Treasure_loc, str2Int(currentXssValue) , regionRecNumber, xtwo, 0 ); //save rectangles number "regionRecNumber" X1
		return;
	}
	
	if(!strcmp(currentXssCommand,"Y2"))
	{
		if(!isStrInt(currentXssValue))
		{
			log_error("%s(%d): must be an integer",filename_rec,line);
			skipXssSection = true;
			return;
		}
		setResourceLocationValue(Treasure_loc, str2Int(currentXssValue) , regionRecNumber, ytwo, 0 ); //save rectangles number "regionRecNumber" Y1
		return;
	}
	
	log_warning("%s(%d): Unrecognized command '%s'",filename_rec,line,currentXssCommand);
}