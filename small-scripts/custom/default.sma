// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts (default.sma -> override.amx)                    ||
// || Maintained by Xanathar, Ummon                                       ||
// || Last Update (25-aug-01)                                             ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This file contains NoX-Wizard standard overrides                    ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

/****************************************************************************
 FUNCTION : __get_milk_from_cow
 AUTHOR   : Xanathar
 PURPOSE  : implements milkable cows, through ITEMS $item_jar_for_milk and
            $item_a_jar_full_of_milk
 ****************************************************************************/
public __get_milk_target(const itm, const chr)
{
    bypass();
    chr_message( chr, _, "Choose the cow to milk...");
    target_create( chr, _, _, _, "__get_milk_from_cow" );
}

public __get_milk_from_cow(const cc, const this_is_useless)
{
    //something wrong : goes out and drops trigging
    if (cc<0) return;
    new id = (chr_getProperty(cc, CP_ID, 2)<<8) + chr_getProperty(cc, CP_ID, 1);

    if ((id!=0xD8)&&(id!=0xE7)) {
        chr_message( cc, _, "It's not a cow!!!");
        return;
    }

    new disabledtime = chr_getProperty(cc, CP_DISABLED);
    if (disabledtime!=0) {
        chr_message( cc, _, "It has been milked recently");
        return;
    }

    new jars = chr_countItems(cc, 0x1005);

    if (jars <= 0) {
        chr_message( cc, _, "You have not jars");
        return;
    }

    new bp = itm_contDelAmount(chr_getBackpack(cc), 1, 0x1005);
    new jar = itm_createByDef( "$item_a_jar_full_of_milk" );
    itm_setContSerial( jar, bp );

    chr_setProperty(cc, CP_DISABLED, 0 , getCurrentTime()+60000);
    chr_setProperty(cc, CP_STR_DISABLEDMSG, 0, "It has been milked recently");

}



/****************************************************************************
 FUNCTION : anatomy_target
 AUTHOR   : Xanathar
 PURPOSE  : shows target stamina to GM anatomists
 ****************************************************************************/
public __anatomy_target(const cc)
{
    if (chr_getProperty(cc, CP_SKILL, SK_ANATOMY) < 950) return;

    //we are here so anatomy >= 95%, let's get target stamina and show it!

    new stm = chr_getProperty(cc, CP_DEXTERITY, CP2_STAMINA);
    new dex = chr_getProperty(cc, CP_DEXTERITY, CP2_DEX);

    new prc = stm*100/dex;

    switch(prc/10) {
        case 0:
            chr_message( cc, _, msg_sk_anatomyDef[28], prc);
        case 1:
            chr_message( cc, _, msg_sk_anatomyDef[29], prc);
        case 2:
            chr_message( cc, _, msg_sk_anatomyDef[30], prc);
        case 3:
            chr_message( cc, _, msg_sk_anatomyDef[31], prc);
        case 4:
            chr_message( cc, _, msg_sk_anatomyDef[32], prc);
        case 5:
            chr_message( cc, _, msg_sk_anatomyDef[33], prc);
        case 6:
            chr_message( cc, _, msg_sk_anatomyDef[34], prc);
        case 7:
            chr_message( cc, _, msg_sk_anatomyDef[35], prc);
        case 8:
            chr_message( cc, _, msg_sk_anatomyDef[36], prc);
        case 9:
            chr_message( cc, _, msg_sk_anatomyDef[37], prc);
        case 10:
            chr_message( cc, _, msg_sk_anatomyDef[38], prc);
        default:
            chr_message( cc, _, msg_sk_anatomyDef[39], prc);
        }
}


/****************************************************************************
 FUNCTION : __crystBall
 AUTHOR   : Xanathar (originally coded in C++ by Blackwinds :))
 PURPOSE  : tells a player its reputation
 ****************************************************************************/
public __crystBall (const ball, const cc)
{
    bypass();

    new karma = chr_getProperty(cc, CP_KARMA, 1);
    new fame = chr_getProperty(cc, CP_FAME, 1);
    new kills = chr_getProperty(cc, CP_KILLS, 1);
    new deaths = chr_getProperty(cc, CP_DEATHS, 1);

    chr_message( cc, _, "You have %d karma", karma);
    chr_message( cc, _, "You have %d fame", fame);
    chr_message( cc, _, "You have killed %d persons", kills);
    chr_message( cc, _, "You have died %d times", deaths);

    itm_reduceAmount(ball, 1);
}

/****************************************************************************
 FUNCTION : __nxwBench
 AUTHOR   : Xanathar
 PURPOSE  : part of the start-up benchmark
 ****************************************************************************/
public __nxwBench()
{
    new i;
    for (i = 0; i<10000; i++) getNXWVersion();
}


/****************************************************************************
 FUNCTION : _GetDirOfTarg
 AUTHOR   : Keldan
 PURPOSE  : Give direction of char to target
 ****************************************************************************/
