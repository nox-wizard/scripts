/*we have here a problem, the region numbers are not necessary in order or in line (like we have region 2 and 4 but not 3),
so we need at server start a way to check for small what regions exist and which ones doesn't, the way it would work and 
I use it now is to create a "worldstone" hashmap and store at this at server start which regions exist - problem: how many
regions are allowed max?
hashmap-usage: x is the region, y is the parameter, z is 0, value is param value
*/
const max_Regionnumber = 512;
public regionamount;
public regionpart;
static filename[] = "scripts/regions.xss";

/*now region borders: this is a special problem since it is unknown how many region rectangles per region are defined 
(for example britain consists out of several rectangles). So since hashmap location x is region number and hashmap 
location y=1 is if region is defined, now hashmap location y=2 we define as amount of the number "region" of rectangles from
that region and hashmap location y=3*region is X1 of the rectangles, y=4*region is Y1 of the rectangles, y=5*region is X2 and y=6*region is Y2
y=3 X1 (region*4)-1
y=4 Y1 region*4
y=5 X2 (region*4)+1
y=6 Y2 (region*4)+2
*/
const Worldstone_Region_Parts =1; //param1 stores the number of region rectangles of the region

public initWorldstone()
{
	regionamount = 0;
	for(new i = 0; i < max_Regionnumber; i++)
	{
		new exist = rgn_isValid(i);
		if(exist == 1)
		{
			//amount of regions we have
			regionamount++;
		}
	}
	log_message("Worldstone updated with Regionnumbers");
	
	log_message("Loading region borders ...");
	if(xss_scanFile(filename,"scan_regions")==INVALID)
	{
		log_error("Unable to read from %s",filename);
		return;
	}	
	log_message("Region borders loaded^region");
}

public scan_regions(file,line)
{
	new worldstone_loc = createResourceMap( RESOURCEMAP_LOCATION, 1, "worldstone_loc");
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
	
	//number of region we have at the moment
	new region = currentXssSection;
	new regionname[100]
	
	if(!strcmp(currentXssCommand,"NAME"))
	{
		sprintf(regionname, currentXssValue);
		return;
	}
	
	if(!strcmp(currentXssCommand,"X1"))
	{
		regionpart++;
		setResourceLocationValue(worldstone_loc, regionpart, region, Worldstone_Region_Parts, 0 ); //save number of defined rectangles of this region
		if(!isStrInt(currentXssValue))
		{
			log_error("%s(%d): must be an integer",filename,line);
			skipXssSection = true;
			return;
		}
		setResourceLocationValue(worldstone_loc,  str2Int(currentXssValue) , region, (region*4)-1, 0); //save rectangle/regionpart X1
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
		setResourceLocationValue(worldstone_loc,  str2Int(currentXssValue) , region, (region*4), 0 ); //save rectangle/regionpart Y1
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
		setResourceLocationValue(worldstone_loc,  str2Int(currentXssValue), region, (region*4)+1, 0 ); //save rectangle/regionpart X2
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
		setResourceLocationValue(worldstone_loc,  str2Int(currentXssValue) , region, (region*4)+2, 0 ); //save rectangle/regionpart Y2
		return;
	}
	//log_warning("%s(%d): Unrecognized command '%s'",filename,line,currentXssCommand);
}