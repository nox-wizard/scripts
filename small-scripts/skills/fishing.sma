//fishing override in SMALL, made by Yerpen, modified by Horian
// fishes, boots, paintings 1, paintings2, shells, drinks, chests, weapons, magic robes, bonus

static itm_fishing[10][] = {
{103001, 103002, 103003, 103004},
{455, 457, 458, 458},
{95505, 95506, 95507, 95508},
{2131, 95511, 95512, 95513},
{103251, 103252, 103253, 103254},
{100031, 100061, 100011, 100005},
{6470, 6471, 6472, 6473},
{501, 502, 16013, 16008},
{16003, 16004, 16005, 16006},
{629, 638, 627, 704}
};

public __nxw_sk_fishing(const item, const chr)
{
	bypass();
	if(itm_getProperty(item, IP_LAYER) == 0)
	{
		chr_message(chr, _ , "You have to equip it!");
		return;
	}
	chr_message( chr, _ , "Where do you want to fish?");
	target_create( chr, _ , _, _, "__fishingTarget" );
}

public __fishingTarget( const t, const chr, const target, const x, const y, const z, const model, const param1 )
{
	if ((x < 0) || (target < 0))
	{
		chr_message(chr, _ , "Invalid target");
		return;
	}
	new xx = chr_getProperty(chr, CP_POSITION, CP2_X);
	new yy = chr_getProperty(chr, CP_POSITION, CP2_Y);
	new distx = (x - xx);
	new disty = (y - yy);
	if((distx > 6) || (distx < -6) || (disty < -6) || (disty > 6))
	{
		chr_message(chr, _ , "This is too far!");
		return;
	}
	
	new tile = map_getTileID(x, y, z);
	if(tile < 0)
	{
		tile = map_getFloorTileID(x, y);
		if((tile < 168) || (tile > 171))
		{
			chr_message(chr, _ , "You can't fish here!");
			return;
		}
	}
	else if((6066 < tile) || (tile < 6039))
	{
		chr_message(chr, _ , "You can't fish here!");
		return
	}
	
	chr_sound (chr, 39);
	chr_action (chr, 11);
	
	if(!chr_checkSkill(chr,18,0,1000,1))
	{
		if(random(100) > 8)
		{
			chr_message(chr, _ , "You didn't catch any fish...");
			return;
		}
		chr_message(chr, _ , "You caught a ... water elemental!");
		new npc = chr_addNPC(22, x, y, z);
		chr_sound(npc, 40);
		chr_moveTo(npc, x, y, z);
	}
	
	new skill = chr_getSkill(chr, 18);
	new typ = random(3);
	new nmb = 0;
	if(random(100) > 92)
	{
		new i = random(10);
		if((skill == 1000) && (i > 8)) { nmb = 9; }
		else if((skill >= 950) && (i > 7)) { nmb = 8;}
		else if((skill >= 900) && (i > 5)) { nmb = 7;}
		else if((skill >= 750) && (i > 3)) { nmb = (random(5)+1); }
		else if(skill >= 550) { nmb = 1; }
	}
	
	itm_createInBp(itm_fishing[nmb][typ], chr);
	
	switch(nmb)
	{
		case 0: chr_message(chr, _ , "You caught a fish!");
		case 1: chr_message(chr, _ , "Hah, the old boots...");
		case 2..3: chr_message(chr, _ , "Hmm, good painting...");
		case 4: chr_message(chr, _ , "It could be tasty....");
		case 5: chr_message(chr, _ , "Yhm...");
		case 6: chr_message(chr, _ , "You are now the owner of a strong, good chest!");
		case 7..9: chr_message(chr, _ , "Hmm, a strange magic item!");
		default: chr_message(chr, _, "Unknown.");
	}
}