const DIR_UNDEF = -1; 

//return the cardinal direction (Nox direction related constants) of vector between a source and a target 
//parameters : SourceX, SourceY : coordinates of source ; TargX, TargY : coordinates of target 
// 
//if source and target are at same postion, then returns DIR_UNDEF ! 
//if one of coords is bad (<0), then returns DIR_UNDEF ! 
// 
// Copyright © 2002 Keldan 
// http://www.nouvelespoir.com 
// 

public _GetDirOfTarg(const SourceX, const SourceY, const TargX, const TargY) 
{
   new dir;
   new DeltaX;
   new DeltaY;
DeltaX = TargX - SourceX;
DeltaY = TargY - SourceY;
if ( (SourceX < 0) || (SourceY < 0) || (TargX < 0) || (TargY < 0) )//one coordinates is wrong 
{
dir = DIR_UNDEF;
}
else if ((SourceX == TargX) && (SourceY == TargY))//Same position ? No direction ! (© GTA2 if border=0> 
{
dir = DIR_UNDEF;
}
else if (DeltaY < 0)//north half 
{
if(DeltaX > 0)//north east quater 
{
if ( ((-DeltaY)/DeltaX)>=2) 
{
dir = DIR_NORTH;
}
else if ( (DeltaX/(-DeltaY))>=2) 
{
dir = DIR_EAST;
}
else 
{
dir = DIR_NORTHEAST;
}
}
else if (DeltaX < 0) //north west quater 
{
if ( (DeltaY/DeltaX)>=2) 
{
dir = DIR_NORTH;
}
else if ( (DeltaX/DeltaY)>=2) 
{
dir = DIR_WEST;
}
else 
{
dir = DIR_NORTHWEST;
}
}
else//same X : full north 
{
dir = DIR_NORTH;
}
}
else if (DeltaY > 0)//south half 
{
if (DeltaX > 0)//south east quater 
{
if ( (DeltaY/DeltaX)>=2) 
{
dir = DIR_SOUTH;
}
else if ( (DeltaX/DeltaY)>=2) 
{
dir = DIR_EAST;
}
else 
{
dir = DIR_SOUTHEAST;
}
}
else if (DeltaX < 0) //south west quater 
{
if ( (DeltaY/(-DeltaX))>=2) 
{
dir = DIR_SOUTH;
}
else if ( ((-DeltaX)/DeltaY)>=2) 
{
dir = DIR_WEST;
}
else 
{
dir = DIR_SOUTHWEST;
}
}
else//same X : full south 
{
dir = DIR_SOUTH;
}
}
else//same Y : full east or west 
{
if (DeltaX > 0) 
{
dir = DIR_EAST;
}
else 
{
dir = DIR_WEST;
}
}
return dir;
}

/****************************************************************************
 FUNCTION : _GetMapRelation
 AUTHOR   : Horian
 PURPOSE  : Is Char under earth or free in nature or under a roof
 ****************************************************************************/
/*
const Delay_Mapcheck = 300;
const MAP_UNDEF = -1;
// im Dungeon: MAP_Relation = 1, x>5200 && auf Statictile oder z < Map
// in Haus: MAP_Relation = 2, x<5200 && in Multi || ist unter Static
// in Freiheit: MAP_Relation = 3, nicht unter Static und nicht in Multi, auf Maptile oder Statictile

public _GetMapRelation(const c)
{
tempfx_activate(_, c, c, 0, Delay_Mapcheck,funcidx("maptimer"));
}

public maptimer(const source, const dest, const power, const mode)
{
if(mode != TFXM_END || source < 0) return;
new c = source;
new MAP_Relation;

new x = chr_getProperty( c, CP_POSITION, CP2_X );
new y = chr_getProperty( c, CP_POSITION, CP2_Y );
new z = chr_getProperty( c, CP_POSITION, CP2_Z );
new staticid = map_getTileID( x, y, z);
new roof = map_isUnderStatic( x, y, z);
if(x >= 5200 && staticid != -1) //Dungeon, Map-z-check muﬂ noch rein
{
	MAP_Relation = 1;
	tempfx_activate(_, c, c, 0, Delay_Mapcheck,funcidx("maptimer"));
	return;
}
else if(!roof) //draussen, Map-z-Check noch rein
{
	MAP_Relation = 3;
	new mapid = map_getTileID( x, y, z);
	if( mapid == -1) //steht nicht auf static-tile
	{
		new floorid = map_getFloorTileID(x,y);
		printf("You targetted a %d^n", floorid);//ID des maptile auf dem steht
		tempfx_activate(_, c, c, 0, Delay_Mapcheck,funcidx("maptimer"));
		return;
	}
	else
	{
		printf("You targetted a %d^n", mapid);//ID des static tiles
		tempfx_activate(_, c, c, 0, Delay_Mapcheck,funcidx("maptimer"));
		return;
	}
}
else if( x<5200 && roof == 1) //in Haus oder unter Baum, Multicheck muﬂ noch rein, Map-z-Check muﬂ noch rein
{
	MAP_Relation = 2;
	tempfx_activate(_, c, c, 0, Delay_Mapcheck,funcidx("maptimer"));
	return;
}
else tempfx_activate(_, c, c, 0, Delay_Mapcheck,funcidx("maptimer"));
}
*/

