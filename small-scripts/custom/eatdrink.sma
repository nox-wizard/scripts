public _ondrinkBottle(const itm, const chr)
{
	bypass();
	new leftover = 105327; //empty bottle
	_onEatandDrink(itm, chr, leftover)
}

public _ondrinkGlass(const itm, const chr)
{
	bypass();
	new leftover = 105305; //empty glass
	_onEatandDrink(itm, chr, leftover)
}

public _ondrinkPitcher(const itm, const chr)
{
	bypass();
	new leftover = 105324; //empty Pitcher
	_onEatandDrink(itm, chr, leftover)
}

public _ondrinkJug(const itm, const chr)
{
	bypass();
	new leftover = 105328; //empty Jug
	_onEatandDrink(itm, chr, leftover)
}

public _ondrinkMug(const itm, const chr)
{
	bypass();
	new leftover = 105322; //empty Mug
	_onEatandDrink(itm, chr, leftover)
}

public _ondrinkGoblet(const itm, const chr)
{
	bypass();
	new leftover = 105301; //empty Goblet
	_onEatandDrink(itm, chr, leftover)
}

public _oneatPlate(const itm, const chr)
{
	bypass();
	new leftover = 105204; //empty Plate
	_onEatandDrink(itm, chr, leftover)
}

public _oneatBowl(const itm, const chr)
{
	bypass();
	new itemscript = itm_getProperty(itm, IP_SCRIPTID);
	new leftover =0;
	switch(itemscript)
   	{
   		case 104200..104204: leftover = 105106;
   		case 104206..104209: leftover = 105108;
   		case 104205: leftover = 105109;
   	}
	_onEatandDrink(itm, chr, leftover)
}

public _oneatBasket(const itm, const chr)
{
	bypass();
	new leftover = 105001; //empty basket
	_onEatandDrink(itm, chr, leftover)
}

public _oneatleft(const itm, const chr)
{
	bypass();
	new leftover = -1; //empty basket
	_onEatandDrink(itm, chr, leftover)
}


public _onEatandDrink(const itm, const chr, const leftover)
{
	new backpack = chr_getBackpack(chr, true);
	new container = itm_getProperty(itm, IP_CONTAINERSERIAL);
	new itype = itm_getProperty(itm, IP_TYPE);
	//printf("itype: %d", itype);
	
	new itmx,itmy,itmz;
	itm_getPosition(itm,itmx,itmy,itmz); 
	
	new itmname[30]; 
	itm_getProperty(itm, IP_STR_NAME, 0, itmname); 
	
	switch(itype)
   	{
   		case 105: //drink
   		{
			new drinkvalue = itm_getLocalIntVar(itm, 1003);
			new olddrink = chr_getLocalIntVar(chr, 1003);
			new thirst = (olddrink + drinkvalue);
			if (thirst > 100)
	         	{
			        chr_message( chr, _, msg_EatDrinkDef[24]);
			        bypass();
			        exit;
	         	}
	         	
			itm_reduceAmount(itm, 1);
			
	   		chr_sound (chr, 49);//slurp
	   		chr_action (chr, 34);//eating movement
	   		
	   		new emote[50];
	   		sprintf(emote, "*drinks %s *", itmname);
	   		chr_emoteAll(chr, emote);
	   		
	   		if(leftover != -1)
	   			if(container == backpack)
		         	{
		         		new left = itm_createInBp(leftover, chr);
		         		itm_moveTo(left, itmx, itmy, itmz);
		         	}
		    		else
		         	{
		         		new left = itm_create(leftover);
		         		itm_moveTo(left, itmx, itmy, itmz);
		         	}
		         	
	    		chr_setLocalIntVar(chr, 1003, thirst);
	    	}
	
		case 14: //food
   		{
   			new eatvalue = itm_getLocalIntVar(itm, 1003);
   			new oldeat = chr_getLocalIntVar(chr, 1003);
   			new hunger = (oldeat + eatvalue);
			//   printf("hunger: %d", hunger);
   			if (hunger > 100)
        		{
        			chr_message( chr, _, msg_EatDrinkDef[25]);
        			bypass();
        			exit;
        		}
        		
   			itm_reduceAmount(itm, 1);
   			
   			chr_sound (chr, 59);//chew
   			chr_action (chr, 34);//eating movement
   			
   			new emote[50];
   			sprintf(emote, "*eats %s *", itmname);
   			chr_emoteAll(chr, emote);
   			
   			if((leftover != -1))
   				if(container == backpack)
	        		{
	        			new left = itm_createInBp(leftover, chr);
	        			itm_moveTo(left, itmx, itmy, itmz);
	        		}
	   			else
	        		{
	        			new left = itm_create(leftover);
	        			itm_moveTo(left, itmx, itmy, itmz);
	        		}
	        		
   			chr_setLocalIntVar(chr, 1002, hunger);
   		}
   		
   		default:
   		{
   			chr_message( chr, _, "An error was logged, please keep this item. A GM will contact you soon because of it.");
   			new chrname[30];
   			chr_getProperty(chr, CP_STR_NAME, 0, chrname);
   			log_error("onEatandDrink was called by an item without IType-Definition, item was %d used by %s^n", itm, chrname);
   		}
   	}
}

