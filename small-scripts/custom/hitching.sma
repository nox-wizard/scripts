const DIR_UNDEF = -1;
const freeze_animal = 1009;
	
public _freezing(const post, const chr)
{	
	bypass();
	new postx = itm_getProperty(post, IP_POSITION, IP2_X); // Ausgabe der
	new posty = itm_getProperty(post, IP_POSITION, IP2_Y); // Char und der Item Position
	new chrx = chr_getProperty(chr, CP_POSITION, CP2_X); // um den Abstand bestimmen 
	new chry = chr_getProperty(chr, CP_POSITION, CP2_Y); // zu koennen
	new x = postx - chrx;
	new y = posty - chry;
	//chr_message( chr, _, " x = %d y = %d", x, y);
	if ((x > 2)||(x < -2)||(y > 2)||(y < -2)) // distance to post
	{
		chr_message( chr, _, "%s", msg_hitchDef[0]);
		return;
	}
	//printf("item: %d, char: %d ^n", post, chr);
	chr_message( chr, _, "%s", msg_hitchDef[1]);
	target_create( chr, post, _, _, "freezezwei" );
}

public freezezwei(const t, const chr, pet, x, y, z, unused, post) //pet is pet
{
	new petid = chr_getProperty(pet, CP_ID);
	new postX = itm_getProperty(post, IP_POSITION, IP2_X);
	new postY = itm_getProperty(post, IP_POSITION, IP2_Y);
	new PetX = chr_getProperty(pet, CP_POSITION, CP2_X);
	new PetY = chr_getProperty(pet, CP_POSITION, CP2_Y);
	new direction = -1;
	new DeltaX = postX - PetX;
	new DeltaY = postY - PetY;
	//printf("DeltaX: %d, DeltaY: %d", DeltaX, DeltaY);
	if((DeltaY > 2) || (DeltaY < (-2)) || (DeltaX > 2) || (DeltaX < (-2)))
	{
		 chr_message( chr, _, "%s", msg_hitchDef[7]);
		 return
	}
	else
	{
		if( chr_getProperty(pet, CP_NPC, _) == 1 && ((petid != 0x0190) || (petid != 0x0191) )) //is NPC, no vendor/human char)
		{
			new owner = chr_getProperty(pet, CP_OWNSERIAL);
			//printf("owner: %d, char: %d, item: %d", owner, chr, post);
			if( owner == chr)
			{
				new animal = itm_getLocalIntVar(post, freeze_animal);
				if( animal == 0) //not already animal bind to
				{
					chr_setProperty(pet,CP_PRIV2,_,2); //freeze
					if(PetX < 0 || PetY < 0 || postX < 0 || postY < 0) direction = DIR_UNDEF; //one coordinates is wrong
					else if(PetX == postX && PetY == postY) direction = DIR_UNDEF; //Same position ? No direction ! 
					else if(DeltaY < 0) //north half 
					{
						if(DeltaX > 0) //north east quater 
						{
							if(((-DeltaY)/DeltaX)>=2) direction = DIR_NORTH;
							else if( (DeltaX/(-DeltaY))>=2) direction = DIR_EAST;
							else direction = DIR_NORTHEAST;
						}
						else if(DeltaX < 0) //north west quater
						{
							if( (DeltaY/DeltaX)>=2) direction = DIR_NORTH;
							else if( (DeltaX/DeltaY)>=2) direction = DIR_WEST;
							else direction = DIR_NORTHWEST;
						}
						else direction = DIR_NORTH; //same X : full north
					}
					else if(DeltaY > 0) //south half
					{
						if(DeltaX > 0) //south east quater 
						{
							if( (DeltaY/DeltaX)>=2) direction = DIR_SOUTH;
							else if( (DeltaX/DeltaY)>=2) direction = DIR_EAST;
							else direction = DIR_SOUTHEAST;
						}
						else if(DeltaX < 0) //south west quater
						{
							if( (DeltaY/(-DeltaX))>=2) direction = DIR_SOUTH;
							else if( ((-DeltaX)/DeltaY)>=2) direction = DIR_WEST;
							else direction = DIR_SOUTHWEST;
						}
						else direction = DIR_SOUTH; //same X : full south
					}
					else //same Y : full east or west
					{
						if (DeltaX > 0) direction = DIR_EAST;
						else direction = DIR_WEST;
					} 
					chr_setProperty(pet, CP_DIR, _, direction); //turn to post
					chr_teleport(pet);
					
					chr_speech(chr, INVALID, SPEECH_EMOTE, _, _, ("%s", msg_hitchDef[2])); //emote
					itm_setLocalIntVar(post, freeze_animal, pet); //animal serial store at post
					itm_delEventHandler(post, EVENT_ITM_ONDBLCLICK);
					itm_setEventHandler(post, EVENT_ITM_ONDBLCLICK, EVENTTYPE_STATIC, "_unfreezing"); //change doubleclick event
				}
				else chr_message( chr, _, "%s", msg_hitchDef[5]);
			}
			else chr_message( chr, _, "%s", msg_hitchDef[3]);
		}
		else chr_message( chr, _, "%s", msg_hitchDef[4]);
	}
}
	
public _unfreezing(const post, const chr)
{
	bypass();
	new animal = itm_getLocalIntVar(post, freeze_animal);
	new owner = chr_getProperty(animal, CP_OWNSERIAL);
	if( owner == chr)
	{
		chr_setProperty(animal,CP_PRIV2,_,0); //unfreeze
		itm_setLocalIntVar(post, freeze_animal, 0);
		itm_delEventHandler(post, EVENT_ITM_ONDBLCLICK);
		itm_setEventHandler(post, EVENT_ITM_ONDBLCLICK, EVENTTYPE_STATIC, "_freezing");
	}
	else chr_message( chr, _, "%s", msg_hitchDef[6]);
}