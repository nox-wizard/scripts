/*!
\defgroup script_command_dupe 'dupe
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_dupe(const chr)
\brief duplicates an item

<B>syntax:<B> 'dupe 
<B>command params:</B>
<UL>

</UL>

If area effect is active, all items in area will be cloned.
If no area effect is active, or if you pass "target", a target will appear and only 
the targetted item will be cloned.<br>
Items in the player's backpack are not copied.
*/
public cmd_dupe(const chr)
{
	readCommandParams(chr);



	new area = chr_getCmdArea(chr);
	new item,i = 0;
	//apply command to all items in area if an area is defined
	if(area_isValid(area))
	{

		for(set_rewind(area_items(area)); !set_end(area_items(area)); i++)
		{
			item = set_getItem(area_items(area));
			if(itm_getProperty(item,IP_CONTAINERSERIAL) != chr_getBackpack(chr)) 
			{
				new copy = itm_duplicate(item);

				if(!isItem(copy))
				{
					chr_message(chr,_,"That item can't be duplicated");
					return;
				}
		
				new x,y,z;
				itm_getPosition(item,x,y,z);
				itm_moveTo(copy,x,y,z);
			}
		}

		chr_message(chr,_,"%d items copied",i);
		
		return;
	}

	//if we are here it means we need a target
	chr_message(chr,_,"Select an item to duplicate");
	target_create(chr,0,_,_,"cmd_dupe_targ");
}

/*!
\author Fax
\fn cmd_freeze_targ(target, chr, object, x, y, z, unused, freeze)
\params all standard target callback params
\brief handles single character targetting and freezing
*/
public cmd_dupe_targ(target, chr, object, x, y, z, unused, unused1)
{
	if(!isItem(object))
	{
		chr_message(chr,_,"It must be an item");
		return;
	}

	if(itm_getProperty(object,IP_CONTAINERSERIAL) != INVALID)
	{
		chr_message(chr,_,"Item must not be in a container");
		return;
	}

	new copy = itm_duplicate(object);

	if(!isItem(copy))
	{
		chr_message(chr,_,"That item can't be duplicated");
		return;
	}

	itm_getPosition(object,x,y,z);
	itm_moveTo(copy,x,y,z);
	chr_message(chr,_,"Item %d created at %d %d %d",copy,x,y,z);
}

public itm_copy(const item)
{
	return itm_create(itm_getProperty(item,IP_SCRIPTID));
}

public chr_copy(const chr)
{
	return chr_addNPC(chr_getProperty(chr,CP_SCRIPTID),1,1,0);
}

public itm_duplicate(const item)
{
	new copy = itm_copy(item)

	for(new prop = IP_DOORDIR; prop <= IP_AUXDAMAGETYPE; prop++)
		if(	//These properties must not be copied
			106 <= prop <= 109 ||
			prop == 116 || prop == 119 )
			continue;
		else itm_setProperty(copy,prop,_,itm_getProperty(item,prop));

	for(new prop = IP_ATT; prop <= IP_AMMOFX; prop++)
		if(	//These properties must not be copied
			prop == 210 ||
			prop == IP_SERIAL ||
			prop == IP_AMXFLAGS ||
			prop == IP_TIME_UNUSED ||
			prop == IP_TIME_UNUSEDLAST)
			continue;
		else itm_setProperty(copy,prop,_,itm_getProperty(item,prop));

	for(new prop = IP_AMOUNT; prop < IP_ID; prop++)
		itm_setProperty(copy,prop,_,itm_getProperty(item,prop));

	new string[100];
	for(new prop = IP_STR_CREATOR; prop < IP_STR_NAME2; prop++)
	{
		itm_getProperty(item,prop,0,string);
		itm_setProperty(copy,prop,0,string);
	}

	return copy;
}

