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
			        chr_message( chr, _, "You are not able to drink one more drop.");
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
        			chr_message( chr, _, "You are not able to eat one more piece.");
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
	if(chr_getProperty(c,CP_PRIVLEVEL) >= PRIV_CNS)
		tempfx_activate(_, c, c, 0, Delay_HungerThirst,funcidx("hungertimer"));
}

public hungertimer(const source, const dest, const power, const mode)
{
	if(mode != TFXM_END) return;
	
	new c = source;

    	new hunger = chr_getLocalIntVar(c, 1002);//Hunger
    	new newhunger = hunger - 3;
    
    	if(newhunger < 0)
    		newhunger = 0;
    
    	chr_setLocalIntVar(c, 1002, newhunger); //new Hunger
    
    	switch(newhunger)
        {
	        case 0..1: chr_message( c, _, "You must eat something immediatelly or you will die in 1 minute!");
	        case 2..11: chr_message( c, _, "You must eat something very very fast or you will die from hunger!");
	        case 12..21: chr_message( c, _, "You are extremly hungry!");
	        case 22..31: chr_message( c, _, "You are very hungry and start feeling dizzy!");
	        case 32..41: chr_message( c, _, "You are really hungry and your stomache growls loudly!");
	        case 42..51: chr_message( c, _, "You stomach starts growling by hunger!");
	        case 52..61: chr_message( c, _, "You are bit hungry.");
	        case 62..71: chr_message( c, _, "You could have something to eat.");
	        case 72..81: chr_message( c, _, "You feel satisfied.");
	        case 82..91: chr_message( c, _, "You are well fed.");
	        case 92..100: chr_message( c, _, "You are absolutly stuffed.");
	        default: chr_message( c, _, "You die from starving too long!");
        }
        
    	new thirst = chr_getLocalIntVar(c, 1003);//thirst value
    	new newthirst = thirst - 3;
    
    	if(newthirst < 0)
    		newthirst = 0;
    		
    	chr_setLocalIntVar(c, 1003, newthirst); //new thirst value
    
    	switch(newthirst)
      	{
	      case 0..1: chr_message( c, _, "And you must drink something immediatelly or you will die in 1 minute!^n");
	      case 2..11: chr_message( c, _, "And you must drink something very very fast or you will die from thirst!^n");
	      case 12..21: chr_message( c, _, "And you are extremly thirsty!^n");
	      case 22..31: chr_message( c, _, "And you are very thirsty and start feeling dizzy!^n");
	      case 32..41: chr_message( c, _, "And you are really hungry and your tongue sticks in your mouth!^n");
	      case 42..51: chr_message( c, _, "And your tongue starts becoming sticky by thirst!^n");
	      case 52..61: chr_message( c, _, "And you are bit thirsty.^n");
	      case 62..71: chr_message( c, _, "And you could have something to drink.^n");
	      case 72..81: chr_message( c, _, "And you don't need to drink anything.^n");
	      case 82..91: chr_message( c, _, "And you feel absolutely no thirst.^n");
	      case 92..100: chr_message( c, _, "And your belly is filled with liquid.^n");
	      default: chr_message( c, _, "And you die from being thirsty too long!^n");
      	}
      	
	tempfx_activate(_, c, c, 0, Delay_HungerThirst,funcidx("hungertimer"));
}