// taming skill export in SMALL, made by Yerpen, modified by Horian

public __tamingTarget( const t, const chr, const target, const x, const y, const z, const model, const param1 )

{
	if (target < 0) return;
	if(chr_getLocalIntVar(chr, 1009) > 0)
	{
		chr_message(chr, _ ,"You are now doing something else!");
		return;
	}
	if(chr == target)
	{
		chr_message(chr, _ ,"You want to tame yourself?");
		return;
	}
	else if(chr_getProperty(chr, CP_HIDDEN) != 0)
	{
		chr_message(chr, _ ,"You can't tame hidden creatures!");
		return;
	}
	else if(!chr_isNpc(target))
	{
		chr_message(chr, _ ,"Hmm maybe just ask, if he want to sarve you...");
		return;
	}
	else if(chr_getProperty(target, CP_TAMED) == 1)
	{
		chr_message(chr, _ ,"This animal is already tamed");
		return;
	}
	else if(chr_distance(chr, target) > 12)
	{
		chr_message(chr, _ ,"You are to far away!");
		return;
	}
	new body = chr_getProperty(chr,CP_ID);
	new scriptid = chr_getProperty(target, CP_SCRIPTID);
	// This is for unicron, kirin and nightmare. Delete if you don't want to make any barries of riding them.
	if((scriptid == 5006) || (scriptid == 5003))
	{
		if((chr_getProperty(chr, CP_KARMA) < 0) || !(chr_isInnocent(chr)))
		{
			chr_message(chr, _ ,"Only honurable people can tame this creature!");
			return;
		}
		else if((scriptid == 5006) && (body != 401))
		{
			chr_message(chr, _ ,"Only women can tame Unicorns!");
			return;
		}
		else if((scriptid == 5003) && (body != 400))
		{
			chr_message(chr, _ ,"Only man can tame Ki-Rin!");
			return;
		}
	}
	else if((scriptid == 430) && (chr_getProperty(chr, CP_KILLS) <= 50))
	{
		chr_message(chr, _ ,"Only evil people can tame the Nightmare!");
		return;
	}
	// End

	new npc_x = chr_getProperty(target, CP_POSITION, IP2_X);
	new npc_y = chr_getProperty(target, CP_POSITION, IP2_Y);
	new npc_z = chr_getProperty(target, CP_POSITION, IP2_Z);
	new chr_x = chr_getProperty(chr, CP_POSITION, IP2_X);
	new chr_y = chr_getProperty(chr, CP_POSITION, IP2_Y);
	new chr_z = chr_getProperty(chr, CP_POSITION, IP2_Z);
	if(chr_lineOfSight(chr, npc_x, npc_y, npc_z, chr_x, chr_y, chr_z,63) == 0)
	{
		chr_message(chr, _ ,"There is something between you and the target");
		return;
	}
	new skill = chr_getSkill(chr, 35);
	new hardskill = chr_getProperty(target, CP_TAMING);
	if(hardskill == 1100)
	{
		chr_message(chr, _ ,"You can't tame that!");
		return;
	}
	else if(hardskill > skill)
	{
		chr_message(chr, _ ,"You are not able to tame this creature");
		return;
	}
	chr_setLocalIntVar(chr, 1009, (random(2)+3)); //chance for automatic repeating of try
	chr_setLocalIntVar(chr, 1010, target); //target serial
	tempfx_activate(_,chr,chr,0,1, funcidx("func_tame"));
}

public func_tame(const chr, const dest, const power, const mode)
{
	if(mode != TFXM_END) return;
	new proba = chr_getLocalIntVar(chr, 1009);
	new animal = chr_getLocalIntVar(chr, 1010);
	if(chr_distance(chr, animal) > 12)
	{
		chr_message(chr, _ ,"You are too far away!");
		chr_setLocalIntVar(chr, 1009, 0);
		return;
	}
	new npc_x = chr_getProperty(animal, CP_POSITION, IP2_X);
	new npc_y = chr_getProperty(animal, CP_POSITION, IP2_Y);
	new npc_z = chr_getProperty(animal, CP_POSITION, IP2_Z);
	new chr_x = chr_getProperty(chr, CP_POSITION, IP2_X);
	new chr_y = chr_getProperty(chr, CP_POSITION, IP2_Y);
	new chr_z = chr_getProperty(chr, CP_POSITION, IP2_Z);
	if(chr_lineOfSight(chr, npc_x, npc_y, npc_z, chr_x, chr_y, chr_z,63) == 0)
	{
		chr_message(chr, _ ,"There is something between you and the animal");
		chr_setLocalIntVar(chr, 1009, 0);
		return;
	}
	if(proba != 0)
	{
		new plec = chr_getProperty(chr,CP_ID);
		new nmb = random(4);
		switch(nmb)
		{
			case 0: chr_talkall(chr,"What a pretty animal!",0);
			case 1: chr_emoteall(chr,"*Smiles to the creature*",0);
			case 2: { if(plec == 400) {chr_talkall(chr,"Come to daddy...",0); } else { chr_talkall(chr,"Come to mammy...",0);}}
			case 3: chr_talkall(chr,"I won't hurt you",0);
			case 4: chr_talkall(chr,"Will you become my new friend?",0);
		}
		proba--;
		chr_setLocalIntVar(chr, 1009, proba);
		tempfx_activate(_,chr,chr,0,2, funcidx("func_tame"));
	}
	else
	{
		if(chr_getProperty(animal, CP_DEAD) == 1) { return; }
		new hardskill = chr_getProperty(animal, CP_TAMING);
		if(chr_checkSkill(chr,35,hardskill,1000,1))
		{
			new name[20];
			chr_getProperty(animal, CP_STR_NAME, 0, name);
			chr_message(chr, _, "%s is at your commands!", name);
			chr_setTamed(chr, animal);
		}
		else if(random(100) > 90)
		{
			chr_npcAttack(animal, chr);
			chr_message(chr, _, "You enraged this creature!");
			chr_setProperty(animal, CP_TAMING,_, (hardskill+100));
		}
		else
		{
			chr_message(chr, _ ,"You failed to tame this creature.");
		}
	}
}

public __nxw_sk_taming(const chr)
{
	if(chr_getLocalIntVar(chr, 1009) != 0)
	{
		chr_message(chr, _ ,"You are taming another creature now!");
		return;
	}
	chr_message( chr, _, "Select a creature you want to tame.");
	target_create( chr, _, _, _, "__tamingTarget" );
}