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
new itmx = itm_getProperty(itm, IP_POSITION, IP2_X); 
new itmy = itm_getProperty(itm, IP_POSITION, IP2_Y); 
new itmz = itm_getProperty(itm, IP_POSITION, IP2_Z); 
new itmname[30]; 
itm_getProperty(itm, IP_STR_NAME, 0, itmname); 
if(itype == 105)
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
   chr_speech(EMOTE, -1, chr, 0,0,emote);
   if((leftover != -1) && (container == backpack))
         {
         new left = itm_createInBp(leftover, chr);
         itm_moveTo(left, itmx, itmy, itmz);
         }
    else if((leftover != -1) && (container != backpack))
         {
         new left = itm_create(leftover);
         itm_moveTo(left, itmx, itmy, itmz);
         }
    chr_setLocalIntVar(chr, 1003, thirst);
    }
else if(itype == 14)
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
   chr_speech(EMOTE, -1, chr,0,0, emote);
   if((leftover != -1) && (container == backpack))
        {
        new left = itm_createInBp(leftover, chr);
        itm_moveTo(left, itmx, itmy, itmz);
        }
   else if((leftover != -1) && (container != backpack))
        {
        new left = itm_create(leftover);
        itm_moveTo(left, itmx, itmy, itmz);
        }
   chr_setLocalIntVar(chr, 1002, hunger);
   }
else
   {
   chr_message( chr, _, "An error was logged, please keep this item. A GM will contact you soon because of it.");
   new chrname[30];
   chr_getProperty(chr, CP_STR_NAME, 0, chrname);
   log_error("onEatandDrink was called by an item without IType-Definition, item was %d used by %s^n", itm, chrname);
   }
}