public chr_duplicate(const chr)
{
	new subprop;
	new copy = chr_copy(chr);

	//copy properties, only those really needed
	chr_setProperty(copy,CP_CANTRAIN,_,chr_getProperty(chr,CP_CANTRAIN));
	chr_setProperty(copy,CP_TAMED,_,chr_getProperty(chr,CP_TAMED));
	chr_setProperty(copy,CP_SHOPKEEPER,_,chr_getProperty(chr,CP_SHOPKEEPER));
	chr_setProperty(copy,CP_FROZEN,_,chr_getProperty(chr,CP_FROZEN));
	chr_setProperty(copy,CP_DIR,_,chr_getProperty(chr,CP_DIR));
	chr_setProperty(copy,CP_DIR2,_,chr_getProperty(chr,CP_DIR2));
	chr_setProperty(copy,CP_FLAG,_,chr_getProperty(chr,CP_FLAG));
	chr_setProperty(copy,CP_FLY_STEPS,_,chr_getProperty(chr,CP_FLY_STEPS));
	chr_setProperty(copy,CP_HIDDEN,_,chr_getProperty(chr,CP_HIDDEN));
	chr_setProperty(copy,CP_NPCWANDER,_,chr_getProperty(chr,CP_NPCWANDER));
	chr_setProperty(copy,CP_OLDNPCWANDER,_,chr_getProperty(chr,CP_OLDNPCWANDER));
	chr_setProperty(copy,CP_PRIV2,_,chr_getProperty(chr,CP_PRIV2));
	chr_setProperty(copy,CP_REACTIVEARMORED,_,chr_getProperty(chr,CP_REACTIVEARMORED));
	chr_setProperty(copy,CP_REGION,_,chr_getProperty(chr,CP_REGION));
	chr_setProperty(copy,CP_SPEECH,_,chr_getProperty(chr,CP_SPEECH));

	for(subprop = DAMAGE_PURE; subprop < MAX_RESISTANCE_INDEX; subprop++)
		chr_setProperty(copy,CP_RESISTS,subprop,chr_getProperty(chr,CP_RESISTS,subprop));

	chr_setProperty(copy,CP_PRIV,_,chr_getProperty(chr,CP_PRIV));
	chr_setProperty(copy,CP_DAMAGETYPE,_,chr_getProperty(chr,CP_DAMAGETYPE));
	chr_setProperty(copy,CP_ATT,_,chr_getProperty(chr,CP_ATT));
	chr_setProperty(copy,CP_DEF,_,chr_getProperty(chr,CP_DEF));

	for(subprop = CP2_EFF; subprop <= CP2_ACT; subprop++)
		chr_setProperty(copy,CP_DEXTERITY,subprop,chr_getProperty(chr,CP_DEXTERITY,subprop)); 

	chr_setProperty(copy,CP_FAME,_,chr_getProperty(chr,CP_FAME));

	for(subprop = CP2_X; subprop <= CP2_Z; subprop++)
	{
		chr_setProperty(copy,CP_FPOS1_NPCWANDER,subprop,chr_getProperty(chr,CP_FPOS1_NPCWANDER,subprop)); 
		chr_setProperty(copy,CP_FPOS2_NPCWANDER,subprop,chr_getProperty(chr,CP_FPOS2_NPCWANDER,subprop)); 
	}

	chr_setProperty(copy,CP_FTARG,_,chr_getProperty(chr,CP_FTARG));
	chr_setProperty(copy,CP_HIDAMAGE,_,chr_getProperty(chr,CP_HIDAMAGE));
	chr_setProperty(copy,CP_HOLDGOLD,_,chr_getProperty(chr,CP_HOLDGOLD));

	for(subprop = CP2_EFF; subprop <= CP2_ACT; subprop++)
		chr_setProperty(copy,CP_INTELLIGENCE,subprop,chr_getProperty(chr,CP_INTELLIGENCE,subprop)); 

	chr_setProperty(copy,CP_KARMA,_,chr_getProperty(chr,CP_KARMA));
	chr_setProperty(copy,CP_LODAMAGE,_,chr_getProperty(chr,CP_LODAMAGE));
	chr_setProperty(copy,CP_NPCAI,_,chr_getProperty(chr,CP_NPCAI));
	chr_setProperty(copy,CP_OWNSERIAL,_,chr_getProperty(chr,CP_OWNSERIAL));
	chr_setProperty(copy,CP_POISON,_,chr_getProperty(chr,CP_POISON));
	chr_setProperty(copy,CP_REATTACKAT,_,chr_getProperty(chr,CP_REATTACKAT));
	chr_setProperty(copy,CP_REGENRATE,_,chr_getProperty(chr,CP_REGENRATE));
	chr_setProperty(copy,CP_SPLIT,_,chr_getProperty(chr,CP_SPLIT));
	chr_setProperty(copy,CP_SPLITCHNC,_,chr_getProperty(chr,CP_SPLITCHNC));

	for(subprop = CP2_EFF; subprop <= CP2_ACT; subprop++)
		chr_setProperty(copy,CP_STRENGTH,subprop,chr_getProperty(chr,CP_STRENGTH,subprop)); 

	chr_setProperty(copy,CP_TAMING,_,chr_getProperty(chr,CP_TAMING));
	chr_setProperty(copy,CP_BASESKILL,_,chr_getProperty(chr,CP_BASESKILL));

	new string[100];
	for(new prop = CP_STR_DISABLEDMSG; prop < CP_STR_TITLE; prop++)
	{
		chr_getProperty(chr,prop,0,string);
		chr_setProperty(copy,prop,0,string);
	}

	//remove all weared items
	new s = set_create();
	set_addItemWeared(s,copy);
	for(set_rewind(s); !set_end(s);)
		itm_remove(set_getItem(s));

	//duplicate original char's weared items and equip them to new char
	set_delete(s);
	s = set_create();
	set_addItemWeared(s,chr);
	new i;
	for(set_rewind(s); !set_end(s);)
	{
		i = itm_duplicate(set_getItem(s));
		chr_equip(copy,i);
	}

	return copy;
}
/*! }@ */