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

public _cookingtwo(const target, const chr, const obj, const x, const y, const z, const mapcheck)
{
    new i = chr_getLocalIntVar(chr, 1002);
    new itemid=itm_getProperty(i, IP_ID);
    new itemscript = itm_getProperty(i, IP_SCRIPTID);
    
    if(!mapcheck)//click on maptile
        {
        new floorid = map_getFloorTileID(x,y);
        //printf("Targetfloor is %d", floorid);
        //printf("x is %d", x);
        //printf("y is %d", y);
        if(itemscript == 105106)
            {
            //_farming3(chr, i, itemscript, floorid, 0);
            }
        else 
            {
            chr_message( chr, _, msg_sk_cookDef[2]);
            return;
            }
        }
    else if(isChar(target))//click on char
        {
        chr_message( chr, _, msg_sk_cookDef[2]); 
        return;
        }
    else if(isItem(target) && (itemscript == 105106))//click on item
         {
         new mapname = 0;
         //_farming3(chr, i, itemscript, mapname, target);
         }
    else if(isItem(target) && (itemscript != 105106))//click on item
    {
    new targetid = obj;
    new targetscript = itm_getProperty(target, IP_SCRIPTID);
    //printf("itemID: %d ", itemid);
    //printf("targetID: %d ", targetid);
    //printf("iScriptID: %d ", itemscript);
    //printf("tScriptID: %d ", targetscript);
    
    switch(itemscript)
    {
    case 101507: //Wheat sheeve
                  {
                  if((0x1920<=targetid<=0x1937) && (itm_getProperty(i, IP_AMOUNT) >= 4)) //flour mill parts and enough wheat
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
                                     new mapname = 0;
                                      //_farming3(chr, i, itemscript, mapname, target);//go to farming system
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
                              if ((targetid >= 2347 && targetid <= 2412)||(targetid >= 1117 && targetid <= 1166)||(targetid >= 3633 && targetid <= 3635)||(targetid >= 6522 && targetid <= 0x6570)||(targetid==0x19bb)) //heat source  
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
                              else if ((targetid >= 2347 && targetid <= 2412)||(targetid >= 1117 && targetid <= 1166)||(targetid >= 3633 && targetid <= 3635)||(targetid >= 6522 && targetid <= 0x6570)||(targetid==0x19bb)) //heat source  
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
                              if ((targetid >= 2347 && targetid <= 2412)||(targetid >= 1117 && targetid <= 1166)) //oven or fireplace 
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
     case 102141,102160,102524,102540,102542,102901,103005,103009,103011,103019: //uncooked meat or fish
                               {
                               if ((targetid >= 2347 && targetid <= 2412)||(targetid >= 1117 && targetid <= 1166)||(targetid >= 3555 && targetid <= 3561)||(targetid >= 3633 && targetid <= 3635)||(targetid >= 6522 && targetid <= 6570)||(targetid==0x19bb))//heat source               
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