public _cooking(const i, const chr)
{    
    bypass();
    new backpack = chr_getBackpack( chr);
      if ((itm_getProperty(i, IP_CONTAINERSERIAL)) != (itm_getProperty(backpack,IP_SERIAL)))
      {
      chr_message( chr, _,msg_sk_cookDef[0]);
      return;
      }
    chr_delLocalVar(chr, 1002, VAR_TYPE_INTEGER);
    chr_addLocalIntVar(chr, 1002, 0);
    chr_setLocalIntVar(chr, 1002, i); //selected Item is stored on char
    chr_message( chr, _, msg_sk_cookDef[1]);
    target_create( chr, _, _, _, "_cookingtwo" );
}

public _cookingtwo(const t, const chr, const target, const x, const y, const z, const model, const param1)
{
	new i = chr_getLocalIntVar(chr, 1002);
	new itemscript = itm_getProperty(i, IP_SCRIPTID);

	if(target == -1)//click on maptile
	{
		new floorid = map_getFloorTileID(x,y);
		//printf("Targetfloor is %d^n", floorid);
		//printf("x is %d", x);
		//printf("y is %d", y);
		if((itemscript == 105106) && ((12788<=floorid<=12795) || (113<=floorid<=120)) ) //target first dirt patch and than pewter bowl
		{
			plantcrossing1(chr, i, 0);
		}
		else 
		{
			chr_message( chr, _, "You need to find a place with dirt showing at the surface.");
			return;
		}
        }
        else if(isChar(target))//click on char
        {
        	chr_message( chr, _, msg_sk_cookDef[2]); 
        	return;
        }
        else if(isItem(target) && (itemscript == 105106))//target first fertile dirt patch and than pewter bowl
        {
        	itemscript = itm_getProperty(target, IP_SCRIPTID); //now call target scriptid
        	new amount = itm_getProperty(target, IP_AMOUNT);
        	if(itemscript == 435)
        	{
        		if(amount < 40)
        		{
        			plantcrossing1(chr, i, target);
        		}
        		else
        		{
        			chr_message( chr, _, "You need a stack of 40 pieces to fill the bowl.");
        			return;
        		}
        	}
        	else
        	{
        		chr_message( chr, _, "You need to fill the bowl with fertile dirt.");
        		return;
        	}
        }
        else if(isItem(target) && (itemscript != 105106))//click on item
        {
        	new targetscript = itm_getProperty(target, IP_SCRIPTID);
        	//printf("model: %d ", model);
        	//printf("iScriptID: %d ", itemscript);
        	//printf("tScriptID: %d ", targetscript);
        	
        	switch(itemscript)
        	{
        		case 101507: //Wheat sheeve
        		{
        			if((0x1920<=model<=0x1937) && (itm_getProperty(i, IP_AMOUNT) >= 4)) //flour mill parts and enough wheat
        			{
        				itm_reduceAmount(i, 4);
        				itm_refresh(i);
        				itm_createInBp( (itemscript + 1), chr );
        			}
        			else chr_message( chr, _, msg_sk_cookDef[3]);
        		}
        		case 100093..100096: //pitcher with water
        		{
        			if(101508<=targetscript<=101512) //sack or bowl of flour
        			{
        				add_and_del_both(chr, 105324, 101513, i, target); //empty pitcher, dough
        			}
        			else if(105305<=targetscript<=105309) //empty glass
        			{
        				add_and_del_both(chr, 105324, 100097, i, target);//empty pitcher, glass with water
        			}
        			else if(121072<=targetscript<=121073) //bowl with soil
        			{
        				plantcrossing2(chr, i, target);//go to farming system
                                }
          			else chr_message( chr, _, msg_sk_cookDef[4]);
        		}
        		case 101508..101512: //sack or bowl of flour
        		{
        			if(100093<=targetscript<=100096) //pitcher with water
        			{
        				add_and_del_both(chr, 105324, 101513, i, target); //empty pitcher, dough
        			}
        			if(targetscript==101514) //sweet dough
        			{
        				add_and_del_both(chr, 105324, 101524, i, target);//empty pitcher, cake mix
        			}
        			else chr_message( chr, _, msg_sk_cookDef[4]);
        		}
        		case 101513: //dough
        		{
        			if ((model >= 2347 && model <= 2412)||(model >= 1117 && model <= 1166)||(model >= 3633 && model <= 3635)||(model >= 6522 && model <= 0x6570)||(model==0x19bb)) //heat source  
        			{
        				if(chr_checkSkill(chr, 13, 500, 1000, 1)) //skillcheck
        				{
        					add_and_del(chr, 101505, i); //bread
        				}
        				else
        				{
        					chr_message( chr, _, msg_sk_cookDef[5]);
        					return;
        				}
        			}
        			else if(targetscript == 104046) //apple
        			{
        				add1_and_del2(chr, 101526, i, target);//unbaked apple pie
        			}
        			else if(targetscript == 103006) //cooked fish steak
        			{
        				add1_and_del2(chr, 101530, i, target);//unbaked fish pie
        			}
        			else if((targetscript == 102161) || (targetscript == 102541) || (targetscript == 102543) ||(102702<=targetscript<=102704)) //cooked cut of ribs, cooked bird or ham
        			{
        				add1_and_del2(chr, 101528, i, target);//unbaked meat pie
        			}
        			else if(targetscript == 102901) //eggs
        			{
                                     add_and_del_both(chr, (101532-1), 102903, i, target);//unbaked quiche, eggshells
        			}
        			else if((targetscript == 104049) || (targetscript == 104050)) //peaches
        			{
        				add1_and_del2(chr, 101534, i, target);//unbaked peach cobbler
        			}
        			else if((targetscript == 104043) || (targetscript == 104044)) //pear
        			{
        				add1_and_del2(chr, 101536, i, target);//unbaked fruit cobbler
        			}
        			else if((targetscript==120452) || (targetscript == 120462)) //pumpkin
        			{
        				add1_and_del2(chr, 101538, i, target);//unbaked pumpkin cobbler
        			}
        			else if(103761 <= targetscript <= 103763) //cheese
        			{
        				add1_and_del2(chr, 101540, i, target);//unbaked cheese pizza
        			} 
        			else if((targetscript == 102700) || (targetscript == 102701)) //sausage
        			{
        				add1_and_del2(chr, 101542, i, target);//unbaked sausage pizza
        			}
        			else if(targetscript == 101516) //honey
        			{
        				add1_and_del2(chr, 101514, i, target);//sweet dough
        			}                   
        			else chr_message( chr, _, msg_sk_cookDef[4]);
        			}
        		case 101514: //sweet dough
        		{
        			if(targetscript == 101516) //honey
        			{
        				add1_and_del2(chr, 101521, i, target);//cookie mix
        			}
        			else if ((model >= 2347 && model <= 2412)||(model >= 1117 && model <= 1166)||(model >= 3633 && model <= 3635)||(model >= 6522 && model <= 0x6570)||(model==0x19bb)) //heat source  
              			{
              				if(chr_checkSkill(chr, 13, 500, 1000, 1)) //skillcheck
              				{
              					add_and_del(chr, (101503-1), i); //muffin
              				}
              				else
              				{
              					chr_message( chr, _, msg_sk_cookDef[5]);
              					return;
              				}
              			}
        			else if(101516 <= targetscript <= 101520) //sack or bowl of flour
        			{
        				add1_and_del2(chr, 101524, i, target);//cake mix
        			}
        			else chr_message( chr, _, msg_sk_cookDef[4]);
        		}                     
        		case 101517..101543: //unbaked dough, pie or pizza
        		{
        			if ((model >= 2347 && model <= 2412)||(model >= 1117 && model <= 1166)) //oven or fireplace 
              			{
                                        if(chr_checkSkill(chr, 13, 500, 1000, 1)) //skillcheck              
           				{
                                        	add_and_del(chr, itemscript, i); //baked stuff
           				}
                  			else
           				{
                                        	chr_message( chr, _, msg_sk_cookDef[5]);
                                        	return;
           				}
        			}
         			else chr_message( chr, _, "You must bake it in an oven.");
         		}
         		case 102141,102160,102524,102540,102901,103005,103009,103011,103019: //uncooked meat or fish
         		{
         			if ((model >= 2347 && model <= 2412)||(model >= 1117 && model <= 1166)||(model >= 3555 && model <= 3561)||(model >= 3633 && model <= 3635)||(model >= 6522 && model <= 6570)||(model==0x19bb))//heat source
         			{
         				if(chr_checkSkill(chr, 13, 500, 1000, 1)) //skillcheck              
         				{
         					add_and_del(chr, itemscript, i); //cooked stuff
         				}
         				else
         				{
         					chr_message( chr, _, msg_sk_cookDef[5]);
         					return;
         				}
         			}
         			else chr_message( chr, _, "You must cook it on a heat source.");
         		}
         		default: chr_message( chr, _, msg_sk_cookDef[4]);
         	}
         }
         else chr_message( chr, _, "Error, please contact a GM!");
}
 
 public add_and_del(const chr, const itemscript, const i)
 {
     itm_reduceAmount(i, 1);
     itm_refresh(i);
     new spawnitem = itm_createInBp( (itemscript + 1), chr );
     new itmname[50]; 
     itm_getProperty(spawnitem, IP_STR_NAME, 0, itmname); 
     chr_message( chr, _, "You've made a %s.", itmname);
 }
 
 public add_and_del_both(const chr, const itemscript, const targetscript, const i, const target)
 {
     itm_reduceAmount(i, 1);
     itm_refresh(i);
     itm_reduceAmount(target, 1);
     itm_refresh(target);
     new spawnitem = itm_createInBp( (itemscript+1), chr);
     itm_createInBp( targetscript, chr);
     new itmname[50]; 
     itm_getProperty(spawnitem, IP_STR_NAME, 0, itmname);
     chr_message( chr, _, "You've made a %s.", itmname);
 }
 
 public add1_and_del2(const chr, const targetscript, const i, const target)
 {
     itm_reduceAmount(i, 1);
     itm_refresh(i);
     itm_reduceAmount(target, 1);
     itm_refresh(target);
     new spawnitem = itm_createInBp( targetscript, chr);
     new itmname[50]; 
     itm_getProperty(spawnitem, IP_STR_NAME, 0, itmname);
     chr_message( chr, _, "Error, please contact a GM!");
     chr_message( chr, _, "You've made a %s.", itmname);
 }