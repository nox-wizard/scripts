/*we have here a problem, the region numbers are not necessary in order or in line (like we have region 2 and 4 but not 3),
so we need at server start a way to check for small what regions exist and which ones doesn't, the way it would work and 
I use it now is to create a "worldstone" hashmap and store at this at server start which regions exist - problem: how many
regions are allowed max?
hashmap-usage: x is the region, y is the parameter (y=1:region number exist?, y=2: number of region rectangles, ), z is 0, value is param value
*/
const max_Regionnumber = 512;
public regionamount;
public regionpart;
static filename[] = "scripts/regions.xss";

/*now region borders: this is a special problem since it is unknown how many region rectangles per region are defined 
(for example britain consists out of several rectangles). So since hashmap location x is region number and hashmap 
location y=1 is if region is defined, now hashmap location y=2 we define as amount of the number "region" of rectangles from
that region and hashmap location y=3*region is X1 of the rectangles, y=4*region is Y1 of the rectangles, y=5*region is X2 and y=6*region is Y2
y=3,7,11... X1 of region rect: (regionrect*4)-1
y=4,8,12... Y1 of region rect: regionrect*4
y=5,9,13... X2 of region rect: (regionrect*4)+1
y=6,10,14... Y2 of region rect: (regionrect*4)+2
*/
const Worldstone_Region_Layer =0; //z=0 is the layer that stores region values (x1,y1,x2,y2)
const Worldstone_Region_Exists =1; //y=1 stores if region exists
const Worldstone_Region_Parts =2; //y=2 stores the number of region rectangles of the region

const Worldstone_Itemheight_Layer =1; //z=1 is the layer that stores item height values from tiledata
const Worldstone_Itemheight_1st =1; //x=1 stores in y from 0 to 6000 the Item Height from tiledata for add menu at z=1
const Worldstone_Itemheight_2nd =2; //x=2 stores in y from 6001 to 12000 the Item Height from tiledata for add menu at z=1
const Worldstone_Itemheight_3rd =3; //x=2 stores in y from 6001 to 12000 the Item Height from tiledata for add menu at z=1
new worldstone_loc;

public initWorldstone()
{
	regionamount = 0;
	worldstone_loc = createResourceMap( RESOURCEMAP_LOCATION, 1, "worldstone_loc");
	
	for(new i = 0; i < max_Regionnumber; i++)
	{
		new exist = rgn_isValid(i);
		if(exist == 1)
		{
			//amount of regions we have
			regionamount++;
		}
	}
	log_message("Worldstone updated with Regionnumbers^n");
	
	log_message("Loading region borders ...");
	if(xss_scanFile(filename,"scan_regions")==INVALID)
	{
		log_error("Unable to read from %s",filename);
		return;
	}	
	log_message("Region borders stored at Worldstone layer 0^n");
	
	scan_itemheight();
	log_message("Item default heights stored at Worldstone layer 1^n");	
	
}

public scan_itemheight()
{
	new i;
	for(i=0x0; i<=0x1770; i++)
	{
		new height=itm_getHeight(i);
		new itemid = hexChar2Number(i);
		if(height != 1)
			setResourceLocationValue(worldstone_loc, height, Worldstone_Itemheight_1st, itemid, Worldstone_Itemheight_Layer ); //region exists (value of y=id is height)
	}
	for(i=0x1771; i<=0x2EE0; i++)
	{
		new height=itm_getHeight(i);
		new itemid = hexChar2Number(i);
		if(height != 1)
			setResourceLocationValue(worldstone_loc, height, Worldstone_Itemheight_2nd, itemid, Worldstone_Itemheight_Layer ); //region exists (value of y=id is height)
	}
	for(i=0x2EE1; i<=0x4650; i++)
	{
		new height=itm_getHeight(i);
		new itemid = hexChar2Number(i);
		if(height != 1)
			setResourceLocationValue(worldstone_loc, height, Worldstone_Itemheight_3rd, itemid, Worldstone_Itemheight_Layer ); //region exists (value of y=id is height)
	}
}

public scan_regions(file,line)
{
	if(strcmp(currentXssSectionType,"REGION"))
	{
		skipXssSection = true;
		return;
	}
	
	if(currentXssSection >= max_Regionnumber)
	{
		log_warning("%s(%d): there are only %d available regions",filename,line,max_Regionnumber);
		skipXssSection = true;
		return;
	}
	
	//number of region we have at the moment, set to "exists"
	new region = currentXssSection;
	setResourceLocationValue(worldstone_loc, 1, region, Worldstone_Region_Exists, Worldstone_Region_Layer ); //region exists (value of y=1 is 1)
	new regionname[100]
	
	if(!strcmp(currentXssCommand,"NAME"))
	{
		sprintf(regionname, currentXssValue);
		return;
	}
	
	if(!strcmp(currentXssCommand,"X1"))
	{
		regionpart++;
		setResourceLocationValue(worldstone_loc, regionpart, region, Worldstone_Region_Parts, Worldstone_Region_Layer ); //save number of defined rectangles of this region (value of y=2 is number of found regionparts)
		if(!isStrInt(currentXssValue))
		{
			log_error("%s(%d): must be an integer",filename,line);
			skipXssSection = true;
			return;
		}
		setResourceLocationValue(worldstone_loc,  str2Int(currentXssValue) , region, (regionpart*4)-1, Worldstone_Region_Layer); //save rectangle/regionpart X1
		return;
	}
	
	if(!strcmp(currentXssCommand,"Y1"))
	{
		if(!isStrInt(currentXssValue))
		{
			log_error("%s(%d): must be an integer",filename,line);
			skipXssSection = true;
			return;
		}
		setResourceLocationValue(worldstone_loc,  str2Int(currentXssValue) , region, (regionpart*4), Worldstone_Region_Layer); //save rectangle/regionpart Y1
		return;
	}
	
	if(!strcmp(currentXssCommand,"X2"))
	{
		if(!isStrInt(currentXssValue))
		{
			log_error("%s(%d): must be an integer",filename,line);
			skipXssSection = true;
			return;
		}
		setResourceLocationValue(worldstone_loc,  str2Int(currentXssValue), region, (regionpart*4)+1, Worldstone_Region_Layer); //save rectangle/regionpart X2
		return;
	}
	
	if(!strcmp(currentXssCommand,"Y2"))
	{
		if(!isStrInt(currentXssValue))
		{
			log_error("%s(%d): must be an integer",filename,line);
			skipXssSection = true;
			return;
		}
		setResourceLocationValue(worldstone_loc,  str2Int(currentXssValue) , region, (regionpart*4)+2, Worldstone_Region_Layer); //save rectangle/regionpart Y2
		return;
	}
	//log_warning("%s(%d): Unrecognized command '%s'",filename,line,currentXssCommand);
}