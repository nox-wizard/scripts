const freeze_animal = 1009; // global Var für Pfosten
const DIR_UNDEF = -1; 

/*Ab hier beliebig einstellbare Ingamemeldungen*/
const NUM_freezeSENTENCE = 8;
static msg_freezeDef[NUM_freezeSENTENCE][]={
"Ihr seid zu weit davon entfernt.", 
"Welches Tier wollt Ihr daran anbinden?", 
"*bindet es an den Pfosten an*",
"Ihr koennt nur ein Euch gehörende Tiere anbinden!",
"Ihr koennt keine anderen Personen anbinden!",
"An diesen Pfosten ist bereits ein Tier angebunden.",
"Das Tier an diesem Pfosten gehört Euch nicht.",
"Das Tier ist zuweit vom Pfosten weg."
};

public _freezing(const itm, const chr)
{
bypass();
new itmx = itm_getProperty(itm, IP_POSITION, IP2_X); // Ausgabe der
new itmy = itm_getProperty(itm, IP_POSITION, IP2_Y); // Char und der Item Position
new chrx = chr_getProperty(chr, CP_POSITION, CP2_X); // um den Abstand bestimmen 
new chry = chr_getProperty(chr, CP_POSITION, CP2_Y); // zu koennen
new x = itmx - chrx;
new y = itmy - chry;
//chr_message( chr, _, " x = %d y = %d", x, y);
if ((x > 2)||(x < -2)||(y > 2)||(y < -2)) // Entfernung zum Pfosten
    {
    chr_message( chr, _, "%s", msg_freezeDef[0]);
    return;
    }
//printf("item: %d, char: %d ^n", itm, chr);
chr_setLocalIntVar(chr, 1007, itm); //Pfostenserial auf Char speichern
chr_message( chr, _, "%s", msg_freezeDef[1]);
target_create( chr, _, _, _, "freezezwei" );
}

public freezezwei(const target, const chr, const itm) //target is pet, itm is id
{
new pfosten = chr_getLocalIntVar(chr, 1007); //Pfostenserial ermitteln
new petid = chr_getProperty(target, CP_ID);
new PfostenX = itm_getProperty(pfosten, IP_POSITION, IP2_X);
new PfostenY = itm_getProperty(pfosten, IP_POSITION, IP2_Y);
new PetX = chr_getProperty(target, CP_POSITION, CP2_X);
new PetY = chr_getProperty(target, CP_POSITION, CP2_Y);
new richtung = -1;
new DeltaX = PfostenX - PetX;
new DeltaY = PfostenY - PetY;
//printf("DeltaX: %d, DeltaY: %d", DeltaX, DeltaY);
if((DeltaY > 2) || (DeltaY < (-2)) || (DeltaX > 2) || (DeltaX < (-2)))
{
	 chr_message( chr, _, "%s", msg_freezeDef[7]);
	 return
}
else
{
	if( chr_getProperty(target, CP_NPC, _) == 1 && ((petid != 0x0190) || (petid != 0x0191) )) //ist NPC, no vendor/human char)
	{
		new owner = chr_getProperty(target, CP_OWNSERIAL);
		//printf("owner: %d, char: %d, item: %d", owner, chr, post);
		if( owner == chr)
		{
			new animal = itm_getLocalIntVar(pfosten, freeze_animal);
			if( animal == 0) //not already animal bind to
			{
				chr_setProperty(target,CP_PRIV2,_,2); //freeze
				if(PetX < 0 || PetY < 0 || PfostenX < 0 || PfostenY < 0) richtung = DIR_UNDEF; //one coordinates is wrong
				else if(PetX == PfostenX && PetY == PfostenY) richtung = DIR_UNDEF; //Same position ? No direction ! 
				else if(DeltaY < 0) //north half 
				{
					if(DeltaX > 0) //north east quater 
					{
						if(((-DeltaY)/DeltaX)>=2) richtung = DIR_NORTH;
						else if( (DeltaX/(-DeltaY))>=2) richtung = DIR_EAST;
						else richtung = DIR_NORTHEAST;
					}
					else if(DeltaX < 0) //north west quater
					{
						if( (DeltaY/DeltaX)>=2) richtung = DIR_NORTH;
						else if( (DeltaX/DeltaY)>=2) richtung = DIR_WEST;
						else richtung = DIR_NORTHWEST;
					}
					else richtung = DIR_NORTH; //same X : full north
				}
				else if(DeltaY > 0) //south half
				{
					if(DeltaX > 0) //south east quater 
					{
						if( (DeltaY/DeltaX)>=2) richtung = DIR_SOUTH;
						else if( (DeltaX/DeltaY)>=2) richtung = DIR_EAST;
						else richtung = DIR_SOUTHEAST;
					}
					else if(DeltaX < 0) //south west quater
					{
						if( (DeltaY/(-DeltaX))>=2) richtung = DIR_SOUTH;
						else if( ((-DeltaX)/DeltaY)>=2) richtung = DIR_WEST;
						else richtung = DIR_SOUTHWEST;
					}
					else richtung = DIR_SOUTH; //same X : full south
				}
				else //same Y : full east or west
				{
					if (DeltaX > 0) richtung = DIR_EAST;
					else richtung = DIR_WEST;
				} 
				chr_setProperty(target, CP_DIR, _, richtung); //turn to pfosten
				chr_teleport(target);
				
				chr_speech(chr, INVALID, SPEECH_EMOTE, _, _, ("%s", msg_freezeDef[2])); //emote
				itm_setLocalIntVar(pfosten, freeze_animal, target); //animal serial store at post
				itm_delEventHandler(pfosten, EVENT_ITM_ONDBLCLICK);
				itm_setEventHandler(pfosten, EVENT_ITM_ONDBLCLICK, EVENTTYPE_STATIC, "_unfreezing"); //change doubleclick event
			}
			else chr_message( chr, _, "%s", msg_freezeDef[5]);
		}
		else chr_message( chr, _, "%s", msg_freezeDef[3]);
	}
	else chr_message( chr, _, "%s", msg_freezeDef[4]);
}
}

public _unfreezing(const itm, const chr)
{
bypass();
new animal = itm_getLocalIntVar(itm, freeze_animal);
new owner = chr_getProperty(animal, CP_OWNSERIAL);
if( owner == chr)
{
	chr_setProperty(animal,CP_PRIV2,_,0); //unfreeze
	itm_setLocalIntVar(itm, freeze_animal, 0);
	itm_delEventHandler(itm, EVENT_ITM_ONDBLCLICK);
	itm_setEventHandler(itm, EVENT_ITM_ONDBLCLICK, EVENTTYPE_STATIC, "_freezing");
}
else chr_message( chr, _, "%s", msg_freezeDef[6]);
}