// Hungersystem starts here
const Delay_HungerThirst = 180;

public hungerandthirst(const c)
{
	if( (tempfx_isActive( c, _, funcidx("hungertimer")) == 1) && (chr_getProperty(c,CP_PRIVLEVEL) < PRIV_CNS) )
		return;
	else if ( (tempfx_isActive( c, _, funcidx("hungertimer")) == 1) && (chr_getProperty(c,CP_PRIVLEVEL) >= PRIV_CNS) )
	{
		tempfx_delete( c, _, false, funcidx("hungertimer"));
		return;
	}
	if(chr_getProperty(c,CP_PRIVLEVEL) < PRIV_CNS)
		tempfx_activate(_, c, c, 500, Delay_HungerThirst,funcidx("hungertimer"));
}

public hungertimer(const source, const dest, const power, const mode)
{
	if(mode != TFXM_END) return;
	//printf("power: %d",power);
	new c = source;

    	new hunger = chr_getLocalIntVar(c, 1002);//Hunger
    	new newhunger = hunger - 3;
    
    	if(newhunger < 0)
    		newhunger = 0;
    
    	chr_setLocalIntVar(c, 1002, newhunger); //new Hunger
    
    	switch(newhunger)
        {
	        case 0..1: chr_message( c, _, msg_EatDrinkDef[0]);
	        case 2..11: chr_message( c, _, msg_EatDrinkDef[1]);
	        case 12..21: chr_message( c, _, msg_EatDrinkDef[2]);
	        case 22..31: chr_message( c, _, msg_EatDrinkDef[3]);
	        case 32..41: chr_message( c, _, msg_EatDrinkDef[4]);
	        case 42..51: chr_message( c, _, msg_EatDrinkDef[5]);
	        case 52..61: chr_message( c, _, msg_EatDrinkDef[6]);
	        case 62..71: chr_message( c, _, msg_EatDrinkDef[7]);
	        case 72..81: chr_message( c, _, msg_EatDrinkDef[8]);
	        case 82..91: chr_message( c, _, msg_EatDrinkDef[9]);
	        case 92..100: chr_message( c, _, msg_EatDrinkDef[10]);
	        default: chr_message( c, _, msg_EatDrinkDef[11]);
        }
        
    	new thirst = chr_getLocalIntVar(c, 1003);//thirst value
    	new newthirst = thirst - 3;
    
    	if(newthirst < 0)
    		newthirst = 0;
    		
    	chr_setLocalIntVar(c, 1003, newthirst); //new thirst value
    
    	switch(newthirst)
      	{
	      case 0..1: chr_message( c, _, msg_EatDrinkDef[12]);
	      case 2..11: chr_message( c, _, msg_EatDrinkDef[13]);
	      case 12..21: chr_message( c, _, msg_EatDrinkDef[14]);
	      case 22..31: chr_message( c, _, msg_EatDrinkDef[15]);
	      case 32..41: chr_message( c, _, msg_EatDrinkDef[16]);
	      case 42..51: chr_message( c, _, msg_EatDrinkDef[17]);
	      case 52..61: chr_message( c, _, msg_EatDrinkDef[18]);
	      case 62..71: chr_message( c, _, msg_EatDrinkDef[19]);
	      case 72..81: chr_message( c, _, msg_EatDrinkDef[20]);
	      case 82..91: chr_message( c, _, msg_EatDrinkDef[21]);
	      case 92..100: chr_message( c, _, msg_EatDrinkDef[22]);
	      default: chr_message( c, _, msg_EatDrinkDef[23]);
      	}
      	
	tempfx_activate(_, c, c, 0, Delay_HungerThirst,funcidx("hungertimer"));
}