#define localvar_TARGETACTUATOR 5000
// Programmed by Straylight of the freeshard Anacron
// [URL]www.anacron.net[/URL]
public isInBackpack(const itm, const chr)
{
	new serial = itm_getProperty(itm, IP_CONTAINERSERIAL); //containerserial of item
	if (!serial) //is not in container
		return 0;
	if ( chr_getBackpack(chr) == serial) //containerserial = backpackserial
		return 1;
	return isInBackpack(serial, chr);
}

public isInBank(const itm, const chr)
{
	new serial = itm_getProperty(itm, IP_CONTAINERSERIAL);
	if (!serial)
		return 0;
	if ( chr_getBankBox( chr, BANKBOX_BANK ) == serial)
		return 1;
	return isInBackpack(serial, chr);
}

public saveTargetActuator(cc, serial)
{
	if ( chr_isaLocalVar( cc, localvar_TARGETACTUATOR ))
	{
		chr_delLocalVar(cc, localvar_TARGETACTUATOR);
	}
	chr_addLocalIntVar( cc, localvar_TARGETACTUATOR, serial );
}

public delTargetActuator(cc)
{
	if ( chr_isaLocalVar( cc, localvar_TARGETACTUATOR ))
	{
		chr_delLocalVar(cc, localvar_TARGETACTUATOR);
	}
}

public getTargetActuator(cc)
{
	if ( chr_isaLocalVar( cc, localvar_TARGETACTUATOR ))
	{
		return chr_getLocalIntVar(cc, localvar_TARGETACTUATOR);
	}
	return -1;
}

public cal_getDaysOfYear(const year)  
{ 
     if ( year % 400 == 0)  
          return 366; 
     if ( year % 100 == 0)  
          return 365; 
     if ( year % 4 == 0)  
          return 366; 
     return 365; 
} 
  
public cal_isLeapYear(const year)  
{ 
     if ( year % 400 == 0)  
          return 1; 
     if ( year % 100 == 0)  
          return 0; 
     if ( year % 4 == 0)  
          return 1; 
     return 0; 
} 
  
public cal_getDayInYear(const daysSince1970)  
{ 
     new left = daysSince1970; 
     new currYear=1970; 
     while ( left > 365 )  
     { 
          left=left - cal_getDaysOfYear(currYear); 
          currYear++; 
     } 
     return left; 
} 
  
public cal_getRealYear(const daysSince1970)  
{ 
     new left = daysSince1970; 
     new currYear=1970; 
     while ( left > 365  )  
     { 
          left=left - cal_getDaysOfYear(currYear); 
          currYear++; 
     } 
     return currYear; 
}

public cal_getRealMonth(daysInYear, const year)  
{ 
     static daysInMonth[13]={0, 31,28,31,30,31,30,31,31,30,31,30,31}; 
     new month=1; 
     if ( daysInYear > 366 )  
          return INVALID; 
     if ( daysInYear > 365 && !cal_isLeapYear(year))  
          return INVALID; 
     while ( daysInYear > daysInMonth[month] )  
     { 
          if ( month == 1 && cal_isLeapYear(year))  
               daysInYear--; 
          daysInYear -= daysInMonth[month]; 
          month++; 
     } 
     return month; 
} 
  
public cal_getDayInMonth(daysInYear, const year)  
{ 
     static daysInMonth[13]={0, 31,28,31,30,31,30,31,31,30,31,30,31}; 
     new month=1; 
     if ( daysInYear > 366 )  
          return INVALID; 
     if ( daysInYear > 365 && !cal_isLeapYear(year))  
          return INVALID; 
     while ( daysInYear > daysInMonth[month] )  
     { 
          if ( month == 1 && cal_isLeapYear(year))  
               daysInYear--; 
          daysInYear -= daysInMonth[month]; 
          month++; 
     } 
     return daysInYear; 
} 
  
public chr_countItemsByDef(const chr, const resource, const color)  
{ 
     new itemsInBackpack = set_create(); 
     set_addItemsInCont(itemsInBackpack, chr_getBackpack(chr), false, true); 
     new amount=0; 
     for ( set_rewind(itemsInBackpack);! set_end(itemsInBackpack);)  
     { 
          new item = set_get(itemsInBackpack); 
          if ( itm_getProperty(item, IP_SCRIPTID) == resource )  
               if ( color >= 0 )  
               { 
                    if ( itm_getProperty(item, IP_COLOR) == color )  
                         amount += itm_getProperty(item, IP_AMOUNT); 
               } 
               else  
                    amount += itm_getProperty(item, IP_AMOUNT); 
     } 
     return amount; 
  
}