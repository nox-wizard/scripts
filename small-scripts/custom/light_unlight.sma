#define lclvar_usagetimer 9008
#define lclvar_usagestart 9009

public light_something(const itm, const chr)
{
	bypass();
	new iname[50];
	itm_getProperty(itm, IP_STR_NAME, _, iname);
	if(itm_isaLocalVar(itm, lclvar_usagetimer, VAR_TYPE_INTEGER) == 1)
	{
		//printf("enter usage control^n");
		new burnleft = itm_getLocalIntVar(itm, lclvar_usagetimer);
		if(burnleft<=0)
		{
			itm_remove(itm);
			chr_message(chr, _, msg_MiscDef[4],iname);
			return;
		}
		itm_setLocalIntVar(itm, lclvar_usagestart, getSystemTime());
		//start tempfx to make sure the candle doesn't burn too long
		tempfx_activate(_,itm,itm,0,burnleft,funcidx("useup_light"));
		//printf("started tempfx, burnleft is %d seconds, current time is %d^n", burnleft,getSystemTime());
	}
	new hex = itm_getProperty(itm, IP_ID);
	switch(hex)
	{
	case 0x09Fb: hex=0x09Fd;
	case 0x0A00: hex=0x0a03;
	case 0x0A05: hex=0x0A07;
	case 0x0A0A: hex=0x0A0C;
	case 0x0A1D: hex=0x0A1A;
	case 0x0A25: hex=0x0A22;
	case 0x0A29: hex=0x0B26;
	case 0x0A27: hex=0x0B1D;
	case 0x0a26: hex=0x0B1A;
	case 0x0a28: hex=0x0a0f;
	case 0x1433: hex=0x1430;
	case 0x142F: hex=0x142c;
	case 0x1437: hex=0x1434;
	case 0x1853: hex=0x1854;
	case 0x1857: hex=0x1858;
	case 0x0B21: hex=0x0B20;
	case 0x0B23: hex=0x0B22;
	case 0x0B25: hex=0x0B24;
	default: log_error("Unknown light source that should be lit, hex is %d^n", hex);
	}
	itm_setProperty(itm, IP_ID, _, hex);
	itm_sound(itm, 958);
	itm_refresh(itm);
	itm_setEventHandler(itm, EVENT_ITM_ONDBLCLICK, EVENTTYPE_STATIC, "unlight_something");
	chr_message(chr, _, msg_MiscDef[0],iname);
	new emotetxt[250];
	sprintf(emotetxt,"%s %s*",msg_MiscDef[1],iname);
	chr_emoteAll(chr, emotetxt);
}

public unlight_something(const itm, const chr)
{
	bypass();
	new iname[50];
	itm_getProperty(itm, IP_STR_NAME, _, iname);
	if(itm_isaLocalVar(itm, lclvar_usagetimer, VAR_TYPE_INTEGER) == 1)
	{
		new burnleft = itm_getLocalIntVar(itm, lclvar_usagetimer);
		new usagestart = itm_getLocalIntVar(itm, lclvar_usagestart);
		new usageend = getSystemTime();
		if(usagestart < usageend)
		{
			new usage = usageend-usagestart;
			itm_setLocalIntVar(itm, lclvar_usagetimer, burnleft-usage);
			
		}
		//stop tempfx to make sure the candle burns long enough
		tempfx_delete( itm, _, false, funcidx("useup_light"));
	}
	new hex = itm_getProperty(itm, IP_ID);
	switch(hex)
	{
	case 0x09Fd: hex=0x09Fb;
	case 0x0a03: hex=0x0A00;
	case 0x0A07: hex=0x0A05;
	case 0x0A0C: hex=0x0A0A;
	case 0x0A1A: hex=0x0A1D;
	case 0x0A22: hex=0x0A25;
	case 0x0B26: hex=0x0A29;
	case 0x0B1D: hex=0x0A27;
	case 0x0B1A: hex=0x0a26;
	case 0x0a0f: hex=0x0a28;
	case 0x1430: hex=0x1433;
	case 0x142c: hex=0x142F;
	case 0x1434: hex=0x1437;
	case 0x1854: hex=0x1853;
	case 0x1858: hex=0x1857;
	case 0x0B20: hex=0x0B21;
	case 0x0B22: hex=0x0B23;
	case 0x0B24: hex=0x0B25;
	default: log_error("unknown light source that should be unlit, hex is %d", hex);
	}
	itm_setProperty(itm, IP_ID, _, hex);
	itm_sound(itm, 71);
	itm_refresh(itm);
	itm_setEventHandler(itm, EVENT_ITM_ONDBLCLICK, EVENTTYPE_STATIC, "light_something");
	chr_message(chr, _, msg_MiscDef[2],iname);
	new emotetxt[250];
	sprintf(emotetxt,"%s %s*",msg_MiscDef[3],iname);
	chr_emoteAll(chr, emotetxt);
}

public useup_light(const itm, const dest, const power, const mode) //first time fertile getting
{
	if(mode != TFXM_END) return;
	itm_sound(itm, 71);
	itm_remove(itm);
}