new keynumber = 0; //local file swtich to decide the action
//empty ring
public dbl_keyring1(const itm, const chr)
{
	keynumber = 0;	
	chr_message( chr, _, "%s", msg_MiscDef[5]);
	target_create( chr, itm, _, _, "keyring_targ" );
}

//one key
public dbl_keyring2(const itm, const chr)
{	
	keynumber = 1;
	chr_message( chr, _, "%s", msg_MiscDef[5]);
	target_create( chr, itm, _, _, "keyring1_targ" );
}

//several key
public dbl_keyring3(const itm, const chr)
{	
	keynumber = 2;
	chr_message( chr, _, "%s", msg_MiscDef[5]);
	target_create( chr, itm, _, _, "keyring1_targ" );
}

//magic key
public dbl_keyring4(const itm, const chr)
{	
	keynumber = 3;
	chr_message( chr, _, "%s", msg_MiscDef[5]);
	target_create( chr, itm, _, _, "keyring1_targ" );
}

public keyring_targ(const t, const chr, key, x, y, z, unused, keyring)
{
	new pack = chr_getBackpack(chr);
	if(itm_getProperty(keyring, IP_CONTAINERSERIAL) != pack)
	{
		chr_message(chr, _, "The keyring must be in your backpack");
		return;
	}
	else if(key == keyring) //make keys single again
	{
		new keycounter = DVit_GetSize(keyring, AMX_keymore)/2;
		new more;
		new type;
		new index;
		new namelength;
		for (new i = 0; i < keycounter; i++)
		{
			more = DVit_GetElement(keyring, AMX_keymore ,i*2-1);
			type = DVit_GetElement(keyring, AMX_keymore ,i*2);
			switch(type)
			{
				case 1: key=itm_createByDef("$item_copper_key", pack);
				case 2: key=itm_createByDef("$item_gold_key", pack);
				case 3: key=itm_createByDef("$item_iron_key", pack);
				case 4: key=itm_createByDef("$item_magic_key", pack);
				case 5: key=itm_createByDef("$item_bronze_key", pack);
				default: 
				{
					log_error("Unknown key type %d at keyring %d^n", type, keyring);
					chr_message(chr, _, "An error occured, please contact a GM, telling that an unknown key type was found.^n");
			}
			itm_setProperty(key, IP_MORE, _, more);
			itm_setProperty(keyring, IP_ID, _, 0x1011);
			itm_getLocalStrVar(keyring, AMX_keyname, keyname3);
			index=1;
			trim(keyname3);
			namelength = strlen(keyname3);
			while( (keyname3{index} != ' '&& (index) < namelength )
				++index;
			substring(keyname3, 0, index+1, keyname);
			printf("substring is %s", keyname);
			itm_setProperty(key, IP_STR_NAME, _, keyname);
		}
		DVit_Delete(keyring, AMX_keyring);
		itm_delLocalVar(keyring, AMX_keyname, VAR_TYPE_STRING)
		itm_setEventHandler(keyring, EVENT_ITM_ONDBLCLICK, EVENTTYPE_STATIC, "dbl_keyring1")
		return;
	}
	new keyname[50];
	new keyname2[2064];
	new keyname3[2064];
	new more, hexid, keytype;
	if(keynumber == 0)
	{
		DVit_Delete(keyring, AMX_keyring); //fastest way to clear it just for security it seems
		DVit_Create(keyring, AMX_keyring);
		more = itm_getProperty(key, IP_MORE);
		hexid = itm_getProperty(key, IP_ID);
		keytype = decide_keytype(hexid, key);
		itm_getProperty(key, IP_STR_NAME, _, keyname);
		//use a very seldom ascii sign to mark the key names beginning and end: ? (can't be shown in normal text-editors, dummy question mark)
		itm_LocalVarMaker(keyring, 1, AMX_keyname); //add the keyname local var to keyring
		DVit_AddElement(keyring, AMX_keymore, 0); //add first more
		DVit_SetElement(keyring, AMX_keymore, 0, more);
		DVit_AddElement(keyring, AMX_keymore, 1); //add first keytype
		DVit_SetElement(keyring, AMX_keymore, 1, keytype);
		sprintf(keyname2, "?%s?", keyname);
		itm_setLocalStrVar(keyring, AMX_keyname, keyname2);
		itm_remove(key);
		itm_setEventHandler(keyring, EVENT_ITM_ONDBLCLICK, EVENTTYPE_STATIC, "dbl_keyring2")
		itm_setProperty(keyring, IP_ID, _, 0x1769);
		return;
	}
	else if(keynumber == 1)
	{
		more = itm_getProperty(key, IP_MORE);
		hexid = itm_getProperty(key, IP_ID);
		keytype = decide_keytype(hexid, key);
		itm_getProperty(key, IP_STR_NAME, _, keyname);
		
		DVit_AddElement(keyring, AMX_keymore, 2); //add second more
		DVit_SetElement(keyring, AMX_keymore, 2, more);
		DVit_AddElement(keyring, AMX_keymore, 3); //add second keytype
		DVit_SetElement(keyring, AMX_keymore, 3, keytype);
		
		itm_getLocalStrVar(keyring, AMX_keyname, keyname3);
		sprintf(keyname2, "%s?%s?", keyname3,keyname);
		itm_setLocalStrVar(keyring, AMX_keyname, keyname2);
		itm_remove(key);
		itm_setEventHandler(keyring, EVENT_ITM_ONDBLCLICK, EVENTTYPE_STATIC, "dbl_keyring3")
		itm_setProperty(keyring, IP_ID, _, 0x176a);
		return;
	}
	else if(keynumber == 2) //many keys
	{
		more = itm_getProperty(key, IP_MORE);
		hexid = itm_getProperty(key, IP_ID);
		keytype = decide_keytype(hexid, key);
		itm_getProperty(key, IP_STR_NAME, _, keyname);
		
		DVit_AddElement(keyring, AMX_keymore, DVit_GetSize(keyring, AMX_keymore)); //add second more
		DVit_SetElement(keyring, AMX_keymore, DVit_GetSize(keyring, AMX_keymore), more);
		DVit_AddElement(keyring, AMX_keymore, DVit_GetSize(keyring, AMX_keymore)); //add second keytype
		DVit_SetElement(keyring, AMX_keymore, DVit_GetSize(keyring, AMX_keymore), keytype);
		
		itm_getLocalStrVar(keyring, AMX_keyname, keyname3);
		sprintf(keyname2, "%s?%s?", keyname3,keyname);
		itm_setLocalStrVar(keyring, AMX_keyname, keyname2);
		itm_remove(key);
		itm_setProperty(keyring, IP_ID, _, 0x176b);
		return;
	}
}

public decide_keytype(const hexID, const key)
{
	new keytype;
	switch(hexid)
	{
		case 0x100e: keytype =1; //copper
		case 0x100f: keytype =2; //gold
		case 0x1010: keytype =3; //iron
		case 0x1012: keytype =4; //magic
		case 0x1013: keytype =5; //bronze
		default: log_error("Unknown key, key is %d, key hex is %d^n", key, hexID);
	}
	return keytype;
}